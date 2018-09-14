# == Schema Information
#
# Table name: albums
#
#  id         :bigint(8)        not null, primary key
#  band_id    :integer          not null
#  title      :string           not null
#  year       :integer          not null
#  is_live    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord

  validates :band_id, :title, :year, presence: true
  validates :is_live, inclusion: { in: [true, false] }

  belongs_to :band

  has_many :tracks, dependent: :destroy

  def band_name
    band.name
  end

  def next_track_num
    if tracks.empty?
      1
    else
      latest_track = tracks.order('ord DESC').limit(1).first
      latest_track.ord + 1
    end
  end

end
