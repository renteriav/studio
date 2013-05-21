require 'spec_helper'

describe "teachers/show" do
  before(:each) do
    @teacher = assign(:teacher, stub_model(Teacher,
      :first => "First",
      :last => "Last",
      :email => "Email",
      :address_id => 1,
      :telephone_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First/)
    rendered.should match(/Last/)
    rendered.should match(/Email/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
