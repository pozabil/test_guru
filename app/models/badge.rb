class Badge < ApplicationRecord
  IMAGE_PATH_HTTP_FORMAT = /\Ahttps?:\/\//i
  NATURAL_NUMBER_FORMAT = /\A\d+\z/
  RULE_TYPES = ["at_first_try", "success_by_category", "success_by_level"]

  belongs_to :creator, class_name: 'User', inverse_of: 'created_badges'
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  before_validation :before_validation_set_correct_image_path

  validates :title, presence: true, uniqueness: true
  validates :image_path, format: { with: IMAGE_PATH_HTTP_FORMAT }
  validates :rule, inclusion: { in: RULE_TYPES }, allow_blank: true
  validates :rule_condition, format: { with: NATURAL_NUMBER_FORMAT }, if: :rule_condition_is_level?

  # def belongs_to_user?(user)
  #   !!user.badges.find_by(id: id)
  # end

  def image_path_is_http?
    image_path.match?(IMAGE_PATH_HTTP_FORMAT)
  end

  def image_path_is_correct?
    image_path.present? && image_path_is_http?
  end

  private

  def before_validation_set_correct_image_path
    self.image_path = image_path_is_http? ? image_path.strip : ("http://" + image_path.strip)
  end

  def rule_condition_is_level?
    rule == RULE_TYPES[2]
  end
end
