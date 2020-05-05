desc "Pings PING_URL to keep a dyno alive"
 task :dyno_ping do
     require "net/http"
     if ENV["PING_URL_REACT"]
         uri = URI(ENV["PING_URL_REACT"])
         response = Net::HTTP.get_response(uri)
         puts response.inspect
     end

     if ENV["PING_URL_REST_API"]
          uri = URI(ENV["PING_URL_REST_API"])
          response = Net::HTTP.get_response(uri)
          puts response.inspect
     end
end