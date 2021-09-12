class Item < ApplicationRecord
 attachment :image
 belongs_to :genre
 has_many :cart_items, dependent: :destroy
 has_many :order_details
 with_options presence: true do
   validates :name
   validates :introduction
   validates :image
   validates :price
   validates :genre_id
 end

end
