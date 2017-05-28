module Devise
  module Models
    module DateRestrictable
      extend  ActiveSupport::Concern

      def date_restricted?
        now = Date.today

        puts now.inspect
        puts valid_from.nil?.inspect
        puts valid_until.nil?.inspect

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
    end
  end
end
