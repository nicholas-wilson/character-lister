class Helper
  def self.logged_in?(session_hash)
    if session_hash[:user_id] && session_hash[:user_id] != ""
      true
    else
      nil
    end
  end

  def self.current_user(session_hash)
    if session_hash[:user_id] == ""
      nil
    else
      User.find(session_hash[:user_id])
    end
  end
end
