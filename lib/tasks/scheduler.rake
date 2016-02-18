desc "This task is called by the Heroku scheduler add-on"
task :remind_cards => :environment do
  User.pending_cards
end

