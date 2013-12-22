module RerunTask
  class WatchProcess

    def initialize(rake_task_name)
      @name = rake_task_name
      @pid_dir = "#{RerunTask::CONFIG['pid_dir']}/rerun_task/pids"
      @process_file = ProcessFile.new(@pid_dir)
    end

    def call(&block)
      start
      block.call
      finished
    end

    def start
      @process_file.create_pid_file
    end

    def finished
      @process_file.destroy
    end

  end
end
