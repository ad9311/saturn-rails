# == Schema Information
#
# Table name: recoveries
#
#  id             :bigint           not null, primary key
#  current_record :integer          default(0), not null
#  description    :text
#  max_record     :integer          default(0), not null
#  report_dates   :jsonb            not null
#  start_date     :date             not null
#  target_date    :date             not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_recoveries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recovery < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }
  validates :start_date, :target_date, presence: true
end
