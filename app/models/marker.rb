class Marker < ApplicationRecord
    has_and_belongs_to_many :categories

    belongs_to :type
end
