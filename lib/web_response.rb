require 'date'

class WebResponse
  attr_accessor :body, :headers, :response_code, :time

  def initialize
    @time = DateTime.now()
  end

  def ok?
    (100..400).cover?(@response_code)
  end
end
