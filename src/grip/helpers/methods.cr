module Grip::Helpers::Methods
  def headers(context, additional_headers)
    context.response.headers.merge!(additional_headers)
  end

  def headers(context, header, value)
    context.response.headers[header] = value
  end

  def json(context, content, status_code = HTTP::Status::OK)
    context.response.status_code = status_code.to_i
    content.to_json
  end

  def html(context, content, status_code = HTTP::Status::OK)
    context.response.status_code = status_code.to_i
    context.response.headers.merge!({"Content-Type" => "text/html"})
    content
  end

  def text(context, content, status_code = HTTP::Status::OK)
    context.response.status_code = status_code.to_i
    context.response.headers.merge!({"Content-Type" => "text/plain"})
    content
  end

  def stream(context, content, status_code = HTTP::Status::OK)
    context.response.status_code = status_code.to_i
    context.response.headers.merge!({"Content-Type" => "application/octetstream"})
    content
  end

  def json(context : HTTP::Server::Context)
    context.params.json
  end

  def query(context : HTTP::Server::Context)
    context.params.query
  end

  def url(context : HTTP::Server::Context)
    context.params.url
  end

  def ws_url(context : HTTP::Server::Context)
    context.ws_route_lookup.params
  end

  def headers(context : HTTP::Server::Context)
    context.request.headers
  end

  def add_handler(handler : HTTP::Handler)
    Grip.config.add_handler handler
  end

  def add_handler(handler : HTTP::Handler, position : Int32)
    Grip.config.add_handler handler, position
  end

  def log(message : String)
    Grip.config.logger.write "#{message}\n"
  end

  def logging(status : Bool)
    Grip.config.logging = status
  end

  def logger(logger : Grip::BaseLogHandler)
    Grip.config.logger = logger
    Grip.config.add_handler logger
  end
end
