## 🕵️ SQL Murder Mystery: “Who Killed the CEO?”

*A Capstone SQL Investigation Challenge*

## 1. Story Background

On **October 15, 2025 at 9:00 PM**, the CEO of **TechNova Inc.** was found dead in their office.
As the **Lead Data Analyst**, I was assigned to investigate the case using the company's internal databases.

All information- movement logs, calls, alibis, and evidence- is stored in the SQL dataset, and the entire case must be solved only using SQL queries.

The goal of this project was to analyze the clues step-by-step and identify:

- Who committed the murder
- When and where it happened
- How SQL evidence leads to the final conclusion

## 2. Database Schema

The dataset contains five key tables, all created using table_creation.sql included in the repo.

- The **employees** table stores basic employee information such as ID, name, department, and job role.
- The **keycard_logs** table records employee movements, capturing room access along with entry and exit timestamps.
- The **calls** table logs all phone interactions between employees, including caller/receiver IDs, call time, and call duration.
- The **alibis** table documents employees’ claimed locations and timestamps, useful for validating or disproving their statements.
- The **evidence** table contains physical evidence details, specifying what was found, where it was found, and when it was discovered.

## 3. Investigation Structure

I structured the investigation into logical phases, each solved using SQL:

### Phase 1 — Identify the Crime Room & Time

Filtering logs to confirm that the murder occurred inside the CEO Office between 20:50–21:00.

### Phase 2 — Track Movements Near the Crime Window

Using JOIN + BETWEEN, I extracted all employees who accessed the CEO Office around the critical time.

### Phase 3 — Validate Alibis

I compared claimed locations against actual keycard activity to identify false statements.

### Phase 4 — Analyze Suspicious Calls

Using time-based filtering on the calls table, I inspected calls made between 20:50–21:00, matching them with movement patterns.

### Phase 5 — Evidence Correlation

Evidence discovered in the CEO’s office was matched with the last known individuals in the room.

### Phase 6 — Final SQL Intersection

I combined:
Office entry logs, False alibis, Suspicious calls, Evidence timeline

to isolate the **final suspect.**

## 4. Final Killer Identification

After running all investigation queries and cross-checking clues across multiple tables:
#### 🔍 Killer Identified: *David Kumar*

### Summary of How I Reached the Conclusion

- **Movement:** Keycard logs placed David Kumar (employee_id = 4) in the CEO Office within the murder window 20:50–21:00.

- **False Alibi:** David claimed to be in the Server Room at 20:50, but keycard logs showed no such entry, confirming a false alibi.

- **Call Activity:** David was involved in a call around 20:55, matching the suspicious call timeline.

- **Evidence Link:** Evidence found in the CEO Office immediately after the murder aligned with David’s presence and timeline.

- **Final Intersection:** Only one person matched all three:
→ Office movement + False alibi + Suspicious call + Evidence proximity

Therefore, **David Kumar** is the confirmed killer.

## 5. Deliverables Included in the Repo

I have included all supporting files used to complete the capstone:

- 📄 table_creation.sql — Database schema + inserts
- 🧩 SQL Murder Mystery.sql — All investigation queries
- 📊 SQL-Murder-Mystery (1).pptx — Presentation of insights & findings
- 🎥 SQL-Murder-Mystery (1)[1].mp4 — Short case-walkthrough video
- 📝 README.md — Project summary (this file)

## 6. Skills Practiced

- Multi-table JOINs, CTE's, Subqueries, Window functions
- Time-based filtering
- Data storytelling
- Evidence-based analysis
- Building a complete case narrative with SQL

## 7. Final Output Query Format

The final query returns a clean, single-column result:

###**killer**
-------------------
David Kumar
