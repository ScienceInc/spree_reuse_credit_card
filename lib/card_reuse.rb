module CardReuse
  def all_cards_for_user(user)
    return nil unless user

    payments = credit_card_payments_for_user(user)

    payments = payments.map do |payment| 
      src = payment.source

      if valid_for_reuse?(src) && payment.valid? && src.gateway_payment_profile_id
        src
      else
        nil
      end
    end.compact.uniq
    payments.each do |payment|
      payments.delete_if do |p| 
        p != payment && (p["last_digits"] == payment["last_digits"] && p["year"] == payment["year"] && p["month"] == payment["month"])
      end
    end
    payments
  end

  def valid_for_reuse?(payment_source)
    # some payment gateways use only one of these?  stripe possibly?
    !(payment_source.nil? || (payment_source.gateway_payment_profile_id.nil? && payment_source.gateway_customer_profile_id.nil?) || payment_source.deleted?)
  end

  def credit_card_payments_for_user(user)
    Spree::Payment.joins(:order).where('spree_orders.completed_at IS NOT NULL').where('spree_orders.user_id' => user.id).order('spree_orders.created_at').where('spree_payments.source_type' => 'Spree::CreditCard').where('spree_payments.state' => 'completed')
  end
end