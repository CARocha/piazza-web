require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'requires a name' do
    @user = User.new(name: '',
                      email: 'jhondoe@example.com',
                      password: 'password')
    assert_not @user.valid?
    @user.name = 'Jhon Doe'
    assert @user.valid?
  end

  test 'requires a valid email' do
    @user = User.new(name: 'Jhon Doe', email: ' ', password: 'password')
    assert_not @user.valid?

    @user.email = 'invalid'
    assert_not @user.valid?

    @user.email = 'jhondoe@example.com'
    assert @user.valid?
  end

  test 'requires a unique email' do
    @exisiting_user = User.create(name: 'Jhon Doe',
                                  email: 'jd@example.com',
                                  password: 'password')
    assert @exisiting_user.persisted?

    @user = User.new(name: 'Jon',
                     email: 'jd@example.com',
                     password: 'password')
    assert_not @user.valid?
  end

  test 'name and email is stripped of spaces before saving' do
    @user = User.create(
      name: ' John ',
      email: ' johndoe@example.com ',
    )
    assert_equal 'John', @user.name
    assert_equal 'johndoe@example.com', @user.email
  end
end
