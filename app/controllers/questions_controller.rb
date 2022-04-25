class QuestionsController < ApplicationController
  def index
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions.all 
  end

  def show
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.find(params[:id])
    @answer = @question.answers.build

    @count = @survey.questions.count
  end

  def next
    #byebug
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.find(params[:question_id])
    @next_question = @survey.questions.find_by(order: @question.order + 1)
    @answer = @question.answers.create(answer_params)
    if @next_question.present? && @answer.errors.none?
      redirect_to survey_question_path(survey_id: @survey.id, id: @next_question.id)
    else
      redirect_to @survey, notice: "Survey Complete. Thank You."
    end

  end

  def new
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.build
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
    params.require(:question).permit(:question, :order, :question_type, :question_first_option, :question_second_option, :question_third_option, :question_fourth_option, :question_fifth_option)
  end
  def answer_params
    params.require(:answer).permit(:answer, :answer_type, :answer_first_option, :answer_second_option, :answer_third_option, :answer_fourth_option, :answer_fifth_option)
  end


end