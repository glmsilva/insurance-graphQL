require 'rails_helper'

describe 'Webhook', type: :request do
  describe '#create' do
    let(:event_object) do
      {
        id: "evt_1NG8Du2eZvKYlo2CUI79vXWy",
        data: {
          object: {
            id: "seti_1NG8Du2eZvKYlo2C9XMqbR0x",
            object: "payment_intent",
            customer: "banana"
          }
        },
        type: "payment_intent.succeeded"
      }
    end

    it 'send event successfully' do
      post stripe_webhooks_path, params: event_object

      expect(response).to have_http_status(200)
    end
  end
end
