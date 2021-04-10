class Api::V1::PromotionsController < Api::V1::ApiController
  def show
    @promotion = Promotion.find(params[:id])
    render json: @promotion
  end
end