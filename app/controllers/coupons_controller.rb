class CouponsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_coupon, only: %i[disable enable]
    
    def create
        @promotion = Promotion.find(params[:id])
        
        @promotion.generate_coupons!
        redirect_to @promotion, notice: t('.success')
    end

    def disable
        set_coupon
        @coupon.disabled!
        redirect_to @coupon.promotion, notice: t('.success', code: @coupon.code)
    end

    def enable
      set_coupon
      @coupon.enabled!
      redirect_to @coupon.promotion, notice: t('.success', code: @coupon.code)
    end

    private
        def set_coupon
            @coupon = Coupon.find(params[:id])
        end
end