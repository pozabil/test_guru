class Admin::TestsController < Admin::BaseController
  before_action :find_test, only: %i[show edit publish update destroy start update_inline]
  before_action :find_tests, only: %i[index update_inline]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index; end

  def show; end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.created_tests.new(test_params)

    if @test.save
      flash[:success] = t('.success', test_title: @test.title)
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def edit; end

  def publish
    if @test.correct?
      @test.published = true
      flash[:success] = t('.success', test_title: @test.title) if @test.save
      redirect_to admin_tests_path
    else
      flash[:alert] = t('.incorrect', test_title: @test.title)
      redirect_to [:admin, @test]
    end
  end

  def update
    if @test.update(test_params)
      flash[:success] = t('.success', test_title: @test.title)
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end    
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path, alert: t('.success', test_title: @test.title)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def find_tests
    @tests = Test.all
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :timer)
  end

  def rescue_with_test_not_found
    render inline: t('errors.test_not_found')
  end
end
