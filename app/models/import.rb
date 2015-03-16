class Import
  SOURCE = 'http://www.reddit.com/r/aww.json'

  def self.import!
    new.import
  end

  def import
    fetch
    persist
  end

  private

  attr_accessor :data

  def fetch
    self.data = JSON.parse(open(SOURCE).read)['data']['children'].map do |datum|
      datum['data']
    end
  end

  def persist
    Image.wrap(data).each(&:persist)
  end

  class Image
    def self.wrap(data)
      data.map { |datum| new(datum) }
    end

    def initialize(data)
      self.data = OpenStruct.new data
    end

    def persist
      return if already_persisted? or not desirable?

      image = ::Image.create(
        reddit_permalink: data.permalink,
        source_url:       data.url,
        title:            data.title,
        file:             open(data.url)
      )
    end

    private

    attr_accessor :data

    def desirable?
      image?
    end

    def image?
      data.url =~ /jpg$|png$/
    end

    def already_persisted?
      ::Image.where(reddit_permalink: data.permalink).exists?
    end
  end
end
