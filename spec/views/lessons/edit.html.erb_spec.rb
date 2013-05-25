require 'spec_helper'

describe "lessons/edit" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :student_id => 1,
      :teacher_id => 1,
      :instrument_id => 1,
      :weekday => 1,
      :frequency => 1
    ))
  end

  it "renders the edit lesson form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lessons_path(@lesson), :method => "post" do
      assert_select "input#lesson_student_id", :name => "lesson[student_id]"
      assert_select "input#lesson_teacher_id", :name => "lesson[teacher_id]"
      assert_select "input#lesson_instrument_id", :name => "lesson[instrument_id]"
      assert_select "input#lesson_weekday", :name => "lesson[weekday]"
      assert_select "input#lesson_frequency", :name => "lesson[frequency]"
    end
  end
end
