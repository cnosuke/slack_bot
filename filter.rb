
Dir[File.expand_path('../filter', __FILE__) << '/*.rb'].each do |file|
  require file
end

module Filter
  class Pipe
    def initialize
    end

    def observer_list
      @observer_list ||= Filter.constants.map{|const| eval("Filter::#{const}") }.
        select{|const| const != self.class && const.instance_methods.include?(:update) }.
        map{|const| const.new }
    end

    def update(params)
      observer_list.map do |filter|
        filter.update(params)
      end
    end
  end
end
