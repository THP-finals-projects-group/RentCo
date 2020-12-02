class Type < ApplicationRecord
    has_one         :new_information
    has_one         :old_information
end
