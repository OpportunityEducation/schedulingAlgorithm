class Day:
    def __init__(self, id, weekday):
        self.id = id
        self.weekday = weekday

class Course:
    def __init__(self, id, name, allowed_grades, is_elective, course_type):
        self.id = id
        self.name = name
        self.allowed_grades = allowed_grades
        self.is_elective = is_elective
        self.course_type = course_type

class Student:
    def __init__(self, id, name, gender, year, free_periods):
        self.id = id
        self.name = name
        self.gender = gender
        self.year = year
        self.free_periods = free_periods

class TieredStudent:
    def __init__(self, id, name, isOnTrack, gender):
        self.id = id
        self.name = name
        self.isOnTraack = isOnTrack
        self.gender = gender

class RankedCourse:
    def __init__(self, id, course_id, ranking):
        self.id = id
        self.course_id = course_id
        self.ranking = ranking

class EnrolledCourse:
    def __init__(self, course_section_id, user_id):
        self.id = course_section_id
        self.course_id = user_id

class CourseSection:
    def __init__(self, id, course_id, section_number, classroom_id, class_period, students_enrolled, males_enrolled):
        self.id = id
        self.course_id = course_id
        self.section_number = section_number
        self.classroom_id = classroom_id
        self.class_period = class_period
        self.students_enrolled = students_enrolled
        self.males_enrolled = males_enrolled

class UnformattedPreference:
    def __init__(self, student_id, student_name, gender, grade, free_periods, req_1, req_2, req_3, req_4, req_5, req_6, req_7, req_8):
        self.student_id = student_id
        self.student_name = student_name
        self.gender = gender
        self.grade = grade
        self.free_periods = free_periods
        self.reqs = [req_1, req_2, req_3, req_4, req_5, req_6, req_7, req_8]

class UnformattedQualification:
    def __init__(self, mentor_id, mentor_name, planning_periods, c1, c2, c3, c4, c5, c6, c7):
        self.mentor_id = mentor_id
        self.mentor_name = mentor_name
        self.planning_periods = planning_periods
        self.quals = [c1, c2, c3, c4, c5, c6, c7]

class MentorQualifiedClass:
    def __init__(self, id, mentor_id, course_id):
        self.id = id
        self.mentor_id = mentor_id
        self.course_id = course_id

class Mentor:
    def __init__(self, id, name, planning_periods):
        self.id = id    
        self.name = name
        self.planning_periods = planning_periods

class CommitmentBlock:
    def __init__(self, day_id, start_time, end_time):
        self.start_time = start_time
        self.end_time = end_time
        self.day_id = day_id
    #id isn't key, need eq & hash
    def __eq__(self, other):
        return self.start_time==other.start_time\
            and self.end_time==other.end_time\
            and self.day_id==other.day_id
    def __hash__(self):
        return hash(('start_time', self.start_time,
            'end_time', self.end_time, 
            'day_id', self.day_id))

class Classroom:
    def __init__(self, id, name, capacity, classroom_type_id):
        self.id = id
        self.name = name
        self.capacity = capacity
        self.classroom_type_id = classroom_type_id

class CourseConflict:
    def __init__(self, id, duplicates, duplicates_num, contained_within, number_of_sections):
        self.id = id
        self.duplicates = duplicates
        self.duplicates_num = duplicates_num
        self.contained_within = contained_within
        self.number_of_sections = number_of_sections


# class FormattedOutput:
#     def __init__(self, id, duplicates, duplicates_num, contained_within, number_of_sections):
#         self.id = id
#         self.duplicates = duplicates
#         self.duplicates_num = duplicates_num
#         self.contained_within = contained_within
#         self.number_of_sections = number_of_sections