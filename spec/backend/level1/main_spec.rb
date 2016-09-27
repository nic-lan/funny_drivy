require "./spec/spec_helper"

RSpec.describe "Level1" do
  let(:data) { JSON.parse(File.read("./backend/level1/data.json")) }
  let(:output) { JSON.parse(File.read("./backend/level1/output.json")).to_json }

  subject { ::Backend::Main.perform(data) }

  describe ".perform" do
    it "returns the correct values" do
      expect(subject).to eq output
    end
  end
end
