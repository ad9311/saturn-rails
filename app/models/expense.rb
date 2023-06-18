# == Schema Information
#
# Table name: expenses
#
#  id              :bigint           not null, primary key
#  amount          :float
#  archived        :boolean          default(FALSE), not null
#  description     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  expense_list_id :bigint           not null
#
# Indexes
#
#  index_expenses_on_expense_list_id  (expense_list_id)
#
# Foreign Keys
#
#  fk_rails_...  (expense_list_id => expense_lists.id)
#
class Expense < ApplicationRecord
  belongs_to :expense_list

  validates :description, presence: true, length: { maximum: 50 }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  after_create :update_expense_list_balance

  private

  def update_expense_list_balance
    old_balance = expense_list.balance
    new_balance = old_balance - amount
    old_total_expenses = expense_list.total_expenses
    new_total_exepnses = old_total_expenses + amount
    expense_list.update(balance: new_balance, total_expenses: new_total_exepnses)
  end
end
