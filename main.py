#MAIN FILE
#beginning of executable

#import subfiles
import settings, tierAssignment, inserts, queries, enrollment
import deletions, formatData, usefulFunctions, scheduling, mysqlUpdates

#init assumptions
settings.init()

#init empty tables
truncateThese = ["student_course_preferences_unenrolled", "course_enrollment", "course_section", 
"formatted_output", "student_course_preferences", "student", "mentor", "mentor_qualified_courses"]
for table in truncateThese:
    deletions.truncateTable(table)

print(queries.getPeriodsLeftByID(2))
mysqlUpdates.setPeriodsLeft()
print(queries.getPeriodsLeftByID(2))
 
#format and insert student course preferences
formatData.init()
inserts.addPreferences()

#prioritization of class assignment
studentList = []
studentList = tierAssignment.init()

#enroll in courses
fullRoster = []
enrollment.init(studentList)
print(0)
for i in range (1, settings.periods):
    enrollment.enroll(studentList, i)
enrollment.balanceSections()
enrollment.matchMentors()

#schedule course sections 
scheduling.init()

allCSs = queries.getAllCourseSections()
for course_section in allCSs:
    scheduling.addPeriodToFormattedOutput(course_section)