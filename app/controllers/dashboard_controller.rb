class DashboardController < ApplicationController
  def index
    @random_reminder = current_user.reminders.order('RANDOM()').first
    @reminders_count = current_user.reminders.count
    @thoughts_count = current_user.thoughts.count
    @recoveries_count = current_user.recoveries.count
    @routines_count = current_user.routines.count
    @expense_lists_count = current_user.expense_lists.count
  end
end
