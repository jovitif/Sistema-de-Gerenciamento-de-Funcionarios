class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 'admin', gestor_rh: 'gestor_rh' }

  validates :role, presence: true, inclusion: { in: roles.keys }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :gestor_rh
  end
end
