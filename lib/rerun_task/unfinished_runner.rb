module RerunTask
  class UnfinishedRunner

    def self.crontab_retry
      crontab = Crontab.new()
      Pids.unfinished.each do |process_file|
        crontab.find_task(process_file.process_name)
      end
    end
  end
end