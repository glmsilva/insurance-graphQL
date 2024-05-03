class StripeWebhooksController < ApplicationController
  def create
    begin
      @event = Stripe::Event.construct_from(params.to_unsafe_h)
    rescue StandardError => e
      head 400
    end

    case @event.type
    when 'checkout.session.completed'
      @payment_completed = @event.data.object
      handle_checkout_session_completed
      head 200
    else
      Rails.logger.info "Event Type não especificado: #{@event.type}"
      head 400
    end
  end

  private

  def handle_checkout_session_completed
    PaymentPublisher.execute(@payment_completed)
  end
end
