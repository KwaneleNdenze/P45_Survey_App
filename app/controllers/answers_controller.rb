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
    @question = @survey.questions.find(params[:question_id])
    @answer = @question.answers.create(answer_params)

    @next_question = @survey.questions.find_by(order: @question.order + 1)
        
    if @next_question.present?
      redirect_to survey_question_path(survey_id: @survey.id, id: @next_question.id)
    
    else
      redirect_to @survey, notice: "Survey Complete. Thank You."
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
  def answer_params
    params.require(:answer).permit(:answer, :answer_type, :answer_first_option, :answer_second_option, :answer_third_option, :answer_fourth_option, :answer_fifth_option)
  end
end