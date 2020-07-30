#responsible for class assignemnts

import queries, inserts, settings, deletions, mysqlUpdates, usefulFunctions, scheduling, enrollment
from random import shuffle
from usefulFunctions import shuffleArray
from scheduling import groupAvailability

global courseSectionId
duplicates = ""
duplicates_num = 0
courseSectionId = 0
allCourseSections = []
sectionsAlreadySplit = []
coreCoursesIds = []

#init 
def init():
    global allCourseSections, courseSectionId, duplicates_num, coreCoursesIds
    courseSectionId = enrollment.courseSectionId
    allCourseSections = enrollment.allCourseSections
    coreCoursesIds = queries.getCoreCourseIds()
    getConflicts()
    dealWithDuplicates()

#get conflicts for scheduling
def getConflicts():
    global duplicates, duplicates_num
    courses = enrollment.courses
    for i in range(len(courses)):
        course = courses[i]
        course_conflict = queries.getCourseConflictsByCourse(course.id)
        duplicates = course_conflict.duplicates
        duplicates_num = course_conflict.duplicates_num
        for j in range(i+1, len(courses)): #fix this part !!!!!
            if j < len(courses):
                otherCourse = courses[j]
                courseSection = queries.getCourseSectionsByCourseID(course.id)
                conflictNum = 0
                courseStudentIds = queries.getStudentIDsEnrolledByCourseSection(courseSection[0].id)
                otherSection = queries.getCourseSectionsByCourseID(otherCourse.id)
                otherStudentIds = queries.getStudentIDsEnrolledByCourseSection(otherSection[0].id)
                if len(courseStudentIds) > 0:
                    conflicts = 0
                    for studentId in courseStudentIds:
                        if studentId in otherStudentIds:
                            conflicts += 1
                    if conflicts/len(courseStudentIds) > .9 or conflicts/len(otherStudentIds) > .9:
                        duplicates = updateCourseConflicts(otherCourse.id, duplicates, -1)
                        otherCourseConflicts = queries.getCourseConflictsByCourse(otherCourse.id)
                        updateCourseConflicts(course.id, otherCourseConflicts.duplicates, otherCourse.id)
                        duplicates_num += 1
                        conflictNum = conflicts
        mysqlUpdates.setDuplicates(duplicates, duplicates_num, course.id)


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
    global sectionsAlreadySplit
    print("dealing with duplicates")
    duplicateCourses = queries.getAllNonzeroDuplicates()
    for dv in duplicateCourses:
        print(dv.id)
    duplicateCourses.sort(key=lambda x: x.duplicates_num, reverse=True)

    #deal with courses as individuals
    for course in duplicateCourses:
        parentSection = queries.getCourseSectionsByCourseID(course.id)
        enrolledIn = queries.getStudentIDsEnrolledByCourseSection(parentSection[0].id)

        #figure out duplicate stuff
        problemSections = []
        dupes = queries.getCourseConflictsByCourse(course.id)
        problemIDs = (dupes.duplicates).split(",")
        for problemID in problemIDs:
            problemSections += queries.getCourseSectionsByCourseID(problemID)
        problemSections += parentSection
        duplicateRoster = list(getDuplicateRoster(problemSections))
        duplicateSectionsMales = 0
        if len(duplicateRoster) > settings.maxDuplicateClassSize:
            print("more students in duplicate class than possible in one section; splitting")
            duplicateInfo = splitDuplicate(duplicateRoster, problemSections)
            duplicateSections = duplicateInfo[0]
            duplicateSectionsMales = duplicateInfo[1]
        else:
            duplicateSections = [duplicateRoster]
            for studentId in duplicateSections[0]:
                student = queries.getStudentById(studentId)
                if student.gender == 'M':
                    duplicateSectionsMales += 1
            duplicateSectionsMales = [duplicateSectionsMales]
        for problem in problemSections:
            if problem.course_id not in sectionsAlreadySplit:
                enrollDuplicates(problem, duplicateSections, duplicateSectionsMales)
            sectionsAlreadySplit.append(problem.course_id)

