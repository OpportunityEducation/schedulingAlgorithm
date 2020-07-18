#responsible for class assignemnts

import queries, inserts, settings, deletions, mysqlUpdates, usefulFunctions
from random import shuffle
from usefulFunctions import shuffleArray

courses = []
allCourseSections = []
courseSectionId = 0
cs1 = []
cs2 = []
cs1M = 0
cs2M = 0

#init 
def init(studentList):
    getRequestedCourses(studentList)
    enroll(studentList, 0)

#first find all courses that have been requested 
def getRequestedCourses(students):
    allCourses = queries.getAllCourses()
    global courses
    for course in allCourses:
        if (queries.getStudentCoursePreferencesByCourseID(course.id)):
            courses.append(course)

#broad enrollment loop
def enroll(studentList, round):
    for student in studentList:
        findCourseSection(student)

#specific student enrollment function; creates or finds a course section
def findCourseSection(student):
    global courseSectionId, allCourseSections
    studentReqs = queries.getStudentEnrollmentPreferencesByID(student.id)
    for req in studentReqs:
        course = queries.getCourseByID(req.course_id)
        courseSections = queries.getCourseSectionsByCourseID(course.id)
        if len(courseSections) > 0: #course section exists, add kid to class roster
            enrollStudent(courseSections[0], student)
        else : 
            courseSectionId = int(courseSectionId) + 1
            inserts.createCourseSection(courseSectionId, course.id, 1)
            courseSection = queries.getCourseSectionByID(courseSectionId)
            enrollStudent(courseSection, student)
        deletions.deleteStudentCoursePreference(student.id, course.id, req.id)
        break #remove if we want some classes to have limited sections

#add student to course_enrollment and update enrollment numbers in course_section
def enrollStudent(section, student):
    males = int(section.males_enrolled)
    if(student.gender == 'M'):
        males += 1
    enrolled = int(section.students_enrolled) + 1
    mysqlUpdates.updateCourseSectionEnrollment(section.id, enrolled, males)
    inserts.enrollStudentByID(student.id, section.id)

#split sections and balance ratio if necessary
def balanceSections():
    global courseSectionId, allCourseSections
    print("balancing sections")
    allCourseSections = queries.getAllCourseSections()
    for section in allCourseSections:
        if (section.students_enrolled > settings.maxClassSize):
            print("splitting needed")
            courseSectionId = int(courseSectionId) + 1
            inserts.createCourseSection(courseSectionId, section.course_id, 2)
            courseSectionId = int(courseSectionId) + 1
            # if(section.students_enrolled > (settings.maxClassSize*2)): #create three sections
            #     inserts.createCourseSection(courseSectionId, section.course_id, 3)
            splitSection(section.course_id)
        else :
            addSectionFormattedOutput(section.course_id, section)
    allCourseSections = queries.getAllCourseSections()

def addSectionFormattedOutput(courseId, section):
    course = queries.getCourseByID(courseId)
    studentIDs = queries.getStudentIDsEnrolledByCourseSection(section.id)
    if course.id == 2:
        print(studentIDs)
        print (section.id)
    students = []
    for studentID in studentIDs:
        students.append(queries.getStudentByID(studentID))
    for student in students:
        inserts.addFormattedOuput(student.name, student.year, student.gender, course.name, "TBA", 1)
        if course.name == "EP1: English":
            print("ADDING %s WHO'S IN YEAR %s TO COURSE %s" %(student.name, student.year, course.name))

