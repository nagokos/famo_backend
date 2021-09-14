require 'rails_helper'

# class Review < ApplicationRecord
#   belongs_to :reviewer, class_name: 'User'
#   belongs_to :reviewee, class_name: 'User'

#   validates :rate, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
#   validates :game_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/ }, uniqueness: { scope: %i[reviewer reviewee] }
#   validates :privacy, presence: true
#   validates :content, presence: true, length: { maximum: 10_000 }

#   enum privacy: { published: 0, player_only: 1 }

#   scope :desc, -> { order(created_at: :desc) }
#   scope :game_desc, -> { order(game_date: :desc) }
#   scope :game_asc, -> { order(game_date: :asc) }
#   scope :rating, -> { order(rate: :desc) }
#   scope :game_select_day, ->(day) { where(game_date: day.all_day) }
#   scope :published, -> { where(privacy: 'published') }
#   scope :require_reviewer, -> { where.not(reviewer_id: nil) }
#   scope :conditions_shuffle, -> { where('LENGTH(content) > 230').order('RAND()').limit(4) }
#   scope :cache_profile, -> { includes(reviewer: :profile, reviewee: { profile: [team: :prefecture, group: { category: :league }] }) }
# end

RSpec.describe Review, type: :model do
  describe 'associations' do
    context 'belongs_to' do
      it { is_expected.to belong_to(:reviewer) }
      it { is_expected.to belong_to(:reviewee) }
    end
  end

  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:privacy) }
      it { is_expected.to validate_presence_of(:content) }
    end

    context 'numericality' do
      it { is_expected.to validate_numericality_of(:rate).is_greater_than_or_equal_to(1) }
      it { is_expected.to validate_numericality_of(:rate).is_less_than_or_equal_to(5) }
    end

    context 'length' do
      it { is_expected.to validate_length_of(:content).is_at_most(10_000) }
    end
  end

  describe 'default' do
    let(:reviewer) { create(:user) }
    let(:reviewee) { create(:user, :player) }
    it '公開設定は公開であること' do
      review = build(:review, reviewer: reviewer, reviewee: reviewee)
      expect(review.privacy).to eq('published')
    end
  end

  describe 'scope' do
    let(:reviewer) { create(:user) }
    let(:reviewee) { create(:user, :player) }

    describe ':desc' do
      let!(:latest_review) { create(:review, reviewer: reviewer, reviewee: reviewee, created_at: Time.current) }
      let!(:old_review) { create(:review, reviewer: reviewer, reviewee: reviewee, created_at: Time.current.ago(1.day)) }
      it 'created_atを基準に降順で並ぶこと' do
        expect(Review.desc.first).to eq(latest_review)
        expect(Review.desc.last).to eq(old_review)
      end
    end

    describe 'game_date' do
      let!(:latest_review) { create(:review, reviewer: reviewer, reviewee: reviewee, game_date: Time.current) }
      let!(:old_review) { create(:review, reviewer: reviewer, reviewee: reviewee, game_date: Time.current.ago(1.day)) }

      describe ':game_desc' do
        it 'game_dateを基準に降順で並ぶこと' do
          expect(Review.game_desc.first).to eq(latest_review)
          expect(Review.game_desc.last).to eq(old_review)
        end
      end

      describe ':game_asc' do
        it 'game_dateを基準に昇順で並ぶこと' do
          expect(Review.game_asc.first).to eq(old_review)
          expect(Review.game_asc.last).to eq(latest_review)
        end
      end
    end

    describe ':rate_desc' do
      let!(:high_review) { create(:review, reviewer: reviewer, reviewee: reviewee, rate: 5.0) }
      let!(:low_review) { create(:review, reviewer: reviewer, reviewee: reviewee, rate: 1.0) }
      it 'rateを基準に降順で並ぶこと' do
        expect(Review.rate_desc.first).to eq(high_review)
        expect(Review.rate_desc.last).to eq(low_review)
      end
    end

    describe ':game_select_day' do
      let!(:select_day_review) { create(:review, reviewer: reviewer, reviewee: reviewee, game_date: Time.current.ago(5.days)) }
      it '選択された試合日のレビューを取得すること' do
        expect(Review.game_select_day(Time.current.ago(5.days)).first).to eq(select_day_review)
      end
    end

    describe ':published' do
      let!(:published_review) { create(:review, reviewer: reviewer, reviewee: reviewee, privacy: 'published') }
      let!(:player_only_review) { create(:review, reviewer: reviewer, reviewee: reviewee, privacy: 'player_only') }
      it '公開に設定してあるレビューのみ取得すること' do
        expect(Review.published).to include(published_review)
        expect(Review.published).to_not include(player_only_review)
      end
    end

    describe ':require_reviewer' do
      let!(:withdrawal_review) { create(:review, reviewer: reviewer, reviewee: reviewee) }
      before { reviewer.destroy! }
      it 'レビュワーが退会していないレビューを取得すること' do
        expect(Review.require_reviewer).to_not include(withdrawal_review)
      end
    end

    describe ':conditions_shuffle' do
      let!(:more_then_content_review) { create(:review,  reviewer: reviewer, reviewee: reviewee, content: 'a' * 230) }
      it '230文字以上のレビューを取得すること' do
        expect(Review.conditions_shuffle).to include(more_then_content_review)
      end
    end
  end
end
