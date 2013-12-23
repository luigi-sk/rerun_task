require 'yaml'
module RerunTask
  CONFIG = YAML.load_file("#{File.dirname(__FILE__)}/../../config/rerun_task.yml")
end
