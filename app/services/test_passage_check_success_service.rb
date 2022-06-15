class TestPassageCheckSuccessService
  WIN_PERCENTAGES = 85

  def initialize(test_passage)
    @test_passage = test_passage
  end

  def call
    @test_passage.success = success?
    @test_passage.save!
  end

  private

  def success?
    @test_passage.completed? && @test_passage.percentage_result >= WIN_PERCENTAGES
  end
end
