class Case < ApplicationRecord
    has_one         :user

    has_many        :rooms
end
