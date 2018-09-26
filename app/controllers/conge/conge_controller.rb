module Conge
    class CongeController < ApplicationController
        def create
            conge=CongeDemande.new(conge_params);
            if conge.save
             render json: {status: 'SUCCESS',message: 'Saved demand',data: conge},status: :ok
            else
                render json: {status: 'ERROR',message: 'Demand not saved ',data: conge.errors},status: :unprocessable_entity
            end
        end

        def getUserConges
            conge=CongeDemande.where(user_id: params[:id]).order(created_at: :desc)
            render json: {status: 'SUCCESS',message: 'Loaded Congés demande',data: conge,total:(conge.count+1)/2},status: :ok
        end

        def getUserCongeModel
            conge=CongeDemande.where(id: params[:id])
            render json: {status: 'SUCCESS',message: 'Loaded Congé demande for model',data: conge},status: :ok
        end

        def GetAllUsers
            users=User.paginate(page: $page, per_page:2).order(created_at: :desc)
            render json: {status: 'SUCCESS',message: 'Loaded users for admin',data: users,total:(users.count+1)/2},status: :ok
        end

        def GetAllDemandesNonT
            congeDemandesNonT=CongeDemande.where(etat:'pas encore traité').paginate(page: $DNTPage, per_page:2).order(created_at: :desc)
            render json: {status: 'SUCCESS',message: 'Loaded Congés demande T',data: congeDemandesNonT, total:(congeDemandesNonT.count+1)/2},:include=> :user, status: :ok
        end

        def GetAllDemandsT
            conge=CongeDemande.where(etat:'Réfusé').or(CongeDemande.where(etat:'Accepté')).paginate(page: $DTPage, per_page:2).order(created_at: :desc)
            render json: {status: 'SUCCESS',message: 'Loaded Congés demande NT',data: conge,total:(conge.count+1)/2},:include=> :user, status: :ok
        end

        def searchDemandesNonT
            congeDemandesNonT=CongeDemande.includes(:user).where("(users.nom LIKE ? OR users.prenom LIKE ?) 
            AND etat= 'pas encore traité' ","%#{params[:motCle]}%","%#{params[:motCle]}%")
            .references(:users).order(created_at: :desc)
            render json: {status: 'SUCCESS',message: 'Loaded Congés demande T',data: congeDemandesNonT},:include=> :user, status: :ok
        end
        
        def RejectConge
            conge=CongeDemande.find(params[:id]);
            if conge.update_attributes(conge_params_Reject)
                conges=CongeDemande.where(etat:'pas encore traité').paginate(page: $DNTPage, per_page:2).order(created_at: :desc)
             render json: {status: 'SUCCESS',message: 'reject conge demand success',data: conges},:include=> :user,status: :ok
            else
                render json: {status: 'ERROR',message: 'Demand reject not updated ',data: conge.errors},status: :unprocessable_entity
            end
        end

        def AcceptConge
            conge=CongeDemande.find(params[:id]);
            user=User.find(params[:user_id]);
            if conge.update_attributes(conge_params_Accept)
                if user.update_attributes(user_params_AcceptConge)
                conges=CongeDemande.where(etat:'pas encore traité').paginate(page: $DNTPage, per_page:2).order(created_at: :desc)
             render json: {status: 'SUCCESS',message: 'Updated demand accept',data: conges},:include=> :user,status: :ok
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