require 'tzinfo'

class QueryParser
  TIMEZONES = {}

  TZInfo::Timezone.all.each do |z|
    region, city = z.name.split('/')
    TIMEZONES[city] = region
  end

  class << self
    def time_for(cities)
      response = "UTC: #{format_time(Time.now)}</br>"
      return response if cities.nil?
      cities.split(',').each do |city|
        tz = timezone(city)
        next if tz.nil?
        response << "#{city}: #{format_time(tz.now)}</br>"
      end

      response
    end

    private

    def format_time(time)
      time.strftime('%a, %d %b %Y %H:%M:%S')
    end

    def timezone(city)
      region = TIMEZONES[city]
      TZInfo::Timezone.get("#{region}/#{city}") rescue nil
    end
  end
end
