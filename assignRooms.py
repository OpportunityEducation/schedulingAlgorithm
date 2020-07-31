#responsbile for assigning class periods and classrooms

import settings, inserts, queries, deletions, usefulFunctions, enrollment, random, mysqlUpdates, enrollment
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

    #then assign rooms to sections by period
    for i in range (1, settings.periods+1):
        sections = queries.getCourseSectionsByPeriod(i)
        assignRoomByPeriod(sections, i)

    for section in queries.getAllCourseSections():
        addRoomsToFormattedOutput(section)

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
    room_name = "No room found"
    if course_section.classroom_id != 0:
        room_name = (queries.getRoomByID(course_section.classroom_id)).name
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


def findAvailableRooms(course_type, course_section):
    types = course_type.split(',')
    roomIds = []
    for type_id in types:
        roomIds = queries.getClassroomsByType(type_id)
    bookedRooms = set(queries.getRoomsBookedByPeriod(course_section.class_period))
    availableRooms = set(roomIds) - bookedRooms
    return availableRooms