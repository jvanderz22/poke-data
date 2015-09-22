class Error
  include ActiveModel::Model

  attr_reader :pointer, :detail, :status

  def initialize(options = {})
    @pointer = options[:pointer]
    @detail = options[:detail]
    @status = options[:status]
  end
end
