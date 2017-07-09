require './epsilon.rb'

e = Epsilon.new()

coins = e.create_coin_hasharray
puts coins
sleep 60
loop do
  coins = e.check_coins(coins)
  coins.each do |coin|
    if coin['buy_count'] == 3
      e.buy(coin['name'])
      puts coins
    end
  end
  sleep 60
end

