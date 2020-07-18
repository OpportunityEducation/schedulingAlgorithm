#imports and runs all necessary SQL queries
import mysql.connector

import classes
from classes import Course, Student, Mentor, RankedCourse, EnrolledCourse, CourseSection
from classes import UnformattedPreference, UnformattedQualification, MentorQualifiedClass
from usefulFunctions import runMySQLOperation

#create and print queries
def getAllStudents():
    query = ("SELECT * FROM student")
    cursor = runMySQLOperation(query)
    for (id, name, gender, year, free_periods) in cursor:
        print("{} is {}".format(id, name))

def getStudentsByGrade(grade):
    query = ("SELECT * FROM student WHERE year=%s" %(grade))
    cursor = runMySQLOperation(query)
    studentsByGrade = []
    for (id, name, gender, year, free_periods) in cursor:
        studentsByGrade.append(Student(id, name, gender, year, free_periods))
    return studentsByGrade

def getStudentByName(name):
    query = ("SELECT * FROM student WHERE name = '%s'" %(name))
    cursor = runMySQLOperation(query)
    for (id, name, gender, year, free_periods) in cursor:
        print("{} is {}".format(id, name))

def getStudentByID(id):
    query = ("SELECT * FROM student WHERE id=%s" %(id))
    cursor = runMySQLOperation(query)
    for (id, name, gender, year, free_periods) in cursor:
        return Student(id, name, gender, year, free_periods)

def getDayById(dayId):
    query = ("SELECT * FROM day WHERE id = %s" %(dayId))
    cursor = runMySQLOperation(query)
    for (id, weekday) in cursor:
        print("{} is {}".format(id, weekday))

def getStudentCoursePreferencesByID(id):
    query = ("SELECT * FROM student_course_preferences WHERE student_id=%s" %(id))
    cursor = runMySQLOperation(query)
    requestedCourses = []
    for (id, student_id, course_id, ranking) in cursor:
        requestedCourses.append(RankedCourse(id, course_id, ranking))
    return requestedCourses

def getStudentCoursePreferencesByCourseID(id):
    query = ("SELECT * FROM student_course_preferences WHERE course_id=%s" %(id))
    cursor = runMySQLOperation(query)
    requestedCourses = []
    for (id, student_id, course_id, ranking) in cursor:
        requestedCourses.append(RankedCourse(id, course_id, ranking))
    if len(requestedCourses) > 0:
        return True
    else :
        return False

def getCourseByID(id):
    query = ("SELECT * FROM course WHERE id=%s" %(id))
    cursor = runMySQLOperation(query)
    for (id, name, allowed_grades, is_elective) in cursor:
        return Course(id, name, allowed_grades, is_elective)

def getCourseByName(name):
    query = ("SELECT * FROM course WHERE name='%s'" %(name))
    cursor = runMySQLOperation(query)
    for (id, name, allowed_grades, is_elective) in cursor:
        return Course(id, name, allowed_grades, is_elective)

def getCourseSectionByID(id):
    query = ("SELECT * FROM course_section WHERE id=%s" %(id))
    cursor = runMySQLOperation(query)
    for (id, course_id, section_number, classroom_id, class_period, students_enrolled, males_enrolled) in cursor:
        return CourseSection(id, course_id, section_number, classroom_id, class_period, students_enrolled, males_enrolled)

def getCourseSectionsByCourseID(courseId):
    query = ("SELECT * FROM course_section WHERE course_id=%s" %(courseId))
    cursor = runMySQLOperation(query)
    courseSections = []
    for (id, course_id, section_number, classroom_id, class_period, students_enrolled, males_enrolled) in cursor:
        courseSections.append(CourseSection(id, course_id, section_number, classroom_id, class_period, students_enrolled, males_enrolled))
    return courseSections

def getAllCourseSections():
    query = ("SELECT * FROM course_section")
    cursor = runMySQLOperation(query)
    allSections = []
    for (id, course_id, section_number, classroom_id, class_period, students_enrolled, males_enrolled) in cursor:
        allSections.append(CourseSection(id, course_id, section_number, classroom_id, class_period, students_enrolled, males_enrolled))
    return allSections

def getAllCourses():
    query = ("SELECT * FROM course")
    cursor = runMySQLOperation(query)
    allCourses = []
    for (id, name, allowed_grades, is_elective) in cursor:
        allCourses.append(Course(id, name, allowed_grades, is_elective))
    return allCourses     

def getStudentEnrollmentByStudentID(id):
    query = ("SELECT * FROM course_enrollment WHERE is_mentor=0 AND user_id=%s" %(id))
    cursor = runMySQLOperation(query)
    enrolledCourses = []
    for (course_section_id, is_mentor, user_id) in cursor:
        enrolledCourses.append(EnrolledCourse(course_section_id, user_id))
    return enrolledCourses

def getStudentEnrollmentPreferencesByID(id):
    query = ("SELECT * FROM student_course_preferences_unenrolled WHERE student_id=%s" %(id))
    cursor = runMySQLOperation(query)
    requestedCourses = []
    for (id, student_id, course_id, ranking) in cursor:
        requestedCourses.append(RankedCourse(id, course_id, ranking))
    return requestedCourses

def getStudentIDsEnrolledByCourseSection(course_id):
    query = ("SELECT * FROM course_enrollment WHERE course_section_id=%s and is_mentor=0" %(course_id))
    cursor = runMySQLOperation(query)
    students = []
    for (user_id, course_section_id, is_mentor) in cursor:
        students.append(user_id)
    return students

def getAllUnformattedPreferences():
    query = ("SELECT * FROM unformatted_preferences")
    cursor = runMySQLOperation(query)
    preferences = []
    for (student_id, student_name, gender, grade, free_periods, req_1, req_2, req_3, req_4, req_5, req_6) in cursor:
        preferences.append(UnformattedPreference(student_id, student_name, gender, grade, free_periods, req_1, req_2, req_3, req_4, req_5, req_6))
    return preferences

def getAllUnformattedQualifications():
    query = ("SELECT * FROM unformatted_mentor_qualifications")
    cursor = runMySQLOperation(query)
    qualifications = []
    for (id, name, planning_periods, course_1, course_2, course_3, course_4, course_5, course_6, course_7) in cursor:
        qualifications.append(UnformattedQualification(id, name, planning_periods, course_1, course_2, course_3, course_4, course_5, course_6, course_7))
    return qualifications

def getQualificationByID(courseID):
    query = ("SELECT * FROM mentor_qualified_courses WHERE course_id=%s" %(courseID))
    cursor = runMySQLOperation(query)
    mentorQuals = []
    for (id, mentor_id, course_id) in cursor:
        mentorQuals.append(MentorQualifiedClass(id, mentor_id, course_id))
    return mentorQuals

def getMentorByID(id):
    query = ("SELECT * FROM mentor WHERE id=%s" %(id))
    cursor = runMySQLOperation(query)
    for (id, name, planning_periods) in cursor:
        return Mentor(id, name, planning_periods)

def getMentorByName(name):
    query = ("SELECT * FROM mentor WHERE name='%s'" %(name))
    cursor = runMySQLOperation(query)
    for (id, name, planning_periods) in cursor:
        return Mentor(id, name, planning_periods)

def getCourseSectionNumByMentor(mentor_id):
    query = ("SELECT * FROM course_enrollment WHERE user_id=%s AND is_mentor=1" %(mentor_id))
    cursor = runMySQLOperation(query)
    totalSections = 0
    for (id, name, planning_periods) in cursor:
        totalSections += 1
    return totalSections
    