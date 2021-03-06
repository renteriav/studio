require File.dirname(__FILE__) + '/../spec_helper'

describe StudentsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Student.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Student.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(students_url)
  end

  it "edit action should render edit template" do
    get :edit, :id => Student.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Student.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Student.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Student.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Student.first
    response.should redirect_to(students_url)
  end
end
