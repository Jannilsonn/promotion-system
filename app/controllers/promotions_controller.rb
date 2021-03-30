class PromotionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_promotion, only: %i[show]

    def index
        @promotions = Promotion.all
    end

    def show
        set_promotion
    end

    def new
        @promotion = Promotion.new
    end

    def create
        @promotion = Promotion.new(promotion_params)
        if @promotion.save
            redirect_to @promotion
        else
            render :new
        end
    end

    def edit
        set_promotion
    end

    def update
        set_promotion
        @promotion.update(promotion_params)
        if @promotion.save
            redirect_to @promotion
        else
            render :edit
        end
    end

    def destroy        
        Promotion.find(params[:id]).destroy
        flash[:notice] = t('.success')
        redirect_to promotions_path
    end

    def search
      @promotions = Promotion.search(params[:q])
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