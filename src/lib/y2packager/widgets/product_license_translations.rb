# ------------------------------------------------------------------------------
# Copyright (c) 2018 SUSE LLC, All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of version 2 of the GNU General Public License as published by the
# Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# ------------------------------------------------------------------------------

require "yast"
require "cwm"
require "y2packager/widgets/product_license"
require "y2packager/widgets/language_selection"

module Y2Packager
  module Widgets
    class ProductLicenseTranslations < CWM::CustomWidget
      attr_reader :product
      attr_reader :language
      def initialize(product)
        super()
        @product = product
        self.handle_all_events
      end

      def contents
        VBox(
          language_selection,
          VSpacing(0.5),
          product_license
        )
      end

      def handle(event)
        byebug
        nil
      end

      def language_selection
        @language_selection ||=
          Y2Packager::Widgets::LanguageSelection.new(languages: ["es_ES", "en_US", "de_DE"])
      end

      def product_license
        @product_license ||=
          Y2Packager::Widgets::ProductLicense.new(product, skip_validation: false)
      end
    end
  end
end
