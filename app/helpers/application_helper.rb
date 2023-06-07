module ApplicationHelper
  def recovery_target_days(recovery)
    (recovery.target_date - recovery.start_date).to_i
  end
end
