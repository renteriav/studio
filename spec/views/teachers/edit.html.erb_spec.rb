require 'spec_helper'

describe "teachers/edit" do
  before(:each) do
    @teacher = assign(:teacher, stub_model(Teacher,
      :first => "MyString",
      :last => "MyString",
      :email => "MyString",
      :address_id => 1,
      :telephone_id => 1
    ))
  end

  it "renders the edit teacher form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teachers_path(@teacher), :method => "post" do
      assert_select "input#teacher_first", :name => "teacher[first]"
      assert_select "input#teacher_last", :name => "teacher[last]"
      assert_select "input#teacher_email", :name => "teacher[email]"
      assert_select "input#teacher_address_id", :name => "teacher[address_id]"
      assert_select "input#teacher_telephone_id", :name => "teacher[telephone_id]"
    end
  end
end
