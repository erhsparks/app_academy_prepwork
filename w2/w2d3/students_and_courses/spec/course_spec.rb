require 'course'

describe Course do
  let(:course) { Course.new("Ruby 101", "CS", 4) }

  describe "#initialize" do
    it "takes a name, department, and # of credits" do
      expect(course.name).to eq("Ruby 101")
      expect(course.department).to eq("CS")
      expect(course.credits).to eq(4)
    end

    it "initializes with an empty array of students" do
      expect(course.students).to eq([])
    end
  end

  describe "#add_student" do
    let(:current_student) { double(:current_student) }
    let(:enrolled_course) { double(:enrolled_course) }
    let(:new_student) { double(:new_student, courses: [enrolled_course]) }

    before :each do
      allow(course).to receive(:students) { [current_student] }
      allow(new_student).to receive(:enroll)
      course.add_student(new_student)
    end

    it "adds a student to its list of students" do
      expect(course.students).to eq([current_student, new_student])
    end

    it "adds itself to the student's list of courses" do
      expect(new_student.courses).to eq([enrolled_course, course])
    end
  end
end
