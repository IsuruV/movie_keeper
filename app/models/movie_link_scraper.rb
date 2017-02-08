class MovieLinkScraper
  attr_accessor :title, :doc, :links
  def initialize(movie_title)
    @title = self.format_title(movie_title)
    self.get_html
    self.get_links
  end

  def format_title(movie_title)
    movie_title.gsub(' ', '-')
  end

  def get_html
    response = HTTParty.get("http://putlockers.ch/watch-#{self.title}-online-free-putlocker.html")
    @doc = Nokogiri::HTML(response)
  end

  def get_links
    self.links = []
    begin
    self.doc.search('td .entry a').each do |row|
      self.links << row.attr('href')
    end
    rescue
      self.links =['no links available']
    end
  end

end
