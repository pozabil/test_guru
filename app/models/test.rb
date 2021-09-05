class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_and_belongs_to_many :users

  def self.filter_by_category(category)
    includes(:category).where(categories: { title: category })
      .order(title: :desc).distinct.pluck(:title)
  end
end
