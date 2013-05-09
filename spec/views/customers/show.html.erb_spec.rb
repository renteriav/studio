require 'spec_helper'

describe "customers/show" do
  before(:each) do
    @customer = assign(:customer, stub_model(Customer,
      :first => "First",
      :last => "Last",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First/)
    rendered.should match(/Last/)
    rendered.should match(/Email/)
  end
end
