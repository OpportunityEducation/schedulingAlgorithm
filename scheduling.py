#responsbile for assigning class periods and classrooms

import settings, inserts, queries, deletions, usefulFunctions, enrollment, random, mysqlUpdates
from random import randint
from usefulFunctions import convertToMinutes

periods = []
limitedMentors = []

#init
def init():
    #NEED TO INIT AMOUNT PER PERIODS (COURSE SECTION COUNT/SETTINGS.NUMBER OF PERIODS)
    global periods, limitedMentors
    periods = queries.getAllPeriodTimeBlocks()
    limitedMentors = queries.getMentorIDsWithLimitedAvailability()
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
        print("course sectin id %s" %(course_section.id))
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
    if(isLimited):
        limits = queries.getMentorAvailabilityByID(mentor_id)
        print("assigning restricted mentor")
        while noMatch:
            #NEED TO CHECK NOT BY BLOCKS BUT INSTEAD IF CONTAINING
            index = randint(1,6)
            period = periods[index]
            periodsLeft = queries.getPeriodsLeftByID(index)
            if periodsLeft > 0:
                for bk in period:
                    if checkContainment(bk, limits):
                        mysqlUpdates.updateRoomForCourseSection(index, course_section.id)
                        periodsLeft -= 1
                        mysqlUpdates.decrementPeriodsLeft(index, periodsLeft)
                        noMatch = False
                        break
                    
    else :
       print("assinging non limited prof") 
       while noMatch:
            index = randint(1,6)
            period = periods[index]
            periodsLeft = queries.getPeriodsLeftByID(index)
            if periodsLeft > 0:
                mysqlUpdates.updateRoomForCourseSection(index, course_section.id)
                periodsLeft -= 1
                print("before decrement")
                mysqlUpdates.decrementPeriodsLeft(index, periodsLeft)
                noMatch = False
                break
    print(queries.getCourseSectionCount())


def assignRoom(course_section):
    print("assigning to periods")


def addPeriodToFormattedOutput(course_section):
    classObj = queries.getCourseByID(course_section.course_id)
    mysqlUpdates.addPeriodsToFormattedOutput(course_section.class_period, classObj.name, course_section.section_number)

def checkContainment(period, limits):
    for limit in limits:
        print("checking containment")
        lStart = convertToMinutes(str(limit.start_time))
        lEnd = convertToMinutes(str(limit.end_time))
        pStart = convertToMinutes(str(period.start_time))
        pEnd = convertToMinutes(str(period.end_time))
        if (lStart < pStart & lEnd < pEnd & lEnd > pStart) | (lStart < pStart & lEnd > pEnd) | (lStart > pStart & lEnd < pEnd) | (lStart > pStart & lStart < pEnd & lEnd > pEnd):
            print("here ya go")
            return True
        return False