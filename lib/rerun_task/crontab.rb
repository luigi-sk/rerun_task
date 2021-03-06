module RerunTask
  class Crontab
    attr_accessor :content
    def initialize
      @content = %x[crontab -l]
      @content = @content.split("\n")
    end

    def find_task(task_name)
      match = @content.reject{|i| !i.include?(task_name)}
      return nil if match.size == 0
      match.first.split(" ")[5,9].join(" ")
    end

  end
end
