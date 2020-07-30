#imports and runs all necessary SQL queries
import mysql.connector

import classes
from classes import Course, Student, Mentor, RankedCourse, EnrolledCourse, CourseSection, Classroom, CourseConflict
from classes import UnformattedPreference, UnformattedQualification, MentorQualifiedClass, CommitmentBlock
from usefulFunctions import runMySQLOperation

#create and print queries

# STUDENTS
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

def getStudentById(id):
    query = ("SELECT * FROM student WHERE id=%s" %(id))
    cursor = runMySQLOperation(query)
    for (id, name, gender, year, free_periods) in cursor:
        return Student(id, name, gender, year, free_periods)

def getAllStudentIDsWithCommitments():
    query = ("SELECT * FROM student_commitments")
    cursor = runMySQLOperation(query)
    ids = []
    for (commitment_type_id, student_id, day_id, start_time, end_time) in cursor:
        ids.append(student_id)
    #idSet = set(ids)
    return set(ids)

def getStudentsEnrolledByCourseName(name):
    query = ("SELECT * from formatted_output WHERE class_name='%s'" %(name))
    cursor = runMySQLOperation(query)
    names = []
    for (name, year, gender, class_name, mentor, section_number, period, classroom) in cursor:
        names.append(name)
    return names


# DAYS
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


# STUDENT COURSE PREFERENCES
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

def getStudentEnrollmentPreferencesByID(id):
    query = ("SELECT * FROM student_course_preferences_unenrolled WHERE student_id=%s" %(id))
    cursor = runMySQLOperation(query)
    requestedCourses = []
    for (id, student_id, course_id, ranking) in cursor:
        requestedCourses.append(RankedCourse(id, course_id, ranking))
    return requestedCourses


# COURSES
def getAllCourses():
    query = ("SELECT * FROM course")
    cursor = runMySQLOperation(query)
    allCourses = []
    for (id, name, allowed_grades, is_elective, course_type) in cursor:
        allCourses.append(Course(id, name, allowed_grades, is_elective, course_type))
    return allCourses

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

def getCoreCourses():
    query = ("SELECT * FROM course WHERE is_elective=0")
    cursor = runMySQLOperation(query)
    courses = []
    for (id, name, allowed_grades, is_elective, course_type) in cursor:
        courses.append(Course(id, name, allowed_grades, is_elective, course_type))
    return courses

def getCoreCourseIds():
    query = ("SELECT * FROM course WHERE is_elective=0")
    cursor = runMySQLOperation(query)
    ids = []
    for (id, name, allowed_grades, is_elective, course_type) in cursor:
        ids.append(id)
    return ids


# COURSE SECTIONS
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

def getCourseSectionNumByMentor(mentor_id):
    query = ("SELECT * FROM course_enrollment WHERE user_id=%s AND is_mentor=1" %(mentor_id))
    cursor = runMySQLOperation(query)
    return cursor.rowcount   

def getCourseSectionCount():
    query = ("SELECT * FROM course_section")
    cursor = runMySQLOperation(query)
    return cursor.rowcount

def getCourseSectionIDsByMentorID(mentor_id):
    query = ("SELECT course_section_id FROM course_enrollment WHERE user_id=%s AND is_mentor=1" %(mentor_id))
    cursor = runMySQLOperation(query)
    ids = []
    for course_section_id in cursor:
        ids.append(course_section_id)
    return ids

def getCourseSectionsByPeriod(i):
    query = ("SELECT * from course_section WHERE class_period=%s" %(i))
    cursor = runMySQLOperation(query)
    allSections = []
    for (id, course_id, section_number, classroom_id, class_period, students_enrolled, males_enrolled) in cursor:
        allSections.append(CourseSection(id, course_id, section_number, classroom_id, class_period, students_enrolled, males_enrolled))
    return allSections


# COURSE ENROLLMENT
def getStudentEnrollmentByStudentID(id):
    query = ("SELECT * FROM course_enrollment WHERE is_mentor=0 AND user_id=%s" %(id))
    cursor = runMySQLOperation(query)
    enrolledCourses = []
    for (course_section_id, is_mentor, user_id) in cursor:
        enrolledCourses.append(EnrolledCourse(course_section_id, user_id))
    return enrolledCourses

def getStudentIDsEnrolledByCourseSection(course_section_id):
    query = ("SELECT * FROM course_enrollment WHERE course_section_id=%s and is_mentor=0" %(course_section_id))
    cursor = runMySQLOperation(query)
    ids = []
    for (user_id, course_section_id, is_mentor) in cursor:
        ids.append(user_id)
    return ids


