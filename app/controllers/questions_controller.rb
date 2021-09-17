class QuestionsController < ApplicationController

  before_action :find_test, only: %i[index create]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render inline: '
      <h1>Список вопросов теста "<%= @test.title %>"</h1>
      <ul>
        <% @test.questions.each do |question| %>
          <li><%= question.body %></li>
        <% end %>
      </ul>
    '
  end

  def show
    render inline: '<h1><%= @question.body %></h1>'
  end

  def new; end

  def create;
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to test_questions_path
    else
      render inline: '<h1>ОШИБКА! ВОПРОС НЕ БЫЛ СОХРАНЕН!</h1>'
    end
  end

  def destroy;
    @question.destroy
    render inline: '<h1>ВОПРОС БЫЛ УДАЛЕН!</h1>'
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
