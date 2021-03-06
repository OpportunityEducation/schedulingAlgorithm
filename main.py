#MAIN FILE
#beginning of executable

#import subfiles
import settings, tierAssignment, inserts, queries, enrollment, successMetrics
import deletions, formatData, usefulFunctions, scheduling, mysqlUpdates, enrollmentDuplicates

for i in range (40):
    #init assumptions
    settings.init()
    print("settings initialized")

    #init empty tables
    truncateThese = ["student_course_preferences_unenrolled", "course_enrollment", "course_section", 
    "formatted_output", "student_course_preferences", "student", "mentor", "mentor_qualified_courses"]
    for table in truncateThese:
        deletions.truncateTable(table)
    print("tables truncated")

    #init known values
    mysqlUpdates.setPeriodsLeft()
    mysqlUpdates.clearDuplicates()
    mysqlUpdates.clearDuplicateNums()
    
    #format and insert student course preferences
    formatData.init()
    inserts.addPreferences()
    print("preferences formatted and inserted")

    #prioritization of class assignment
    studentList = []
    studentList = tierAssignment.init()
    print("tiers assigned")

    #enroll in courses
    fullRoster = []
    enrollment.init(studentList)
    enrollment.balanceSections()
    enrollmentDuplicates.init()
    enrollment.matchMentors()

    #schedule course sections 
    scheduling.init()
    print("scheduling complete")

    #run success metrics
    successMetrics.getStudentConflicts()

