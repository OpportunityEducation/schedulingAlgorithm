#responsible for class assignemnts

import queries, inserts, settings, deletions, mysqlUpdates, usefulFunctions, scheduling
from random import shuffle
from usefulFunctions import shuffleArray
from scheduling import groupAvailability

global allCourseSections, conflictDict, duplicates_num
duplicates = ""
duplicates_num = 0
courses = []
courseSectionId = 0
cs1 = []
cs2 = []
cs1M = 0
cs2M = 0

#init 
def init(studentList):
    allCourseSections = []
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
    global courseSectionId, allCourseSections, duplicates
    print("balancing sections")
    allCourseSections = queries.getAllCourseSections()

    #deal with the duplicates first 
    getBiggestConflicts()
    dealWithDuplicates()

    #then all the rest of the course sections
    for section in allCourseSections:
        if (section.students_enrolled > settings.maxClassSize):
            #print("splitting needed")
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
    students = []
    for studentID in studentIDs:
        students.append(queries.getStudentById(studentID))
    for student in students:
        inserts.addFormattedOuput(student.name, student.year, student.gender, course.name, "TBA", 1)

def splitSection(courseId):
    #("splitting section of class %s" %(courseId))
    global cs1, cs2, cs1M, cs2M
    course = queries.getCourseByID(courseId)
    courseSections = queries.getCourseSectionsByCourseID(courseId)
    studentIDs = queries.getStudentIDsEnrolledByCourseSection(courseSections[0].id)
    commitedGroups = groupAvailability(studentIDs)
    females = []
    nonFemales = []
    for studentID in studentIDs:
        student = queries.getStudentById(studentID)
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
            else:
                cs2.append(nonFemales[i])
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

#get conflicts for scheduling
def getBiggestConflicts():
    global duplicates, conflictDict, duplicates_num
    courses = queries.getAllCourses()
    conflictDict = dict()
    for i in range(len(courses)):
        course = courses[i]
        # print(course)
        conflicts = dict()
        course_conflict = queries.getCourseConflictsByCourse(course.id)
        # print(course_conflict)
        duplicates = course_conflict.duplicates
        duplicates_num = course_conflict.duplicates_num
        for j in range(i+1, len(courses)): #fix this part !!!!!
            if j < len(courses):
                other = courses[j]
                conflictNum = getOverlap(course, other)
                if conflictNum != 0:
                    conflicts[str(other.id)] = conflictNum
        mysqlUpdates.setDuplicates(duplicates, duplicates_num, course.id)
        print(duplicates)
        conflictDict[str(course.id)] = conflicts


#get exact overlap via roster
def getOverlap(course, otherCourse):
    global duplicates, duplicates_num
    courseSection = queries.getCourseSectionsByCourseID(course.id)
    if len(courseSection) == 0:
        return 0
    courseStudentIds = queries.getStudentIDsEnrolledByCourseSection(courseSection[0].id)
    otherSection = queries.getCourseSectionsByCourseID(otherCourse.id)
    if len(otherSection) == 0:
        return 0
    otherStudentIds = queries.getStudentIDsEnrolledByCourseSection(otherSection[0].id)
    if len(courseStudentIds) > 0:
        conflicts = 0
        for studentId in courseStudentIds:
            if studentId in otherStudentIds:
                conflicts += 1
        if conflicts/len(courseStudentIds) > .9 or conflicts/len(otherStudentIds) > .9:
            print("it's a duplicate")
            duplicates = updateCourseConflicts(otherCourse.id, duplicates, -1)
            print(duplicates)
            otherCourseConflicts = queries.getCourseConflictsByCourse(otherCourse.id)
            updateCourseConflicts(course.id, otherCourseConflicts.duplicates, otherCourse.id)
            duplicates_num += 1
            return conflicts
    else:
        print("NOT LONG ENOUGH")
    return 0


def updateCourseConflicts(courseId, newDuplicates, updateId):
    if newDuplicates is None:
        newDuplicates = str(courseId)
    else :
        newDuplicates += "," + str(courseId)
    if updateId != -1:
        mysqlUpdates.incrementDuplicateNum(updateId)
        mysqlUpdates.updateDuplicates(newDuplicates, updateId)
    return newDuplicates


