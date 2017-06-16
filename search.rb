require 'twitter'
require 'pp'
require 'yaml'

yaml = YAML.load_file("./config.yml")

client = Twitter::REST::Client.new(
  consumer_key:        yaml["YOUR_CONSUMER_KEY"],
	consumer_secret:     yaml["YOUR_CONSUMER_SECRET"],
  access_token:        yaml["YOUR_ACCESS_TOKEN"],
  access_token_secret: yaml["YOUR_ACCESS_SECRET"],
)

msg=" FF外から失礼します。メールしたらガチで貰えた！！などという変なツイートをされています。知らぬ間に変なアプリを
連携していると思われます。アプリの解除法を示しました。http://yomeba.hatenablog.jp/entry/2017/06/15/081156"

query="メールしたらガチで貰えた！！"
res=client.search(query, count: 100, result_type: "recent", exclude: "retweets")

res.take(100).each_with_index do |tw, i |
  puts "#{i}: #{tw.user.screen_name}:#{tw.full_text}"
  puts "知らせる？(Y or N)"
	c = gets
	case c
	  when /^[yY]/
	    pp client.update("@#{tw.user.screen_name} #{msg}")
		  puts "お伝えしました"
    when /^[nN]/,/^$/
	    puts "スルーしました"
	end
end

