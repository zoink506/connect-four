require_relative '../lib/Game.rb'
require_relative '../lib/Board.rb'
require_relative '../lib/Computer.rb'

describe Game do
  describe "#initialize" do
    subject(:game) { described_class.new }
    
    it "Creates new Board object" do
      expect(Board).to receive(:new)
      Game.new
    end

    it "Creates new Computer object" do
      expect(Computer).to receive(:new)
      Game.new
    end
  end

  describe "#play" do

  end
end