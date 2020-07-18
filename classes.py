class Course:
    def __init__(self, id, name, allowed_grades, is_elective):
        self.id = id
        self.name = name
        self.allowed_grades = allowed_grades
        self.is_elective = is_elective

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
    def __init__(self, student_id, student_name, gender, grade, free_periods, req_1, req_2, req_3, req_4, req_5, req_6):
        self.student_id = student_id
        self.student_name = student_name
        self.gender = gender
        self.grade = grade
        self.free_periods = free_periods
        self.reqs = [req_1, req_2, req_3, req_4, req_5, req_6]

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
