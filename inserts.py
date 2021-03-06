#contains all necessary insertions

import mysql.connector
from usefulFunctions import runMySQLOperation

#insert statements
def addCommitment(id, commitmentName):
    query = ("INSERT INTO commitment_types (id, reason) VALUES (%s, %s)" %(id, commitmentName))
    cursor = runMySQLOperation(query)

def enrollStudentByID(studentID, courseSectionID):
    query = ("INSERT INTO course_enrollment (course_section_id, is_mentor, user_id) VALUES (%s, 0, %s)" %(courseSectionID, studentID))
    cursor = runMySQLOperation(query)

def createCourseSection(id, course_id, section_number):
    query = ("INSERT INTO course_section (id, course_id, section_number, classroom_id, class_period, students_enrolled, males_enrolled)"
        " VALUES (%s, %s, %s, 0, 0, 0, 0)" %(id, course_id, section_number))
    cursor = runMySQLOperation(query)

def addPreferences():
    query = ("INSERT INTO student_course_preferences_unenrolled (course_id, id, ranking, student_id)"
        " SELECT course_id, id, ranking, student_id FROM student_course_preferences")
    cursor = runMySQLOperation(query)

def addFormattedPreference(course_id, id, ranking, student_id):
    query = ("INSERT INTO student_course_preferences (course_id, id, ranking, student_id) VALUES (%s, %s, %s, %s)" %(course_id, id, ranking, student_id))
    cursor = runMySQLOperation(query)

def addFormattedOuput(name, year, gender, class_name, mentor, section_number):
    query = ("INSERT INTO formatted_output (name, year, gender, class_name, mentor, section_number)"
        " VALUES ('%s', %s, '%s', '%s', '%s', %s)" %(name, year, gender, class_name, mentor, section_number))
    cursor = runMySQLOperation(query)

def addStudent(student_id, name, gender, year, free_periods):
    query = ("INSERT INTO student (id, name, gender, year, free_periods) VALUES (%s, '%s', '%s', %s, %s)" %(student_id, name, gender, year, free_periods))
    cursor = runMySQLOperation(query)

def addFormattedQualification(id, mentor_id, course_id):
    query = ("INSERT INTO mentor_qualified_courses (id, mentor_id, course_id) VALUES (%s, %s, %s)" %(id, mentor_id, course_id))
    cursor = runMySQLOperation(query)

def addMentor(mentor_id, mentor_name, planning_periods):
    query = ("INSERT INTO  mentor (id, name, planning_periods) VALUES (%s, '%s', %s)" %(mentor_id, mentor_name, planning_periods))
    cursor = runMySQLOperation(query)

def addMentorToCourseSection(course_section_id,  user_id):
    query = ("INSERT INTO  course_enrollment (course_section_id, is_mentor, user_id) VALUES (%s, 1, %s)" %(course_section_id, user_id))
    cursor = runMySQLOperation(query)
    