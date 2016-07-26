class ImagesController < ApplicationController
  before_action :find_category
  before_action :find_image, only: [:show]

  def index
    @images = @category.images
  end

  def show
    @image
  end

  private

    def find_category
      @category = Category.find(params[:category_id])
    end

    def find_image
      @image = Image.find(params[:id])
    end
end
