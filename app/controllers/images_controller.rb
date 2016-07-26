class ImagesController < ApplicationController
  acts_as_token_authentication_handler_for User, only: :none

  before_action :find_category
  before_action :find_image, only: [:show, :destroy]

  def index
    @images = @category.images
  end

  def show
    @image
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to edit_category_url(@category), notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def find_category
      @category = Category.find(params[:category_id])
    end

    def find_image
      @image = Image.find(params[:id])
    end
end
