class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 'admin', gestor_rh: 'gestor_rh' }

  validates :role, presence: true, inclusion: { in: roles.keys }

  after_initialize :set_default_role, if: :new_record?

  has_many :user_departamentos
  has_many :departamentos, through: :user_departamentos


  def set_default_role
    self.role ||= :gestor_rh
  end

  def admin?
    # Retorne true se o usuário for administrador
    self.role == 'admin'
  end

  def departamentos_permitidos
    # Liste os departamentos que o usuário pode gerenciar (ajuste de acordo com sua lógica)
    self.departamentos
  end

    # Callback to assign all departments to admin users
    before_save :assign_departments_for_admin

    private
  
    def assign_departments_for_admin
      if admin? && departamentos.empty?
        self.departamentos = Departamento.all
      end
    end
end