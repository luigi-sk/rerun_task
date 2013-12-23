module RerunTask
  class UnfinishedRunner

    def self.crontab_retry
      crontab = Crontab.new()
      Pids.unfinished.each do |process_file|
        cmd = crontab.find_task(process_file.process_name)
        next if cmd.nil?
        puts "Running command #{cmd} again"
        system("#{cmd} &")
      end
    end
  end
end