module RerunTask
  class Pids
    def self.unfinished
      res = []
      Dir.glob("#{RerunTask::CONFIG['pid_dir']}/rerun_task/pids/*.pid").each do |file_path|
        args = {}
        File.open(file_path, 'r') do |f|
          args = ProcessFile.parse_file(f.read)
        end
        next if args[:process_name].nil? || args[:pid].nil?
        p = ProcessFile.load_file("#{RerunTask::CONFIG['pid_dir']}/rerun_task/pids", args[:process_name])
        begin
          p.process_exists?
        rescue
          res << p
          next
        end
      end
      res
    end
  end
end
