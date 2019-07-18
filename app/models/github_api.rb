require "net/https"
require 'securerandom'

class GithubApi

  class << self
    def get_oauth_authorize_url(redirect_uri, scope='public_repo', allow_signup=true)
      params = {
        client_id: GithubSetting.client_id,
        redirect_uri: redirect_uri,
        scope: scope,
        state: SecureRandom.hex(10),
        allow_signup: allow_signup
      }

      uri = URI("https://github.com/login/oauth/authorize")
      uri.query = URI.encode_www_form(params)
      uri.to_s
    end

    def get_oauth(redirect_uri, code, state)
      params = {
        client_id: GithubSetting.client_id,
        client_secret: GithubSetting.client_secret,
        code: code,
        redirect_uri: redirect_uri,
        state: state
      }
      uri = URI("https://github.com/login/oauth/access_token")
      header = {'Accept': 'application/json'}
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.request_uri)
      req.body = params.to_json
      http.use_ssl = true
      response = http.request(req)
    end

    def user_access(access_token)
      uri = URI("https://api.github.com/user")
      req = Net::HTTP::Get.new(uri.path)
      req["Authorization"] = "#{access_token} OAUTH-TOKEN"
      res = Net::HTTP.start(uri.host, uri.port) {|http|
        http.request(req)
      }
    end
  end
end