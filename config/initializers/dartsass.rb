Rails.application.config.dartsass.build_options += [
  '--quiet-deps',
  '--silence-deprecation=import',
  '--silence-deprecation=if-function',
  '--silence-deprecation=global-builtin',
  '--silence-deprecation=color-functions'
]
