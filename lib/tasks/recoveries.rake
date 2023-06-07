namespace :recoveries do
  desc 'Check for unreported recoveries'
  task check_unreported_recoveries: :environment do
    current_date = Time.zone.now.to_date
    Recovery.all.each do |recovery|
      last_report = recovery.report_dates.last
      next if last_report.nil?

      if Date.parse(last_report) != current_date - 1.day
        date_difference = (recovery.target_date - recovery.start_date).to_i
        new_target_date = current_date + date_difference.days
        recovery.update(start_date: current_date, target_date: new_target_date, current_record: 0)
      end
    end
  end
end
