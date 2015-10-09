# cool_rack_application.rb
require "rack"

class CoolRackApplication
  # The required instance method for EVERY rack app.
  def call(env)
    request = Rack::Request.new(env)
    http_verb = request.request_method
    status = 200
    headers = {}
    body = ["got #{http_verb} request\n"]

    # status : An HTTP status code
    # body : An object that responds to each.
    [status, headers, body]
  end
end

# This middleware will detect all PATCH requests and 405 them.
class PatchBlockingMiddleware
  def initialize(app)
    @app = app # The final rack app that this middleware can pass a request to
  end

  # Notice that this middle ware is a rack app too!
  def call(env)
    request = Rack::Request.new(env)

    if request.patch?
      [405, {}, ["PATCH requests not allowed!\n"]]
    else
      @app.call(env)
    end
  end
end

# Run on localhost, port 9292
app = Rack::Builder.new do # combines middlewares and your final rack app
  use PatchBlockingMiddleware
  run CoolRackApplication.new
end

Rack::Handler::WEBrick.run app, Port: 9292
