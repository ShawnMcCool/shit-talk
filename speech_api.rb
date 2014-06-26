require 'uri'
require 'net/http';
require 'openssl'

filename = ARGV[0]

# load key
file = File.open("key.txt", "rb")
key = file.read
key.strip!

# build query
url = "https://www.google.com/speech-api/v2/recognize?output=json&lang=en-us&key=#{key}&results=6&pfilter=2"
uri = URI.parse(url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE    

# build request
request = Net::HTTP::Post.new(uri.request_uri)
request.body = File.read(filename)
request.content_type = 'audio/l16; rate=16000;'

# response
res = http.request(request)

File.write('./.api_out.txt', res.body)
