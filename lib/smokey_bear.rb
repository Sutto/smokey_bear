require "smokey_bear/version"
require "active_support"
require "active_support/core_ext"

module SmokeyBear
  
  class << self

    require 'smokey_bear/helpers'

    attr_accessor :domain, :endpoint, :https, :timeout

    def configure
      yield self if block_given?
    end

    def build_base_url
      "#{https ? "https" : "http"}://#{domain}/"
    end

    def base_url
      @base_url ||= build_base_url
    end

  end

  self.endpoint = nil
  self.https    = false
  self.timeout  = 15

end
