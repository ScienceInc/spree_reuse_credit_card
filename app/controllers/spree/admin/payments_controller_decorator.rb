require 'card_reuse'

module Spree
  module Admin
    PaymentsController.class_eval do
      include CardReuse

      def new
        @payment = @order.payments.build
        @cards = all_cards_for_user(@order.user)
      end

      def object_params
        if params[:payment] and params[:payment_source]
          if params[:existing_card]
            credit_card = Spree::CreditCard.find(params[:existing_card])
            authorize! :manage, credit_card
            params[:payment][:source] = credit_card
          else
            id = params[:payment][:payment_method_id]
            params[:payment][:source_attributes] = params[:payment_source][id] if id
          end
        end
        params[:payment]
      end
    end
  end
end