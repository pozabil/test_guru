class QuestionsController < ApplicationController

  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    redirect_to test_path(@test)
  end

  def show; end

  def new
    @question = Question.new
  end

  def create;
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to test_questions_path
    else
      render :new
    end
  end

  def edit
    @test = @question.test
  end

  def update
    @test = @question.test

    if @question.update(question_params)
      redirect_to test_path(@question.test)
    else
      render :edit
    end
  end

  def destroy;
    @question.destroy
    redirect_to test_path(@question.test)
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render inline: '<h1>ОШИБКА! ВОПРОС НЕ БЫЛ НАЙДЕН!</h1>'
  end
end
