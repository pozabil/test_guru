class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[show edit update destroy]
  before_action :find_question, only: %i[index new create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_answer_not_found

  def index
    redirect_to question_path(@question)
  end

  def show; end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @answer.question
    else
      render :new
    end
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to @answer.question
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to @answer.question
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end

  def rescue_with_answer_not_found
    render inline: '<h1>ОШИБКА! ОТВЕТ НЕ БЫЛ НАЙДЕН!</h1>'
  end
end
