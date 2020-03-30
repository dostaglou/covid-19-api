desc "This is a task that is called by the Heroku Scheduler add-on"
task :do_something => :environment do
  SlackNotification.hello
end
