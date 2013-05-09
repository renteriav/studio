require "spec_helper"

describe CustomerTelephonesController do
  describe "routing" do

    it "routes to #index" do
      get("/telephones").should route_to("telephones#index")
    end

    it "routes to #new" do
      get("/telephones/new").should route_to("telephones#new")
    end

    it "routes to #show" do
      get("/telephones/1").should route_to("telephones#show", :id => "1")
    end

    it "routes to #edit" do
      get("/telephones/1/edit").should route_to("telephones#edit", :id => "1")
    end

    it "routes to #create" do
      post("/telephones").should route_to("telephones#create")
    end

    it "routes to #update" do
      put("/telephones/1").should route_to("telephones#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/telephones/1").should route_to("telephones#destroy", :id => "1")
    end

  end
end
