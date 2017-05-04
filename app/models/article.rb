class Article < ActiveRecord::Base
    validates :title, presence: true, length: { minimum: 3, maximum: 5}
    validates :description, presence: true, length: { minimum: 10, maximum: 160}
end