module Task
  class TaskExecutor

    def self.execute(task)
      task.run
    end

    def self.execute_later(task)
      task.run
    end

  end
end
