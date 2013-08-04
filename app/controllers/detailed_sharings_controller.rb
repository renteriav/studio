class DetailedSharingsController < ApplicationController
  def index
    @detailed_sharings = DetailedSharing.all
  end

  def new
    @student = Student.find(params[:student_id])
    @detailed_sharing = DetailedSharing.new
    @date = Time.now.beginning_of_month
  end

  def create
    @student = Student.find(params[:student_id])
    @detailed_sharing = @student.detailed_sharings.build(params[:detailed_sharing])
    respond_to do |format|
      if @detailed_sharing.save
        format.html { redirect_to student_path(@student), 
        notice: 'Student signed up for sharing succesfully.' }
      else
      render :action => 'new'
      end
    end
  end

  def edit
    @student = Student.find(params[:student_id])
    @detailed_sharing = DetailedSharing.find(params[:id])
    @date = Sharing.find(@detailed_sharing.sharing_id).date
  end

  def update
    @student = Student.find(params[:student_id])
    @detailed_sharing = DetailedSharing.find(params[:id])
    if @detailed_sharing.update_attributes(params[:detailed_sharing])
      redirect_to student_path(@student), :notice  => "Sharing sign up successfully updated."
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @detailed_sharing = DetailedSharing.find(params[:id])
    @detailed_sharing.destroy

    respond_to do |format|
      format.html { redirect_to customer_detailed_sharings_url }
      format.json { head :no_content }
    end
  end
  
  def show
    @detailed_sharing = DetailedSharing.find(params[:id])
    @date = Time.now.beginning_of_month
  end
  
  def sharing_search
    if params[:detailed_sharing_id] == "" or params[:detailed_sharing_id] == nil
      @detailed_sharing = DetailedSharing.new
    else
      @detailed_sharing = DetailedSharing.find(params[:detailed_sharing_id])
    end
    
    @student = Student.find(params[:student_id])

    render :layout => false
  end
  
  def attendance
    @sharing = Sharing.find(params[:sharing_id])
    @detailed_sharings = @sharing.detailed_sharings
    @students = Array.new
    @detailed_sharings.each do |detailed_sharing|
      @students.push(Student.find(detailed_sharing.student_id))
      @students.sort_by!{ |m| [m.last, m.first] }
    end
  end
  
  def update_attendance
    @sharing = Sharing.find(params[:sharing_id])
    params['detailed_sharing'].keys.each do |id|
      @detailed_sharing = DetailedSharing.find(id.to_i)
      @detailed_sharing.update_attributes(params['detailed_sharing'][id])
    end
    respond_to do |format|
      
      format.js
    end
  end
  
end
