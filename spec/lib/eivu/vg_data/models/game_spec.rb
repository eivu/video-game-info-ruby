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

  describe 'slugify_string' do
    context 'with a normal string' do
      it 'returns a slugified string' do
        expect(described_class.slugify_string('Super Mario Bros.')).to eq('supermariobros')
      end
    end

    context 'with a string with a country code' do
      it 'returns a slugified string' do
        expect(described_class.slugify_string('Super Mario Bros. (U)')).to eq('supermariobros')
      end
    end

    context 'with a string that has values in brackets' do
      it 'returns a slugified string' do
        expect(described_class.slugify_string('Super Mario Bros. [misc]')).to eq('supermariobros')
      end
    end

    context 'when the word the is in the middle of the string' do
      it 'returns a slugified string' do
        expect(described_class.slugify_string('Happy The Caveman')).to eq('happycaveman')
      end
    end

    context 'when the word the is at the beginning of the string' do
      it 'returns a slugified string' do
        expect(described_class.slugify_string('The Happy Caveman')).to eq('happycaveman')
      end
    end
  end
end
