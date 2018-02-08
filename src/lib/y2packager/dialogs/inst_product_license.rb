# ------------------------------------------------------------------------------
# Copyright (c) 2017 SUSE LLC, All Rights Reserved.
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
require "cwm/dialog"

require "y2packager/widgets/product_license_translations"

require "cgi/util"
Yast.import "Language"
Yast.import "UI"

module Y2Packager
  module Dialogs
    # Dialog which shows the user a license and ask for confirmation
    class InstProductLicense < CWM::Dialog
      # @return [Y2Packager::Product] Product
      attr_reader :product
      attr_reader :language

      # Constructor
      #
      # @param product [Y2Packager::Product] Product to ask for the license
      def initialize(product)
        super()
        @product = product
        @language = Yast::Language.language
      end

      # Returns the dialog title
      #
      # @return [String] Dialog's title
      def title
        format(_("%s License Agreement"), product.label)
      end

      # Dialog content
      #
      # @return [Yast::Term] Dialog's content
      def contents
        VBox(
          Y2Packager::Widgets::ProductLicenseTranslations.new(product)
        )
      end
    end
  end
end
