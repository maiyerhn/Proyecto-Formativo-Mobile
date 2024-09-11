class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/:id
  def show
    render json: @user
  end

  # POST /signup
  def signup
    user = User.new(user_params)
    if user.save
      render json: { message: 'Usuario Registrado Con Éxito', user: user }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /login
  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = generate_token(user.id)
      render json: { message: 'Login Exitoso', token: token, user: user }, status: :ok
    else
      render json: { errors: 'Usuario o Contraseña Incorrecto' }, status: :unauthorized
    end
  end

  # POST /logout
  def logout
    render json: { message: 'Logout Exitoso' }, status: :ok
  end

  # PUT /users/:id
  def update
    if @user.update(user_params)
      render json: { message: 'Usuario Actualizado Con Éxito', user: @user }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    render json: { message: 'Usuario Eliminado Con Éxito' }, status: :ok
  end

  private

  # Método para establecer el usuario basado en el ID de los parámetros
  def set_user
    @user = User.find(params[:id])
  end

  # Parámetros permitidos
  def user_params
    params.require(:user).permit(:name, :last_name, :email, :phone, :password, :address, :role)
  end

  # Generar un token JWT
  def generate_token(user_id)
    JWT.encode({ user_id: user_id, exp: 24.hours.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

end
