class StripeWebhooksController < ApplicationController
  def create
    begin
      @event = Stripe::Event.construct_from(params.to_unsafe_h)
    rescue StandardError => e
      head 400
    end

    case @event.type
    when 'payment_intent.succeeded'
      @payment_intent = @event.data.object
      handle_payment_intent_succeeded
      head 200
    else
      Rails.logger.info "Event Type não especificado: #{@event.type}"
    end
  end

  private

  def handle_payment_intent_succeeded
    PaymentPublisher.execute(@payment_intent)
  end
end
