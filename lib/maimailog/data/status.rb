module Maimailog
  module Data

    ##
    # ステータスのデータクラス
    class Status
      attr_reader :name, :rating, :rating_max

      def initialize(name, rating, rating_max)
        @name = name
        @rating = rating
        @rating_max = rating_max
      end
    end

  end
end