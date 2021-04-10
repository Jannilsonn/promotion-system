class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_error

  private
    def not_found_error
      head 404
    end

    def invalid_error
      head 409
    end
end