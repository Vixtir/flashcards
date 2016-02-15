require "open-uri"
require "nokogiri"

url = "http://en365.ru/top50verbs.htm"
doc = Nokogiri::HTML(open(url))

doc.css('#middle table tr:not(:first-child)').each do |e|
  o_text = e.css("td")[1].text
  t_text = e.css("td")[3].text
  Card.create(original_text: o_text, translated_text: t_text)
end
