class PaymentPublisher
  attr_accessor :payload, :connection, :exchange, :queue_name, :channel

  def initialize(payload)
    @payload = payload
    @connection = Bunny.new(hostname: ENV['RABBIT_MQ_HOST'])
    @connection.start

    @channel = connection.create_channel
    @exchange = Bunny::Exchange.new(channel, :direct, ENV['RABBIT_MQ_EXCHANGE'], durable: true)
    @queue_name = 'policy-payment.succeeded'
  end

  def self.execute(payload)
    new(payload).execute
  end

  def execute
    exchange.publish(payload.to_json, routing_key: queue_name)

    channel.close
    connection.close
    :ack
  end
end
