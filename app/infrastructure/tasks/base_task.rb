module Tasks

  class BaseTask
    def run
      raise TaskNotImplementedException, "Run method not implemented in derived class"
    end
  end

  class TaskNotImplementedException < NoMethodError
  end

end
