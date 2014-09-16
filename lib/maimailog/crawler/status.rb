module Maimailog
  module Crawler

    ##
    # ステータスを取得するクラス
    class Status < Base

      def fetch(id, password)
        page = login(id, password)
        Maimailog::Data::Status.new(name(page), rating(page), rating_max(page))
      end

      private

      def name(page)
        elm = page.search('//div[@class="status_name"]//font[@class="blue"]')
        elm.empty? ? '' : elm[0].text.strip
      end

      def rating(page)
        elm = page.search('//div[@class="status_data"]/font[@class="blue"]')
        elm.empty? ? '' : elm[1].text.strip[/\d+\.\d+/].to_f
      end

      def rating_max(page)
        elm = page.search('//div[@class="status_data"]/font[@class="blue"]')
        elm.empty? ? '' : elm[1].text.strip[/ \d+\.\d+/].to_f
      end
    end

  end
end
