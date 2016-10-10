require "./spec/spec_helper"

RSpec.shared_examples "a_main_object" do
  it "returns the correct values" do
    expect(subject).to eq output
  end
end

RSpec.describe "Main" do
  subject { ::Backend::Main.perform(data, opts) }

  describe ".perform" do
    context "when level1" do
      it_behaves_like "a_main_object" do
        let(:opts) { {} }
        let(:data) { parse_json("./backend/level1/data.json") }
        let(:output) { parse_json("./backend/level1/output.json").to_json }
      end
    end

    context "when level2" do
      it_behaves_like "a_main_object" do
        let(:opts) { { discount: true } }
        let(:data) { parse_json("./backend/level2/data.json") }
        let(:output) { parse_json("./backend/level2/output.json").to_json }
      end
    end

    context "when level3" do
      it_behaves_like "a_main_object" do
        let(:opts) { { discount: true, commission: true } }
        let(:data) { parse_json("./backend/level3/data.json") }
        let(:output) { parse_json("./backend/level3/output.json").to_json }
      end
    end

    context "when level4" do
      it_behaves_like "a_main_object" do
        let(:opts) { { discount: true, commission: true, deductible: true } }
        let(:data) { parse_json("./backend/level4/data.json") }
        let(:output) { parse_json("./backend/level4/output.json").to_json }
      end
    end
  end
end
