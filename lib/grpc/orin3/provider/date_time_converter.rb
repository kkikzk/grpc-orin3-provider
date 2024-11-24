require 'time'

module Grpc
  module ORiN3
    module Provider
      class DateTimeConverter
        TICKS_PER_SECOND = 10_000_000
        WINDOWS_EPOCH = Time.utc(1601, 1, 1, 0, 0, 0)

        def self.to_int64(time)
          ticks = (time.to_f * TICKS_PER_SECOND).to_i + TICKS_TO_UNIX_EPOCH
          [ticks].pack('q').unpack('Q')[0]  # Convert to unsigned 64-bit integer
        end

        def self.from_int64(int64)
          # FILETIME（ティック）を 100ナノ秒単位で扱い、Unixエポック（1970年1月1日）に変換
          seconds_since_windows_epoch = int64.to_f / TICKS_PER_SECOND

          # Windows エポックからの経過時間を計算して Time オブジェクトに変換
          return WINDOWS_EPOCH + seconds_since_windows_epoch
        end
      end
    end
  end
end