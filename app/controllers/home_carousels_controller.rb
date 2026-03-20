# frozen_string_literal: true

class HomeCarouselsController < ApplicationController
  authorized_when { current_user.admin? }

  def edit
    @home_carousel = HomeCarousel.first_or_initialize
  end

  def update
    @home_carousel = HomeCarousel.first_or_initialize

    @home_carousel.update(home_carousel_params)

    respond_with @home_carousel, location: edit_home_carousel_path
  end

  def destroy
    @home_carousel = HomeCarousel.sole
    image_name = params[:image]
    @home_carousel.send(image_name).destroy!

    respond_with @home_carousel, location: edit_home_carousel_path, notice: "#{image_name.humanize} has been deleted."
  end

  private

  def home_carousel_params
    params.require(:home_carousel).permit(:image_one, :image_two, :image_three)
  end
end
