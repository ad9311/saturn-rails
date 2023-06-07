# == Schema Information
#
# Table name: awards
#
#  id             :bigint           not null, primary key
#  awardable_type :string
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  awardable_id   :integer
#  user_id        :bigint           not null
#
# Indexes
#
#  index_awards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Award < ApplicationRecord
  belongs_to :user
  belongs_to :awardable, polymorphic: true

  validates :title, presence: true
end
