module PolicyService
  def self.get_policy(args)
    conn = Faraday.new(url: ENV['INSURANCE_API'])
    res = conn.get "/policies/#{args[:id]}" do |req|
      req.headers[:content_type] = "application/json"
      req.headers[:authorization] = "Bearer #{args[:token]}"
    end

    res.body
  end

  def self.get_policies(token:)
    conn = Faraday.new(url: ENV['INSURANCE_API'])
    res = conn.get "/policies" do |req|
      req.headers[:content_type] = "application/json"
      req.headers[:authorization] = "Bearer #{token}"
    end

    res.body
  end

  def self.create_policy(payload)
    PolicyPublisher.call(payload)
  end
end
