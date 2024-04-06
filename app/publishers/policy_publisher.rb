require 'bunny'
require 'thread'

class PolicyPublisher
  attr_accessor :payload, :call_id, :response, :lock, :condition, :connection, :channel, :queue_name, :reply_queue, :exchange

  def initialize(payload)
    @payload = payload
    @connection = Bunny.new(hostname: 'insura_rabbit')
    @connection.start

    @channel = connection.create_channel
    @exchange = Bunny::Exchange.new(channel, :direct, "sneakers", durable: true)
    @queue_name = 'policy-create'

    setup_reply_queue
  end

  def self.call(payload)
    new(payload).call
  end


  def call
    @call_id = uuid

    exchange.publish(payload,
                     routing_key: queue_name,
                     correlation_id: call_id,
                     reply_to: reply_queue.name)

    lock.synchronize do
      condition.wait(lock) until response
    end

    channel.close
    connection.close
    response
  end

  private

  def uuid
    SecureRandom.uuid
  end

  def setup_reply_queue
    @lock = Mutex.new
    @condition = ConditionVariable.new
    @reply_queue = channel.queue('', exclusive: true)
    @reply_queue = reply_queue.bind(exchange, :routing_key => reply_queue.name)

    @reply_queue.subscribe(:manual_ack => true) do |_delivery_info, properties, payload|
      if properties[:correlation_id] == call_id
        self.response = payload

        lock.synchronize { condition.signal }
      end
    end
  end
end
