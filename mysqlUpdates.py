#contains all necessary insertions

import mysql.connector

#insert statements
def updateCourseSectionEnrollment(id, students_enrolled, males_enrolled):
    query = ("UPDATE course_section set students_enrolled = %s, males_enrolled = %s WHERE id = %s" %(students_enrolled, males_enrolled, id))
    cursor = runUpdate(query)

def updateCourseEnrollment(user_id, course_section_id, new_course_section):
    query = ("UPDATE course_enrollment SET course_section_id=%s WHERE user_id=%s AND course_section_id=%s AND is_mentor=0" %(new_course_section, user_id, course_section_id))
    cursor = runUpdate(query)

#class_name, gender, mentor, name, section_number
def updateFormattedOutput(mentor, class_name, section_number):
    query = ("UPDATE formatted_output SET mentor='%s' WHERE class_name = '%s' AND section_number=%s" %(mentor, class_name, section_number))
    cursor = runUpdate(query)

#universal connection to db, runs insert
def runUpdate(update):
    scheduledb = mysql.connector.connect(
        user="acastillo",
        password="OpEd2020!",
        database="schedule_db",
        host = "localhost"
    )
    cursor = scheduledb.cursor(buffered=True)
    cursor.execute(update)
    scheduledb.commit()
    cursor.close()
    scheduledb.close()
    return cursor