# frozen_string_literal: true

RSpec.describe EivuVideoGameInfo do
  it "has a version number" do
    expect(EivuVideoGameInfo::VERSION).not_to be nil
  end
end
