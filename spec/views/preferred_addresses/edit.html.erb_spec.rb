require 'spec_helper'

describe "preferred_addresses/edit" do
  before(:each) do
    @preferred_address = assign(:preferred_address, stub_model(PreferredAddress,
      :address_id => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit preferred_address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => preferred_addresses_path(@preferred_address), :method => "post" do
      assert_select "input#preferred_address_address_id", :name => "preferred_address[address_id]"
      assert_select "input#preferred_address_description", :name => "preferred_address[description]"
    end
  end
end
