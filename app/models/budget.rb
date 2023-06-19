# == Schema Information
#
# Table name: budgets
#
#  id             :bigint           not null, primary key
#  amount         :float            not null
#  balance        :float            not null
#  title          :string           not null
#  total_expenses :float            default(0.0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_budgets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Budget < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :amount, presence: true, numericality: { greater_than: 0.0 }
  validates :total_expenses, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  before_create :set_balance
  before_update :set_balance

  private

  def set_balance
    self.balance = amount - total_expenses
  end
end
