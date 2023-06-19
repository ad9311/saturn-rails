# == Schema Information
#
# Table name: expenses
#
#  id          :bigint           not null, primary key
#  amount      :float
#  archived    :boolean          default(FALSE), not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  budget_id   :bigint           not null
#
# Indexes
#
#  index_expenses_on_budget_id  (budget_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_id => budgets.id)
#
class Expense < ApplicationRecord
  belongs_to :budget

  validates :description, presence: true, length: { maximum: 20 }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  after_create :add_to_budget_balance
  before_destroy :substract_to_budget_balance

  private

  def add_to_budget_balance
    budget.update(
      balance: budget.balance - amount,
      total_expenses: budget.total_expenses + amount
    )
  end

  def substract_to_budget_balance
    budget.update(
      balance: budget.balance - amount,
      total_expenses: budget.total_expenses - amount
    )
  end
end
