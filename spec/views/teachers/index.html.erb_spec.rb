require 'spec_helper'

describe "teachers/index" do
  before(:each) do
    assign(:teachers, [
      stub_model(Teacher,
        :first => "First",
        :last => "Last",
        :email => "Email",
        :address_id => 1,
        :telephone_id => 2
      ),
      stub_model(Teacher,
        :first => "First",
        :last => "Last",
        :email => "Email",
        :address_id => 1,
        :telephone_id => 2
      )
    ])
  end

  it "renders a list of teachers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First".to_s, :count => 2
    assert_select "tr>td", :text => "Last".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
