class CouponsController < ApplicationController
    def create
        @promotion = Promotion.find(params[:id])
        
        @promotion.generate_coupons!
        redirect_to @promotion, notice: 'Cupons gerados com sucesso'
    end
end