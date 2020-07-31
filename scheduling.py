#responsbile for assigning class periods and classrooms

import settings, inserts, queries, deletions, usefulFunctions 
import enrollment, random, mysqlUpdates, enrollment, assignRooms
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
    #conflicts = enrollment.conflictDict
    print("init scheduling")
    remainingCourseSections = []

    assignDuplicates()

    #assign limited availability mentors first 
    for course_section in enrollment.allCourseSections:
        mentor_id = queries.getMentorIDByCourseSection(course_section.id)
        if mentor_id in limitedMentors:
            assignPeriod(mentor_id, course_section, True)
        else :
            remainingCourseSections.append(course_section)

    #then assign rest of mentors
    print("assigning mentors")
    for course_section in remainingCourseSections:
        if course_section.class_period == 0: 
            mentor_id = queries.getMentorIDByCourseSection(course_section.id)
            assignPeriod(mentor_id, course_section, False)
    print("done assigning mentors")

    for i in range(1, settings.periods+1):
        period = queries.getCourseSectionsByPeriod(i)
        #checkConflicts(period)

    print("assigning periods")
    assignRooms.init()



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


def assignPeriod(mentor_id, course_section, isLimited):
    noMatch = True
    posPeriods = [1, 2, 3, 4, 5, 6]
    posPeriods = set(posPeriods) - set(checkMentorEnrolledPeriods(mentor_id))
    posPeriods = list(posPeriods)
    if len(posPeriods) > 0:
        if(isLimited):
            limits = queries.getMentorAvailabilityByID(mentor_id)
            while True:
                index = posPeriods[randint(0, len(posPeriods)-1)]
                period = periods[index]
                periodsLeft = queries.getPeriodsLeftByID(index)
                if periodsLeft > 0: #& balancePeriods(periodsLeft):
                    noConflict = True
                    for bk in period:
                        noConflict &= checkContainment(bk, limits)
                    if(noConflict):
                        mysqlUpdates.updatePeriodForCourseSection(index, course_section.id)
                        periodsLeft -= 1
                        mysqlUpdates.decrementPeriodsLeft(index, periodsLeft)
                        break                    
        else :
            while noMatch:
                index = posPeriods[randint(0, len(posPeriods)-1)]
                period = periods[index]
                periodsLeft = queries.getPeriodsLeftByID(index)
                if periodsLeft > 0:
                    mysqlUpdates.updatePeriodForCourseSection(index, course_section.id)
                    periodsLeft -= 1
                    mysqlUpdates.decrementPeriodsLeft(index, periodsLeft)
                    noMatch = False
                    break
    else:
        print("mentor has run out of possible sections")

#determine if limited availability excludes randomly selected period
def checkContainment(period, limits):
    for limit in limits:
        if(limit.day_id == period.day_id):
            lStart = convertToMinutes(str(limit.start_time))
            lEnd = convertToMinutes(str(limit.end_time))
            pStart = convertToMinutes(str(period.start_time))
            pEnd = convertToMinutes(str(period.end_time))
            if (lStart < pStart & lEnd < pEnd & lEnd > pStart) | (lStart < pStart & lEnd > pEnd) | (lStart > pStart & lEnd < pEnd) | (lStart > pStart & lStart < pEnd & lEnd > pEnd):
                return False
        return True


def checkMentorEnrolledPeriods(mentor_id):
    sectionIDs = queries.getCourseSectionIDsByMentorID(mentor_id)
    periods = []
    for sectionID in sectionIDs:
        periods.append(queries.getPeriodFromCourseSectionID(sectionID))
    return periods


#control for randomization outlying possibility of heavily lopsided enrollment
def balancePeriods(periodsLeft):
    remainders = []
    for i in range (1,7):
        remainders.append(queries.getPeriodsLeftByID(i))
    return True


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
                    sectionBase = queries.getCourseSectionsByCourseID(groupContains[0])
                    for i in range (len(sectionBase)):
                        sectionBasis[i+1] = queries.getStudentIDsEnrolledByCourseSection(sectionBase[i].id)
                    #print("section basis is %s" %(sectionBasis))
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
        allSections += courseSections
    sharedStudents = list(getDuplicateRoster(allSections))
    
    
    print("has a bsis")

def enrollWithoutBasis(basis, courses):
    if len(basis) == 2: #single section courses, just enroll normally
        print("single section based")
        for course in courses:
            courseSections = queries.getCourseSectionsByCourseID(course.id)
            #FIND PERIODS FOR THIS BABY
            enrollment.addSectionFormattedOutput(courseSections[0])
    else:
        allSections = []
        for course in courses:
            courseSections = queries.getCourseSectionsByCourseID(course.id)
            allSections += courseSections
        sharedStudents = getDuplicateRoster(allSections)
        print("sharedStudents: %s" %(sharedStudents))
        sharedSections = splitStudents(basis, list(sharedStudents))
        for course in courses: 
            courseSections = queries.getCourseSectionsByCourseID(course.id)
            print("courseSections: %s" %(courseSections))
            courseSpecificStudents = queries.getStudentIDsEnrolledByCourseSection(courseSections[0].id)
            print("course specific students %s" %(courseSpecificStudents))
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
            formatThese = queries.getCourseSectionsByCourseID(course.id)
            for ft in formatThese:
                enrollment.addSectionFormattedOutput(ft)
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
    