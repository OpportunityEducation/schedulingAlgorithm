#calculates success rate of program based on various stats

import settings, queries

def init():
    print('initializing success metrics')


def getMentorStats():
    print("obtaining mentor stats")


def getStudentStats():
    print("getting students stasts")



def getStudentConflicts():
    print("periods where student course choice conflicts")
    for i in range(1, settings.periods+1):
        roster = []
        sections = queries.getCourseSectionsByPeriod(i)
        roster = queries.getStudentIDsEnrolledByCourseSection