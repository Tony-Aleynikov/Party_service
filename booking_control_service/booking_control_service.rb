require 'bunny'
require 'json'
require 'faraday'
require_relative 'booking_control_service.rb'


connection = Bunny.new('amqp://guest:guest@rabbitmq')
connection.start

channel = connection.create_channel
queue = channel.queue('change_ticket_status', auto_delete: true)

queue.subscribe do |_delivery_info, _metadata, payload|
  ticket_information = JSON.parse(payload) #=> { ticket_number: <ticket number>, booking_time: <time> }
  # BookingControlService.change_status_order(ticket_information)
end

Signal.trap('INT') do
  puts 'exiting INT'
  connection.close
end

Signal.trap('TERM') do
  puts 'killing TERM'
  connection.close
end

loop do
  sleep
end
