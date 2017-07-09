require 'nokogiri'
require 'open-uri'
#require 'yaml'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def get_name(page, crypto_type, up_down, prediction)
  return page.xpath("/html/body/div[1]/main/div[1]/div[2]/div/div/div/div/#{crypto_type}/div/#{up_down}/div[2]/div/#{prediction}/div[1]/div[1]/div").text
end

page = Nokogiri::HTML(open("https://epsilon.one"))
for i in 1..2
  for j in 1..5
    open('soaring', 'a') { |f|
      f.puts get_name(page, "div[#{i}]", 'div[1]', "div[#{j}]")
    }
    open('sinking', 'a') { |f|
      f.puts get_name(page, "div[#{i}]", 'div[2]', "div[#{j}]")
    }
    end
  end
end
