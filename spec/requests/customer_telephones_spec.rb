require 'spec_helper'

describe "CustomerTelephones" do
  describe "GET /telephones" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get customer_telephones_path
      response.status.should be(200)
    end
  end
end
