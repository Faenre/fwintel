require 'date'

class WebResponse
  attr_reader :body, :headers, :response_code, :time

  def initialize
    @time = DateTime.now()
  end

  def ok?
    (200..300).cover?(@response_code)
  end
end
