module Maimailog
  module Crawler

    class Base
      def initialize
        @agent = Mechanize.new
      end

      ##
      # maimainet にログインを試みる
      # 成功したら home 画面ページが返る
      def login(id, password)
        page = @agent.get('https://maimai-net.com/maimai-mobile/login.html')
        form = page.forms[0]
        form.segaid = id
        form.passwd = password
        button = form.button_with(value: 'Sid Login')
        @agent.submit(form, button)
      end
    end

  end
end