# == Schema Information
#
# Table name: stoppers
#
#  id          :bigint           not null, primary key
#  datetime    :datetime         not null
#  mood        :integer          not null
#  reason      :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  recovery_id :bigint           not null
#
# Indexes
#
#  index_stoppers_on_recovery_id  (recovery_id)
#
# Foreign Keys
#
#  fk_rails_...  (recovery_id => recoveries.id)
#
class Stopper < ApplicationRecord
  belongs_to :recovery

  validates :reason, presence: true, length: { maximum: 1000 }
  validates :datetime, presence: true
  validates :mood, presence: true

  enum mood: SaturnApp::Constants::MOODS
end
