require_relative "../../test_helper"
require "y2packager/dialogs/product_license"
require "y2packager/product"

describe Y2Packager::Dialogs::ProductLicense do
  Yast.import "UI"
  include Yast::UIShortcuts

  subject(:dialog) { described_class.new(product) }
  let(:product) do
    instance_double(
      Y2Packager::Product,
      label:                   "openSUSE",
      license:                  content
    )
  end
  let(:language) { "en_US" }
  let(:content) { "content" }

  describe "#run" do
    before do
      allow(Yast::Language).to receive(:language).and_return(language)
      allow(Yast::Language).to receive(:GetLanguageItems).and_return([])
    end

    context "user clicks 'ok'" do
      before do
        allow(Yast::UI).to receive(:UserInput).and_return(:ok)
      end

      it "returns :ok" do
        expect(dialog.run).to eq(:ok)
      end
    end
  end
end
