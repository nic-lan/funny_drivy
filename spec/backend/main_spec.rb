require "./spec/spec_helper"

RSpec.shared_examples "a_main_object" do |level|
  context "when #{level}" do
    let(:data) { parse_json("./backend/#{level}/data.json") }
    let(:output) { parse_json("./backend/#{level}/output.json").to_json }
    it "returns the correct values for #{level}" do
      # puts JSON.pretty_generate JSON.parse(subject)["rentals"][0]
      # puts JSON.pretty_generate JSON.parse(output)["rentals"][0]
      expect(subject).to eq output
    end
  end
end

RSpec.describe Backend::Main do
  subject { described_class.perform(data, opts) }

  describe ".perform" do
    it_behaves_like "a_main_object", "level1" do
      let(:opts) { {} }
    end

    it_behaves_like "a_main_object", "level2" do
      let(:opts) { { discount: true } }
    end

    it_behaves_like "a_main_object", "level3" do
      let(:opts) { { discount: true, commission: true } }
    end

    it_behaves_like "a_main_object", "level4" do
      let(:opts) { { discount: true, commission: true, deductible: true } }
    end

    it_behaves_like "a_main_object", "level5" do
      let(:opts) do
        {
          discount: true,
          commission: true,
          deductible: true,
          serializer: :improved
        }
      end
    end

    it_behaves_like "a_main_object", "level6" do
      let(:opts) do
        {
          discount: true,
          commission: true,
          deductible: true,
          serializer: :improved,
          path: :rental_modification
        }
      end
    end
  end
end
