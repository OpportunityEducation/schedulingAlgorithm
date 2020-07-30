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

#init 
def init():
    global allCourseSections, courseSectionId, duplicates_num
    courseSectionId = enrollment.courseSectionId
    allCourseSections = enrollment.allCourseSections
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
    print("dealing with duplicates")
    dealtWithIDs = []
    duplicateCourses = queries.getAllNonzeroDuplicates()
    for dv in duplicateCourses:
        print(dv.id)
    duplicateCourses.sort(key=lambda x: x.duplicates_num, reverse=True)

    #do classes that are self contained duplicates then do rest of duplicates
    for i in range (2):
        noSizeRun = False
        if i == 1:
            noSizeRun = True
        for course in duplicateCourses:
            parentSection = queries.getCourseSectionsByCourseID(course.id)
            enrolledIn = queries.getStudentIDsEnrolledByCourseSection(parentSection[0].id)
            if (noSizeRun or len(enrolledIn) < settings.maxDuplicateClassSize) and parentSection[0].course_id not in dealtWithIDs:
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
                    duplicateInfo = splitDuplicate(duplicateRoster, enrolledIn, noSizeRun)
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
                    if problem.course_id not in dealtWithIDs:
                        enrollDuplicates(problem, duplicateSections, duplicateSectionsMales)
                    dealtWithIDs.append(problem.course_id)

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


def splitDuplicate(roster, parentRoster, isNotSmallClass): #, parentCourseId): #roster contains all names of students
    print("splitting duplicate")
    males = []
    nonMales = []
    smallRoster = []
    numSections = int(len(roster)/settings.maxDuplicateClassSize)
    if len(roster)%settings.maxDuplicateClassSize > 0:
        numSections += 1
    splitRoster = [[] for _ in range(numSections)]
    splitRosterMales = [0 for _ in range(numSections)]
    for studentId in roster:
        if not isNotSmallClass:
            if studentId not in parentRoster:
                student = queries.getStudentById(studentId)
                if student.gender == 'M':
                    males.append(student.id)
                else:
                    nonMales.append(student.id)
        else:
            student = queries.getStudentById(studentId)
            if student.gender == 'M':
                males.append(student.id)
            else:
                nonMales.append(student.id)
    
    males = list(set(males))
    nonMales = list(set(nonMales))

    #this is only for duplicates with class size less than max class size (no splitting)
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
            males = shuffleArray(males, 5)
            nonMales = shuffleArray(nonMales, 5)
            for i in range(len(males)):
                splitRoster[i%len(splitRoster)].append(males.pop(0))
                splitRosterMales[i%len(splitRoster)] += 1
            for i in range(len(nonMales)):
                splitRoster[i%len(splitRoster)].append(nonMales.pop(0))

    return [splitRoster, splitRosterMales]


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
