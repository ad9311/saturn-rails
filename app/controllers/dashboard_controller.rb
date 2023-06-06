class DashboardController < ApplicationController
  def index
    @recoveries = current_user.recoveries
  end
end
