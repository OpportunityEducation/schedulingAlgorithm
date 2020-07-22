#contains all necessary insertions

import mysql.connector
from usefulFunctions import runMySQLOperation

#insert statements
def updateCourseSectionEnrollment(id, students_enrolled, males_enrolled):
    query = ("UPDATE course_section set students_enrolled = %s, males_enrolled = %s WHERE id = %s" %(students_enrolled, males_enrolled, id))
    cursor = runMySQLOperation(query)

def updateCourseEnrollment(user_id, course_section_id, new_course_section):
    query = ("UPDATE course_enrollment SET course_section_id=%s WHERE user_id=%s AND course_section_id=%s AND is_mentor=0" %(new_course_section, user_id, course_section_id))
    cursor = runMySQLOperation(query)

#class_name, gender, mentor, name, section_number
def updateFormattedOutput(mentor, class_name, section_number):
    query = ("UPDATE formatted_output SET mentor='%s' WHERE class_name = '%s' AND section_number=%s" %(mentor, class_name, section_number))
    cursor = runMySQLOperation(query)

def updateRoomForCourseSection(period, id):
    query = ("UPDATE course_section SET class_period=%s WHERE id=%s" %(period, id))
    cursor = runMySQLOperation(query)

def decrementPeriodsLeft(index, periodsLeft):
    query = ("UPDATE periods SET periods_left=%s WHERE id=%s" %(periodsLeft, index))
    cursor = runMySQLOperation(query)

def setPeriodsLeft():
    query = ("UPDATE periods SET periods_left = 7")
    cursor = runMySQLOperation(query)

def addPeriodsToFormattedOutput(period, class_name, section_number):
    query = ("UPDATE formatted_output SET period=%s WHERE class_name = '%s' AND section_number=%s" %(period, class_name, section_number))
    cursor = runMySQLOperation(query)
