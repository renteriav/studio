require "spec_helper"

describe PreferredAddressesController do
  describe "routing" do

    it "routes to #index" do
      get("/preferred_addresses").should route_to("preferred_addresses#index")
    end

    it "routes to #new" do
      get("/preferred_addresses/new").should route_to("preferred_addresses#new")
    end

    it "routes to #show" do
      get("/preferred_addresses/1").should route_to("preferred_addresses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/preferred_addresses/1/edit").should route_to("preferred_addresses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/preferred_addresses").should route_to("preferred_addresses#create")
    end

    it "routes to #update" do
      put("/preferred_addresses/1").should route_to("preferred_addresses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/preferred_addresses/1").should route_to("preferred_addresses#destroy", :id => "1")
    end

  end
end
