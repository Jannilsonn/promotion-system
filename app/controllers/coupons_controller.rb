class CouponsController < ApplicationController
    def create
        @promotion = Promotion.find(params[:id])
        
        @promotion.generate_coupons!
        redirect_to @promotion, notice: t('.success')
    end

    def disable
        @coupon = Coupon.find(params[:id])
        @coupon.disabled!
        redirect_to @coupon.promotion, notice: t('.success', code: @coupon.code)
    end

    private
        def set_coupon
            @coupon = Coupon.find(params[:id])
        end
end