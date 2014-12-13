module Maimailog
  module Crawler

    ##
    # 詳細データを取得する
    module Detail
      private

      # ページを詳細データに変換して返す
      def convert_data(page)
        data = Maimailog::Data::Detail.new
        data.date = date(page)
        data.difficulty = difficulty(page)
        data.name = name(page)
        data.judge = judge(page)
        data.score = score(page)
        data
      end

      def date(page)
        str = page.search('//div[@class="accordion"]/h3').text[/[\d]{4}-[\d]{2}-[\d]{2} [\d]{2}:[\d]{2}/]
        DateTime.strptime("#{str} JST", '%Y-%m-%d %H:%M %Z')
      end

      def difficulty(page)
        page.search('//div[@class="accordion"]/ul/font')[1].text.strip
      end

      def name(page)
        page.search('//div[@class="accordion"]/ul/li/table//td')[1].text.strip
      end

      def judge(page)
        data = Maimailog::Data::Detail::Judge.new
        data.perfect = page.search('//table[@class="detail"]//tr[1]//font')[1].text.to_i
        data.great = page.search('//table[@class="detail"]//tr[2]//font')[1].text.to_i
        data.good = page.search('//table[@class="detail"]//tr[3]//font')[1].text.to_i
        data.miss = page.search('//table[@class="detail"]//tr[4]//font')[1].text.to_i
        data
      end

      def score(page)
        data = Maimailog::Data::Detail::Score.new
        data.tap = page.search('//table[@class="detail"]//tr[6]//td[2]/div')[0].text.to_i
        data.hold = page.search('//table[@class="detail"]//tr[7]//td[2]/div')[0].text.to_i
        data.slide = page.search('//table[@class="detail"]//tr[8]//td[2]/div')[0].text.to_i
        data.break = page.search('//table[@class="detail"]//tr[9]//td[2]/div')[0].text.to_i
        data.tap_max = page.search('//table[@class="detail"]//tr[6]//td[3]//font')[0].text.to_i
        data.hold_max = page.search('//table[@class="detail"]//tr[7]//td[3]//font')[0].text.to_i
        data.slide_max = page.search('//table[@class="detail"]//tr[8]//td[3]//font')[0].text.to_i
        data.break_max = page.search('//table[@class="detail"]//tr[9]//td[3]//font')[0].text.to_i
        data
      end
    end

    ##
    # プレイ履歴を取得するクラス
    class History < Base
      include Detail
      attr_writer :sleep_duration

      # 取得間隔の初期値
      DEFAULT_SLEEP_DURATION = 1

      def initialize
        super
        @sleep_duration = DEFAULT_SLEEP_DURATION
      end

      # プレイ履歴ページからデータを取得して返す
      # 事前に login を済ませておく必要がある
      def fetch(page_num = 0)
        page = @agent.page
        raise 'require login.' if page.nil?

        if page.uri.to_s[/home\.html/]
          page = page.link_with(text: /[ ]+データ\z/).click
        end
        page = @agent.get("https://maimai-net.com/maimai-mobile/results.html?p=#{page_num}&#{page.uri.query[/sid=[\w]+/]}")

        links = page.search('//div[@id="accordion"]/ul/li//a')
        raise DataNotFoundError.new('maimai play data not found') if links.size == 0
        links.each do |elm|
          data = convert_data(@agent.get(elm[:href]))
          sleep(@sleep_duration)
          yield data
        end
      end

      # プレイ履歴を最初から最後まで順番に取得していく
      def fetch_all(&block)
        0.upto(9999) do |page_num|
          begin
            fetch(page_num, &block)
          rescue DataNotFoundError
            break
          end
        end
      end
    end

  end
end
