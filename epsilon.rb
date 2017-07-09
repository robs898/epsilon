require 'nokogiri'
require 'open-uri'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class Epsilon
  def get_name(r, tab, num)
    return r.xpath("//*[@id=\"#{tab}\"]/div/#{num}/div[1]/div[1]/div").text
  end

  def get_coinlist
    c = []
    r = Nokogiri::HTML(open("https://epsilon.one"))
    for i in 1..5
      c << get_name(r, "coin_tab_left", "div[#{i}]")
      c << get_name(r, "asset_tab_left", "div[#{i}]")
    end
    return c
  end

  def create_coins(coinlist)
    coins = []
    for i in 0..(coinlist.length - 1)
      h = {}
      h['name'] = coinlist[i]
      h['buy_count'] = 1
      h['sell_count'] = 0
      coins << h
    end
    return coins
  end

  def check_coins(coins, coinlist)
    # increment counts
    coins.each do |coin|
      if coinlist.include?(coin['name'])
        coin['buy_count'] += 1
        coin['sell_count'] = 0
      else
        coin['sell_count'] += 1
        if coin['buy_count'] < 3
          coin['buy_count'] = 0
        end
      end
    end

    # add new coins
    coinlist.each do |coin|
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

  def check_sell(coins)
    coins.delete_if do |coin|
      if coin['sell_count'] == 3
        if coin['buy_count'] > 2
          #sell(coin['name'])
          t = Time.new
          puts t.inspect
          puts "Sell: #{coin}"
        end
        true
      end
    end
  end

  def check_buy(coins)
    coins.each do |coin|
      if coin['buy_count'] == 3
        #buy(coin['name'])
        t = Time.new
        puts t.inspect
        puts "Buy: #{coin}"
      end
    end
  end

end
