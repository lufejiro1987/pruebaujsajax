class Category < ApplicationRecord
    has_and_belongs_to_many :markers
    has_many :subcategories

    enum status: {"public_cat" => "public_cat", "private_cat" => "private_cat"}
end
