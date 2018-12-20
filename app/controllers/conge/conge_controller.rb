module Conge
    class CongeController < ApplicationController
        # post '/saveConge'
        def create
            conge = CongeDemande.new(conge_params);
            if conge.save
             render json: {status: 'SUCCESS',message: 'Saved demand',data: conge},status: :ok
            else
                render json: {status: 'ERROR',message: 'Demand not saved ',data: conge.errors},status: :unprocessable_entity
            end
        end

        # get '/GetUserConges/(/:id)
        def getUserConges
            conge = CongeDemande.where(user_id: params[:id]).order('updated_at DESC')
            render json: {status: 'SUCCESS',message: 'Loaded Congés demande',data: conge},status: :ok
        end

        # get '/getUserCongeModel/(/:id)
        def getUserCongeModel
            conge = CongeDemande.where(id: params[:id])
            render json: {status: 'SUCCESS',message: 'Loaded Congé demande for model',data: conge},status: :ok
        end


        # get '/GetAllDemandsNonT'
        def GetAllDemandesNonT
            p = params[:p]
            congeDemandesNonT=CongeDemande.where(etat:'pas encore traité').paginate(page: p, per_page:2).order('updated_at DESC')
            render json: {status: 'SUCCESS',message: 'Loaded Congés demande T',data: congeDemandesNonT, total:(congeDemandesNonT.total_pages)},:include=> :user, status: :ok
        end

        # get '/GetAllDemandsT'
        def GetAllDemandsT
            p = params[:p]
            conge = CongeDemande.where(etat:'Réfusé').or(CongeDemande.where(etat:'Accepté')).paginate(page: p, per_page:2).order('updated_at DESC')
            render json: {status: 'SUCCESS',message: 'Loaded Congés demande NT',data: conge,total:(conge.total_pages)},:include=> :user, status: :ok
        end

        # get '/search/(/:motCle)'
        def searchDemandesNonT
          @mc = params[:motCle]
            if (@mc)
              if params[:motCle].include? " "
                puts "String includes 'espace'"
                @nom, @prenom = params[:motCle].split(' ')
                puts "Nom "+@nom+" Prenom "+@prenom
                congeDemandesNonT = CongeDemande.includes(:user).where("(users.nom LIKE ? OR users.prenom LIKE ?)
                AND etat= 'pas encore traité' ","%#{@nom}%","%#{@prenom}%")
                .references(:users).paginate(page: params[:p], per_page:2).order(updated_at: :desc)
                render json: {status: 'SUCCESS',message: 'Loaded Congés demande T',data: congeDemandesNonT,total:congeDemandesNonT.total_pages},:include=> :user, status: :ok
              else
                congeDemandesNonT = CongeDemande.includes(:user).where("(users.nom LIKE ? OR users.prenom LIKE ?)
                AND etat= 'pas encore traité' ","%#{params[:motCle]}%","%#{params[:motCle]}%")
                .references(:users).paginate(page: params[:p], per_page:2).order(updated_at: :desc)
                render json: {status: 'SUCCESS',message: 'Loaded Congés demande T',data: congeDemandesNonT,total:congeDemandesNonT.total_pages},:include=> :user, status: :ok
              end
            else
              congeDemandesNonT = CongeDemande.includes(:user).where("(users.nom LIKE ? OR users.prenom LIKE ?)
              AND etat= 'pas encore traité' ","%#{params[:motCle]}%","%#{params[:motCle]}%")
              .references(:users).paginate(page: params[:p], per_page:2).order(updated_at: :desc)
              render json: {status: 'SUCCESS',message: 'Loaded Congés demande T',data: congeDemandesNonT,total:congeDemandesNonT.total_pages},:include=> :user, status: :ok
            end
        end

        # post '/RejectConge/(/:id)'
        def RejectConge
            p = params[:p]
            conge = CongeDemande.find(params[:id]);
            if conge.update_attributes(conge_params_Reject)
                conges=CongeDemande.where(etat:'pas encore traité').paginate(page: p, per_page:2).order('updated_at DESC')
             render json: {status: 'SUCCESS',message: 'reject conge demand success',data: conges},:include=> :user,status: :ok
            else
                render json: {status: 'ERROR',message: 'Demand reject not updated ',data: conge.errors},status: :unprocessable_entity
            end
        end

        #added by ayoub delete function
        # post '/deleteConge/(/:id)'
        def deleteDemande
            conge = CongeDemande.destroy(params[:id])
            render json: {status: 'SUCCESS',message: 'delete conge demand success'},status: :ok
        end

        # post '/AcceptConge/(/:id)'
        def AcceptConge
            p = params[:p]
            conge = CongeDemande.find(params[:id])
            user = User.find(params[:user_id])
            if conge.update_attributes(conge_params_Accept)
                if user.update_attributes(user_params_AcceptConge)
                conges = CongeDemande.where(etat:'pas encore traité').paginate(page: p, per_page:2).order('updated_at DESC')
             render json: {status: 'SUCCESS',message: 'Updated demand accept',data: conges,total:(conges.total_pages)},:include=> :user,status: :ok
                end
            else
                render json: {status: 'ERROR',message: 'Demand accept not updated ',data: conge.errors},status: :unprocessable_entity
            end
        end

        private
        def conge_params
            params.permit(:user_id , :date_debut, :date_fin, :motifAb)
        end

        def conge_params_Reject
            params.permit(:motifR,:etat)
        end

        def conge_params_Accept
            params.permit(:etat)
        end
        def user_params_AcceptConge
            params.permit(:solde)
        end

    end
end
