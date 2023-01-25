class BaseInteractor
  include ActiveSupport::Rescuable

  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def perform
    try(:load_params)
    execute
  rescue StandardError => exception
    rescue_with_handler(exception)
  end
end
