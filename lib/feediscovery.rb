require "feediscovery/version"

module Feediscovery
  class DiscoverFeedService
    require 'json'
    require 'google-search'

    attr_reader :url, :uri

    def initialize(url)
      self.url = url
    end

    def url=(url)
      begin
        @uri = URI.parse url
        if valid_uri?
          @url = url
        else
          search = search_result(url)
          @url = search.uri
        end
      rescue
        search = search_result(url)
        @url = search.uri
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
      "http://feediscovery.appspot.com/?url=#{self.url}"
    end

    def perform_request
      #response = Curl::Easy.perform(disco_url) do |curl|
        #curl.headers["User-Agent"] = "1kpl.us/ruby"
        #curl.max_redirects = 5
        #curl.timeout = 30
        #curl.follow_location = true
        #curl.on_redirect {|easy,code|
          #@url = location_from_header(easy.header_str) if easy.response_code == 301
        #}
      #end
      response = Typhoeus::Request.get(disco_url, followlocation: true)
      JSON.parse(response.body).map {|e| OpenStruct.new e}
    end

  end


end
