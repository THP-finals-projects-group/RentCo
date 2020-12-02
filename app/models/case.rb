class Case < ApplicationRecord
	has_many_attached :videos
	
    has_one         :user

    has_many        :rooms
end
