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
    subject(:slug) { described_class.slugify_string(string) }

    context 'with a normal string' do
      let(:string) { 'Super Mario Bros.' }

      it { is_expected.to eq('supermariobros') }
    end

    context 'with a string that contains accents' do
      let(:string) { 'Pokémon Yellow' }

      it { is_expected.to eq('pokemonyellow') }
    end

    context 'with a string with a country code' do
      let(:string) { 'Super Mario Bros. (U)' }

      it { is_expected.to eq('supermariobros') }
    end

    context 'with a string that has values in brackets' do
      let(:string) { 'Super Mario Bros. [misc]' }

      it { is_expected.to eq('supermariobros') }
    end

    context 'when the word the is in the middle of the string' do
      let(:string) { 'Happy The Caveman' }

      it { is_expected.to eq('happycaveman') }
    end

    context 'when the word the is at the beginning of the string' do
      let(:string) { 'The Happy Caveman' }

      it { is_expected.to eq('happycaveman') }
    end

    context 'when the string contains gbs player v1.0' do
      let(:string) { 'GBS Player V1.0 - Super Mario Bros.' }

      it { is_expected.to eq('supermariobros') }
    end

    context 'when the string contains Disney\'s' do
      let(:string) { 'Disney\'s Aladdin' }

      it { is_expected.to eq('aladdin') }
    end

    context 'when the string contains special characters within brackets' do
      let(:string) { 'Super Mario Bros. [!p]' }

      it { is_expected.to eq('supermariobros') }
    end
  end

  describe 'slugify_string_xtra' do
    subject(:xtra_slug) { described_class.slugify_string_xtra(string) }

    context 'with a normal string' do
      let(:string) { 'Super Mario Bros.' }

      it { is_expected.to eq('supermariobros') }
    end

    context 'with a string that contains accents' do
      let(:string) { 'Pokémon Yellow' }

      it { is_expected.to eq('pokemonyellow') }
    end

    context 'with a string with a country code' do
      let(:string) { 'Super Mario Bros. (U)' }

      it { is_expected.to eq('supermariobros') }
    end

    context 'with a string that has values in brackets' do
      let(:string) { 'Super Mario Bros. [misc]' }

      it { is_expected.to eq('supermariobros') }
    end

    context 'when the word the is in the middle of the string' do
      let(:string) { 'Happy The Caveman' }

      it { is_expected.to eq('happycaveman') }
    end

    context 'when the word the is at the beginning of the string' do
      let(:string) { 'The Happy Caveman' }

      it { is_expected.to eq('happycaveman') }
    end

    context 'when the string contains gbs player v1.0' do
      let(:string) { 'GBS Player V1.0 - Super Mario Bros.' }

      it { is_expected.to eq('supermariobros') }
    end

    context 'when the string contains Disney\'s' do
      let(:string) { 'Disney\'s Aladdin' }

      it { is_expected.to eq('aladdin') }
    end

    context 'when the string contains special characters within brackets' do
      let(:string) { 'Super Mario Bros. [!p]' }

      it { is_expected.to eq('supermariobros') }
    end

    context 'when the string contains a version number and alpha denotation' do
      let(:string) { 'Super Boss Gaiden (J) V1.2a' }

      it { is_expected.to eq('superbossgaiden') }
    end

    context 'when the string contains only a version number' do
      let(:string) { 'N-Warp Daisakusen V1.1' }

      it { is_expected.to eq('nwarpdaisakusen') }
    end
  end

  describe 'slugify_rom' do
    subject(:slugified_rom) { described_class.slugify_rom(path) }

    context 'when the rom is varooom-3d' do
      let(:path) { 'spec/fixtures/roms/gba/varooom-3d.gba' }

      it { is_expected.to eq('varooom3d') }
    end

    context 'when the rom is varooom-3d_slow' do
      let(:path) { 'spec/fixtures/roms/gba/varooom-3d_slow.gba' }

      it { is_expected.to eq('varooom3dslow') }
    end

    context 'when the rom is butano-fighter' do
      let(:path) { 'spec/fixtures/roms/gba/butano-fighter.gba' }

      it { is_expected.to eq('butanofighter') }
    end

    context 'when the rom is Tobu Tobu Girl' do
      let(:path) { 'spec/fixtures/roms/gameboy/Tobu Tobu Girl (US, JP).gb' }

      it { is_expected.to eq('tobutobugirl') }
    end

    context 'when the rom is dpadhero2' do
      let(:path) { 'spec/fixtures/roms/nes/dpadhero2.nes' }

      it { is_expected.to eq('dpadhero2') }
    end

    context 'when the rom is flappy' do
      let(:path) { 'spec/fixtures/roms/nes/flappy.nes' }

      it { is_expected.to eq('flappy') }
    end

    context 'when the rom is dpadhero' do
      let(:path) { 'spec/fixtures/roms/nes/dpadhero.nes' }

      it { is_expected.to eq('dpadhero') }
    end

    context 'when the rom is Rolling Pumpkins' do
      let(:path) { 'spec/fixtures/roms/nintendo_64/Rolling Pumpkins.n64' }

      it { is_expected.to eq('rollingpumpkins') }
    end

    context 'when the rom is Super Boss Gaiden' do
      let(:path) { 'spec/fixtures/roms/snes/Super Boss Gaiden (J) V1.2a.sfc' }

      it { is_expected.to eq('superbossgaidenv12a') }
    end

    context 'when the rom is N-Warp Daisakusen' do
      let(:path) { 'spec/fixtures/roms/snes/N-Warp Daisakusen V1.1.smc' }

      it { is_expected.to eq('nwarpdaisakusenv11') }
    end

    context 'when the rom is Jet Pilot Rising' do
      let(:path) { 'spec/fixtures/roms/snes/Jet Pilot Rising (J) (V1.1).sfc' }

      it { is_expected.to eq('jetpilotrising') }
    end

    context 'when the rom is anguna' do
      let(:path) { 'spec/fixtures/roms/nintendo_ds/anguna.nds' }

      it { is_expected.to eq('anguna') }
    end

    context 'when the rom is Lost In Space' do
      let(:path) { 'spec/fixtures/roms/nintendo_ds/Lost In Space.nds' }

      it { is_expected.to eq('lostinspace') }
    end
  end

  describe 'slugify_rom_xtra' do
    subject(:slug) { described_class.slugify_rom_xtra(path) }

    context 'when the rom is varooom-3d' do
      let(:path) { 'spec/fixtures/roms/gba/varooom-3d.gba' }

      it { is_expected.to eq('varooom3d') }
    end

    context 'when the rom is varooom-3d_slow' do
      let(:path) { 'spec/fixtures/roms/gba/varooom-3d_slow.gba' }

      it { is_expected.to eq('varooom3dslow') }
    end

    context 'when the rom is butano-fighter' do
      let(:path) { 'spec/fixtures/roms/gba/butano-fighter.gba' }

      it { is_expected.to eq('butanofighter') }
    end

    context 'when the rom is Tobu Tobu Girl' do
      let(:path) { 'spec/fixtures/roms/gameboy/Tobu Tobu Girl (US, JP).gb' }

      it { is_expected.to eq('tobutobugirl') }
    end

    context 'when the rom is dpadhero2' do
      let(:path) { 'spec/fixtures/roms/nes/dpadhero2.nes' }

      it { is_expected.to eq('dpadhero2') }
    end

    context 'when the rom is flappy' do
      let(:path) { 'spec/fixtures/roms/nes/flappy (1).nes' }

      it { is_expected.to eq('flappy') }
    end

    context 'when the rom is dpadhero' do
      let(:path) { 'spec/fixtures/roms/nes/dpadhero.nes' }

      it { is_expected.to eq('dpadhero') }
    end

    context 'when the rom is Rolling Pumpkins' do
      let(:path) { 'spec/fixtures/roms/nintendo_64/Rolling Pumpkins.n64' }

      it { is_expected.to eq('rollingpumpkins') }
    end

    context 'when the rom is Super Boss Gaiden' do
      let(:path) { 'spec/fixtures/roms/snes/Super Boss Gaiden (J) V1.2a.sfc' }

      it { is_expected.to eq('superbossgaiden') }
    end

    context 'when the rom is N-Warp Daisakusen' do
      let(:path) { 'spec/fixtures/roms/snes/N-Warp Daisakusen V1.1.smc' }

      it { is_expected.to eq('nwarpdaisakusen') }
    end

    context 'when the rom is Jet Pilot Rising' do
      let(:path) { 'spec/fixtures/roms/snes/Jet Pilot Rising (J) (V1.1).sfc' }

      it { is_expected.to eq('jetpilotrising') }
    end

    context 'when the rom is anguna' do
      let(:path) { 'spec/fixtures/roms/nintendo_ds/anguna.nds' }

      it { is_expected.to eq('anguna') }
    end

    context 'when the rom is Lost In Space' do
      let(:path) { 'spec/fixtures/roms/nintendo_ds/Lost In Space.nds' }

      it { is_expected.to eq('lostinspace') }
    end
  end

  describe 'fetch_rom_info' do
    subject(:rom_info) { described_class.fetch_rom_info(path) }

    context 'when the rom is varooom-3d' do
      let(:path) { 'spec/fixtures/roms/gba/varooom-3d.gba' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('varooom3d')
          expect(rom_info.platform_name).to eq('Nintendo Game Boy Advance')
          expect(rom_info.id).to eq(79_118)
        end
      end
    end

    context 'when the rom is varooom-3d_slow' do
      let(:path) { 'spec/fixtures/roms/gba/varooom-3d_slow.gba' }

      it { is_expected.to be_nil }
    end

    context 'when the rom is butano-fighter' do
      let(:path) { 'spec/fixtures/roms/gba/butano-fighter.gba' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('butanofighter')
          expect(rom_info.platform_name).to eq('Nintendo Game Boy Advance')
          expect(rom_info.id).to eq(77_337)
        end
      end
    end

    context 'when the rom is Tobu Tobu Girl' do
      let(:path) { 'spec/fixtures/roms/gameboy/Tobu Tobu Girl (US, JP).gb' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('tobutobugirl')
          expect(rom_info.platform_name).to eq('Nintendo Game Boy')
          expect(rom_info.id).to eq(76_973)
        end
      end
    end

    context 'when the rom is dpadhero2' do
      let(:path) { 'spec/fixtures/roms/nes/dpadhero2.nes' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('dpadhero2')
          expect(rom_info.platform_name).to eq('Nintendo Entertainment System')
          expect(rom_info.id).to eq(72_921)
        end
      end
    end

    context 'when the rom is flappy' do
      let(:path) { 'spec/fixtures/roms/nes/flappy.nes' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('flappy')
          expect(rom_info.platform_name).to eq('Nintendo Entertainment System')
          expect(rom_info.id).to eq(73_153)
        end
      end
    end

    context 'when the rom is dpadhero' do
      let(:path) { 'spec/fixtures/roms/nes/dpadhero.nes' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('dpadhero')
          expect(rom_info.platform_name).to eq('Nintendo Entertainment System')
          expect(rom_info.id).to eq(72_920)
        end
      end
    end

    context 'when the rom is Rolling Pumpkins' do
      let(:path) { 'spec/fixtures/roms/nintendo_64/Rolling Pumpkins.n64' }

      it { is_expected.to be_nil }
    end

    context 'when the rom is Super Boss Gaiden' do
      let(:path) { 'spec/fixtures/roms/snes/Super Boss Gaiden (J) V1.2a.sfc' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('superbossgaiden')
          expect(rom_info.platform_name).to eq('Super Nintendo Entertainment System')
          expect(rom_info.id).to eq(123_193)
        end
      end
    end

    context 'when the rom is N-Warp Daisakusen' do
      let(:path) { 'spec/fixtures/roms/snes/N-Warp Daisakusen V1.1.smc' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('nwarpdaisakusen')
          expect(rom_info.platform_name).to eq('Super Nintendo Entertainment System')
          expect(rom_info.id).to eq(122_729)
        end
      end
    end

    context 'when the rom is Jet Pilot Rising' do
      let(:path) { 'spec/fixtures/roms/snes/Jet Pilot Rising (J) (V1.1).sfc' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('jetpilotrising')
          expect(rom_info.platform_name).to eq('Super Nintendo Entertainment System')
          expect(rom_info.id).to eq(122_263)
        end
      end
    end

    context 'when the rom is anguna' do
      let(:path) { 'spec/fixtures/roms/nintendo_ds/anguna.nds' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('angunawarriorsofvirtue')
          expect(rom_info.platform_name).to eq('Nintendo DS')
          expect(rom_info.id).to eq(67_874)
        end
      end
    end

    context 'when the rom is Lost In Space' do
      let(:path) { 'spec/fixtures/roms/nintendo_ds/Lost In Space.nds' }

      it { is_expected.to be_nil }
    end

    context 'when the rom is Dexanoid' do
      let(:path) { 'spec/fixtures/roms/nintendo_64/Dexanoid.z64' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('dexanoid')
          expect(rom_info.platform_name).to eq('Nintendo 64')
          expect(rom_info.id).to eq(67_166)
        end
      end
    end

    context 'when the rom is Pyoro 64' do
      let(:path) { 'spec/fixtures/roms/nintendo_64/Pyoro64.n64' }

      it 'returns the game info' do
        aggregate_failures do
          expect(rom_info).to be_a(described_class)
          expect(rom_info.slug).to eq('pyoro64')
          expect(rom_info.platform_name).to eq('Nintendo 64')
          expect(rom_info.id).to eq(67_419)
        end
      end
    end
  end

  describe 'fetch_rom_info_as_json' do
    subject(:json_info) { described_class.fetch_rom_info_as_json(path) }

    context 'when the rom is varooom-3d' do
      let(:path) { 'spec/fixtures/roms/gba/varooom-3d.gba' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('varooom3d')
          expect(json_info[:platform_name]).to eq('Nintendo Game Boy Advance')
          expect(json_info[:id]).to eq(79_118)
        end
      end
    end

    context 'when the rom is varooom-3d_slow' do
      let(:path) { 'spec/fixtures/roms/gba/varooom-3d_slow.gba' }

      it { is_expected.to be_nil }
    end

    context 'when the rom is butano-fighter' do
      let(:path) { 'spec/fixtures/roms/gba/butano-fighter.gba' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('butanofighter')
          expect(json_info[:platform_name]).to eq('Nintendo Game Boy Advance')
          expect(json_info[:id]).to eq(77_337)
        end
      end
    end

    context 'when the rom is Tobu Tobu Girl' do
      let(:path) { 'spec/fixtures/roms/gameboy/Tobu Tobu Girl (US, JP).gb' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('tobutobugirl')
          expect(json_info[:platform_name]).to eq('Nintendo Game Boy')
          expect(json_info[:id]).to eq(76_973)
        end
      end
    end

    context 'when the rom is dpadhero2' do
      let(:path) { 'spec/fixtures/roms/nes/dpadhero2.nes' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('dpadhero2')
          expect(json_info[:platform_name]).to eq('Nintendo Entertainment System')
          expect(json_info[:id]).to eq(72_921)
        end
      end
    end

    context 'when the rom is flappy' do
      let(:path) { 'spec/fixtures/roms/nes/flappy.nes' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('flappy')
          expect(json_info[:platform_name]).to eq('Nintendo Entertainment System')
          expect(json_info[:id]).to eq(73_153)
        end
      end
    end

    context 'when the rom is dpadhero' do
      let(:path) { 'spec/fixtures/roms/nes/dpadhero.nes' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('dpadhero')
          expect(json_info[:platform_name]).to eq('Nintendo Entertainment System')
          expect(json_info[:id]).to eq(72_920)
        end
      end
    end

    context 'when the rom is Rolling Pumpkins' do
      let(:path) { 'spec/fixtures/roms/nintendo_64/Rolling Pumpkins.n64' }

      it { is_expected.to be_nil }
    end

    context 'when the rom is Super Boss Gaiden' do
      let(:path) { 'spec/fixtures/roms/snes/Super Boss Gaiden (J) V1.2a.sfc' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('superbossgaiden')
          expect(json_info[:platform_name]).to eq('Super Nintendo Entertainment System')
          expect(json_info[:id]).to eq(123_193)
        end
      end
    end

    context 'when the rom is N-Warp Daisakusen' do
      let(:path) { 'spec/fixtures/roms/snes/N-Warp Daisakusen V1.1.smc' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('nwarpdaisakusen')
          expect(json_info[:platform_name]).to eq('Super Nintendo Entertainment System')
          expect(json_info[:id]).to eq(122_729)
        end
      end
    end

    context 'when the rom is Jet Pilot Rising' do
      let(:path) { 'spec/fixtures/roms/snes/Jet Pilot Rising (J) (V1.1).sfc' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('jetpilotrising')
          expect(json_info[:platform_name]).to eq('Super Nintendo Entertainment System')
          expect(json_info[:id]).to eq(122_263)
        end
      end
    end

    context 'when the rom is anguna' do
      let(:path) { 'spec/fixtures/roms/nintendo_ds/anguna.nds' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('angunawarriorsofvirtue')
          expect(json_info[:platform_name]).to eq('Nintendo DS')
          expect(json_info[:id]).to eq(67_874)
        end
      end
    end

    context 'when the rom is Lost In Space' do
      let(:path) { 'spec/fixtures/roms/nintendo_ds/Lost In Space.nds' }

      it { is_expected.to be_nil }
    end

    context 'when the rom is Dexanoid' do
      let(:path) { 'spec/fixtures/roms/nintendo_64/Dexanoid.z64' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('dexanoid')
          expect(json_info[:platform_name]).to eq('Nintendo 64')
          expect(json_info[:id]).to eq(67_166)
        end
      end
    end

    context 'when the rom is Pyoro 64' do
      let(:path) { 'spec/fixtures/roms/nintendo_64/Pyoro64.n64' }

      it 'returns the game info' do
        aggregate_failures do
          expect(json_info).to be_a(Hash)
          expect(json_info[:slug]).to eq('pyoro64')
          expect(json_info[:platform_name]).to eq('Nintendo 64')
          expect(json_info[:id]).to eq(67_419)
        end
      end
    end
  end
end
