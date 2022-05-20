class User
  include ActiveModel::Model

  attr_accessor :name, :email, :password

  validates :name, :email, :password, presence: true
  validates :name, length: { minimum: 5, maximum: 128 }
  validates :password, length: { minimum: 10, maximum: 128 }
  validates :email, format: { with: /\A[a-zA-Z0-9_\W]{0,63}@[a-zA-Z0-9.-]*${0,128}\z/,
    message: "is invalid" }

  validate :password_validation

  private

  def password_validation
    rules = {
      " must contain at least two lowercase letter"  => /[a-z]/,
      " must contain at least two uppercase letter"  => /[A-Z]/,
      " must contain at least two digit"             => /[0-9]/,
      " must contain at least two special character" => /\W/
    }

    rules.each do |message, regex|      
      errors.add( :password, message ) if password.scan(regex).length < 2
    end
  end
end

