class Character < ActiveRecord::Base
  belongs_to :user

  def update_rank(number)
    if !self.list_rank
      self.list_rank = 0
    end
    characters = Character.ordered_list(self.user)
    if characters.size == 0
      self.list_rank = 1
      self.save
    elsif number.to_i > characters.last.list_rank || number.to_i < 1
      self.list_rank = characters.last.list_rank + 1
      self.save
    else
      original_rank = self.list_rank
      self.list_rank = number.to_i
      self.save
      characters.each do |character|
        if original_rank == 1 && character.list_rank < original_rank && character.id != self.id
          character.list_rank = character.list_rank - 1
          character.save
        elsif character.list_rank <= self.list_rank && character.id != self.id
          character.list_rank = character.list_rank + 1
          character.save
        elsif character.list_rank < original_rank && character.id != self.id
          character.list_rank = character.list_rank - 1
          character.save
        end
      end
    end
  end

  def self.ordered_list(user)
    user.characters.sort_by &:list_rank
  end
end