# MENTORS
def getMentorIDByCourseSection(id):
    query = ("SELECT user_id FROM course_enrollment WHERE is_mentor=1 AND course_section_id=%s" %(id))
    cursor = runMySQLOperation(query)
    for user_id in cursor:
        return user_id

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


# UNFORMATTED PREFERENCES
def getAllUnformattedPreferences():
    query = ("SELECT * FROM unformatted_preferences")
    cursor = runMySQLOperation(query)
    preferences = []
    for (student_id, student_name, gender, grade, free_periods, req_1, req_2, req_3, req_4, req_5, req_6) in cursor:
        preferences.append(UnformattedPreference(student_id, student_name, gender, grade, free_periods, req_1, req_2, req_3, req_4, req_5, req_6))
    return preferences


# UNFORMATTED QUALIFICATIONS
def getAllUnformattedQualifications():
    query = ("SELECT * FROM unformatted_mentor_qualifications")
    cursor = runMySQLOperation(query)
    qualifications = []
    for (id, name, planning_periods, course_1, course_2, course_3, course_4, course_5, course_6, course_7) in cursor:
        qualifications.append(UnformattedQualification(id, name, planning_periods, course_1, course_2, course_3, course_4, course_5, course_6, course_7))
    return qualifications


# MENTOR QUALIFIED COURSES
def getQualificationByID(courseID):
    query = ("SELECT * FROM mentor_qualified_courses WHERE course_id=%s" %(courseID))
    cursor = runMySQLOperation(query)
    mentorQuals = []
    for (id, mentor_id, course_id) in cursor:
        mentorQuals.append(MentorQualifiedClass(id, mentor_id, course_id))
    return mentorQuals



# STUDENT COMMITMENTS
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

    
# PERIODS
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

def getPeriodsLeftByID(id):
    query = ("SELECT periods_left FROM periods WHERE id=%s" %(id))
    cursor = runMySQLOperation(query)
    periodsLeft = []
    for periods_left in cursor:
        periodsLeft.append(periods_left)
    pL = [x[0] for x in periodsLeft]
    return pL[0]

def getEnrolledPeriodsForMentor(course_section_id):
    query = ("SELECT class_period FROM course_section WHERE id=%s" %(course_section_id))
    cursor = runMySQLOperation(query)
    mentorSections = 0
    for class_period in cursor:
        mentorSections.append(class_period)
    return mentorSections

def getPeriodFromCourseSectionID(sectionID):
    query = ("SELECT class_period FROM course_section WHERE id=%s" %(sectionID))
    cursor = runMySQLOperation(query)
    cps = []
    for class_period in cursor:
        cps.append(class_period)
    cp = [x[0] for x in cps]
    return cp[0]


# MENTOR AVAILABILITY
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


# COURSE TYPES
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


# CLASSROOMS
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
    idList = [x[0] for x in roomIds]
    return idList
    #return roomIds

def getRoomByID(id):
    query = ("SELECT * FROM classroom WHERE id=%s" %(id))
    cursor = runMySQLOperation(query)
    for (id, name, capacity, classroom_type_id) in cursor:
        return Classroom(id, name, capacity, classroom_type_id)

def getAllRooms():
    query = ("SELECT * from classroom")
    cursor = runMySQLOperation(query)
    ids = []
    for (id, name, capacity, classroom_type_id) in cursor:
        ids.append(id)
    return ids


# CAPACITY
def getCapacityByRoomId(room_id):
    query = ("SELECT capacity FROM classroom WHERE id=%s" %(room_id))
    cursor = runMySQLOperation(query)
    cap = []
    for capacity in cursor:
        cap.append(capacity)
    cp = [x[0] for x in cap]
    return cp[0]


# COURSE CONFLICTS (DUPLICATES)
def getCourseConflictsByCourse(id):
    query = ("SELECT * from course_conflicts WHERE id=%s" %(id))
    cursor = runMySQLOperation(query)
    for (id, dupes, dupeNum, contains, sectNum) in cursor:
        return CourseConflict(id, dupes, dupeNum, contains, sectNum)

def getAllNonzeroDuplicates():
    query = ("SELECT * FROM course_conflicts WHERE duplicates_num > 0")
    cursor = runMySQLOperation(query)
    obj = []
    for (id, dupes, dupeNum, contains, sectNum) in cursor:
        obj.append(CourseConflict(id, dupes, dupeNum, contains, sectNum))
    return obj
    