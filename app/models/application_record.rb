class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def voted_by?(user)
    votes.exists?(user: user)
  end
end
