class TestsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_test, only: %i[show start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def show; end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render inline: '<h1>ОШИБКА! ТЕСТ НЕ БЫЛ НАЙДЕН!</h1>'
  end
end
