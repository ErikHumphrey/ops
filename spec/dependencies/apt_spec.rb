# frozen_string_literal: true

require 'dependencies/apt'

RSpec.describe Dependencies::Apt do
	subject { described_class.new(name) }
	let(:name) { "some-dependency" }

	describe '#met?' do
		it "calls `dpkg-query` to check if the dependency is installed" do
			expect(subject).to receive(:execute).with(/^dpkg-query .*/)
			subject.met?
		end
	end

	describe '#meet' do
		it "calls apt-get to install the package" do
			expect(subject).to receive(:execute).with("apt-get install -y some-dependency")
			subject.meet
		end
	end

	describe '#unmeet' do
		it "returns true" do
			expect(subject.unmeet).to be true
		end
	end

	describe '#should_meet?' do
		let(:result) { subject.should_meet? }

		before do
			allow(subject).to receive(:`).with("uname").and_return(uname)
		end

		context "Darwin kernel is running" do
			let(:uname) { "Darwin\n" }

			it "returns true" do
				expect(result).to be false
			end
		end

		context "Linux kernel is running" do
			let(:uname) { "Linux\n" }

			it "returns false" do
				expect(result).to be true
			end
		end
	end
end
