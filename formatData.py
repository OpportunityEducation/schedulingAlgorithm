#contains formatting rules for inputting dat into student preferences

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
        rank = 1
        for req in student.reqs:
            if req != '' and req != ' ':
                if(req[len(req)-1] == ' '):
                    req = req[:-1]
                if(req == "CSP"):
                    req = "CSP (Computer Science Principles)"
                if(req == "Physcial Education"):
                    req = "Physical Education"
                course = queries.getCourseByName(req)
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
        mentorId += 1
        for qual in mentor.quals:
            if qual != '' and qual != ' ':
                if(qual[len(qual)-1] == ' '):
                    qual = qual [:-1]
                course = queries.getCourseByName(qual)
                qualificationId += 1
                inserts.addFormattedQualification(qualificationId, mentor.mentor_id, course.id)
    inserts.addMentor(mentorId, "TBA", 0)
