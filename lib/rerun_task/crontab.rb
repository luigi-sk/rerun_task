module RerunTask
  class Crontab
    @content
    def initialize
      @content = %x[crontab -l]
      @content = @content.split("\n")
    end

    def find_task(task_name)
      match = @content.reject{|i| !i.include?(task_name)}
      match.split(" ")[5,9].join(" ")
    end

  end
end
