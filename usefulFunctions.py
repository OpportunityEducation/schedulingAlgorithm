#useful functions used in different subfiles

import random, mysql.connector
from random import shuffle

def shuffleArray(a, times):
    for i in range(times):
        shuffle(a)
    return a

#
def getGradeLevel(grade):
    grades = {
        "Freshman": 9,
        "Sophomore": 10,
        "Junior": 11,
        "Senior": 12
    }
    return grades.get(grade, "invalid grade")


#universal connection to db
def runMySQLOperation(op):
    scheduledb = mysql.connector.connect(
        user="acastillo",
        password="OpEd2020!",
        database="schedule_db",
        host = "localhost"
    )
    cursor = scheduledb.cursor(buffered=True)
    cursor.execute(op)
    scheduledb.commit()
    cursor.close()
    scheduledb.close()
    return cursor
    
#convert timedelta to minutes
def convertToMinutes(time):
    hourMinSec = time.split(':')
    minutes = int(hourMinSec[0])*60 + int(hourMinSec[1])
    print("%s is %s minutes" %(time, minutes))
    return minutes