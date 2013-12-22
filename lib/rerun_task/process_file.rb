require 'pathname'

module RerunTask
  class ProcessFile
    attr_accessor :process_name, :pid

    def initialize(pid_dir)
      @pid_dir = pid_dir
      FileUtils.mkdir_p(@pid_dir) unless Dir.exists?(@pid_dir)
    end

    def create_pid_file
      if File.exists?(path)
        puts "file exists #{path}"

        process_from_file = ProcessFile.load_file(@pid_dir, process_name)
        raise RuntimeError.new("Process #{process_name} is already running with pid #{process_from_file.pid}") if process_from_file.process_exists?
      end

      File.open(path, 'w+') do |f|
        f.write(self.to_s)
      end
    end

    def path
      ProcessFile.create_file_path(@pid_dir, process_name)
    end

    def self.create_file_path(pid_dir, process_name)
      basename = Pathname.new("#{pid_dir}/#{process_name}.pid").basename
      "#{pid_dir}/#{basename}"
    end

    def process_name
      @process_name = @process_name || extract_process_name(Process.pid)
    end

    def to_s
      "#{Process.pid}\n#{process_name}"
    end

    def process_exists?
      extract_process_name(pid) == @process_name
    end

    def self.load_file(pid_dir, process_name)
      f = File.open(create_file_path(pid_dir, process_name), 'r')
      p = ProcessFile.new(pid_dir)
      args = parse_file(f.read)
      p.process_name = process_name.nil? ? args[:process_name] : process_name
      p.pid = args[:pid]
      f.close
      p
    end

    def self.parse_file(string)
      a = string.split("\n")
      { pid:  a.first, process_name: a.last }
    end

    def destroy
      FileUtils.rm(path)
    end

    private

    def extract_process_name(pid)
      ps_res = %x[ps ax]
      ps_res = ps_res.split("\n")
      name = ""
      ps_res.each do |line|
        rows = line.split(" ")
        name = rows.last if rows.first == pid.to_s
      end
      raise RuntimeError.new("process_name not found for pid #{pid}") if name === ""
      name
    end
  end
end
