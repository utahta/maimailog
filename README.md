# Maimailog

maimai のプレイ履歴を取得する

## Installation

Add this line to your application's Gemfile:

    gem 'maimailog'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install maimailog

## Usage

ステータスを取得する

    c = Maimailog::Crawler::Status.new
    c.fetch(userid, passwd)

プレイ履歴を取得する

    c = Maimailog::Crawler::History.new
    c.login(userid, passwd)
    page_num = 0
    c.fetch(page_num) do |data|
      p data
    end
    
プレイ履歴を新しいものから順番に取得する

    c = Maimailog::Crawler::History.new
    c.login(userid, passwd)
    c.fetch_all do |data|
      p data
    end
    
## Contributing

1. Fork it ( https://github.com/utahta/maimailog/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
