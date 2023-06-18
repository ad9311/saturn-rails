# == Schema Information
#
# Table name: expense_lists
#
#  id                 :bigint           not null, primary key
#  balance            :float            not null
#  title              :string           not null
#  top_amount_allowed :float            not null
#  total_expenses     :float            default(0.0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_expense_lists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ExpenseList < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :top_amount_allowed, presence: true, numericality: { greater_than: 0.0 }
  validates :total_expenses, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  before_create :set_balance

  private

  def set_balance
    self.balance = top_amount_allowed
  end
end
