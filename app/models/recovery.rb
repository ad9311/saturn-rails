# == Schema Information
#
# Table name: recoveries
#
#  id             :bigint           not null, primary key
#  completed      :boolean          default(FALSE), not null
#  current_record :integer          default(0), not null
#  description    :text
#  favorite       :boolean          default(FALSE), not null
#  max_record     :integer          default(0), not null
#  report_dates   :jsonb            not null
#  start_date     :date             not null
#  target_date    :date             not null
#  target_days    :integer          not null
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
  has_many :awards, as: :awardable, dependent: :nullify
  has_many :stoppers, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }
  validates :start_date, :target_date, presence: true

  before_create :calculate_target_days
  before_update :calculate_target_days

  def calculate_target_days
    self.target_days = (target_date - start_date).to_i + 1
  end
end
