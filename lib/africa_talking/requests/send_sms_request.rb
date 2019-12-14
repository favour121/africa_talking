require 'json'

module AfricaTalking
  class SendSMSRequest < BaseRequestModel
    attribute :to, Array[String]
    attribute :from, String
    attribute :message, String
    attribute :bulkSMSMode, Integer, default: 1
    attribute :enqueue, Integer, default: 1
    attribute :keyword, String
    attribute :linkId, String
    attribute :retryDurationInHours, Integer, default: 48


    def body_attributes
      h = super
      h[:to] = to.join(', ')
      h
    end

    def route
      'messaging'
    end

    def http_method
      :post
    end

    def response_class
      SendSMSResponse
    end

  end
end