class Admin::AnswersController < Admin::BaseController
  before_action :find_answer, only: %i[show edit update destroy]
  before_action :find_question, only: %i[new create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_answer_not_found

  def show; end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      TestCorrectnessCheckService.new(@answer.question.test).call
      flash[:success] = t('.success', answer_body: @answer.body)
      redirect_to [:admin, @answer.question]
    else
      render :new
    end
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      TestCorrectnessCheckService.new(@answer.question.test).call
      flash[:success] = t('.success', answer_body: @answer.body)
      redirect_to [:admin, @answer.question]
    else
      render :edit
    end
  end

  def destroy
    if @answer.destroy
      TestCorrectnessCheckService.new(@answer.question.test).call
      redirect_to [:admin, @answer.question], alert: t('.success', answer_body: @answer.body)
    else
      render :show
    end
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
    render inline: t('errors.answer_not_found')
  end
end
