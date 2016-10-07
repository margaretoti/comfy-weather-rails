class WeatherTypeSerializer < BaseSerializer
  attributes :temp_range, :precip_type

  def temp_range
    [object.temp_range.first, object.temp_range.last]
  end
end
