# frozen_string_literal: true

require "zlib"

module BridgetownAvatar
  class Builder < Bridgetown::Builder
    DEFAULT_SIZE = "40"
    API_VERSION  = "3"
    SERVERS      = 4

    attr_reader :size

    def build
      liquid_tag "avatar" do |attributes, tag|
        @attributes = attributes # .split(",").map(&:strip)
        @size = compute_size
        @context = tag.context

        "<img src=\"#{url}\" class=\"#{classes}\"/>"
      end
    end

    private

    def compute_size
      matches = @attributes.match(%r!\bsize=(\d+)\b!i)
      matches ? matches[1] : DEFAULT_SIZE
    end

    def username
      return @context["user"] if @context["user"]

      result = @attributes.include?(" ") ? @attributes.split(" ")[0] : @attributes
      result.start_with?("@") ? result.sub("@", "") : result
    end

    def path(scale = 1)
      "#{username}?v=#{API_VERSION}&s=#{scale == 1 ? size : (size.to_i * scale)}"
    end

    def url(scale = 1)
      "#{host}/#{path(scale)}"
    end

    def server_number
      Zlib.crc32(path) % SERVERS
    end

    def host
      "https://avatars#{server_number}.githubusercontent.com"
    end

    SCALES = %w(1 2 3 4).freeze
    private_constant :SCALES

    def srcset
      SCALES.map { |scale| "#{url(scale.to_i)} #{scale}x" }.join(", ")
    end

    # See http://primercss.io/avatars/#small-avatars
    def classes
      size.to_i < 48 ? "avatar avatar-small" : "avatar"
    end
  end
end

BridgetownAvatar::Builder.register
