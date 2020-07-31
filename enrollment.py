#responsible for class assignemnts

import queries, inserts, settings, deletions, mysqlUpdates, usefulFunctions, scheduling, enrollmentDuplicates
from random import shuffle
from usefulFunctions import shuffleArray
from scheduling import groupAvailability

global allCourseSections, courseSectionId #, conflictDict, duplicates_num
# duplicates = ""
# duplicates_num = 0
allCourseSections = None
courses = []
courseSectionId = 0 

#init 
def init(studentList):
    allCourseSections = []
    allCourses = queries.getAllCourses()
    global courses
    for course in allCourses:
        if (queries.getStudentCoursePreferencesByCourseID(course.id)):
            courses.append(course)
    for i in range(settings.periods):
        for student in studentList:
            findCourseSection(student)
    allCourseSections = queries.getAllCourseSections()

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
    global courseSectionId, allCourseSections, duplicates
    print("balancing sections")
    allCourseSections = queries.getAllCourseSections()

    for section in allCourseSections:
        if (section.students_enrolled > settings.maxClassSize):
            splitSection(section, section.course_id)
        else:
            mysqlUpdates.updateCourseSectionEnrollment(section.id, section.students_enrolled, 0)

def addSectionFormattedOutput(section):
    course = queries.getCourseByID(section.course_id)
    studentIDs = queries.getStudentIDsEnrolledByCourseSection(section.id)
    mentorId = queries.getMentorIDByCourseSection(section.id)
    mentor = queries.getMentorByID(mentorId)
    students = []
    for studentID in studentIDs:
        students.append(queries.getStudentById(studentID))
    for student in students:
        inserts.addFormattedOuput(student.name, student.year, student.gender, course.name, mentor.name, section.section_number)

def splitSection(section, courseId):
    global courseSectionId
    #("splitting section of class %s" %(courseId))
    course = queries.getCourseByID(section.course_id)
    # courseSections = queries.getCourseSectionsByCourseID(courseId)
    studentIDs = queries.getStudentIDsEnrolledByCourseSection(section.id)

    numSections = 1 + int(section.students_enrolled/settings.maxClassSize)
    if section.students_enrolled%settings.maxClassSize > 0:
        numSections += 1

    #get number of students they should have
    splitSections = [0 for _ in range(numSections-1)]
    for i in range(section.students_enrolled):
        splitSections[i%len(splitSections)] += 1
    splitSections.sort(reverse=True)
    for i in range(2, numSections):
        courseSectionId += 1
        inserts.createCourseSection(courseSectionId, section.course_id, i)
    courseSections = queries.getCourseSectionsByCourseID(courseId) 

    for courseSection in courseSections:
        mysqlUpdates.updateCourseSectionEnrollment(courseSection.id, splitSections[0], 0)


  
  
#assign mentors to course sections
def matchMentors():
    print("matching mentors with qualified courses")
    allCourseSections = queries.getAllCourseSections()
    for section in allCourseSections:
        mentors = queries.getQualificationByID(section.course_id)
        course = queries.getCourseByID(section.course_id)
        mentorName = "TBA" #no mentor for Omaha currently qualified for music
        if len(mentors) > 0 :
            mentors = shuffleArray(mentors, 5)
            mentorName = getMentorWithLeastCourseSections(mentors)
        mentor = queries.getMentorByName(mentorName)
        inserts.addMentorToCourseSection(section.id, mentor.id)
        mentor_id = queries.getMentorIDByCourseSection(section.id)
        mysqlUpdates.updateFormattedOutput(mentorName, course.name, section.section_number)

def getMentorWithLeastCourseSections(mentors):
    #ADD IN CHECKING HOW MANY FREE PERIODS THEY NEED
    addMentor = mentors[0]
    addMentorSections = queries.getCourseSectionNumByMentor(addMentor.mentor_id)
    for mentor in mentors:
        numSections = queries.getCourseSectionNumByMentor(mentor.mentor_id)
        if addMentorSections > numSections:
            addMentor = mentor
            addMentorSections = numSections
    mentor = queries.getMentorByID(addMentor.mentor_id)
    return mentor.name
