Sidekiq::Cron::Job.destroy_all!

if File.exist?(schedule_file) && Sidekiq.server?
  schedule_file = File.join(Rails.root, "config", "cron.yml")
  Sidekiq::Cron::Job.destroy_all!
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
