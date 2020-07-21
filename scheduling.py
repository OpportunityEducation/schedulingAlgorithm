#responsbile for assigning class periods and classrooms

import settings, inserts, queries, deletions, usefulFunctions


#init
def init():
    print("init scheduling")
    assignPeriods()
    assignRooms()


#checks availability and if matching, groups 
def groupAvailability(users): #, isMentor):
    print("checking availabilty")
    ids = queries.getAllStudentIDsWithCommitments()
    ids = ids & set(users)
    blocks = queries.getAllDistinctStudentCommitmentTimeBlocks()
    if len(blocks) == 1:
        return [ids]
    else:
        groups = []
        for block in blocks:
            group = queries.getAllStudentsIDsWithSpecificCommitmentBlock(block)
            groups.append(group)
        return groups

def assignPeriods():
    periods = queries.getAllPeriodTimeBlocks()
    print("assigning to periods")

def assignRooms():
    print("assigning to periods")