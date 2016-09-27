require "./spec/spec_helper"

RSpec.describe "Level2" do
  describe ".perform" do
    let(:data) { JSON.parse(File.read("./backend/level2/data.json")) }
    let(:output) do
      JSON.parse(File.read("./backend/level2/output.json")).to_json
    end

    subject { ::Backend::Main.perform(data, discount: true) }

    it "returns the expected output" do
      expect(subject).to eq output
    end
  end
end
