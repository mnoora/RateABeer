require 'rails_helper'

RSpec.describe Style, type: :model do
  it "has the style name set correctly" do
    style = Style.new name:"Lager"

    expect(style.name).to eq("Lager")
  end
end
