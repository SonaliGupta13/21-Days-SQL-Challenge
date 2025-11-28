/* ===========================================================
   SQL Murder Mystery — Documented Investigation Script
   File: SQL_Murder_Mystery_documented.sql
   Author: Sonali Gupta
   Date: 2025-11-28
   Format: STEP → Objective → Approach → SQL → Insight / Result
   =========================================================== */

/* ----------------------------------------------------------------
   STEP 1: Identify where and when the crime happened
   Objective:
     Find any presence in the CEO Office near the crime window (approx 20:30–21:15 on 2025-10-15).
   Approach:
     Use keycard_logs and filter logs that overlap the crime window.
------------------------------------------------------------------ */
-- Query:
SELECT *
FROM keycard_logs
WHERE entry_time <= '2025-10-15 21:15:00'
  AND exit_time  >= '2025-10-15 20:30:00';

-- Insight:
-- The keycard log shows employee_id 4 (David Kumar) was inside the CEO Office from 20:50 to 21:00,which overlaps the crime time window (20:30–21:15).
-- He is the only person recorded in the CEO Office at the exact moment of the crime (20:50).
-- This immediately positions David as a primary suspect.

/* ----------------------------------------------------------------
   STEP 2: Analyze who accessed critical areas at the time
   Objective:
     Identify employees who were in the CEO Office or Server Room at 20:50.
   Approach:
     JOIN employees to keycard_logs; check if 2025-10-15 20:50:00 is between entry and exit.
------------------------------------------------------------------ */
-- Query:
SELECT e.employee_id,
       e.name,
       k.room,
       k.entry_time,
       k.exit_time
FROM employees AS e
JOIN keycard_logs AS k
  ON e.employee_id = k.employee_id
WHERE k.room IN ('CEO Office', 'Server Room')
  AND '2025-10-15 20:50:00' BETWEEN k.entry_time AND k.exit_time;

-- Insight:
-- At exactly 20:50, the only person present in either CEO Office or Server Room was David Kumar in the CEO Office.
-- No one else accessed these restricted areas at or near this time.
-- This reinforces that David had exclusive access to the crime scene at the critical moment.

/* ----------------------------------------------------------------
   STEP 3: Cross-check alibis with actual logs
   Objective:
     Find alibis (claimed locations at a specific claim_time) that are not supported by keycard logs.
   Approach:
     LEFT JOIN alibis to keycard_logs using the claim_time and claimed_location; where no matching keycard record exists -> potential false alibi.
------------------------------------------------------------------ */
-- Query:
SELECT a.alibi_id,
       a.employee_id,
       emp.name,
       a.claimed_location,
       a.claim_time
FROM alibis AS a
JOIN employees AS emp 
  ON a.employee_id = emp.employee_id
LEFT JOIN keycard_logs AS k
  ON k.employee_id = a.employee_id
     AND a.claim_time BETWEEN k.entry_time AND k.exit_time
     AND k.room = a.claimed_location
WHERE k.employee_id IS NULL;

-- Insight:
-- Four employees provided alibis at 20:50 that were not supported by keycard activity.
-- David Kumar claimed he was in the Server Room, but there is no Server Room entry at 20:50.
-- This makes David’s alibi provably false, further heightening suspicion on him.

/* ----------------------------------------------------------------
   STEP 4: Investigate suspicious calls made around 20:50–21:00
   Objective:
     Identify calls that overlap the window 20:50–21:00 (incoming or outgoing).
   Approach:
     compute call end time with DATE_ADD(call_time, INTERVAL duration_sec SECOND).
     Join caller/receiver IDs to employees for names.
------------------------------------------------------------------ */
-- Query:
SELECT c.call_id,
       c.caller_id,
       caller.name AS caller_name,
       c.receiver_id,
       receiver.name AS receiver_name,
       c.call_time,
       c.duration_sec,
       DATE_ADD(c.call_time, INTERVAL c.duration_sec SECOND) AS call_end_time
FROM calls AS c
JOIN employees AS caller   ON c.caller_id   = caller.employee_id
JOIN employees AS receiver ON c.receiver_id = receiver.employee_id
WHERE c.call_time <= '2025-10-15 21:00:00'
  AND DATE_ADD(c.call_time, INTERVAL c.duration_sec SECOND) >= '2025-10-15 20:50:00';

-- Insight:
-- A single call overlapped the crime window (20:50–21:00):David Kumar ↔ Alice Johnson at 20:55 for 45 seconds.
-- This call happened while David was inside the CEO Office.
-- His call duration (20:55–20:55:45) fits within the crime timeframe, indicating:
		-- He was active and awake.
		-- He had his phone and could have attempted to manipulate or distract.

