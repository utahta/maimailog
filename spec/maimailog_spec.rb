require 'rspec'

describe 'Maimailog' do

  context 'Login' do
    it 'ログインできること' do
      c = Maimailog::Crawler::Base.new
      page = c.login(LOGIN_ID, LOGIN_PASSWD)
      uri = "#{page.uri.scheme}://#{page.uri.host}#{page.uri.path}"
      expect(uri).to eq 'https://maimai-net.com/maimai-mobile/home.html'
    end
  end

  context 'History' do
    it '過去データが1件取得できること' do
      c = Maimailog::Crawler::History.new
      c.login(LOGIN_ID, LOGIN_PASSWD)
      c.fetch_all do |data|
        expect(data.instance_of? Maimailog::Data::Detail).to eq true
        break
      end
    end
  end

end