# frozen_string_literal: true

require "require_all"
require_rel "../dependencies"

require_relative "../builtin"
require_relative "helpers/dependency_handler"

module Builtins
	class Up < Builtin
		def run
			# TODO: return a success/failure status to the caller
			meet_dependencies
		end

		private

		def dependency_handler
			Helpers::DependencyHandler.new(@config["dependencies"])
		end

		def meet_dependencies
			dependency_handler.dependencies.each do |dependency|
				if dependency.met?
					puts "#{dependency.type} dependency '#{dependency.name}' already met; skipping..."
				else
					puts "Meeting #{dependency.type} dependency '#{dependency.name}'..."
					puts "Failed to meet dependency '#{dependency.name}'!" unless dependency.meet
				end
			end
		end
	end
end
