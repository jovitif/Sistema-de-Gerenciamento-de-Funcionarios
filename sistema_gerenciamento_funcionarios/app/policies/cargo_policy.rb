class CargoPolicy < ApplicationPolicy
    attr_reader :user, :cargo
  
    def initialize(user, cargo)
      @user = user
      @cargo = cargo
    end
  
    def index?
      user.admin? || user.gestor_rh?
    end
  
    def show?
      user.admin? || (user.gestor_rh? && user.departamentos.include?(cargo.departamento))
    end
  
    def create?
      user.admin?
    end
  
    def update?
      user.admin? || (user.gestor_rh? && user.departamentos.include?(cargo.departamento))
    end
  
    def destroy?
      user.admin?
    end
  end
  