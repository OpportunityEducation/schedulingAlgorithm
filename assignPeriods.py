#responsbile for assigning class periods and classrooms

import settings, inserts, queries, deletions, usefulFunctions 
import enrollment, random, mysqlUpdates, enrollment, assignRooms, enrollmentDuplicates
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
    #conflicts = dict() #.fromkeys(list(range(1, settings.maxClassSize+1))) #keep track of all differences
    print("INIT PERIODS")
    electiveCourseSections = []
    remainingCourseSections = []
    remainingCoreCourseSections = []

    allCourseSections = queries.getAllCourseSections()
    allCoreCourseIds = queries.getCoreCourseIds()
    allCoreCourseSections = []

    #grab all core course sections first 
    for course_section in allCourseSections:
        if course_section.course_id in allCoreCourseIds:
            allCoreCourseSections.append(course_section)
        else:
            electiveCourseSections.append(course_section)


    conflicts = dict.fromkeys(list(range(1, len(allCoreCourseSections)+1)))
    conflictSpecs = dict.fromkeys(list(range(1, len(allCoreCourseSections)+1)))
    for i in range(len(allCoreCourseSections)):
        core_section = allCoreCourseSections[i]
        students = queries.getStudentIDsEnrolledByCourseSection(core_section.id)
        #print(students)
        bigConflicts = 0
        conflictSpecsString = []
        for j in range(len(allCoreCourseSections)):
            numConflicts = 0
            other_section = allCoreCourseSections[j]
            if other_section.id != core_section.id:
                otherStudents = queries.getStudentIDsEnrolledByCourseSection(other_section.id)
                for student in students:
                    if student in otherStudents:
                        #print(student)
                        numConflicts += 1
                if numConflicts > 2:
                    bigConflicts += 1
                    conflictSpecsString.append(other_section.id)
        conflicts[core_section.id] = bigConflicts
        conflictSpecs[core_section.id] = conflictSpecsString
    conflicts_cleaned = {k:v for k,v in conflicts.items() if v != None}
    conflicts_specs_cleaned = {k:v for k,v in conflictSpecs.items() if v != None}
    print(conflicts_cleaned)
    sorted_core_conflicts = sorted(conflicts_cleaned.items(), key=lambda x: x[1], reverse=True)
    print(sorted_core_conflicts)
    print(conflicts_specs_cleaned)

    for course_section_id in sorted_core_conflicts:
        course_section = queries.getCourseSectionByID(course_section_id[0])
        mentor_id = queries.getMentorIDByCourseSection(course_section.id)
        conflict_specs = conflicts_specs_cleaned.get(course_section.id)
        if mentor_id in limitedMentors:
            assignPeriod(mentor_id, course_section, True, conflict_specs)
        else:
            remainingCoreCourseSections.append(course_section)

    for course_section in remainingCoreCourseSections:
        mentor_id = queries.getMentorIDByCourseSection(course_section.id)
        conflict_spec_strs = conflicts_specs_cleaned.get(course_section.id)
        conflict_specs = []
        for cnf in conflict_spec_strs:
            conflict_specs.append(int(cnf))
        assignPeriod(mentor_id, course_section, False, conflict_specs)

    print("finished with core courses")

    print(len(electiveCourseSections))

    # #assign elective courses
    # for course_section in electiveCourseSections:
    #     mentor_id = queries.getMentorIDByCourseSection(course_section.id)
    #     if mentor_id in limitedMentors:
    #         assignPeriod(mentor_id, course_section, True)
    #     else:
    #         remainingCourseSections.append(course_section)
    
    # print("finished halfway with electives")

    # for course_section in remainingCourseSections:
    #     mentor_id = queries.getMentorIDByCourseSection(course_section.id)
    #     assignPeriod(mentor_id, course_section, False)



def assignPeriod(mentor_id, course_section, isLimited, conflictSpecs):
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
                othersInPeriod = queries.getCourseSectionIdsByPeriod(period)
                if periodsLeft > 0: #& balancePeriods(periodsLeft):
                    noConflict = True
                    for others in othersInPeriod:
                        if others in conflictSpecs:
                            noConflict = False
                            print("CAN'T ASSIGN IT HERE")
                            break
                    for bk in period:
                        noConflict &= checkContainment(bk, limits)
                    if(noConflict):
                        mysqlUpdates.updatePeriodForCourseSection(index, course_section)
                        enrollment.addSectionFormattedOutput(course_section.id)
                        periodsLeft -= 1
                        mysqlUpdates.decrementPeriodsLeft(index, periodsLeft)
                        break                    
        else :
            while noMatch:
                index = posPeriods[randint(0, len(posPeriods)-1)]
                period = periods[index]
                periodsLeft = queries.getPeriodsLeftByID(index)
                othersInPeriod = queries.getCourseSectionIdsByPeriod(index)
                print("*****")
                print("others: %s" %(othersInPeriod))
                print(othersInPeriod)
                print("conflict specs")
                print(conflictSpecs)
                for others in othersInPeriod:
                    if others in conflictSpecs:
                        print("CAN'T ASSIGN IT HERE")
                        periodsLeft = 0
                        break
                if periodsLeft > 0:
                    mysqlUpdates.updatePeriodForCourseSection(index, course_section.id)
                    enrollment.addSectionFormattedOutput(course_section)
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



# #checks availability and if matching, groups 
# def groupAvailability(users): #, isMentor):
#     ids = queries.getAllStudentIDsWithCommitments()
#     ids = ids & set(users)
#     blocks = queries.getAllDistinctStudentCommitmentTimeBlocks()
#     if len(blocks) == 1:
#         return [ids]
#     else:
#         groups = []
#         for block in blocks:
#             group = queries.getAllStudentsIDsWithSpecificCommitmentBlock(block)
#             groups.append(group)
#         return groups