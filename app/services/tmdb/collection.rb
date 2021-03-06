module Tmdb
  class Collection < Base
    attr_accessor :args

    def self.discover(page_number)
      response = Request.get(page_number)
      Collection.new(response)
    end

    def self.get_by_id(id)
      Request.get_by_id(id)
    end

    def initialize(args = {})
      @args = args
      super(@args)
    end

  end
end
