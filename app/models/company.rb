class Company < ApplicationRecord
    validates :key, presence: true, uniqueness: true
end
