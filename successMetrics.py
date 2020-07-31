#calculates success rate of program based on various stats

import settings, queries

def init():
    print('initializing success metrics')


def getMentorStats():
    print("obtaining mentor stats")
    mentors = queries.getAllMentors()


# def getStudentStats():
#     print("getting students stasts")



def getStudentConflicts():
    students = queries.getAllStudents()
    studentConfs = 0
    for student in students:
        enrolledCourses = queries.getStudentEnrollmentByStudentID(student.id)
        periodsEnrolled= []
        for courseSection in enrolledCourses:
            p = queries.getCourseSectionByID(courseSection.id).class_period
            if p != 0:
                periodsEnrolled.append(queries.getCourseSectionByID(courseSection.id).class_period)
        if len(periodsEnrolled) != len(set(periodsEnrolled)):
            print(student.name)
            print(periodsEnrolled)
            studentConfs += 1
    print("Total conflicts: %s" %(studentConfs))

