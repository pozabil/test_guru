class TestPassageCheckSuccessService
  def initialize(test_passage)
    @test_passage = test_passage
  end

  def call
    @test_passage.success = true if @test_passage.success?
    @test_passage.save!
  end
end
