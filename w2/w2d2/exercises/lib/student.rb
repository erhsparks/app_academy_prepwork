#!/usr/bin/env ruby

# -------------------------------------------------------
# student.rb - Lizzi Sparks - May 2016
#
# `Student` class:
# Methods:
# - `Student#initialize(String1, String2)` : assigns
# `String1` to class attribute `@first_name`, `String2` to
# `@last_name`, and initializes two other attributes:
# `@courses`, an empty array, and `@course_load`, an empty
# hash.
#
# - `Student#name` : returns a string of `@first_name` and 
# `@last_name` separated by a space.
#
# - `Student#enroll(Course)` : unless `Course` conflicts with
# one of the `Course` objects stored in `@courses` or `Course`
# already exists in `@courses`, adds `Course` to `@courses`
# AND adds `self` (`Student` object) to `Course`'s `@students`
# array.
#
# - `Student#course_load` : returns options hash with key/
# value pairs `Course#department => total Course#credits`
# for each `Course` found in `@courses`.
# 
# -------------------------------------------------------

class Student
  attr_reader :first_name, :last_name, :courses

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
    @course_load = {}
  end

  def name
    %(#{@first_name} #{@last_name})
  end

  def enroll(new_course)
    raise if @courses.any? { |course| new_course.conflicts_with?(course) }

    @courses << new_course unless @courses.include?(new_course)
    new_course.students << self

    @courses
  end

  def course_load
    @courses.each do |course|
      if @course_load[course.department]
        @course_load[course.department] += course.credits
      else
        @course_load[course.department] = course.credits
      end
    end

    @course_load
  end
end
