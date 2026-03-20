# frozen_string_literal: true

class EmbeddedYoutubesController < ApplicationController
  authorized_when { current_user.present? }

  def show
    @embedded_youtube = EmbeddedYoutube.new(id: params[:id])

    render json: {
      sgid: @embedded_youtube.attachable_sgid,
      content: render_to_string(partial: 'embedded_youtubes/thumbnail',
                                locals: { embedded_youtube: @embedded_youtube }, formats: [:html])
    }
  end
end
