require 'net/http'

class RequestService
  def initialize
    @http = Net::HTTP.new("insurance-rest", 3000)
    @http.start
  end

  def self.get(params)
    new.request_get(params[:route], params[:id])
  end

  def request_get(route, id)
    binding.pry
    Net::HTTP.new(@http.ipaddr, @http.port)
              .request_get("/#{route}/#{id}")
              .read_body
  end
end
