require 'pry'
describe 'Character' do
  before do
    @user = User.create(:username => "nictheguy", :password => "dog")
    @character = Character.create(:name => "Ash Ketchup", :description => "Throws tomato based sauce on foes.", :liked_because => "he's neat.", :list_rank => 1, :user_id => 1) #writing tests for character still
  end

  it "has a decription" do
    expect(@character.description).to eq("Throws tomato based sauce on foes.")
  end

  it "has a reason they're liked" do
    expect(@character.liked_because).to eq("he's neat.")
  end

  it "has a list_rank" do
    expect(@character.list_rank).to eq(1)
  end

  it "has a user" do
    expect(@character.user).to be_an_instance_of(User)
  end
end
