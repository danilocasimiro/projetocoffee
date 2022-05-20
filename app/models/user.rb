class User
  include ActiveModel::Model

  attr_accessor :nome, :email, :password

  validates_presence_of :nome, :email, message: 'é obrigatório'
  validates_length_of :nome, in: 5..128, message: 'precisa ter entre 5 à 128 caracteres'
  validates_length_of :password, in: 10..128, message: 'precisa ter entre 10 à 128 caracteres'
  validates :email, format: { with: /\A[a-zA-Z0-9_\W]{0,63}@[a-zA-Z0-9.-]*${0,128}\z/,
    message: 'não é valido' }
  validate :password_validation

  private

  def password_validation
    rules = {
      ' deve conter pelo menos duas letras minúsculas'  => /[a-z]/,
      ' deve conter pelo menos duas letras maiúsculas'  => /[A-Z]/,
      ' deve conter pelo menos dois dígitos'            => /[0-9]/,
      ' deve conter pelo menos dois caracteres especiais' => /\W/
    }

    rules.each do |message, regex|      
      errors.add( :password, message ) if password.scan(regex).length < 2
    end
  end
end

