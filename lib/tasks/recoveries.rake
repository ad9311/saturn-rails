namespace :recoveries do
  desc "Checks for each recovery's report"
  task check_recoveries_report: :environment do
    current_date = Time.zone.now.to_date
    Recovery.where(completed: false).each do |recovery|
      last_report = recovery.report_dates.last

      next if recovery.start_date >= current_date

      report_is_valid = (last_report.nil? && recovery.start_date < current_date)
      report_is_day_before = (Date.parse(last_report) != current_date - 1.day) unless last_report.nil?
      next unless report_is_valid || report_is_day_before

      date_difference = (recovery.target_date - recovery.start_date).to_i
      new_target_date = current_date + date_difference.days
      recovery.update(start_date: current_date, target_date: new_target_date, current_record: 0)
    end
  end
end
