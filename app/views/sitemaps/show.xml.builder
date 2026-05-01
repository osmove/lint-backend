xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'

base = 'https://lint.to'
now = Time.zone.today.iso8601

pages = [
  ['/',          '1.0', 'weekly'],
  ['/features',  '0.9', 'monthly'],
  ['/apps',      '0.8', 'monthly'],
  ['/pricing',   '0.9', 'monthly'],
  ['/security',  '0.7', 'yearly'],
  ['/downloads', '0.9', 'weekly'],
  ['/about',     '0.6', 'monthly'],
  ['/faq',       '0.6', 'monthly'],
  ['/contact',   '0.7', 'monthly'],
  ['/terms',     '0.3', 'yearly'],
  ['/privacy',   '0.3', 'yearly']
]

xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  pages.each do |path, priority, changefreq|
    xml.url do
      xml.loc(base + path)
      xml.lastmod(now)
      xml.changefreq(changefreq)
      xml.priority(priority)
    end
  end
end
