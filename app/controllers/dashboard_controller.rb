class DashboardController < ApplicationController
  def index
    @thoughts_count = current_user.thoughts.count
    @recoveries_count = current_user.recoveries.count
    @routines_count = current_user.routines.count
  end
end
