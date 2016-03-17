require "rails_helper"

RSpec.describe Supermemo, type: "service" do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }

  before :each do
    @card = build(:card, user: user, deck: deck, ef: 2.5, i: 1, attempt: 1)
    @s = Supermemo.new(@card, @time)
  end

  describe "check word" do
    describe "new word" do
      describe "has rignt answer" do
        it "grade 5 if time < 15" do
          @time = 14
          @card.i = 1
          @card.save
          expect(@s.grade('дом', @time)).to eq(5)
        end

        it "grade 4 if time >= 15" do
          @time = 15
          @card.i = 1
          @card.save
          expect(@s.grade('дом', @time)).to eq(4)
        end

        it "change review time on 1 day" do
          @card.review_date = Time.zone.now
          @card.save
          @time = 14
          t = @card.review_date
          @s.update_card(@card.i, @card.ef, 'дом' , @time)
          expect(@card.review_date).to be_within(1.second).of t + 1.day
        end

        it "change ef" do
          old_ef = @card.ef
          grade = 5
          expect(@s.next_ef(@card.ef, grade)).to eq(old_ef + (0.1 - (5-grade) * (0.08 + (5 - grade) * 0.02)))
        end

        it "change i + 1" do
          expect(@s.next_i(@card.i, 5)).to eq(2)
        end
      end

      describe "answer with 1 wrong letter" do
        it "grade 4" do
          @time = 14
          expect(@s.grade('дон', @time = 14)).to eq(4)
        end

        it "ef dont changing" do
          expect(@s.next_ef(@card.ef, 4)).to eq(@card.ef)
        end
      end
    end

    describe "wrong answer" do
      it "add attempt" do
        @time = 14
        @s.update_card(@card.i, @card.ef, "чтото", @time)
        expect(@card.attempt).to eq(2)
      end
    end

    describe "rignt answer after wrongs" do
      before :each do
        @card.attempt = 4
        @card.i = 5
        @card.save
      end

      it "grade < 4" do
        expect(@s.grade('авыа', @time = 14)).to be < 4
      end

      it "down ef level" do
        old_ef = @card.ef
        expect(@s.next_ef(@card.ef, 3)).to be < old_ef
      end

      it "i again = 1" do
        expect(@s.next_i(@card.i, 2)).to eq(1)
      end
    end
  end
end
