class TestsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_test, only: %i[show start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def show
    redirect_to root_path if @test.questions.size == 0
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render inline: t('errors.test_not_found')
  end
end
