require 'json'

class String
  def remove_lines(i)
    split("\n")[i..-1].join("\n")
  end
end

text = IO.read('.api_out.txt');
text = text.remove_lines(1);

translation = JSON.parse(text)

puts translation['result'][0]['alternative'][0]['transcript']