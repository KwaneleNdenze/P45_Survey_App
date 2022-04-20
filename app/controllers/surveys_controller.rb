class SurveysController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @surveys = Survey.all    
  end

  def show
    @survey = Survey.find(params[:id])  
    @question = @survey.questions.first
    

  end

  def new
    #@survey = Survey.new
    @survey = current_user.surveys.build
  end

  def create
    #@survey = Survey.new(survey_params)
    @survey = current_user.surveys.build(survey_params)
 
    if @survey.save
      redirect_to @survey, notice: "Survey Created Succesfully."
    else
      render 'new'
    end
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:id])
 
    if @survey.update(survey_params)
      redirect_to @survey, notice: "Survey Edited Succesfully"
    else
      render 'edit'
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
 
    redirect_to surveys_path, notice: "Survey Deleted Successfully"
  end

  def correct_user
    @survey = current_user.surveys.find_by(id: params[:id])
    redirect_to surveys_path, notice: "Not Authorized To Modify This Survey" if @survey.nil?

  end

  private
    def survey_params
      params.require(:survey).permit(:title, :user_id)
    end


end