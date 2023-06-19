class DashboardController < ApplicationController
  def index
    @random_reminder = current_user.reminders.order('RANDOM()').first
    @reminders_count = current_user.reminders.count
    @thoughts_count = current_user.thoughts.count
    @recoveries_count = current_user.recoveries.count
    @routines_count = current_user.routines.count
    @budgets_count = current_user.budgets.count
  end
end
