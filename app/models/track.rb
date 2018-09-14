# == Schema Information
#
# Table name: tracks
#
#  id         :bigint(8)        not null, primary key
#  album_id   :integer          not null
#  title      :string           not null
#  ord        :integer          not null
#  lyrics     :text
#  is_bonus   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ApplicationRecord

  validates :album_id, :title, :ord, presence: true
  validates :is_bonus, inclusion: { in: [true, false] }
  validates :album_id, uniqueness: { scope: :ord }

  belongs_to :album
  has_many :notes, dependent: :destroy

  def album_title
    album.title
  end

end
