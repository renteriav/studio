require 'spec_helper'

describe "preferred_addresses/index" do
  before(:each) do
    assign(:preferred_addresses, [
      stub_model(PreferredAddress,
        :address_id => "Address",
        :description => "Description"
      ),
      stub_model(PreferredAddress,
        :address_id => "Address",
        :description => "Description"
      )
    ])
  end

  it "renders a list of preferred_addresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
