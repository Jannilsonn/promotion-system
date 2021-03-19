class CouponsController < ApplicationController
    def create
        @promotion = Promotion.find(params[:id])
        
        (1..@promotion.coupon_quantity).each do |number|
          Coupon.create!(code: "#{@promotion.code}-#{'%04d' % number}", promotion: @promotion)
        end
    
        flash[:notice] = 'Cupons gerados com sucesso'
        redirect_to @promotion
    end
end