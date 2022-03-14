# frozen_string_literal: true

require_relative "time_zones_api/version"
require "httparty"

# TimeZonesApi is quick and simple time zone lookup by geographic point.
#
# Usage:
#
# ```ruby
# TimeZonesApi.lookup(50.004444, 36.231389)
# # => 'Europe/Kiev'
#
# TimeZonesApi.get(50.004444, 36.231389)
# # => #<TZInfo::DataTimezone: Europe/Kiev>
#
# TimeZonesApi.get(-42, 146)
# # => #<TZInfo::DataTimezone: Australia/Hobart>
# ```
module TimeZonesApi
  extend self

  class TimeZoneApiError < StandardError; end

  def lookup(latitude, longitude, timeout: 5)
    validate!(latitude, longitude)
    send_request(latitude, longitude, timeout)
  end

  def get(lat, lng, timeout: 5)
    load_tzinfo
    TZInfo::Timezone.get(lookup(lat, lng, timeout: timeout))
  end

  private

  def load_tzinfo
    require "tzinfo"
  rescue LoadError
    raise TimeZoneApiError, "Please install tzinfo for using #get"
  end

  def send_request(latitude, longitude, timeout)
    url = "https://timezonesapi.com/lookup/?lat=#{latitude}&long=#{longitude}"
    response = HTTParty.get(url, timeout: timeout, format: :plain)
    JSON.parse(response.body, symbolize_names: true)[:zone] if response.code == 200
  rescue Net::ReadTimeout
    raise TimeZoneApiError, "Request to timezonesapi.com timed out"
  end

  def validate!(latitude, longitude)
    raise TimeZoneApiError, "No latitude provided" if latitude.nil?
    raise TimeZoneApiError, "No longitude provided" if longitude.nil?
    raise TimeZoneApiError, "Invalid longitude provided (-180 < long < 180)" unless valid_longitude?(longitude)
    raise TimeZoneApiError, "Invalid latitude provided (-90 < lat < 90)" unless valid_latitude?(latitude)
  end

  def valid_longitude?(longitude)
    long = parse_float(longitude)
    long > -180 && long < 180
  end

  def valid_latitude?(latitude)
    lat = parse_float(latitude)
    lat > -90 && lat < 90
  end

  def parse_float(value)
    Float(value)
  rescue ArgumentError
    raise TimeZoneApiError "Could not parse value #{value} as Float"
  end
end
