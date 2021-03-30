class PromotionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_promotion, only: %i[show edit update destroy approve]

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
        @promotion = current_user.promotions.new(promotion_params)
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

    def approve
      PromotionApproval.create!(promotion: @promotion, user: current_user)
      redirect_to @promotion, notice: 'Promoção aprovada com sucesso'
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