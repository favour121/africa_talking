require 'json'

module AfricaTalking

  class Model
    include ::Virtus.model(nullify_blank: true)

    def body_attributes
      attributes
    end
  end

  class SMSResponseRecipientDetail < Model
    attribute :statusCode, Integer
    attribute :number, String
    attribute :status, String
    attribute :cost, String
    attribute :messageId, String
  end

  class SMSResponseDetail < Model
    attribute :Message, String
    attribute :Recipients, Array[SMSResponseRecipientDetail]
  end

  class SendSMSResponse < Model
    attribute :SMSMessageData, Array[SMSResponseDetail]
  end

  class SMSDeliveryCallbackNotification < Model
    attribute :id, String
    attribute :status, String
    attribute :phoneNumber, String
    attribute :networkCode, String
    attribute :failureReason, String
    attribute :retryCount, Integer
  end

end