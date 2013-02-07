require 'twitter'
require 'yaml'

keys = YAML.load_file 'keys.yaml'

Twitter.configure do |config|
  config.consumer_key = keys['consumer_key']
  config.consumer_secret = keys['consumer_secret']
  config.oauth_token = keys['oauth_token']
  config.oauth_token_secret = keys['oauth_token_secret']
end


# tweets = []
# tweets += Twitter.user_timeline('SheldonQuote', count:200)
# tweets += Twitter.user_timeline('SheldonQuote', count:200, max_id:tweets.last.id-1)

handle = 'SheldonQuote'
max_count = 200

new_tweets = Twitter.user_timeline(handle, count: max_count)
tweets = []

tweets += new_tweets
while new_tweets.length >= max_count / 2
	new_tweets = Twitter.user_timeline(handle, count:200, max_id:tweets.last.id-1)
	tweets += new_tweets
	sleep 2
end

quotes = tweets.map {|t| t.text }

File.open "#{handle}_quotes.yaml", "wb" do |file|
	yaml = YAML.dump quotes
	file.write yaml
	end




#quotes.each {|q| puts q, ''}

# p tweets.first.created_at
# p tweets.last.created_at
# p new_tweets.first.created_at
# p new_tweets.last.created_at

puts quotes.last
puts tweets.last.created_at
puts tweets.size
