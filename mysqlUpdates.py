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

def updatePeriodForCourseSection(period, id):
    query = ("UPDATE course_section SET class_period=%s WHERE id=%s" %(period, id))
    cursor = runMySQLOperation(query)

def decrementPeriodsLeft(index, periodsLeft):
    query = ("UPDATE periods SET periods_left=%s WHERE id=%s" %(periodsLeft, index))
    cursor = runMySQLOperation(query)

def setPeriodsLeft():
    query = ("UPDATE periods SET periods_left = 7")
    cursor = runMySQLOperation(query)

def addSchedulingToFormattedOutput(period, room_name, class_name, section_number):
    query = ("UPDATE formatted_output SET period=%s, classroom = '%s' WHERE class_name = '%s' AND section_number=%s" %(period, room_name, class_name, section_number))
    cursor = runMySQLOperation(query)

def assignCourseSectionToRoom(id, section_number, assignedRoom):
    query = ("UPDATE course_section SET classroom_id=%s WHERE id=%s AND section_number=%s" %(assignedRoom, id, section_number))
    cursor = runMySQLOperation(query)

def updateDuplicates(duplicate, id):
    query = ("UPDATE course_conflicts SET duplicates='%s' WHERE id=%s" %(duplicate, id))
    cursor = runMySQLOperation(query)

def setDuplicates(duplicate, duplicateNum, id):
    query = ("UPDATE course_conflicts SET duplicates='%s', duplicates_num=%s WHERE id=%s" %(duplicate, duplicateNum, id))
    print("updating duplicates")
    cursor = runMySQLOperation(query)

def clearDuplicates():
    query = ("UPDATE course_conflicts SET duplicates = NULL WHERE duplicates is not null")
    cursor = runMySQLOperation(query)

def clearDuplicateNums():
    query = ("UPDATE course_conflicts SET duplicates_num = 0")
    cursor = runMySQLOperation(query)

def incrementDuplicateNum(courseId):
    query = ("UPDATE course_conflicts SET duplicates_num = duplicates_num + 1 WHERE id = %s" %(courseId))
    cursor = runMySQLOperation(query)
