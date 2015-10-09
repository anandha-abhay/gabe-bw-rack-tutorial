# cool_rack_application.rb
require "rack"

class CoolRackApplication
  def call(env)
    http_verb = env["REQUEST_METHOD"]
    status = 200
    headers = {}
    body = ["got #{http_verb} request\n"]

    # status : An HTTP status code
    # body : An object that responds to each.
    [status, headers, body]
  end
end

# Run on localhost, port 9292
Rack::Handler::WEBrick.run CoolRackApplication.new, Port: 9292
