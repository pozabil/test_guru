class UserBadgesUpdateService
  def initialize(test_passage)
    @test_passage = test_passage
    @current_user = @test_passage.user
    @current_test = @test_passage.test
    @all_badges = Badge.all
  end

  def call
    previus_badges_quantity = @current_user.badges.size

    @all_badges.each do |badge|
      @current_user.badges.push(badge) if send("#{badge.rule}_badge_check", badge)
    end

    return @current_user.badges.size > previus_badges_quantity
  end

  private

  def at_first_try_badge_check(badge)
    @test_passage.success? && @current_user.test_passages.where(test_id: @current_test.id).size == 1
  end

  def success_by_category_badge_check(badge)
    return false if !@test_passage.success? || @current_test.category.title != badge.rule_condition

    all_filtered_tests = Test.joins(:questions).distinct.filter_by_category(badge.rule_condition)
    passed_filtered_tests = passed_tests.filter_by_category(badge.rule_condition).uniq
    return passed_filtered_tests.size == all_filtered_tests.size
  end

  def success_by_level_badge_check(badge)
    return false if !@test_passage.success? || @current_test.level != badge.rule_condition.to_i

    all_filtered_tests = Test.joins(:questions).distinct.where(level: badge.rule_condition)
    passed_filtered_tests = passed_tests.where(level: badge.rule_condition).uniq
    return passed_filtered_tests.size == all_filtered_tests.size
  end

  def passed_tests
    @current_user.tests.where(test_passages: { success: true })
  end
end
