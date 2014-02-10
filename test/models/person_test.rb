require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'invalid without a phone number' do
    p = Person.create(phone_number: nil)
    refute p.valid?
    refute p.errors[:phone_number].nil?
  end

  test 'phone_number must be unique' do
    p2 = Person.create(phone_number: people(:valid).phone_number)
    refute p2.valid?
    refute p2.errors[:phone_number].nil?
  end

  test 'active defaults to true' do
    assert Person.new.active?, 'Active should be true by default'
  end

  test 'normalizes a phone_number before create' do
    p = Person.create(phone_number: '1 (703) 451-5115')
    assert_equal '17034515115', p.phone_number
  end

  test 'normalizes a phone_number before update' do
    p = people(:valid)
    p.phone_number = '1 (703) 451-5115'
    p.save
    assert_equal '17034515115', p.phone_number
  end
end
