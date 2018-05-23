module Devise
  module Models
    module DateRestrictable
      extend  ActiveSupport::Concern

      included do

        validate :date_restrictable_must_be_chronological

      end

      def date_restricted?
        now = Date.today

        !((valid_from.nil? or now >= valid_from) and (valid_until.nil? or now <= valid_until))
      end

      def self.required_fields(klass)
        attributes = []
        attributes << :valid_from
        attributes << :valid_until
        attributes
      end

      def access_locked?
        date_restricted?
      end

      def active_for_authentication?
        super && !date_restricted?
      end

      def inactive_message
        date_restricted? ? :account_date_restricted : super
      end

      private

        def date_restrictable_must_be_chronological

          # bounce unless we have both dates
          return if valid_from.blank? or valid_until.blank?

          # otherwise…
          unless valid_until.to_date >= valid_from.to_date

            field_name = self.class.human_attribute_name( :valid_from )
            errors.add( :valid_until, :must_be_on_or_after, { field: field_name })

          end

        end
    end
  end
end
