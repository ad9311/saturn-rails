module ApplicationHelper
  def allow_submit_report?(recovery)
    current_date = Time.zone.now.to_date
    current_time = Time.zone.now
    last_report = recovery.report_dates.last&.to_date

    return false if current_time.hour >= 13 && current_time.hour <= 23

    return false if recovery.completed

    return false unless current_date >= recovery.start_date

    return false if current_date >= last_report

    true
  end
end
