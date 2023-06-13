module RecoveryHelper
  def allow_submit_report?(recovery)
    current_date = Time.zone.now.to_date
    current_time = Time.zone.now
    last_report = recovery.report_dates.last&.to_date

    return false unless current_time.hour >= 22 && current_time.hour <= 23

    return false if recovery.completed

    return false unless current_date >= recovery.start_date

    return true if last_report.nil?

    return false unless current_date > last_report

    true
  end

  def calculate_progress(recovery)
    recovery.target_days.zero? ? 0.0 : (100.0 * recovery.current_record.to_f) / recovery.target_days.to_f
  end
end
