module ApplicationHelper
  def recovery_target_days(recovery)
    (recovery.target_date - recovery.start_date).to_i
  end

  def recovery_last_report_today?(recovery)
    return false if recovery.report_dates.last.nil?

    return true if Date.parse(recovery.report_dates.last) == Time.zone.now.to_date

    false
  end
end
