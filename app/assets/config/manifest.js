//= link_tree ../images
//= link_directory ../javascripts .js
//= link_tree ../builds
// Stylesheets compiled by dartsass-rails (legacy app overrides) and
// tailwindcss-rails (app-wide framework) both land in ../builds —
// linking that tree once is enough. The legacy
// `link_directory ../stylesheets .css` was double-linking
// application.css against the dartsass output.
