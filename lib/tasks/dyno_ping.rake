desc "Pings PING_URL to keep a dyno alive"
 task :dyno_ping do
     require "net/http"
     if ENV["PING_URL_REACT"]
         uri = URI(ENV["PING_URL_REACT"])
         Net::HTTP.get_response(uri)
     end

     if ENV["PING_URL_REST_API"]
          uri = URI(ENV["PING_URL_REST_API"])
          Net::HTTP.get_response(uri)
     end
end