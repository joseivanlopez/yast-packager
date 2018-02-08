# ------------------------------------------------------------------------------
# Copyright (c) 2017 SUSE LINUX GmbH, Nuernberg, Germany.
#
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of version 2 of the GNU General Public License as published by the
# Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, contact Novell, Inc.
#
# To contact Novell about this file by physical or electronic mail, you may find
# current contact information at www.novell.com.
# ------------------------------------------------------------------------------

require "yast"
require "cwm/widget"

module Y2Packager
  module Widgets
    # Language selection widget
    class LanguageSelection < CWM::ComboBox

      attr_reader :default
      attr_reader :languages

      # @param emit_event [Boolean] flag if handle of widget emit `:redraw` event
      #   when language changed or not
      def initialize(languages: [])
        textdomain "y2packager"
        @languages = languages
        @default = Yast::Language.language
      end

      # Widget label
      #
      # @return [String]
      def label
        _("&Language")
      end

      # Widget options
      #
      # Widget is forced to report immediatelly after value changed.
      def opt
        [:notify, :hstretch]
      end

      # Initialize the selected value
      def init
        self.value = default
      end

      # Widget help text
      #
      # @return [String]
      def help
        ""
      end

      # Handle value changes
      def handle
        nil
      end

      # Store widget value
      def store
        handle
        nil
      end

      # Return the options to be shown in the combobox
      #
      # @return [Array<Array<String,String>>] Array of languages in form [code, description]
      def items
        @items ||= Yast::Language.GetLanguageItems(:primary).each_with_object([]) do |item, langs|
          byebug
          id, description = item.to_a
          code = id.first
          next unless languages.include?(code)
          langs << [code, description]
        end
      end
    end
  end
end
