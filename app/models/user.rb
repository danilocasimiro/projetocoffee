class User
  include ActiveModel::Model

  attr_accessor :name, :email, :password

  validates_presence_of :name, :email, message: I18n.t('errors.is_required')
  validates_length_of :name, in: 5..128, message: I18n.t('errors.user_name_range')
  validates_length_of :password, in: 10..128, message: I18n.t('errors.user_password_range')
  validates :email, format: { with: /\A[a-zA-Z0-9_\W]{0,63}@[a-zA-Z0-9.-]*${0,128}\z/,
    message: I18n.t('errors.is_not_valid') }
  validate :password_validation

  private

  def password_validation
    rules = {
      I18n.t('errors.user_password_at_leat_two_lowercase')          => /[a-z]/,
      I18n.t('errors.user_password_at_leat_two_uppercase')          => /[A-Z]/,
      I18n.t('errors.user_password_at_leat_two_digits')             => /[0-9]/,
      I18n.t('errors.user_password_at_leat_two_special_characters') => /\W/
    }

    rules.each do |message, regex|      
      errors.add( :password, message ) if password.scan(regex).length < 2
    end
  end
end

