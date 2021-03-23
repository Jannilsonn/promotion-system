class CategoriesController < ApplicationController
    def index
        @categories = Category.all
    end

    def show
        set_category
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to @category
        else
            render :new
        end
    end

    def edit
        set_category
    end

    def update
        set_category
        @category.update(category_params)
        if @category.save
            redirect_to @category
        else
            render :edit
        end
    end

    def destroy
        set_category.destroy
        flash[:notice] = t('.success')
        redirect_to categories_path
    end

    private
        def set_category
            @category = Category.find(params[:id])
        end

        def category_params
            params.require(:category).permit(:name, :code)
        end
end