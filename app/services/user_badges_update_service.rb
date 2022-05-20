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
      @current_user.badges.push(badge) if (@test_passage.success? && send("#{badge.rule}_badge_check_success", badge))
    end

    return true if @current_user.badges.size > previus_badges_quantity
  end

  private

  def at_first_try_badge_check_success(badge)
    @current_user.first_try?(@current_test)
  end

  def success_by_category_badge_check_success(badge)
    if @test_passage.test.category.title == badge.rule_condition
      filtered_tests = Test.filter_by_category(badge.rule_condition)
      return filtered_tests_complete_succesfully?(filtered_tests) ? true : false 
    end
  end

  def success_by_level_badge_check_success(badge)
    if @test_passage.test.level == badge.rule_condition.to_i
      filtered_tests = Test.where(level: badge.rule_condition)
      return filtered_tests_complete_succesfully?(filtered_tests) ? true : false
    end
  end

  def filtered_tests_complete_succesfully?(filtered_tests)
    if filtered_tests.present?
      filtered_tests.each do |test|
        if test.questions.size > 0
          if @current_user.test_passage(test).present?
            return false unless test_complete_succesfully?(test)
          else
            return false
          end
        end
      end
      return true
    end
  end

  def test_complete_succesfully?(test)
    all_tries = @current_user.test_passages.where(test_id: test.id)

    all_tries.each do |try|
      return true if try.success?
    end
    return false
  end
end
