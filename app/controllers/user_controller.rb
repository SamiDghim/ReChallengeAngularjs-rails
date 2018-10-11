class UserController < ApplicationController
    def show
        user=User.find(params[:id])
        render json: user
    end

    # get '/GetAllUsers'
    def GetAllUsers
        p = params[:p]
        users = User.paginate(page: p, per_page:2).order('updated_at DESC')
        render json: {status: 'SUCCESS',message: 'Loaded users for admin',data: users,total:(users.total_pages)},status: :ok
    end

    # put '/updateUser'
    def updateUser
      user = User.find(params[:id])
      if user.update_attributes(user_params)
        users = User.paginate(page: p, per_page:2).order('updated_at DESC')
        render json: {status: 'SUCCESS',message: 'Loaded users for admin after update ',data: users,total:(users.total_pages)},status: :ok
      else
        render json: {status: 'ERROR',message: 'user not updated !',data: user.errors},status: :unprocessable_entity
      end
    end

    def changeInfo
      user = User.find(params[:id])
      if user.update_attributes(userr_params)
        users = User.paginate(page: p, per_page:2).order('updated_at DESC')
        render json: {status: 'SUCCESS',message: 'Loaded users for admin after update ',data: users,total:(users.total_pages)},status: :ok
      else
        render json: {status: 'ERROR',message: 'user not updated !',data: user.errors},status: :unprocessable_entity
      end

    end

    private
    def user_params
        params.permit(:nom, :prenom, :email, :role, :solde)
    end

    private
    def userr_params
        params.permit(:nom, :prenom, :email, :password)
    end
end
