require 'spec_helper'

describe "telephones/edit" do
  before(:each) do
    @telephone = assign(:telephone, stub_model(CustomerTelephone,
      :number => "MyString",
      :type => "",
      :customer_id => 1
    ))
  end

  it "renders the edit telephone form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => customer_telephones_path(@telephone), :method => "post" do
      assert_select "input#telephone_number", :name => "telephone[number]"
      assert_select "input#telephone_type", :name => "telephone[type]"
      assert_select "input#telephone_customer_id", :name => "telephone[customer_id]"
    end
  end
end
