module Maimailog
  module Data

    ##
    # 詳細データ
    class Detail
      attr_accessor :name, :score, :date, :judge, :difficulty

      ##
      # ノーツ判定
      class Judge
        attr_accessor :great, :miss, :perfect, :good

        def initialize
          @perfect = 0
          @great = 0
          @good = 0
          @miss = 0
        end

        def total
          @perfect + @great + @good + @miss
        end
      end

      ##
      # スコア
      class Score
        attr_accessor :break, :slide, :tap, :hold, :break_max, :hold_max, :slide_max, :tap_max

        def initialize
          @tap = 0
          @hold = 0
          @slide = 0
          @break = 0
          @tap_max = 0
          @hold_max = 0
          @slide_max = 0
          @break_max = 0
        end

        def total
          @tap + @hold + @slide + @break
        end

        def total_max
          @tap_max + @hold_max + @slide_max + @break_max
        end

        def rate
          (total / total_max.to_f * 10000).floor / 100.0
        end
      end

      def initialize
        @date = nil
        @difficulty = nil
        @name = nil
        @judge = Judge.new
        @score = Score.new
      end
    end

  end
end