def dealWithDuplicates():
    print("dealing with duplicates")
    dealtWithIDs = []
    duplicateCourses = queries.getAllNonzeroDuplicates()
    duplicateCourses.sort(key=lambda x: x.duplicates_num, reverse=True)
    print(duplicateCourses)

    #do classes that are self contained duplicates then do rest of duplicates
    for i in range (2):
        noSizeRun = False
        if i == 1:
            noSizeRun = True
        for course in duplicateCourses:
            print("checking duplicate course")
            parentSection = queries.getCourseSectionsByCourseID(course.id)
            enrolledIn = queries.getStudentIDsEnrolledByCourseSection(parentSection[0].id)
            if (noSizeRun or len(enrolledIn) < settings.maxDuplicateClassSize) and parentSection[0].course_id not in dealtWithIDs:
                problemSections = []
                dupes = queries.getCourseConflictsByCourse(course.id)
                problemIDs = (dupes.duplicates).split(",")
                for problemID in problemIDs:
                    newProblems = queries.getCourseSectionsByCourseID(problemID)
                    for prob in newProblems:
                        problemSections.append(prob)
                for sect in parentSection:
                    problemSections.append(sect)
                print(problemSections)
                duplicateRoster = list(getDuplicateRoster(problemSections))
                print("DUPLICATE ROSTER")
                print(duplicateRoster)
                print("***************")
                if len(duplicateRoster) > settings.maxDuplicateClassSize:
                    print("more students in duplicate class than possible in one section; splitting")
                    duplicateInfo = splitDuplicate(duplicateRoster, enrolledIn, noSizeRun)
                    duplicateSections = duplicateInfo[0]
                    duplicateSectionsMales = duplicateInfo[1]
                    print("SECTIONS ASSIGNED")
                    print(duplicateSections)
                    print("***************")
                else:
                    duplicateSections = duplicateRoster
                for problem in problemSections:
                    dealtWithIDs.append(problem.course_id)

def getDuplicateRoster(duplicateSections):
    allRosters = []
    idRoster = []
    # print("DUPLICATE SECTIONS")
    # print(duplicateSections)
    # print("************")
    for section in duplicateSections:
        students = queries.getStudentIDsEnrolledByCourseSection(section.id)
        allRosters.append(students)
        # course = queries.getCourseByID(section.course_id)
        # roster = queries.getStudentsEnrolledByCourseName(course.name)
        # allRosters.append(roster)
    print(allRosters)
    # for studentName in allRosters:
    #     student = queries.getStudentByName(studentName)
    #     idRoster.append(student.id)
    # allRosters = idRoster
    duplicateRoster = []
    for i in range (len(allRosters)):
        checkThis = allRosters[i]
        for j in range (i+1, len(allRosters)):
            if j < len(allRosters):
                for student in checkThis:
                    if student in allRosters[j]:
                        print("got here ")
                        duplicateRoster.append(student)
    return set(duplicateRoster) # <-- set of all names in multiple duplicates


def splitDuplicate(roster, parentRoster, isNotSmallClass): #, parentCourseId): #roster contains all names of students
    print("splitting duplicate")
    males = []
    nonMales = []
    smallRoster = []
    numSections = len(roster) 
    if len(roster)%settings.maxDuplicateClassSize > 0:
        numSections += 1
    splitRoster = [[] for _ in range(numSections)]
    splitRosterMales = [0 for _ in range(numSections)]
    for studentId in roster:
        if not isNotSmallClass:
            if not studentId in parentRoster:
                student = queries.getStudentById(studentId)
                if student.gender == 'M':
                    males.append(student)
                else:
                    nonMales.append(student)
        else:
            if not studentId in parentRoster:
                student = queries.getStudentById(studentId)
                if student.gender == 'M':
                    males.append(student)
                else:
                    nonMales.append(student)


    if not isNotSmallClass:
        for student in parentRoster:
            if student in roster:
                splitRoster[0].append(student)
        for student in splitRoster[0]:
            if queries.getStudentById(studentId).gender == 'M':
                splitRosterMales[0] += 1
        
        #assign rest of students
        for i in range(len(males)):
            splitRoster[(i%(len(splitRoster)-1))+1].append(males.pop(0))
            splitRosterMales[(i%(len(splitRoster)-1))+1] += 1
        for i in range(len(nonMales)):
            splitRoster[(i%(len(splitRoster)-1))+1].append(nonMales.pop(0))

    else:
    #assignThese = [] => if generalizing logic parts
    #***** TO DO: Basis of ratio not number ******
        if len(males) < 4:
            splitRoster[0] = males
            splitRosterMales[0] = len(males)
            nonMales = shuffleArray(nonMales, 5)
            for i in range(len(nonMales)):
                splitRoster[i%len(splitRoster)].append(nonMales.pop(0))
        elif len(nonMales) < 4:
            splitRoster[0] = nonMales
            males = shuffleArray(males, 5)
            for i in range(len(males)):
                splitRoster[i%len(splitRoster)].append(males.pop(0))
                splitRosterMales[i%len(splitRoster)] += 1
        else: 
            adjustRatio(nonMales, males, "none")
            males = shuffleArray(males, 5)
            nonMales = shuffleArray(nonMales, 5)
            for i in range(len(males)):
                splitRoster[i%len(splitRoster)].append(males.pop(0))
                splitRosterMales[i%len(splitRoster)] += 1
            for i in range(len(nonMales)):
                splitRoster[i%len(splitRoster)].append(nonMales.pop(0))
    
    return [splitRoster, splitRosterMales]

