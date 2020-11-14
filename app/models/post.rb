class Post < ApplicationRecord
    belongs_to :user
    validates :body, length: {maximum: 160}
    validates_presence_of :body, :user_id
    has_many :comments,dependent: :destroy
    def self.search(search)
        where("body LIKE ?", "%#{search}%")
    end
end
