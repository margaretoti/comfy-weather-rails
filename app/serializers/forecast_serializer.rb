class ForecastSerializer < BaseSerializer
  attributes :summary, :icon, :precipProbability, :temperature,
             :apparentTemperature, :humidity, :windSpeed, :cloudCover, :pressure
end
