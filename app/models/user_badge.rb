class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  def self.check(test_passage)
    current_user = test_passage.user
    current_test = test_passage.test
    previus_badges_quantity = current_user.badges.size

    Badge.all.each do |badge|
      case badge.rule
      when "at_first_try"
        current_user.badges.push(badge) if (test_passage.success? && current_user.what_try?(current_test) == 1 )
      when "success_by_category"
        current_user.badges.push(badge) if (test_passage.success? && check_success_by_condition_type(:category ,test_passage, badge))
      when "success_by_level"
        current_user.badges.push(badge) if (test_passage.success? && check_success_by_condition_type(:level ,test_passage, badge))
      end
    end

    return true if current_user.badges.size > previus_badges_quantity
  end

  private

  def self.check_success_by_condition_type(condition_type, test_passage, badge)
    current_user = test_passage.user

    if condition_type == :category
      if test_passage.test.send(condition_type).title == badge.rule_condition
        filtered_tests = Test.filter_by_category(badge.rule_condition)
        return filtered_tests_complete_succesfully?(current_user, filtered_tests) ? true : false
      end
    else
      if test_passage.test.send(condition_type) == badge.rule_condition.to_i
        filtered_tests = Test.where(condition_type => badge.rule_condition)
        return filtered_tests_complete_succesfully?(current_user, filtered_tests) ? true : false
      end
    end
  end

  def self.filtered_tests_complete_succesfully?(user, filtered_tests)
    if filtered_tests.present?
      filtered_tests.each do |test|
        if test.questions.size > 0
          if user.test_passage(test).present?
            return false unless test_complete_succesfully?(user, test)
          else
            return false
          end
        end
      end
      return true
    end
  end

  def self.test_complete_succesfully?(user, test)
    all_tries = user.test_passages.where(test_id: test.id)

    all_tries.each do |try|
      return true if try.success?
    end
    return false
  end

end
