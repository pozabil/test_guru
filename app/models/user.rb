class User < ApplicationRecord
  has_and_belongs_to_many :tests

  def test_list_by_level(level)
    self.tests.where(level: level)
  end
end
