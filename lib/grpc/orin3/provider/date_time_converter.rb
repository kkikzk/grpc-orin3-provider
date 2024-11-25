require 'time'

module Grpc
  module ORiN3
    module Provider
      class DateTimeConverter
        TICKS_PER_SECOND = 10_000_000
        EPOCH = Time.utc(1, 1, 1, 0, 0, 0)

        def self.to_int64(time)
          utc_time = time.utc
          ticks = ((utc_time - EPOCH) * TICKS_PER_SECOND).to_i
          return ticks & 0x3FFFFFFFFFFFFFFF
        end
  
        def self.from_int64(int64)
          filter = 0x3FFFFFFFFFFFFFFF
          datetime_num = int64 & filter
          seconds_since_windows_epoch = datetime_num.to_f / TICKS_PER_SECOND
          return EPOCH + seconds_since_windows_epoch
        end
      end
    end
  end
end