def splitSection(courseId):
    print("splitting section of class %s" %(courseId))
    global cs1, cs2, cs1M, cs2M
    course = queries.getCourseByID(courseId)
    courseSections = queries.getCourseSectionsByCourseID(courseId)
    studentIDs = queries.getStudentIDsEnrolledByCourseSection(courseSections[0].id)
    females = []
    nonFemales = []
    for studentID in studentIDs:
        student = queries.getStudentByID(studentID)
        if student.gender == 'F':
            females.append(student)
        else :
            nonFemales.append(student)

    #balance the gender ratio
    if len(females) < 4:
        adjustRatio(females, nonFemales, "skewed male")
    elif len(nonFemales) < 4:
        adjustRatio(females, nonFemales, "skewed female")
    else :
        adjustRatio(females, nonFemales, "none")

    #update course sections (id, students_enrolled, males_enrolled):
    mysqlUpdates.updateCourseSectionEnrollment(courseSections[0].id, len(cs1), cs1M)
    mysqlUpdates.updateCourseSectionEnrollment(courseSections[1].id, len(cs2), cs2M)

    #enroll students
    for student in cs2:
        mysqlUpdates.updateCourseEnrollment(student.id, courseSections[0].id, courseSections[1].id)

    #add into formatted output
    tba = queries.getMentorByName('TBA')
    for student in cs1:
        inserts.addFormattedOuput(student.name, student.year, student.gender, course.name, tba, 1)
    for student in cs2:
        inserts.addFormattedOuput(student.name, student.year, student.gender, course.name, tba, 2)

    # if len(courseSections) == 2: #split two ways
    #     if len(females) < 4: #enroll all girls in one class 
    #         cs1 = females   
    # else : #split three ways

#adjust gender ratio
def adjustRatio(females, nonFemales, skew):
    females = shuffleArray(females, 5) #add if not worried abt grades
    nonFemales = shuffleArray(nonFemales, 5) #add if not worried abt grades
    global cs1, cs2, cs1M, cs2M
    cs1M = 0
    cs2M = 0
    cs1 = []
    cs2 = []
    if(skew == "skewed female"):
        cs1 = nonFemales
        cs1M = len(nonFemales)
        for i in range (0, len(females)):
            if i%2 == 1:
                cs1.append(females[i])
            elif i > len(females)-len(nonFemales):
                cs2.append(females[i])
            else :
                cs2.append(females[i])
    elif(skew == "skewed male"):
        cs1 = females
        for i in range (0, len(nonFemales)):
            if i%2 == 1:
                cs1.append(nonFemales[i])
                cs1M += 1
            elif i > len(nonFemales)-len(females):
                cs2.append(females[i])
                #cs2M += 1
            else:
                cs2.append(nonFemales[i])
                #cs2M += 1
        #cs2M = len(nonFemales) - cs1M
    elif skew == "none" :
        for i in range (0, len(females)):
            if i%2 == 1:
                cs1.append(females[i])
            else :
                cs2.append(females[i])
        for i in range (0, len(nonFemales)):
            if i%2 == 1:
                cs1.append(nonFemales[i])
                cs1M += 1
            else:
                cs2.append(nonFemales[i])
                #cs2M += 1
    cs2M = len(nonFemales) - cs1M
  
  
#assign mentors to course sections
def matchMentors():
    print("matching mentors with qualified courses")
    for section in allCourseSections:
        mentors = queries.getQualificationByID(section.course_id)
        course = queries.getCourseByID(section.course_id)
        mentorName = "TBA" #no mentor for Omaha currently qualified for music
        if len(mentors) > 0 :
            mentors = shuffleArray(mentors, 5)
            mentorName = getMentorWithLeastCourseSections(mentors)
        mentor = queries.getMentorByName(mentorName)
        inserts.addMentorToCourseSection(course.id, mentor.id)
        mysqlUpdates.updateFormattedOutput(mentorName, course.name, section.section_number)

def getMentorWithLeastCourseSections(mentors):
    addMentor = mentors[0]
    addMentorSections = queries.getCourseSectionNumByMentor(addMentor.mentor_id)
    for mentor in mentors:
        numSections = queries.getCourseSectionNumByMentor(mentor.mentor_id)
        if addMentorSections > numSections:
            addMentor = mentor
            addMentorSections = numSections
    mentor = queries.getMentorByID(addMentor.mentor_id)
    return mentor.name