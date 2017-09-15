module ShutterstockRuby
  # A class to hold all videos related code.
  class Videos < Connections

    def search(query, options = {})
      JSON.parse(get('/videos/search', { query: query }.merge(options)))
    end

    def details(id, options = {})
      JSON.parse(get('/videos', { id: id }.merge(options)))
    end

    def purchase(id, subscription_id, size, options = {}, metadata = {})
      params = { subscription_id: subscription_id, size: size }
      body = { videos: [ video_id: id, metadata: metadata ] }.to_json
      JSON.parse(post("/videos/licenses", body, params, options))
    end

    def licenses(video_id, license, options = {})
      params = { video_id: video_id, license: license }
      JSON.parse(get("/videos/licenses", params.merge(options)))
    end

    def download(licence)
      JSON.parse(post("/videos/licenses/#{licence}/download"))
    end

    class << self
      def search(query, options = {})
        client.search(query, options)
      end

      def details(id, options = {})
        client.details(id, options)
      end

      def purchase(id, subscription_id, size, options = {}, metadata = {})
        client.purchase(id, subscription_id, size, options, metadata)
      end
    end
  end
end
