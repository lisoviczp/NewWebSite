class Post < ActiveRecord::Base

	def getSrc
		if self.vibe_type == "soundcloud"
			source ="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/"
			source += self.url
			source += "&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true"
		else self.vibe_type == "youtube"
			source ="https://www.youtube.com/embed/"
			source += self.url if self.url
		end	
	end

end
