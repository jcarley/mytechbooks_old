module Tasks

  class ProcessBatchTask < BaseTask
    include Sidekiq::Worker

    def initialize(user_id, filename)
      @user_id = user_id
      @filename = filename
    end

    def run
      ProcessBatchTask.perform_async(@user_id, @filename)
    end

    def perform(user_id, filename)
      input = File.readlines(filename)
      command = RegisterBookCommandHandler.new
      input.each do |isbn|
        command.execute(user_id, isbn)
      end
    end

  end
end
