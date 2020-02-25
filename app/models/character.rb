class Character < ActiveRecord::Base
  belongs_to :user

  def list_rank=(number)
    previous_pos = 0
    if self.list_rank
      previous_pos = self.list_rank
    end
    super
    last_character = Character.ordered_list(self.user).last
    if self.user.characters.size == 0
      @list_rank = 1
      self.save
    elsif number.to_i > last_character.list_rank || number.to_i < 1
      @list_rank = last_character.list_rank + 1
      self.save
    else
      @list_rank = number.to_i
      self.save
      Character.update_list(self.user, self, previous_pos)
    end
  end

  def self.update_list(user, character_to_update, previous_pos=0)
    characters = Character.ordered_list(user)
    if previous_pos == 0 || previous_pos > character_to_update.list_rank    # if the character had no rank before or goes up
      characters.each_with_index do |character, index|
        if index >= character_to_update.list_rank - 1 && character.id != character_to_update.id && character.list_rank < previous_pos
          character.list_rank += 1
          character.save
        end
      end
    elsif previous_pos < character_to_update.list_rank                      # if the character moved down in ranking
      characters.each_with_index do |character, index|
        if character_to_update.list_rank == character.list_rank && character.id != character_to_update.id && character.list_rank != 1    # the character at same rank as what the changing character is now also moves up a rank
          character.list_rank -= 1
          character.save
        elsif index >= previous_pos - 1 && index < character_to_update.list_rank - 1                         # all characters get ranked up by 1 that were previously lower ranked than the character being updated except for those still ranked lower
          character.list_rank -= 1
          character.save
        elsif character_to_update.list_rank == characters.size + 1 && character.id == character_to_update.id # when the updated character is moved to the bottom of the list it will still be moved up 1 for proper listing
          character.list_rank -= 1
          character.save
        end
      end
    end
  end

  def self.ordered_list(user)
    user.characters.sort_by &:list_rank
  end
end
