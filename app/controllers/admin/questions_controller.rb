class Admin::QuestionsController < Admin::BaseController
  before_action :find_question, only: %i[show edit update destroy]
  before_action :find_test, only: %i[new create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def show; end

  def new
    @question = @test.questions.new
  end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      flash[:success] = t('.success', question_body: @question.body)
      redirect_to [:admin, @question]
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      flash[:success] = t('.success', question_body: @question.body)
      redirect_to [:admin, @question]
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to [:admin, @question.test], alert: t('.success', question_body: @question.body)
    else
      render :show
    end
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
    render inline: t('errors.question_not_found')
  end
end
