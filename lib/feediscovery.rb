require "feediscovery/version"

module Feediscovery
  class DiscoverFeedService
    require 'curb'
    require 'json'
    require 'google-search'

    attr_reader :request_url, :uri

    def initialize(url)
      self.request_url = url
    end

    def request_url=(url)
      begin
        @uri = URI.parse url
        if valid_uri?
          @request_url = url
        else
          search = search_result(url)
          @request_url = search.uri
        end
      rescue
        search = search_result(url)
        @request_url = search.uri
      end
    end

    def result
      perform_request
    end

    private

    def search_result(term)
      search = Google::Search::Web.new(query: term)
      search.first
    end

    def valid_uri?
      uri.scheme && uri.host
    end

    def disco_url
      "http://feediscovery.appspot.com/?url=#{self.request_url}"
    end

    def perform_request
      response = Curl::Easy.perform(disco_url) do |curl|
        curl.headers["User-Agent"] = "1kpl.us/ruby"
        curl.max_redirects = 5
        curl.timeout = 30
        curl.follow_location = true
        curl.on_redirect {|easy,code|
          @url = location_from_header(easy.header_str) if easy.response_code == 301
        }
      end

      JSON.parse(response.body_str).map {|e| OpenStruct.new e}
    end

  end


end
