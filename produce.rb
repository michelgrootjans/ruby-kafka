require 'kafka'

kafka_ip = exec 'docker-machine ip default'

kafka = Kafka.new(
    seed_brokers: ["#{kafka_ip}:9092"],
    client_id: 'ruby-kafka'
)

# require 'json'
# event = {
#     event: 'customer_moved',
#     customer_id: 385,
#     from: 'old address',
#     to: 'new address',
#     timestamp: Time.now
# }
#
# kafka.deliver_message(JSON.dump(event), topic: 'test2')

consumer = kafka.consumer(group_id: 'ruby-consumer')
consumer.subscribe('test2', start_from_beginning: false)
consumer.each_message do |message|
  puts "#{message.offset}: #{message.value}"
end
