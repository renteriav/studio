require 'spec_helper'

describe "customers/new" do
  before(:each) do
    assign(:customer, stub_model(Customer,
      :first => "MyString",
      :last => "MyString",
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new customer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => customers_path, :method => "post" do
      assert_select "input#customer_first", :name => "customer[first]"
      assert_select "input#customer_last", :name => "customer[last]"
      assert_select "input#customer_email", :name => "customer[email]"
    end
  end
end
