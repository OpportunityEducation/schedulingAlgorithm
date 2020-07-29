#responsbile for assigning class periods and classrooms

import settings, inserts, queries, deletions, usefulFunctions, enrollment, random, mysqlUpdates, enrollment
from random import randint
from usefulFunctions import convertToMinutes

global conflicts
conflicts = dict()
periods = []
limitedMentors = []

#init
def init():
    #NEED TO INIT AMOUNT PER PERIODS (COURSE SECTION COUNT/SETTINGS.NUMBER OF PERIODS)
    global periods, limitedMentors, conflicts 
    periods = queries.getAllPeriodTimeBlocks()
    limitedMentors = queries.getMentorIDsWithLimitedAvailability()
    conflicts = enrollment.conflictDict
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
    #then assign rooms to sections by period
    for i in range (1, settings.periods+1):
        sections = queries.getCourseSectionsByPeriod(i)
        assignRoomByPeriod(sections, i)

    for section in queries.getAllCourseSections():
        addRoomsToFormattedOutput(section)


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


def assignRoomByPeriod(sections, period):
    print("assigning room by period")

    #sort sections by num enrolled as we need to enroll smallest classes first
    sections.sort(key=lambda x: x.students_enrolled) 

    #OMAHA ONLY
    if any(section.course_id == 23 for section in sections):
        print("CSP must be in 340 which has id 5")
        cspSection = next((x for x in sections if x.course_id == 23), None)
        mysqlUpdates.assignCourseSectionToRoom(cspSection.id,cspSection.section_number, 5)

    #all others
    unfitSections = []
    for section in sections:
        if section.course_id != 23: #OMAHA ONLY: CSP case
            course = queries.getCourseByID(section.course_id)
            openRooms = list(findAvailableRooms(course.course_type, section))
            openRoomsWithCapacity = dict()
            for openRoomId in openRooms:
                capacity = queries.getCapacityByRoomId(openRoomId)
                openRoomsWithCapacity[str(openRoomId)] = capacity
            openRoomsWithCapacity = sorted(openRoomsWithCapacity.items(), key=lambda x: x[1])
            assignedRoom = 0
            for key, value in openRoomsWithCapacity:
                if value >= section.students_enrolled:
                    assignedRoom = int(key)
                    break
            if assignedRoom == 0:
                unfitSections.append(section)
            else: 
                mysqlUpdates.assignCourseSectionToRoom(section.id, section.section_number, assignedRoom)
    for section in unfitSections:
        openRooms = list(set(queries.getAllRooms()) - set(queries.getRoomsBookedByPeriod(period)))
        openRoomsWithCapacity = dict()
        for openRoomId in openRooms:
            capacity = queries.getCapacityByRoomId(openRoomId)
            openRoomsWithCapacity[str(openRoomId)] = capacity
        openRoomsWithCapacity = sorted(openRoomsWithCapacity.items(), key=lambda x: x[1])
        assignedRoom = 0
        for key, value in openRoomsWithCapacity:
            if value >= section.students_enrolled:
                assignedRoom = int(key)
                break
        if assignedRoom == 0:
            print("needed capacity %s" %(section.students_enrolled))
        else: 
            mysqlUpdates.assignCourseSectionToRoom(section.id, section.section_number, assignedRoom)


def addRoomsToFormattedOutput(course_section):
    classObj = queries.getCourseByID(course_section.course_id)
    #print(course_section.classroom_id)
    room_name = "No room found"
    if course_section.classroom_id != 0:
        room_name = (queries.getRoomByID(course_section.classroom_id)).name
    #print(room_name)
    mysqlUpdates.addSchedulingToFormattedOutput(course_section.class_period, room_name, classObj.name, course_section.section_number)


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
    bookedRooms = set(queries.getRoomsBookedByPeriod(course_section.class_period))
    #print("roomsBooked %s" %(bookedRooms))
    availableRooms = set(roomIds) - bookedRooms
    #print("avialable %s" %(availableRooms))
    return availableRooms



def assignDuplicates():
    global conflicts
    duplicates = queries.getAllNonzeroDuplicates()
    duplicates.sort(key=lambda x: x.duplicates_num, reverse=True)
    for course in duplicates:
        

    print("checking to see conflicts")
    