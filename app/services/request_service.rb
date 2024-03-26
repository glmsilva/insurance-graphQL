require 'net/http'

class RequestService
  def initialize
    @http = Net::HTTP.new("insurance-rest", 3000)
    @http.start
  end

  def self.get(path)
    new.request_get(path)
  end

  def request_get(path)
    Net::HTTP.new(@http.ipaddr, @http.port)
              .request_get(path)
              .read_body
  end
end
