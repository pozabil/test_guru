class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update result gist]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_passage_not_found

  def show
    if @test_passage.user == current_user
      redirect_to result_test_passage_path(@test_passage) if @test_passage.completed?
    else
      redirect_to root_path
    end
  end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestPassageCheckSuccessService.new(@test_passage).call
      flash[:success] = t('.badge_list_updated') if UserBadgesUpdateService.new(@test_passage).call
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    gist = GistQuestionService.new(@test_passage.current_question)
    result = gist.call

    if gist.success?
      Gist.create(user: current_user, question: @test_passage.current_question, gist_id: result.id)
      flash[:success_link] = url_link(result)
    else
      flash[:alert] = t('.fail')
    end
    redirect_to @test_passage
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def url_link(gist_result)
    view_context.link_to(t('.success'), gist_result.html_url, class: "link-secondary")
  end

  def rescue_with_test_passage_not_found
    render inline: t('errors.test_passage_not_found')
  end
end
