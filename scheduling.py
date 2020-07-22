#responsbile for assigning class periods and classrooms

import settings, inserts, queries, deletions, usefulFunctions, enrollment, random, mysqlUpdates
from random import randint
from usefulFunctions import convertToMinutes

periods = []
limitedMentors = []
# courseTypes = dict.fromkeys(range(1,settings.typenum), [])

#init
def init():
    #NEED TO INIT AMOUNT PER PERIODS (COURSE SECTION COUNT/SETTINGS.NUMBER OF PERIODS)
    global periods, limitedMentors #, courseTypes
    periods = queries.getAllPeriodTimeBlocks()
    limitedMentors = queries.getMentorIDsWithLimitedAvailability()
    #courseTypes = queries.getAllCourseTypes(settings.typenum)
    print("init scheduling")
    remainingCourseSections = []

    #assign limited availability mentors first 
    for course_section in enrollment.allCourseSections:
        mentor_id = queries.getMentorIDByCourseSection(course_section.id)
        if mentor_id in limitedMentors:
            assignPeriod(mentor_id, course_section, True)
        else :
            remainingCourseSections.append(course_section)

    #then assign rest of mentors
    for course_section in remainingCourseSections:
        mentor_id = queries.getMentorIDByCourseSection(course_section.id)
        assignPeriod(mentor_id, course_section, False)

    #then assign rooms to sections
    for course_section in enrollment.allCourseSections:
        assignRoom(course_section)


#checks availability and if matching, groups 
def groupAvailability(users): #, isMentor):
    print("checking availabilty")
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
            print("assigning restricted mentor")
            while True:
                index = posPeriods[randint(0, len(posPeriods)-1)]
                period = periods[index]
                periodsLeft = queries.getPeriodsLeftByID(index)
                if periodsLeft > 0: #& balancePeriods(periodsLeft):
                    noConflict = True
                    for bk in period:
                        noConflict &= checkContainment(bk, limits)
                    if(noConflict):
                        mysqlUpdates.updateRoomForCourseSection(index, course_section.id)
                        periodsLeft -= 1
                        mysqlUpdates.decrementPeriodsLeft(index, periodsLeft)
                        break                    
        else :
            while noMatch:
                index = posPeriods[randint(0, len(posPeriods)-1)]
                period = periods[index]
                periodsLeft = queries.getPeriodsLeftByID(index)
                if periodsLeft > 0:
                    mysqlUpdates.updateRoomForCourseSection(index, course_section.id)
                    periodsLeft -= 1
                    mysqlUpdates.decrementPeriodsLeft(index, periodsLeft)
                    noMatch = False
                    break
    else:
        print("mentor has run out of possible sections")


def assignRoom(course_section):
    course = queries.getCourseByID(course_section.course_id)
    openRooms = list(findAvailableRooms(course.course_type, course_section))
    openRoomsWithCapacity = dict()
    for openRoomId in openRooms:
        capacity = queries.getCapacityByRoomId(openRoomId)
        openRoomsWithCapacity[openRoomId] = capacity
        print(queries.getCapacityByRoomId(openRoomId))
    ascCapacity = sorted(openRoomsWithCapacity.items(), key=lambda x: x[1])
    print(ascCapacity)
    print("assigning to periods")


def addPeriodToFormattedOutput(course_section):
    classObj = queries.getCourseByID(course_section.course_id)
    mysqlUpdates.addPeriodsToFormattedOutput(course_section.class_period, classObj.name, course_section.section_number)


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


def findAvailableRooms(course_type, course_section):
    types = course_type.split(',')
    roomIds = []
    for type_id in types:
        roomIds = queries.getClassroomsByType(type_id)
    print("roomIds %s" %(roomIds))
    bookedRooms = queries.getRoomsBookedByPeriod(course_section.class_period)
    print("roomsBooked %s" %(bookedRooms))
    availableRooms = set(roomIds) - set(bookedRooms)
    print(availableRooms)
    return availableRooms
    