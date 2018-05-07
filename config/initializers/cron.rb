schedule_file = File.join(Rails.root, "config", "cron.yml")

if File.exist?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.create YAML.load_file(schedule_file)
end
