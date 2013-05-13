require 'spec_helper'

describe "preferred_addresses/new" do
  before(:each) do
    assign(:preferred_address, stub_model(PreferredAddress,
      :address_id => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new preferred_address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => preferred_addresses_path, :method => "post" do
      assert_select "input#preferred_address_address_id", :name => "preferred_address[address_id]"
      assert_select "input#preferred_address_description", :name => "preferred_address[description]"
    end
  end
end
