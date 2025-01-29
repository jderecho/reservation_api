class Rack::Attack
  throttle("requests by ip", limit: 300, period: 5.minutes) do |request|
    request.ip
  end
end
