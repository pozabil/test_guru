class TestCorrectnessCheckService
  def initialize(test)
    @test = test
  end

  def call
    @test.correctness = correct?
    @test.save!
  end

  private

  def correct?
    return false if @test.questions.size == 0
    !!@test.questions.reverse_each { |q| return false if q.has_no_correct_answers? }
  end
end
