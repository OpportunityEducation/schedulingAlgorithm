#responsbile for assigning class periods and classrooms

import settings, inserts, queries, deletions, usefulFunctions, assignPeriods
import enrollment, random, mysqlUpdates, assignRooms, enrollmentDuplicates
from random import randint
from usefulFunctions import convertToMinutes, shuffleArray

global conflicts
conflicts = dict()
periods = []
limitedMentors = []

#init
def init():
    #NEED TO INIT AMOUNT PER PERIODS (COURSE SECTION COUNT/SETTINGS.NUMBER OF PERIODS)
    global periods, limitedMentors #, conflicts 
    periods = queries.getAllPeriodTimeBlocks()
    limitedMentors = queries.getMentorIDsWithLimitedAvailability()
    conflicts = dict.fromkeys(list(range(1, settings.maxClassSize+1))) #keep track of all differences
    
    print("init scheduling")
    assignDuplicates()

    # for cs in queries.getAllCourseSections():
    #     enrollment.addSectionFormattedOutput(cs)

    assignPeriods.init()
    assignRooms.init()
    print("finished scheduling")

#checks availability and if matching, groups 
def groupAvailability(users): #, isMentor):
    ids = queries.getAllStudentIDsWithCommitments()
    ids = ids & set(users)
    blocks = queries.getAllDistinctStudentCommitmentTimeBlocks()
    if len(blocks) == 1:
        return [ids]
    else:
        groups = []
        for block in blocks:
            group = queries.getAllStudentsIDsWithSpecificCommitmentBlock(block)
            groups.append(group)
        return groups


def assignDuplicates():
    global conflicts
    duplicatesDealtWith = []
    allDuplicates = queries.getAllNonzeroDuplicates()
    allContainers = queries.getAllNonzeroContainerIds()
    duplicateContainerIds = []
    allDuplicates.sort(key=lambda x: x.number_of_sections)
    largestSectionNum = allDuplicates[len(allDuplicates)-1].number_of_sections
    #index = 0
    duplicatesGroups = [[] for _ in range(largestSectionNum+1)]
    print(duplicatesGroups)

    #get dif groups based on sections
    for dup in allDuplicates:
        duplicatesGroups[dup.number_of_sections].append(dup)
        if dup.id in allContainers:
            duplicateContainerIds.append(dup.id)

    #go through and enroll based on duplicates within group (most is first)
    for i in range (1, len(duplicatesGroups)):
        sectionBasis = [[] for _ in range(1, i+2)]
        sectionGroup = duplicatesGroups[i]
        sectionGroup.sort(key=lambda x: x.duplicates_num, reverse=True)
        for sectionGroupMember in sectionGroup:
            if sectionGroupMember.id in duplicatesDealtWith:
                break
            else:
                group = []
                group.append(sectionGroupMember)
                addThese = sectionGroupMember.duplicates.split(',')
                for sectGM in addThese:
                    group.append(queries.getCourseConflictsByCourse(sectGM))
                #print(group)
                groupContains = []
                for groupie in group:
                    if groupie.id in duplicateContainerIds:
                        withinGroup = groupie.contained_within.split(',')
                        groupContains += withinGroup
                        groupContains = list(set(groupContains))
                        # print("within this: ")
                        # print(groupContains)
                if len(groupContains) > 0: # fix this part later to check for greatest amount of conflicts
                    #print("has containees")

                    #find the greatest amount of sections
                    largestBasis = queries.getCourseConflictsByCourse(groupContains[0])
                    for containee in groupContains:
                        if queries.getCourseConflictsByCourse(containee).number_of_sections > largestBasis.number_of_sections:
                            largestBasis = containee

                    sectionBase = queries.getCourseSectionsByCourseID(largestBasis.id) #(groupContains[0])
                    for i in range (len(sectionBase)):
                        sectionBasis[i+1] = queries.getStudentIDsEnrolledByCourseSection(sectionBase[i].id)
                    print("section basis is %s" %(sectionBasis))
                    enrollWithBasis(sectionBasis, group)
                else: #just do it on random basis basically; later add in grouping of student conflicts
                    #print("no containees so")
                    enrollWithoutBasis(sectionBasis, group)
                #dealt with all in group so 
                for doneWith in group:
                    duplicatesDealtWith.append(doneWith.id)

    print("checking to see conflicts")


