require 'test_helper'

class RestrictionTests < ActiveSupport::TestCase

  # Check valid from
  test 'ensure user cannot log in before valid_from' do

    assert_not( User.new( valid_from: 1.day.from_now ).active_for_authentication? )

  end

  test 'ensure user can log in after valid_from' do

    assert( User.new( valid_from: 1.day.ago ).active_for_authentication? )

  end

  # Check valid until
  test 'ensure user cannot log in after valid_until' do

    assert_not( User.new( valid_until: 1.day.ago ).active_for_authentication? )

  end

  test 'ensure user can log in before valid_until' do

    assert( User.new( valid_until: 1.day.from_now ).active_for_authentication? )

  end

  # check ranges
  test 'ensure user cannot log in before date range' do

    assert_not( User.new( valid_from: 1.day.from_now, valid_until: 2.days.from_now ).active_for_authentication? )

  end

  test 'ensure user cannot log in after date range' do

    assert_not( User.new( valid_from: 2.days.ago, valid_until: 1.days.ago ).active_for_authentication? )

  end

  test 'ensure user can log in during date range' do

    assert( User.new( valid_from: 1.day.ago, valid_until: 1.days.from_now ).active_for_authentication? )

  end

  # Edge-cases
  test 'ensure user can still log in if date_until is set to the current date' do

    assert( User.new( valid_until: Date.today ).active_for_authentication? )

  end

  test 'ensure user can log in if date_from is set to the current date' do

    assert( User.new( valid_from: Date.today ).active_for_authentication? )

  end

  test 'ensure user can log in if both date_from and date_until are set to the current date' do

    assert( User.new( valid_from: Date.today, valid_until: Date.today ).active_for_authentication? )

  end
end
