class Api::V1::PromotionsController < Api::V1::ApiController
  def show
    @promotion = Promotion.find(params[:id])
    render json: @promotion
  end

  def create
    @promotion = current_user.promotions.new(promotion_params)
    @promotion.save!
    render json: @promotion
  end

  def update
    set_promotion
    @promotion.update(promotion_params)
    @promotion.save!
    render json: @promotion
  end

  private
      def set_promotion
          @promotion = Promotion.find(params[:id])
      end

      def promotion_params
          params
          .require(:promotion)
          .permit(:name,
                  :description,
                  :code,
                  :discount_rate,
                  :coupon_quantity,
                  :expiration_date)
      end
end