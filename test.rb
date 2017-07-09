require './epsilon.rb'
require 'test/unit'

class TestEpsilon < Test::Unit::TestCase

  def test_create_coins
    e = Epsilon.new()
    coins = [{"name"=>"ZEC", "buy_count"=>1, "sell_count"=>0}, {"name"=>"BTC", "buy_count"=>1, "sell_count"=>0}]
    coinlist = ['ZEC', 'BTC']
    assert_equal(coins, e.create_coins(coinlist) )
  end

  def test_check_coins
    e = Epsilon.new()
    coins = [{"name"=>"ZEC", "buy_count"=>1, "sell_count"=>0}, {"name"=>"BTC", "buy_count"=>1, "sell_count"=>0}]
    coinlist = ['ZEC', 'BTC']
    coins2 = [{"name"=>"ZEC", "buy_count"=>2, "sell_count"=>0}, {"name"=>"BTC", "buy_count"=>2, "sell_count"=>0}]
    assert_equal(coins2, e.check_coins(coins, coinlist) )
  end 

  def test_check_coins_buy2
    e = Epsilon.new()
    coins = [{"name"=>"ZEC", "buy_count"=>2, "sell_count"=>0}, {"name"=>"BTC", "buy_count"=>2, "sell_count"=>0}]
    coinlist = ['ZEC', 'BTC']
    coins2 = [{"name"=>"ZEC", "buy_count"=>3, "sell_count"=>0}, {"name"=>"BTC", "buy_count"=>3, "sell_count"=>0}]
    assert_equal(coins2, e.check_coins(coins, coinlist) )
  end

  def test_check_coins_sell1
    e = Epsilon.new()
    coins = [{"name"=>"ZEC", "buy_count"=>1, "sell_count"=>0}, {"name"=>"BTC", "buy_count"=>1, "sell_count"=>0}]
    coinlist = ['ZEC', 'ETC']
    coins2 = [{"name"=>"ZEC", "buy_count"=>2, "sell_count"=>0}, {"name"=>"BTC", "buy_count"=>0, "sell_count"=>1}, {"name"=>"ETC", "buy_count"=>1, "sell_count"=>0}]
    assert_equal(coins2, e.check_coins(coins, coinlist) )
  end





end
