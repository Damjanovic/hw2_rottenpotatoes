# == Schema Information
#
# Table name: movies
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  rating       :string(255)
#  description  :text
#  release_date :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Movie < ActiveRecord::Base

	def self.mpaa_rating
		filmovi= self.find(:all, select: "distinct rating")
		mpaa_r=Array.new
		filmovi.each do |mpaa|
			mpaa_r.push(mpaa.rating)
		end
		mpaa_r
	end

end
