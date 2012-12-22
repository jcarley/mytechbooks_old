module Tasks

  class ProcessBatchTask < BaseTask
    include Sidekiq::Worker

    def initialize(filename = nil)
      @filename = filename
    end

    def run
      ProcessBatchTask.perform_async(@filename)
    end

    def perform(filename)
      input = File.readlines(filename)
      input.each do |line|
        api = Amazon.new
        api.search(line) do |book|
          process(book)
        end
      end
    end

    private

      def process(book)
        save(book) unless exists(book)
      end

  end
end