def enrollWithBasis(basis, courses):
    allSections = []
    for course in courses:
        courseSections = queries.getCourseSectionsByCourseID(course.id)
        print(len(queries.getStudentIDsEnrolledByCourseSection(courseSections[0].id)))
        allSections += courseSections
    sharedStudents = getDuplicateRoster(allSections)
    print("ENROLL WITH BASIS")
    print("basis")
    print(basis)
    unbased = []
    for i in range(len(basis)):
        if basis[i] == []:
            unbased.append(basis[i])

    print("unbased")
    print(unbased)

    #get students already enrolled
    basedStudents = []
    for base in basis:
        basedStudents += base
 
    unassignedStudents = sharedStudents - set(basedStudents)
    unassignedStudents = list(unassignedStudents)

    unbased = splitStudents(unbased, unassignedStudents)
    unbased.remove([])
    print("split unbased")
    print(unbased)

    #   ADD BACK IN FOR OTHER COURSES
    # for course in courses:
    #     courseSections = queries.getCourseSectionsByCourseID(course.id)
    #     #print("courseSections: %s" %(courseSections))
    #     courseSpecificStudents = queries.getStudentIDsEnrolledByCourseSection(courseSections[0].id)
    #     unassignedStudents = set(courseSpecificStudents) - sharedStudents
    #     unassignedStudents = list(unassignedStudents)
    #     rebased = splitStudents(unbased, unassignedStudents)
    #     rebased.remove([])
    #     realBasis = [[]]
    #     for i in range(len(basis)):
    #         if basis[i] != []:
    #             realBasis.append(basis[i])
    #     realBasis += rebased
    #     print("real basis")
    #     print(realBasis)

    # unbased.remove([])
    realBasis = [[]]
    for i in range(len(basis)):
        if basis[i] != []:
            realBasis.append(basis[i])

    print("basis edited")
    print(realBasis)

    realBasis += unbased
    print("new basis")
    print(realBasis)

    pt1 = realBasis[1]
    print(pt1)
    newRealBasis = []
    for i in range(5):
        # ap = pt1[i]
        realBasis[3].append(realBasis[1].pop(0))
    pt2 = realBasis[2]
    for i in range(6):
        # ap = pt2[i]
        realBasis[3].append(realBasis[2].pop(0))

    print("shared sections")
    print(realBasis)
    #[[], [66, 70, 75, 79, 80, 81, 82, 83, 84, 85, 86], [72, 73, 76, 77, 78, 87, 89], 
    # [67, 57, 58, 60, 61, 62, 65, 59, 63, 64, 68, 69, 71], [67, 57, 58, 60, 61, 62, 65, 59, 63, 64, 68, 69, 71]]
    sharedSections = realBasis
    for course in courses: 
        courseSections = queries.getCourseSectionsByCourseID(course.id)
        print("course sections" )
        print(courseSections)
        #print("courseSections: %s" %(courseSections))
        courseSpecificStudents = queries.getStudentIDsEnrolledByCourseSection(courseSections[0].id)
        #print("course specific students %s" %(courseSpecificStudents))
        unassignedStudents = set(courseSpecificStudents) - sharedStudents
        unassignedStudents = list(unassignedStudents)
        if len(unassignedStudents) > 0:
            courseSpecificSections = splitStudents(sharedSections, unassignedStudents)
        else:
            courseSpecificSections = sharedSections
        for i in range (1, len(courseSpecificSections)):
            css = courseSpecificSections[i]
            print("course specific sections")
            print(css)
            students_enrolled = 0
            for student in css:
                if student in courseSpecificStudents:
                    # updateCourseEnrollment(user_id, course_section_id, new_course_section):
                    mysqlUpdates.updateCourseEnrollment(student, courseSections[0].id, courseSections[i-1].id)
                    students_enrolled += 1
            mysqlUpdates.updateCourseSectionEnrollment(courseSections[i-1].id, students_enrolled, 0)
        # formatThese = queries.getCourseSectionsByCourseID(course.id)
        # for ft in formatThese:
        #     enrollment.addSectionFormattedOutput(ft)
    



def enrollWithoutBasis(basis, courses):
    print("ENROLL WITH NO BASIS")
    if len(basis) > 2:
        allSections = []
        for course in courses:
            courseSections = queries.getCourseSectionsByCourseID(course.id)
            allSections += courseSections
        sharedStudents = getDuplicateRoster(allSections)
        #print("sharedStudents: %s" %(sharedStudents))
        sharedSections = splitStudents(basis, list(sharedStudents))
        for course in courses: 
            courseSections = queries.getCourseSectionsByCourseID(course.id)
            #print("courseSections: %s" %(courseSections))
            courseSpecificStudents = queries.getStudentIDsEnrolledByCourseSection(courseSections[0].id)
            #print("course specific students %s" %(courseSpecificStudents))
            unassignedStudents = set(courseSpecificStudents) - sharedStudents
            unassignedStudents = list(unassignedStudents)
            if len(unassignedStudents) > 0:
                courseSpecificSections = splitStudents(sharedSections, unassignedStudents)
            else:
                courseSpecificSections = sharedSections
            for i in range (1, len(courseSpecificSections)):
                css = courseSpecificSections[i]
                students_enrolled = 0
                for student in css:
                    if student in courseSpecificStudents:
                        mysqlUpdates.updateCourseEnrollment(student, courseSections[0].id, courseSections[i-1].id)
                        students_enrolled += 1
                mysqlUpdates.updateCourseSectionEnrollment(courseSections[i-1].id, students_enrolled, 0)
            # formatThese = queries.getCourseSectionsByCourseID(course.id)
            # for ft in formatThese:
            #     enrollment.addSectionFormattedOutput(ft)
        #then just assign randomly **** TO DO: BASE ASSIGNEMNT ON STUDENT AVAILABILITY****
        print("has no basis")

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
    return set(duplicateRoster) # <-- set of all ids in multiple duplicates


def splitStudents(basis, students):
    print("splitting students")
    students = shuffleArray(students, 5)
    for i in range(len(students)):
        basis[(i%(len(basis)-1))+1].append(students.pop(0))
    return basis
  