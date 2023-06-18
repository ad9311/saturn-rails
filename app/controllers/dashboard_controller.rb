class DashboardController < ApplicationController
  def index
    @reminders_count = current_user.reminders.count
    @thoughts_count = current_user.thoughts.count
    @recoveries_count = current_user.recoveries.count
    @routines_count = current_user.routines.count
  end
end
