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
#  last_report    :datetime
#  last_setback   :datetime
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
  validate :validate_days, on: :create
  validates :target_days, presence: true, numericality: { greater_than: 0 }
  validate :validate_target_days, on: :create

  def bookmarked?
    bookmarked
  end

  def completed?
    completed
  end

  private

  def validate_days
    errors.add(:days, 'cannot be empty') and return if days.blank?

    days_of_week = SaturnApp::Constants::DAYS_OF_WEEK
    foreign_entries = days - days_of_week
    errors.add(:days, 'can only contain days of the week') unless foreign_entries.empty?
  end

  def validate_target_days
    return unless target_days < days.count

    errors.add(:target_days, 'must be greater or equal to at least the number of days selected')
  end
end
