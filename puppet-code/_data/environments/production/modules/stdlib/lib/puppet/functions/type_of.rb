# frozen_string_literal: true

# THIS FILE WAS GENERATED BY `rake regenerate_unamespaced_shims`

# @summary DEPRECATED.  Use the namespaced function [`stdlib::type_of`](#stdlibtype_of) instead.
Puppet::Functions.create_function(:type_of) do
  dispatch :deprecation_gen do
    repeated_param 'Any', :args
  end
  def deprecation_gen(*args)
    call_function('deprecation', 'type_of', 'This function is deprecated, please use stdlib::type_of instead.')
    call_function('stdlib::type_of', *args)
  end
end
