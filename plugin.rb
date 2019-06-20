# name: mozilla-letter-avatar
# about: Changes letter avatars to be more Mozilla
# version: 0.0.1
# authors: Leo McArdle
# url: https://github.com/mozilla/discourse-mozilla-letter-avatar

after_initialize do
  class ::LetterAvatar
    VERSION = "#{VERSION}_MOZILLA_1"

    def self.generate_fullsize(identity)
      color = identity.color
      letter = identity.letter

      filename = fullsize_path(identity)

      instructions = %W{
        -size #{FULLSIZE}x#{FULLSIZE}
        xc:#{to_rgb(color)}
        -pointsize #{POINTSIZE}
        -fill #ffffff
        -font #{File.expand_path("../zilla-slab/ttf/ZillaSlab-Bold.ttf", __FILE__)}
        -gravity Center
        -annotate -0+0 #{letter}
        -depth 8
        #{filename}
      }

      Discourse::Utils.execute_command('convert', *instructions)

      ## do not optimize image, it will end up larger than original
      filename
    end
  end
end
