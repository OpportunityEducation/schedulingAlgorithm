#imports and runs all necessary SQL queries
import mysql.connector

import classes
from classes import Course, Student, Mentor, RankedCourse, EnrolledCourse, CourseSection
from classes import UnformattedPreference, UnformattedQualification, MentorQualifiedClass, CommitmentBlock
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
        return Student(id, name, gender, year, free_periods)

def getStudentByID(id):
    query = ("SELECT * FROM student WHERE id=%s" %(id))
    cursor = runMySQLOperation(query)
    for (id, name, gender, year, free_periods) in cursor:
        return Student(id, name, gender, year, free_periods)

def getDayById(dayId):
    query = ("SELECT * FROM day WHERE id = %s" %(dayId))
    cursor = runMySQLOperation(query)
    for (id, weekday) in cursor:
        return weekday

def getDayIDByName(weekday):
    query = ("SELECT * FROM day WHERE weekday = %s" %(weekday))
    cursor = runMySQLOperation(query)
    for (id, weekday) in cursor:
        return id

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
    for (id, name, allowed_grades, is_elective, course_type) in cursor:
        return Course(id, name, allowed_grades, is_elective, course_type)

def getCourseByName(name):
    query = ("SELECT * FROM course WHERE name='%s'" %(name))
    cursor = runMySQLOperation(query)
    for (id, name, allowed_grades, is_elective, course_type) in cursor:
        return Course(id, name, allowed_grades, is_elective, course_type)

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
    for (id, name, allowed_grades, is_elective, course_type) in cursor:
        allCourses.append(Course(id, name, allowed_grades, is_elective, course_type))
    return allCourses     

def getStudentEnrollmentByStudentID(id):
    query = ("SELECT * FROM course_enrollment WHERE is_mentor=0 AND user_id=%s" %(id))
    cursor = runMySQLOperation(query)
    enrolledCourses = []
    for (course_section_id, is_mentor, user_id) in cursor:
        enrolledCourses.append(EnrolledCourse(course_section_id, user_id))
    return enrolledCourses

def getMentorIDByCourseSection(id):
    query = ("SELECT user_id FROM course_enrollment WHERE is_mentor=1 AND course_section_id=%s" %(id))
    cursor = runMySQLOperation(query)
    for user_id in cursor:
        return user_id

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
    ids = []
    for (user_id, course_section_id, is_mentor) in cursor:
        ids.append(user_id)
    return ids

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
    return cursor.rowcount

def getEnrolledPeriodsForMentor(course_section_id):
    query = ("SELECT class_period FROM course_section WHERE id=%s" %(course_section_id))
    cursor = runMySQLOperation(query)
    mentorSections = 0
    for class_period in cursor:
        mentorSections.append(class_period)
    return mentorSections

def getAllStudentIDsWithCommitments():
    query = ("SELECT * FROM student_commitments")
    cursor = runMySQLOperation(query)
    ids = []
    for (commitment_type_id, student_id, day_id, start_time, end_time) in cursor:
        ids.append(student_id)
    #idSet = set(ids)
    return set(ids)

def getAllStudentCommitmentStartTimes():
    query = ("SELECT start_time FROM student_commitments")
    cursor = runMySQLOperation(query)
    starts = []
    for start_time in cursor:
        starts.append(start_time)
    return starts

def getAllDistinctStudentCommitmentTimeBlocks():
    query = ("SELECT day_id, start_time, end_time FROM student_commitments")
    cursor = runMySQLOperation(query)
    blocks = [] 
    for (day_id, start_time, end_time) in cursor:
        blocks.append(CommitmentBlock(day_id, start_time, end_time))
    return set(blocks)

def getAllStudentsIDsWithSpecificCommitmentBlock(block):
    query = ("SELECT student_id FROM student_commitments WHERE day_id=%s AND start_time='%s' AND end_time='%s'"
        %(block.day_id, block.start_time, block.end_time))
    cursor = runMySQLOperation(query)
    students = [] 
    for student_id in cursor:
        students.append(student_id)
    return set(students)  

def getAllPeriodTimeBlocks():
    query = ("SELECT * FROM periods")
    cursor = runMySQLOperation(query)
    periods = []
    periodID = 0
    period = []
    for (id, day_id, start_time, end_time, periods_left) in cursor:
        if periodID != int(id):
            periods.append(period)
            period = [CommitmentBlock(day_id, start_time, end_time)]
            periodID = id
        else:
            period.append(CommitmentBlock(day_id, start_time, end_time))
    periods.append(period)
    return periods  

def getMentorIDsWithLimitedAvailability():
    query = ("SELECT mentor_id FROM mentor_availability")
    cursor = runMySQLOperation(query)
    ids = []
    for mentor_id in cursor:
        ids.append(mentor_id)
    return set(ids)
    
def getMentorAvailabilityByID(id):
    query = ("SELECT day_id, start_time, end_time FROM mentor_availability WHERE mentor_id=%s" %(id))
    cursor = runMySQLOperation(query)
    blocks = []
    for (day_id, start_time, end_time) in cursor:
        blocks.append(CommitmentBlock(day_id, start_time, end_time))
    return blocks     

def getCourseSectionCount():
    query = ("SELECT * FROM course_section")
    cursor = runMySQLOperation(query)
    return cursor.rowcount

def getPeriodsLeftByID(id):
    query = ("SELECT periods_left FROM periods WHERE id=%s" %(id))
    cursor = runMySQLOperation(query)
    periodsLeft = []
    for periods_left in cursor:
        periodsLeft.append(periods_left)
    pL = [x[0] for x in periodsLeft]
    return pL[0]

def getCourseSectionIDsByMentorID(mentor_id):
    query = ("SELECT course_section_id FROM course_enrollment WHERE user_id=%s AND is_mentor=1" %(mentor_id))
    cursor = runMySQLOperation(query)
    ids = []
    for course_section_id in cursor:
        ids.append(course_section_id)
    return ids

def getPeriodFromCourseSectionID(sectionID):
    query = ("SELECT class_period FROM course_section WHERE id=%s" %(sectionID))
    cursor = runMySQLOperation(query)
    cps = []
    for class_period in cursor:
        cps.append(class_period)
    cp = [x[0] for x in cps]
    return cp[0]

def getNumberOfCourseTypes():
    query = ("SELECT * FROM classroom_type")
    cursor = runMySQLOperation(query)
    return cursor.rowcount

def getAllCourseTypes(typenum):
    query = ("SELECT * FROM classroom_type")
    cursor = runMySQLOperation(query)
    #change number of types if necessary
    types = dict.fromkeys(range(1,typenum), [])
    for (id, course_type) in cursor:
        types[id].append(course_type)
    return types

def getClassroomsByType(type_id):
    query = ("SELECT id FROM classroom WHERE classroom_type_id=%s" %(type_id))
    cursor = runMySQLOperation(query)
    ids = []
    for id in cursor:
        ids.append(id)
    idList = [x[0] for x in ids]
    return idList

def getRoomsBookedByPeriod(periodId):
    query = ("SELECT classroom_id FROM course_section WHERE class_period=%s" %(periodId))
    cursor = runMySQLOperation(query)
    roomIds = []
    for classroom_id in cursor:
        roomIds.append(classroom_id)
    # idList = [x[0] for x in roomIds]
    # return idList
    return roomIds

def getCapacityByRoomId(room_id):
    query = ("SELECT capacity FROM classroom WHERE id=%s" %(room_id))
    cursor = runMySQLOperation(query)
    cap = []
    for capacity in cursor:
        cap.append(capacity)
    cp = [x[0] for x in cap]
    return cp[0]
