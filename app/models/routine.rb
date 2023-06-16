# == Schema Information
#
# Table name: routines
#
#  id             :bigint           not null, primary key
#  bookmarked     :boolean          default(FALSE), not null
#  completed      :boolean          default(FALSE), not null
#  current_record :integer          default(0), not null
#  days           :jsonb            not null
#  description    :text
#  max_record     :integer          default(0), not null
#  target_days    :integer          not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_routines_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Routine < ApplicationRecord
  belongs_to :user
  has_many :awards, as: :awardable, dependent: :nullify

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }
  # TODO validate days
end
