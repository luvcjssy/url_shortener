module Api
  module V1
    class TinyUrlsController < BaseController
      before_action :get_slug, only: :decode
      before_action :set_tiny_url, only: :decode

      def encode
        @tiny_url = TinyUrl.new(tiny_url_params)

        if @tiny_url.find_duplicate.nil?
          if @tiny_url.save
            render_object('Created successfully', @tiny_url, TinyUrlSerializer)
          else
            render_error('Created failed', false, 422, @tiny_url.errors)
          end
        else
          render_object('Url is existed', @tiny_url.find_duplicate, TinyUrlSerializer)
        end
      end

      def decode
        render_object('Url is found', @tiny_url, LongUrlSerializer)
      end

      private

      def tiny_url_params
        params.permit(:long_url)
      end

      def get_slug
        return render_error('Short url is invalid', false, 422) unless UriService.valid?(params[:short_url])

        URI(params[:short_url]).path.delete('/')
      end

      def set_tiny_url
        @tiny_url = TinyUrl.find_by!(slug: get_slug)
      end
    end
  end
end