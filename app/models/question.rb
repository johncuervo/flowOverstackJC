# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  validates :title, :content, presence: true

  def self.search(search)
    search ? where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"]) : all
  end

end
