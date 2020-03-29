require 'net/ping'
require 'watir'
require 'webdrivers'

class SfrWifiAuto
  def initialize
    @browser = Watir::Browser.new
    @username = ''
    @password = ''
  end

  def check_connection
    check = Net::Ping::External.new('8.8.8.8')
    connection_status = check.ping?
    if connection_status
      puts "Connexion ok"
    else
      puts "Connexion KO"
    end
    connection_status
  end

  def connect_to_sfr
    puts "start reconnecting user"
    @browser.goto("https://hotspot.wifi.sfr.fr/")
    sleep(5)
    @browser.text_field(name: "username").set @username
    @browser.text_field(name: "password").set @password
    @browser.checkbox(id: 'conditions').set
    @browser.button(name: 'connexion').click
    puts "user connected again!"
    sleep(10)
  end

  def start
    while 1
      connect_to_sfr unless check_connection
      sleep(30)
    end
  end
end

sfr = SfrWifiAuto.new
sfr.start