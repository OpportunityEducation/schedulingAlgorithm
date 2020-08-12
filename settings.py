# contains list of all assumptions necessary for program execution

#init all globals

import queries

def init():
    global minClassSize
    minClassSize = 12
    global maxClassSize
    maxClassSize = 17
    global periods
    periods = 8 #omaha 6, santa rosa 8
    # global typenum
    # typenum = queries.getNumberOfCourseTypes()
