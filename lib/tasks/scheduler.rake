desc "This is a task that is called by the Heroku Scheduler add-on"
task :do_something => :environment do
  DataRequest.request_data
end

task :line_update => :environment do
  current = Time.now
  current += 9.hours if Rails.env.development?
  hour = current.hour.to_s
  minute = (current.min - (current.min % 30)) == 0? "00" : "30"
  time_slot = hour + ":" + minute

  user_list = User.where.not(line_id: nil, line_notifications: false, line_countries: nil )
                  .where(line_update_time: time_slot, line_deleted_at: nil)

  LineBotController.new.line_broadcast_update(user_list) if user_list.length > 0
end
