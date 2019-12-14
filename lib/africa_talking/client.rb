require 'base64'
require 'json'
require 'rest-client'

module AfricaTalking

  class Client
    API_BASE_URL_SANDBOX = 'https://api.sandbox.africastalking.com/version1/'
    API_BASE_URL = 'https://api.africastalking.com/version1/'

    def initialize(username, apiKey, sandbox_mode = true)
      @username = username
      @apiKey = apiKey
      @sandbox_mode = sandbox_mode
    end

    def username
      @sandbox_mode ? 'sandbox' : @username
    end

    def send_request(sms_request)
      if @sandbox_mode
        url = API_BASE_URL_SANDBOX + sms_request.route
      else
        url = API_BASE_URL + sms_request.route
      end
      method = sms_request.http_method
      payload = {}
      headers = client_headers.merge(sms_request.headers)

      headers = headers.merge(params: client_payload) if sms_request.http_method == :get
      payload = client_payload.merge(sms_request.payload) if method != :get

      begin
        response = RestClient::Request.execute(method: method, url: url, payload: payload.to_json, headers: headers)
      rescue RestClient::ExceptionWithResponse => err
        raise err
      end

      response_hash = JSON.parse(response.body)
      sms_request.response_class.new(response_hash)
    end

    def client_payload
      {'username': self.username}
    end

    def client_headers
      hsh = {
          'User-Agent': "favour121/AfricaTalking-#{AfricaTalking::VERSION}",
          'Content-Type': 'application/json',
          'accept': 'application/json',
          apiKey: @apiKey

      }
      hsh
    end

  end

end