class Rack::Attack
  blocklist('prohibit access from outside Japan') do |req|
    ip = req.env["action_dispatch.remote_ip"].to_s
    ret = Rails.configuration.x.maxminddb.lookup(ip)
    if ret.found? == false
      puts "ip address not found"
      next false
    end
    puts "check country iso code : #{ret.country.iso_code}"
    ret.country.iso_code != "JP"
  end
end