/* ----------------------------------------------------------------
   STEP 5: Match evidence with movements and claims
   Objective:
     For each piece of evidence, find the last recorded person in that room before the evidence was found.
   Approach:
     - Use a CTE (movements) that joins evidence -> keycard_logs where entry_time <= found_time.
     - Use ROW_NUMBER partitioned by evidence to pick the most recent entry before found_time (ORDER BY entry_time DESC).
------------------------------------------------------------------ */
-- Query:
WITH movements AS (
    SELECT k.employee_id,
           k.room,
           k.entry_time,
           k.exit_time,
           e.evidence_id,
           e.found_time,
           ROW_NUMBER() OVER (
               PARTITION BY e.room, e.evidence_id
               ORDER BY k.entry_time DESC
           ) AS rn
    FROM evidence AS e
    JOIN keycard_logs AS k
      ON e.room = k.room
     AND k.entry_time <= e.found_time
)
SELECT m.evidence_id,
       m.room,
       m.found_time,
       m.employee_id,
       emp.name,
       m.entry_time,
       m.exit_time
FROM movements AS m
JOIN employees AS emp 
  ON emp.employee_id = m.employee_id
WHERE m.rn = 1
ORDER BY m.evidence_id;

-- Insight:
-- Every piece of evidence—including fingerprints and digital traces—was last associated with David Kumar.
-- Evidence #1 and #2 directly connect him to the CEO Office immediately before discovery.
-- Evidence #3 links back to his earlier Server Room access in the morning, disproving his later alibi.

/* ----------------------------------------------------------------
   STEP 6: Combine all findings to identify the killer
   Objective:
     Find employees who satisfy all three suspicious conditions:
       - Were in CEO Office at 20:50 (movement_match)
       - Gave an alibi at 20:50 that claims a different location (alibi_mismatch)
       - Had a call overlapping 20:50–21:00 (call_overlap)
   Approach:
     Build three CTEs and INTERSECT (via JOIN on distinct employee_ids) to get the intersection.
------------------------------------------------------------------ */
-- Query:
WITH movement_match AS (
    SELECT DISTINCT employee_id
    FROM keycard_logs
    WHERE room = 'CEO Office'
      AND '2025-10-15 20:50:00' BETWEEN entry_time AND exit_time
),
alibi_mismatch AS (
    SELECT DISTINCT employee_id
    FROM alibis
    WHERE claim_time = '2025-10-15 20:50:00'
      AND claimed_location <> 'CEO Office'
),
call_overlap AS (
    SELECT DISTINCT employee_id
    FROM (
        SELECT caller_id AS employee_id,
               call_time,
               DATE_ADD(call_time, INTERVAL duration_sec SECOND) AS call_end
        FROM calls
        UNION ALL
        SELECT receiver_id AS employee_id,
               call_time,
               DATE_ADD(call_time, INTERVAL duration_sec SECOND)
        FROM calls
    ) AS c
    WHERE call_time <= '2025-10-15 21:00:00'
      AND call_end >= '2025-10-15 20:50:00'
)
SELECT e.name AS killer
FROM employees AS e
JOIN movement_match AS mm  ON e.employee_id = mm.employee_id
JOIN alibi_mismatch AS am ON e.employee_id = am.employee_id
JOIN call_overlap AS co   ON e.employee_id = co.employee_id;

-- Insight:
-- David Kumar is the only person who satisfies all three independent suspicious criteria:
	-- Location: Present in CEO Office at 20:50
    -- Alibi Mismatch: Lied about being in the Server Room
    -- Call Overlap: Made a call between 20:50–21:00
-- The intersection of these evidence pillars is a single name: David Kumar, confirming him as the killer.

/* ----------------------------------------------------------------
   Final Conclusion: David Kumar is the murderer.
------------------------------------------------------------------ */

/* ----------------------------------------------------------------
   Short explanation (how the conclusion was reached)
   - Movement: Keycard logs placed David Kumar (employee_id 4) in the CEO Office overlapping 20:50–21:00.
   - False alibi: David claimed to be in the Server Room at 20:50, but keycard records do NOT support presence there at that time.
   - Call activity: David participated in a call around 20:55 which overlaps the 20:50–21:00 window.
   - Evidence linkage: Evidence found in CEO Office shortly after the crime maps to the last recorded person — David.
   - Intersection: Intersection of movement, alibi mismatch, and call overlap produced a single match: David Kumar.
------------------------------------------------------------------ */

