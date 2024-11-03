require 'time'

module Grpc
  module ORiN3
    module Provider
      class DateTimeConverter
        TICKS_PER_SECOND = 10_000_000
        TICKS_TO_UNIX_EPOCH = 621_355_968_000_000_000

        def self.to_int64(time)
          ticks = (time.to_f * TICKS_PER_SECOND).to_i + TICKS_TO_UNIX_EPOCH
          [ticks].pack('q').unpack('Q')[0]  # Convert to unsigned 64-bit integer
        end

        def self.from_int64(int64)
          ticks = [int64].pack('Q').unpack('q')[0]  # Convert to signed 64-bit integer
          seconds = (ticks - TICKS_TO_UNIX_EPOCH).to_f / TICKS_PER_SECOND
          Time.at(seconds).utc
        end
      end
    end
  end
end