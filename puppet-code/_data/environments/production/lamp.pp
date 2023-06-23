# include lamp

class { 'lamp':
  params_overrides => {
    'db_root_password' => 'new_password',
  },
}
