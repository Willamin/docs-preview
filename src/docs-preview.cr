module DocsPreview
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
end

require "stout"

OLD_VER = "0.20.0"
VERSION = "0.26.1"

class Stout::Context
  def redirect_to(path)
    @http.response.headers.add("Location", path)
    @http.response.status_code = 302
  end
end

server = Stout::Server.new
server.default_route = "/"

server.get("/") { |c| c.redirect_to("/api") }
server.get("/api") { |c| c.redirect_to("/api/#{VERSION}") }
server.get("/api/#{VERSION}") { |c| c.redirect_to("/api/#{VERSION}/index.html") }

server.get("/api/#{OLD_VER}") { |c| c.redirect_to("/api/#{OLD_VER}/index.html") }
server.get("/api/old") { |c| c.redirect_to("/api/old/index.html") }
server.get("/api/old/*anything") do |c|
  c.redirect_to("/api/#{OLD_VER}/#{c.params["anything"]}")
end

server.get("/api/latest") { |c| c.redirect_to("/api/latest/index.html") }
server.get("/api/latest/*anything") do |c|
  c.redirect_to("/api/#{VERSION}/#{c.params["anything"]}")
end

[VERSION, OLD_VER].each do |v|
  server.get("/api/#{v}/*anything") do |c|
    path = c.params["anything"]
    if path.is_a?(JSON::Any)
      path = path.as_s
    end

    File.open(path) do |file|
      IO.copy(file, c.response)
    end
  end
end

server.listen
