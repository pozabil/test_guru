class Gist < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :gist_id, presence: true

  after_destroy_commit :delete_gist, prepend: true

  def synchronize
    self.destroy if !GeneralGistService.new(gist_id).synchronize
  end

  private

  def delete_gist
    GeneralGistService.new(gist_id).delete
  end
end
