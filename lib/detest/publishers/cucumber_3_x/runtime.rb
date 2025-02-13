require "cucumber/runtime"

module Detest
  module Publishers
    module Cucumber
      class Runtime < ::Cucumber::Runtime
        def run!(adapter)
          load_step_definitions
          install_wire_plugin
          fire_after_configuration_hook

          adapter.enqueue(feature_file_paths)
        end

        def feature_file_paths
          our_cwd = Dir.pwd
          feature_files.map do |s_file|
            s_path = Pathname(s_file)
            if s_path.absolute?
              s_path.relative_path_from(our_cwd).to_s
            else
              s_full_path = Pathname(our_cwd) + s_path
              s_full_path.relative_path_from(our_cwd).to_s
            end
          end
        end
      end
    end
  end
end
