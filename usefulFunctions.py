#useful functions used in different subfiles

import random
from random import shuffle

def shuffleArray(a, times):
    for i in range(times):
        shuffle(a)
    return a

def getGradeLevel(grade):
    grades = {
        "Freshman": 9,
        "Sophomore": 10,
        "Junior": 11,
        "Senior": 12
    }
    return grades.get(grade, "invalid grade")
