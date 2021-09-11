class Test < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User', inverse_of: 'created_tests'
  has_many :questions
  has_and_belongs_to_many :users

  def self.filter_by_category(category)
    joins(:category).where(categories: { title: category })
      .order(title: :desc).distinct.pluck(:title)
  end
end
