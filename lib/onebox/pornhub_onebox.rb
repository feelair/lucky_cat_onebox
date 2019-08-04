# frozen_string_literal: true

module Onebox
  module Engine
    class PornhubOnebox
      include Engine
      include HTML

      matches_regexp(/^(https?:\/\/)?([\da-z\.-]+)(pornhub.com\/)(.)+\/?$/)

      # Try to get the video ID. Works for URLs of the form:
      # * http://v.youku.com/v_show/id_XNjM3MzAxNzc2.html
      # * http://v.youku.com/v_show/id_XMTQ5MjgyMjMyOA==.html?from=y1.3-tech-index3-232-10183.89969-89963.3-1
      def video_id
        match = uri.query.match(/viewkey=(\w+)&?/)
        match && match[1]
      rescue
        nil
      end

      def to_html
        if video_id
          <<-HTML
             <iframe width="570"
                      height="360"
                      src="https://www.pornhub.com/embed/#{video_id}"
                      frameborder="0"
                      allowfullscreen>
              </iframe>
          HTML
        end
      end

    end
  end
end
