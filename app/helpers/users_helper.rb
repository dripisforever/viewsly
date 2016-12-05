module UsersHelper
    def gravatar_for(user, options = { size: 80 })
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end

    def avatar_for(user, options = { size: 100 })
      size = options[:size]
      if user.avatar?
        image_tag user.avatar.url(:thumb), alt: user.name, width: size, class: "user-ava"
      else
        image_tag "logo.png", class:"user-ava", width: size
      end
    end
end
