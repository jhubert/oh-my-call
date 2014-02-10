# Person
# Anyone who can be called when needed.
#
# http://docs.ohmycall.apiary.io/#person
class Person < ActiveRecord::Base
  validates :phone_number, uniqueness: true, presence: true
  before_save :normalize_phone_number
  belongs_to :user

  private

  def normalize_phone_number
    write_attribute(:phone_number, Phony.normalize(phone_number))
  end
end
