require 'nokogiri'
require 'open-uri'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def get_name(r, tab, num)
  return r.xpath("//*[@id=\"#{tab}\"]/div/#{num}/div[1]/div[1]/div").text
end

def get_coins
  c = []
  r = Nokogiri::HTML(open("https://epsilon.one"))
  for i in 1..5
    c << get_name(r, "coin_tab_left", "div[#{i}]")
    c << get_name(r, "asset_tab_left", "div[#{i}]")
  end
  return c
end

def create_coin_hasharray
  coin_list = get_coins
  coins = []
  for i in 0..9
    h = {}
    h['name'] = coin_list[i]
    h['buy_count'] = 1
    h['sell_count'] = 0
    coins << h
  end
  return coins
end

def check_coins(coins)
  # get new coins
  new_coins = get_coins

  # increment counts 
  coins.each do |coin|
    if new_coins.include?(coin['name'])
      coin['buy_count'] += 1
    else
      coin['sell_count'] += 1
    end
  end

  # check for sell
  coins.delete_if do |coin|
    if coin['sell_count'] > 3
      if coin['buy_count'] > 3
        t = Time.new
        puts t.inspect
        puts "Sell: #{coin['name']}"
      end
      true
    end
  end

  # add new coins
  new_coins.each do |coin|
    if ! coins.detect {|c| c['name'] == coin}
      h = {}
      h['name'] = coin
      h['buy_count'] = 1
      h['sell_count'] = 0
      coins << h
    end
  end

  return coins
end

def sell
end

def buy
end

coins = create_coin_hasharray
#coins = [{"name"=>"SC", "count"=>33},{"name"=>"REP", "count"=>33},{"name"=>"LTC", "count"=>33},{"name"=>"1ST", "count"=>33},{"name"=>"DASH", "count"=>33},{"name"=>"BTC", "count"=>43},{"name"=>"XCN", "count"=>33},{"name"=>"AMP", "count"=>33},{"name"=>"ANS", "count"=>33},{"name"=>"GNT", "count"=>33}]
sleep 60
loop do
  puts "old coins are #{coins}"
  coins = check_coins(coins)
  puts "new coins are #{coins}"
  coins.each do |coin|
    if coin['count'] == 3
      t = Time.new
      puts t.inspect
      puts "Buy: #{coin['name']}"
    end
  end
  sleep 60
end

