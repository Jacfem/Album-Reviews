class Category < ActiveRecord::Base
  has_many :albums
end
