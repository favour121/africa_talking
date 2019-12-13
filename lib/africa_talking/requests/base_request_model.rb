require 'json'

module AfricaTalking
  class BaseRequestModel < Model

    def payload
      if http_method == :get
        nil
      else
        body_attributes.to_json
      end
    end

    def headers
      if http_method == :get
        {params: payload}
      else
        {}
      end
    end
  end
end