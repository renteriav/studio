require 'spec_helper'

describe "telephones/new" do
  before(:each) do
    assign(:telephone, stub_model(CustomerTelephone,
      :number => "MyString",
      :type => "",
      :customer_id => 1
    ).as_new_record)
  end

  it "renders new telephone form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => customer_telephones_path, :method => "post" do
      assert_select "input#telephone_number", :name => "telephone[number]"
      assert_select "input#telephone_type", :name => "telephone[type]"
      assert_select "input#telephone_customer_id", :name => "telephone[customer_id]"
    end
  end
end