def getDuplicateRoster(duplicateSections):
    allRosters = []
    idRoster = []
    for section in duplicateSections:
        students = queries.getStudentIDsEnrolledByCourseSection(section.id)
        allRosters.append(students)
    duplicateRoster = []
    for i in range (len(allRosters)):
        checkThis = allRosters[i]
        for j in range (i+1, len(allRosters)):
            if j < len(allRosters):
                for student in checkThis:
                    if student in allRosters[j]:
                        duplicateRoster.append(student)
    print("duplicate roster")
    print(set(duplicateRoster))
    return set(duplicateRoster) # <-- set of all ids in multiple duplicates


def splitDuplicate(roster, sections): #, parentCourseId): #roster contains all names of students
    global coreCoursesIds
    print("splitting duplicate")
    males = []
    nonMales = []
    smallRoster = []

    #core courses take priority, so find them first
    coreCourses = []
    electives = []
    for section in sections:
        if section.course_id in coreCourses:
            coreCourses.append(section)
        else:
            electives.append(section)
    coreCourses.sort(key=lambda x: x.students_enrolled) #, reverse=True)

   

def enrollDuplicates(duplicateSection, duplicateSectionAssignments, duplicateSectionsMale):
    global courseSectionId
    section = duplicateSection
    #section = queries.getCourseSectionByID(problem.id)
    students = queries.getStudentIDsEnrolledByCourseSection(section.id)
    unassignedStudentIds = []

    if section.course_id == 29:
        print("THIS IS FOR PE")
        for duplicateRoster in duplicateSectionAssignments:
            print (duplicateRoster)

    for duplicateRoster in duplicateSectionAssignments:
        for i in range (len(duplicateRoster)):
            if duplicateRoster[i] not in students:
                unassignedStudentIds.append(duplicateRoster[i])
    if section.course_id == 29:
        print("THIS IS FOR PE")
        print(len(unassignedStudentIds))
        print(students)
    numSections = int(len(students)/settings.maxClassSize)
    if len(students)%settings.maxClassSize > 0:
        numSections += 1

    if numSections > len(duplicateSectionAssignments):
        course = queries.getCourseByID(section.course_id)
        print("%s NEEDS AN extra section" %(course.name))
        print("%s unassigned students" %(len(unassignedStudentIds)))
        splitSections = [[] for _ in range(numSections-len(duplicateSectionAssignments))]
        splitSectionMales = [0 for _ in range(numSections-len(duplicateSectionAssignments))]
        for i in range(len(unassignedStudentIds)):
            splitSections[i%len(splitSections)].append(unassignedStudentIds.pop(0))
            splitSectionMales[i%len(splitSections)] += 1
        for ss in splitSections:
            duplicateSectionAssignments.append(ss)
        for sm in splitSectionMales:
            duplicateSectionsMale.append(sm)
    else:
        # assign unassigned students (non duplicates)
        unassignedStudentIds = shuffleArray(unassignedStudentIds, 5)
        for i in range(len(unassignedStudentIds)):
            studentId = unassignedStudentIds.pop(0)
            duplicateSectionAssignments[i%len(duplicateSectionAssignments)].append(studentId)
            if queries.getStudentById(studentId).gender == 'M':
                duplicateSectionsMale[i%len(duplicateSectionAssignments)] += 1
    
    #create new sections
    courseSections = [queries.getCourseSectionByID(section.id)]
    for i in range (2, len(duplicateSectionAssignments)):
        courseSectionId = int(courseSectionId) + 1
        inserts.createCourseSection(courseSectionId, section.course_id, i)
        courseSection = queries.getCourseSectionByID(courseSectionId)
        courseSections.append(courseSection)
    
    #NOW update sections and enroll students
    for courseSection in courseSections:
        course = queries.getCourseByID(courseSection.course_id)
        dsa = duplicateSectionAssignments[courseSection.section_number-1]
        mysqlUpdates.updateCourseSectionEnrollment(courseSection.id, len(dsa), duplicateSectionsMale[courseSection.section_number-1])

        #enroll students, add into formatted output
        tba = queries.getMentorByName('TBA')
        for studentId in dsa:
            mysqlUpdates.updateCourseEnrollment(studentId, courseSections[0].id, courseSection.id)
            student = queries.getStudentById(studentId)
