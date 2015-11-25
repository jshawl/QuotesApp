class Quote < ActiveRecord::Base
  belongs_to :author
  has_many :favorites, dependent: :destroy
  has_many :collections, through: :favorites

  # before_save :create_author
  # private
  # def create_author
    # does quote have an author: self.author
    # does author exist in db?
    # if not create it
  # end
end
