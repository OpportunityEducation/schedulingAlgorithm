#contains all necessary deletions

import mysql.connector
from usefulFunctions import runMySQLOperation

#delete statements
def deleteStudentCoursePreference(studentID, courseID, id):
    query = ("DELETE FROM student_course_preferences_unenrolled WHERE course_id=%s and id=%s and student_id=%s" %(courseID, id, studentID))
    cursor = runMySQLOperation(query)

def truncateTable(table):
    query = ("TRUNCATE %s" %(table))
    cursor = runMySQLOperation(query)
    print("%s deleted" %(table))

def deleteMentorQualifiedCourse(mentor_id, course_id):
    query = ("DELETE FROM course_enrollment WHERE course_id=%s and user_id=%s and is_mentor=1" %(course_id, mentor_id))
    cursor = runMySQLOperation(query)
    
#universal connection to db, runs deletion
def runDeletion(deletion):
    scheduledb = mysql.connector.connect(
        user="acastillo",
        password="OpEd2020!",
        database="schedule_db",
        host = "localhost"
    )
    cursor = scheduledb.cursor(buffered=True)
    cursor.execute(deletion)
    scheduledb.commit()
    cursor.close()
    scheduledb.close()
    return cursor