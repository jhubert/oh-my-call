# Person
# Anyone who can be called when needed.
#
# http://docs.ohmycall.apiary.io/#person
class Person < ActiveRecord::Base
  validates :phone_number, uniqueness: true, presence: true
end
