module RoutineHelper
  def allow_submit_routine_report?(routine)
    today = Time.zone.today.strftime('%A').downcase
    current_date = Time.zone.now.to_date
    last_report = routine.last_report

    return false unless routine.days.include?(today)

    return false if !last_report.nil? && last_report.to_date >= current_date

    true
  end
end
