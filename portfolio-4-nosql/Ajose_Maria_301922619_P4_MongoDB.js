
// Run once in mongosh
// Select the MongoDB database.
db = db.getSiblingDB("student_portal_nosql");

// Stop rather than inserting another copy of an existing exercise.
if (db.student_activities.countDocuments() !== 0) {
    throw new Error("student_activities already contains records. Check them before continuing.");
}

//  Each document records one activity event. Student and course details are snapshots.
db.student_activities.insertMany([
    {
        "_id": "EVT_001",
        "event_type": "ENROLLMENT_SUBMISSION",
        "timestamp": ISODate("2026-03-01T08:30:00Z"),
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
    },
    {
        "_id": "EVT_002",
        "event_type": "GRADE_POSTING",
        "timestamp": ISODate("2026-03-02T10:15:00Z"),
        "student": {
            "student_id": 3,
            "student_name": "Rhoda Atanda"
        },
        "course": {
            "course_id": 4,
            "course_name": "Database Systems"
        },
        "details": {
            "numerical_grade": 85.00,
            "letter_grade": "A",
            "grader": "Dr. Smith"
        }
    },
    {
        "_id": "EVT_003",
        "event_type": "ENROLLMENT_SUBMISSION",
        "timestamp": ISODate("2026-03-01T09:00:00Z"),
        "student": {
            "student_id": 4,
            "student_name": "James Bede"
        },
        "course": {
            "course_id": 5,
            "course_name": "Data Structures"
        },
        "details": {
            "submission_channel": "Mobile App",
            "status": "Late"
        }
    },
    {
        "_id": "EVT_004",
        "event_type": "GRADE_POSTING",
        "timestamp": ISODate("2026-03-03T14:20:00Z"),
        "student": {
            "student_id": 4,
            "student_name": "James Bede"
        },
        "course": {
            "course_id": 5,
            "course_name": "Data Structures"
        },
        "details": {
            "numerical_grade": 78.50,
            "letter_grade": "B",
            "grader": "Dr. Adams"
        }
    }
]);

// printjson shows each result when this file is run as a script.
// Q1: Four documents should have been saved.
printjson(db.student_activities.countDocuments());

// Q2: Show student 3's events in the order they happened.
printjson(db.student_activities.find(
    { "student.student_id": 3 },
    { _id: 1, event_type: 1, timestamp: 1, details: 1 }
).sort({ timestamp: 1, _id: 1 }).toArray());

// Q3: Search a field inside the details document.
printjson(db.student_activities.find({ "details.status": "Late" }).toArray());