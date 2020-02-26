class Character < ActiveRecord::Base
  belongs_to :user
  def list_rank=(number)
    number = number.to_i
    super
  end
  def move_down
    self.list_rank += 1
    self.save
  end

  def move_up
    self.list_rank -= 1
    self.save
  end

  def self.update_list(user, character_to_update, previous_rank=0)
    characters = Character.ordered_list(user)
    if character_to_update.list_rank < 1 || character_to_update.list_rank > characters.size
      character_to_update.list_rank = characters.size
      character_to_update.save
    end
    if previous_rank == 0
      characters.each do |character|
        if character.list_rank >= character_to_update.list_rank && character.id != character_to_update.id
          character.move_down
        end
      end
    elsif previous_rank < character_to_update.list_rank
      characters.each do |character|
        if character.list_rank > previous_rank && character.list_rank <= character_to_update.list_rank && character.id != character_to_update.id
          character.move_up
        end
      end
    elsif previous_rank > character_to_update.list_rank
      characters.each do |character|
        if character.list_rank < previous_rank && character.list_rank >= character_to_update.list_rank && character.id != character_to_update.id
          character.move_down
        end
      end
    end
  end

  def self.ordered_list(user)
    user.characters.sort_by &:list_rank
  end
end
