#contains formatting rules for inputting dat into student preferences
# necessary: identical data naming/ids across all data sheets

import inserts, queries, usefulFunctions, classes
from classes import UnformattedPreference, UnformattedQualification
from usefulFunctions import getGradeLevel


def init():
    insertPreferences()
    insertQualifications()

def insertPreferences():
    preferences = queries.getAllUnformattedPreferences()
    preferenceId = 1
    for student in preferences:
        insertStudent(student)
        print("*****")
        print(student.student_name)
        rank = 1
        for req in student.reqs:
            if req != '' and req != ' ':
                if(req[len(req)-1] == ' '):
                    req = req[:-1]
                if(req == "Physcial Education"):
                    req = "Physical Education"
                if(req== "CSP"):
                    req = "CSP (Computer Science Principles)"
                if(req=="EP2: Physics"):
                    req = "TP: Physics"
                if(req == "Ancient Greek History (Honors) MSL"):
                    req = "Ancient Greek History"
                if req =="TP: College Level":
                    req = "TP: College Level English"
                print("%s***" %(req))
                course = queries.getCourseByName(req)
                print(course.id)
                inserts.addFormattedPreference(course.id, preferenceId, rank, student.student_id)
                rank += 1
                preferenceId += 1

def insertStudent(student):
    gender = 'O'
    if(student.gender == 'Female' or student.gender == 'female'):
        gender = 'F'
    if(student.gender == 'Male' or student.gender == 'male'):
        gender = 'M'
    name = student.student_name
    inserts.addStudent(student.student_id, name, gender, getGradeLevel(student.grade), student.free_periods)

def insertQualifications():
    qualifications = queries.getAllUnformattedQualifications()
    qualificationId = 1
    mentorId = 1
    for mentor in qualifications:
        inserts.addMentor(mentor.mentor_id, mentor.mentor_name, mentor.planning_periods)
        print(mentor.mentor_name)
        mentorId += 1
        for qual in mentor.quals:
            if qual != '' and qual != ' ':
                if(qual[len(qual)-1] == ' '):
                    qual = qual [:-1]
                if qual == "FP: Social Science (Upper Grades)":
                    qual = "FP: Social Sciences"
                if qual =="TP: College Level":
                    qual = "TP: College Level English"
                # if qual == "Spanish 1":
                #     qual = "Spanish 1: DG"
                # if qual == "Spanish 2":
                #     qual = "Spanish 2: DG"
                # if qual == "Spanish 3":
                #     qual = "Spanish 3 & 4: DG"
                # if qual == "EP2: Precalculus Con.":
                #     qual = "EP2: Precalculus"
                # if qual ==  "Physical Education":
                #     qual = "PE/Independent Study PE: JE"
                print(qual)
                course = queries.getCourseByName(qual)
                qualificationId += 1
                inserts.addFormattedQualification(qualificationId, mentor.mentor_id, course.id)
    mentorId += 1
    inserts.addMentor(mentorId, "TBA", 0)
