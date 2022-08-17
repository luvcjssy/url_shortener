module ApiResponseHelpers
  extend ActiveSupport::Concern

  def render_object(message, object, serializer, instance_options = {})
    hash = { success: true, message: message, data: {} }

    if object
      json = serializer.new(object, instance_options).as_json
      hash[:data] = hash[:data].merge(json)
    end

    render json: hash
  end
end
