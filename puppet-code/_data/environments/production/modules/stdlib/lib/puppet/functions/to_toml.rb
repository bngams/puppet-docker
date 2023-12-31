# frozen_string_literal: true

# THIS FILE WAS GENERATED BY `rake regenerate_unamespaced_shims`

# @summary DEPRECATED.  Use the namespaced function [`stdlib::to_toml`](#stdlibto_toml) instead.
Puppet::Functions.create_function(:to_toml) do
  dispatch :deprecation_gen do
    repeated_param 'Any', :args
  end
  def deprecation_gen(*args)
    call_function('deprecation', 'to_toml', 'This function is deprecated, please use stdlib::to_toml instead.')
    call_function('stdlib::to_toml', *args)
  end
end
