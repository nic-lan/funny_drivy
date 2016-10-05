require "./spec/spec_helper"

RSpec.describe "Level3" do
  let(:data) { JSON.parse(File.read("./backend/level3/data.json")) }
  let(:output) do
    JSON.parse(File.read("./backend/level3/output.json")).to_json
  end

  subject { ::Backend::Main.perform(data, discount: true, commission: true) }

  describe ".perform" do
    it "returns the correct values" do
      expect(subject).to eq output
    end
  end
end
