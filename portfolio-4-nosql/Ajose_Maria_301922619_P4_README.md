
# Portfolio 4 NoSQL and Advanced Data Models

## Document model
The NoSQL document model captures student activity events within the student_portal_nosql database using a single student_activities collection. Each document uses a unique string _id ( EVT_001 through EVT_004) and standard top-level fields for event_type and timestamp. Related entities and varying event metrics are stored via embedded sub-documents (student, course, and polymorphic details), linking directly to student and course identifiers from the relational schema.

---

### Example Document (EVT_001)
```json
{
  "_id": "EVT_001",
  "event_type": "ENROLLMENT_SUBMISSION",
  "timestamp": "2026-03-01T08:30:00.000Z",
  "student": {
    "student_id": 3,
    "student_name": "Rhoda Atanda"
  },
  "course": {
    "course_id": 4,
    "course_name": "Database Systems"
  },
  "details": {
    "submission_channel": "Web Portal",
    "status": "On-Time"
  }
}
```
## Implementation and results
After creating the student_portal_nosql database and inserting the four activity documents via insertMany, verification queries confirmed data integrity. Running db.student_activities.countDocuments({}) returned 4. Querying sorted history for student 3 (db.student_activities.find({ "student.student_id": 3 }).sort({ timestamp: 1 })) successfully returned chronological events EVT_001 and EVT_002. Filtering by nested attributes (db.student_activities.find({ "details.status": "Late" })) accurately retrieved document EVT_003.

## Why MongoDB fits
MongoDB's flexible document model is well-suited for logging student activity streams because different event types (such as enrollment submissions versus grade postings) require varying attributes inside their details fields. Embedding student and course context directly into each event document avoids complex multi-table joins, enabling rapid retrieval of an entity's complete chronological history in a single query. However, a limitation of this denormalized model is data redundancy; if a student's name changes, multiple event documents must be updated rather than a single relational row.

## Files
- [MongoDB Script](Ajose_Maria_301922619_P4_MongoDB.js)
- Screenshot: [Query Checkpoint](Images/Ajose_Maria_301922619_P4_Queries.png)

## References
- MongoDB Manual — [Documents](https://www.mongodb.com/docs/manual/core/document/)
- MongoDB Manual — [Query Documents](https://www.mongodb.com/docs/manual/tutorial/query-documents/)



