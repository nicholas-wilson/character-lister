require 'pry'
describe 'User' do
  before do
    @user = User.create(:username => "test 123", :password => "test")
    @char1 = Character.create(:name => "Flash", :description => "Fast as heck", :user_id => 1)
    @char2 = Character.create(:name => "Light Yagami", :description => "Twisted sense of justice", :user_id => 1)
  end
  it "has many characters" do
    expect(@user.characters.size).to eq(2)
  end

  it 'has a secure password' do

    expect(@user.authenticate("dog")).to eq(false)

    expect(@user.authenticate("test")).to eq(@user)
  end
end
