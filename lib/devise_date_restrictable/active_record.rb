module Devise
  module Models

    # DateRestrictable provides the ability to restrict a user’s access by date. This can be used to limit logging in
    # either before- or after a certain date, or outside of a given date range.
    #
    # Where dates are given they are <em>inclusive</em>, that is:
    #
    # - if <tt>valid_from</tt> is specified, the user may log in after 00:00:00 on that date
    # - if <tt>valid_until</tt> is specified, the user may log in until 23:59:59 on that date
    #
    # This module also provides basic validation to ensure that, where both <tt>valid_from</tt> and <tt>valid_until</tt>
    # are specified, this is done in a sensible chronological order.
    module DateRestrictable
      extend  ActiveSupport::Concern

      # Add validation onto base model.
      included do

        validate :date_restrictable_must_be_chronological

      end

      # Returns whether or not the user is currently restricted by date.
      def date_restricted?

        now = Date.today

        !((valid_from.nil? or now >= valid_from) and (valid_until.nil? or now <= valid_until))

      end

      # Returns an array of fields required by this module.
      def self.required_fields( klass )

        %i{ valid_from, valid_until }

      end

      # Hook into lockable: verifies whether the user is locked for any reason.
      def access_locked?

        super && date_restricted?

      end

      # Hook into authenticatable: verifies whether the user is available for authentication.
      def active_for_authentication?

        super && !date_restricted?

      end

      # Returns an appropriate message should the user be locked out by this module.
      def inactive_message

        date_restricted? ? :account_date_restricted : super

      end

      private

        # Internal validation function to ensure that, when both -from and -to dates are specified, they make
        # chronological sense.
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
