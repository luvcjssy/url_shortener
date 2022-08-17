module UriService
  def self.valid?(url)
    URI(url).is_a?(URI::HTTP) rescue false
  end
end
