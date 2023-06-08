# == Schema Information
#
# Table name: stoppers
#
#  id          :bigint           not null, primary key
#  date        :date             not null
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
end
