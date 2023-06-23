class lamp ($params_overrides = {}) inherits lamp::params {
  # merge $params_overrides $lamp::params
  include lamp::apache
  # include lamp::db
  # instead include class ('lamp::db':) {}	
}
