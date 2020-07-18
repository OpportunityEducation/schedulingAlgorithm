# queries all students and assigns them a ranking based on:
#   grade level and advancement level

import statistics, random
from statistics import mean
from random import shuffle

import queries, classes, usefulFunctions
from classes import TieredStudent
from usefulFunctions import shuffleArray

tieredStudents = []
firstTier = []
secondTier = []
round = 0

def init():
    global tieredStudents
    tieredStudents = withinTiers(False, 0)
    return tieredStudents

def withinTiers(balanceTiers, roundNum):
    global tieredStudents, round
    round = roundNum
    for i in range (12, 8, -1):
        tiered = detLevel(i, balanceTiers)
        for student in tiered:
            tieredStudents.append(student)
    return tieredStudents

def detLevel(grade, balanceTiers):
    global firstTier, secondTier
    firstTier = []
    secondTier = []
    for student in queries.getStudentsByGrade(grade):
        courses = queries.getStudentCoursePreferencesByID(student.id)
        overallLevel = []
        for course in courses:
            courseInfo = queries.getCourseByID(course.course_id)
            overallLevel.append(getAllowedGrades(courseInfo.allowed_grades, student.year))
        #     levels = []
        #     levels = courseInfo.allowed_grades
        #     for level in levels:
        #         overallLevel.append(int(level))
        #         print("appending %s to student %s" %(level, student))
        studentAdvancement = mean(overallLevel)
        if abs(studentAdvancement - student.year) <= .25:
            firstTier.append(TieredStudent(student.id, student.name, True, student.gender))
        else : 
            secondTier.append(TieredStudent(student.id, student.name, False, student.gender))       
    if firstTier :
        firstTier =(firstTier)
        if not secondTier :
            return firstTier
        secondTier = shuffleArray(secondTier, 3)
        if balanceTiers:
            temp = firstTier
            firstTier = secondTier
            secondTier = temp
        for student in secondTier:
            firstTier.append(student)
        return firstTier
    if secondTier :
        secondTier = shuffleArray(secondTier, 3)
        return secondTier


def getAllowedGrades(gradeString, studentGrade):
    allowedGrades = gradeString.split(',')
    if len(allowedGrades) == 1:
        return int(allowedGrades[0])
    if studentGrade in allowedGrades:
        return int(studentGrade)
    else :
        sumGrades = []
        for grade in allowedGrades:
            sumGrades.append(int(grade))
        return mean(sumGrades)
