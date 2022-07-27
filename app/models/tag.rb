class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy
  has_many :books, through: :book_tags

  scope :merge_books, -> (tags){ }

  def self.search_for(search, word)
    if search == "perfect"
      tags = Tag.where("name LIKE?", "#{word}" )
    elsif search == "forward"
      tags = Tag.where("name LIKE?", "#{word}%" )
    elsif search == "backward"
      tags = Tag.where("name LIKE?", "%#{word}" )
    else
      tags = Tag.where("name LIKE?", "%#{word}%" )
    end

    return tags.inject(init = []) {|result, tag| result + tag.books}

  end

end
