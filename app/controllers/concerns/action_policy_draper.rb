module ActionPolicyDraper
  extend ActiveSupport::Concern

  def policy_for(record:, **opts)
    record = record.model while record.is_a?(Draper::Decorator)

    super(record: record, **opts)
  end
end
