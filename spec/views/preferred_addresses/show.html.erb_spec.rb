require 'spec_helper'

describe "preferred_addresses/show" do
  before(:each) do
    @preferred_address = assign(:preferred_address, stub_model(PreferredAddress,
      :address_id => "Address",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address/)
    rendered.should match(/Description/)
  end
end
