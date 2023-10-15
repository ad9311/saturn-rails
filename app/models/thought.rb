# == Schema Information
#
# Table name: thoughts
#
#  id         :bigint           not null, primary key
#  bookmarked :boolean          default(FALSE), not null
#  message    :text             not null
#  mood       :integer          default("neutral"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_thoughts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Thought < ApplicationRecord
  belongs_to :user

  validates :message, presence: true, length: { maximum: 1000 }
  validates :mood, presence: true

  enum mood: Saturn::Constants::MOODS

  def bookmarked?
    bookmarked
  end
end
