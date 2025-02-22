# frozen_string_literal: true

require 'eivu'

describe Eivu::VgData::Models::Game do
  describe 'extract_country' do
    it 'returns USA for U' do
      expect(described_class.extract_country('Super Mario Bros. (U)')).to eq('USA')
    end

    it 'returns Japan for J' do
      expect(described_class.extract_country('Super Mario Bros. (J)')).to eq('Japan')
    end

    it 'returns Europe for E' do
      expect(described_class.extract_country('Super Mario Bros. (E)')).to eq('Europe')
    end

    it 'returns Korea for K' do
      expect(described_class.extract_country('Super Mario Bros. (K)')).to eq('Korea')
    end

    it 'returns Unknown for nil' do
      expect(described_class.extract_country('Super Mario Bros.')).to be_nil
    end

    it 'returns Unknown for other' do
      expect(described_class.extract_country('Super Mario Bros. (X)')).to eq('Unknown')
    end
  end
end
