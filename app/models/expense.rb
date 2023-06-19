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

  validates :description, presence: true, length: { maximum: 20 }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  after_create :add_to_expense_list_balance
  before_destroy :substract_to_expense_list_balance

  private

  def add_to_expense_list_balance
    expense_list.update(
      balance: expense_list.balance - amount,
      total_expenses: expense_list.total_expenses + amount
    )
  end

  def substract_to_expense_list_balance
    expense_list.update(
      balance: expense_list.balance - amount,
      total_expenses: expense_list.total_expenses - amount
    )
  end
end
