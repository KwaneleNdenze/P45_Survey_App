class AnswersController < ApplicationController
  def index
    @answers = Answer.all
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def new
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.find(params[:question_id])
    @answer = @question.answers.build
  end
  
  def create
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.create(question_params)
    
    if @question.errors.none?
    redirect_to survey_path(@survey), notice: "Question Created Succesfully"
    else 
      render 'new'
    end
  end

  def edit
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.find(params[:id])
    if @question.update(question_params)
      redirect_to @survey, notice: "Question Edited Succesfully"
    else
      render 'edit'
    end
  end

  def destroy
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.find(params[:id])
    @question.destroy
    redirect_to survey_path(@survey), notice: "Question Deleted Succesfully"
  end

  private
  def question_params
    params.require(:question).permit(:question, :question_type, :question_first_option, :question_second_option, :question_third_option, :question_fourth_option, :question_fifth_option)
  end
end