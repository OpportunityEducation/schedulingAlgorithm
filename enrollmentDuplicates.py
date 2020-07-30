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
coreCoursesIds = []

#init 
def init():
    global allCourseSections, courseSectionId, duplicates_num, coreCoursesIds
    courseSectionId = enrollment.courseSectionId
    allCourseSections = enrollment.allCourseSections
    coreCoursesIds = queries.getCoreCourseIds()
    getConflicts()
    #makeDuplicateSections()

#get conflicts for scheduling
def getConflicts():
    global duplicates, duplicates_num
    courses = enrollment.courses
    for i in range(len(courses)):
        course = courses[i]
        course_conflict = queries.getCourseConflictsByCourse(course.id)
        duplicates = course_conflict.duplicates
        duplicates_num = course_conflict.duplicates_num
        number_of_sections = len(queries.getCourseSectionsByCourseID(course.id))
        for j in range(i+1, len(courses)): #fix this part !!!!!
            if j < len(courses):
                otherCourse = courses[j]
                courseSection = queries.getCourseSectionsByCourseID(course.id)
                #number_of_sections = len(courseSection)
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
                        #change this lol
                        courseSectionNum = len(courseSection)
                        otherSectionNum = len(otherSection)
                        if courseSectionNum == otherSectionNum:
                            print("%s and %s are DUPLICATES of equal size" %(course.name, otherCourse.name))
                            duplicates = updateEqualDuplicates(otherCourse.id, duplicates, -1)
                            otherCourseConflicts = queries.getCourseConflictsByCourse(otherCourse.id)
                            updateEqualDuplicates(course.id, otherCourseConflicts.duplicates, otherCourse.id)
                            duplicates_num += 1
                            conflictNum = conflicts
                        elif courseSectionNum > otherSectionNum:
                            print("THE COURSE %s CONTAINS %s " %(course.id, otherCourse.id))
                            updateContainedDuplicates(course.id, otherCourse.id)
                        else:
                            print("THE OTHER %s CONTAINS %s " %(otherCourse.id, course.id))
                            updateContainedDuplicates(otherCourse.id, course.id)
        mysqlUpdates.setDuplicates(duplicates, duplicates_num, course.id, number_of_sections)


def updateEqualDuplicates(courseId, newDuplicates, updateId):
    if newDuplicates is None:
        newDuplicates = str(courseId)
    else :
        newDuplicates += "," + str(courseId)
    if updateId != -1:
        mysqlUpdates.incrementDuplicateNum(updateId)
        mysqlUpdates.updateDuplicates(newDuplicates, updateId)
    return newDuplicates

def updateContainedDuplicates(containerId, containedId):
    contained = queries.getCourseConflictsByCourse(containerId).contained_within
    if contained is None:
        contained = str(containedId)
    else :
        contained += "," + str(containedId)
    mysqlUpdates.updateContained(contained, containerId)
