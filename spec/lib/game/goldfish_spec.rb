 require 'spec_helper'

 require './lib/game/goldfish'

 describe GoldFish do
   context ".run" do
     subject { GoldFish.new(double).run }

     its(:first) { is_expected.to be_a BoarState }
     its(:last) { is_expected.to be_a BoarState }

   end
 end
