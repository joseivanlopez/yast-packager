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
require "ui/dialog"
require "cgi/util"
require "ui/installation_dialog"

Yast.import "UI"

module Y2Packager
  module Dialogs
    class ProductLicense < ::UI::Dialog
      # include Yast::I18n
      # include ::UI::EventDispatcher

      # @return [Y2Packager::Product] Product
      attr_reader :product

      # Constructor
      #
      # @param product [Y2Packager::Product] Product to ask for the license
      def initialize(product)
        super()
        @product = product
        self.language = Yast::Language.language
      end

      # Handler for the :language action
      #
      # This happens when the user changes the license language
      def language_handler
        self.language = Yast::UI.QueryWidget(Id(:language), :Value)
        Yast::UI.ReplaceWidget(Id(:license_replace_point), license_content)
      end

      def ok_handler
        finish_dialog(:ok)
      end

      def run
        create_dialog
        event_loop
      ensure
        close_dialog
      end

    private

      attr_accessor :language

      # Dialog content
      #
      # @see ::UI::Dialog
      def dialog_content
        VBox(
          Left(language_selection),
          VSpacing(0.5),
          ReplacePoint(
            Id(:license_replace_point),
            license_content
          ),
          HBox(
            PushButton(Id(:ok), _("OK"))
          )
        )
      end

      # Return the UI for the language selector
      def language_selection
        ComboBox(
          Id(:language),
          Opt(:notify, :hstretch),
          _("&License Language"),
          Yast::Language.GetLanguageItems(:primary)
        )
      end

      # Return the UI for the license content
      def license_content
        MinWidth(
          80,
          RichText(Id(:license_content), formatted_license_text)
        )
      end

      # Regexp to determine whether the text is formatted as richtext
      RICHTEXT_REGEXP = /<\/.*>/

      # Return the license text
      #
      # It detects whether license text is richtext or not and format it
      # accordingly.
      #
      # @return [String] Formatted license text
      def formatted_license_text
        text = product.license(language)
        if RICHTEXT_REGEXP =~ text
          text
        else
          "<pre>#{CGI.escapeHTML(text)}</pre>"
        end
      end
    end
  end
end
