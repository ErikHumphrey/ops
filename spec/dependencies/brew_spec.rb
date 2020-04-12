# frozen_string_literal: true

require_relative "../spec_helper.rb"

require_relative "../../lib/dependencies/brew"

RSpec.describe Dependencies::Brew do
	subject { described_class.new(name) }
	let(:name) { "some-dependency" }

	describe "#installed?" do
	end

	describe "#install" do
	end
end
