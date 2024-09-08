class DepartamentoPolicy
    attr_reader :user, :departamento
  
    def initialize(user, departamento)
      @user = user
      @departamento = departamento
    end
  
    def index?
      user.admin?
    end
  
    def show?
      user.admin?
    end
  
    def create?
      user.admin?
    end
  
    def update?
      user.admin?
    end
  
    def destroy?
      user.admin?
    end
  end
  