require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#short_name" do

    example "ihover@gmail.com" do
      user = User.new( :email => "ihover@gmail.com" )
      expect( user.short_name ).to eq("ihover")
    end

  end

end
