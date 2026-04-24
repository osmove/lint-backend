namespace :platforms do
  desc 'Generate Platforms'

  task generate: :environment do
    Platform.delete_all
    Framework.delete_all
    Language.delete_all

    c = Language.create(name: 'C', slug: 'c', image_url: '/images/platformicons/svg/c.svg')
    cplusplus = Language.create(name: 'C++', slug: 'cplusplus', image_url: '/images/platformicons/svg/cplusplus.svg')
    csharp = Language.create(name: 'C#', slug: 'csharp', image_url: '/images/platformicons/svg/csharp.svg')
    html = Language.create(name: 'HTML', slug: 'html', image_url: '/images/platformicons/svg/HTML5.svg')
    go = Language.create(name: 'Go', slug: 'go', image_url: '/images/platformicons/svg/go.svg')
    java = Language.create(name: 'Java', slug: 'java', image_url: '/images/platformicons/svg/java.svg')
    javascript = Language.create(name: 'Javascript', slug: 'javascript',
                                 image_url: '/images/platformicons/svg/javascript.svg')
    # nodejs = Language.create(name: 'NodeJS', slug: 'nodejs', image_url: '/images/platformicons/svg/nodejs.svg')
    perl = Language.create(name: 'Perl', slug: 'perl', image_url: '/images/platformicons/svg/perl.svg')
    php = Language.create(name: 'PHP', slug: 'php', image_url: '/images/platformicons/svg/php.svg')
    python = Language.create(name: 'Python', slug: 'python', image_url: '/images/platformicons/svg/python.svg')
    ruby = Language.create(name: 'Ruby', slug: 'ruby', image_url: '/images/platformicons/svg/ruby.svg')
    Language.create(name: 'Rust', slug: 'rust', image_url: '/images/platformicons/svg/rust.svg')
    swift = Language.create(name: 'Swift', slug: 'swift', image_url: '/images/platformicons/svg/swift.svg')
    objective_c = Language.create(name: 'Objective-C', slug: 'objective-c',
                                  image_url: '/images/platformicons/svg/objective-c.svg')

    angularjs = Framework.create(name: 'Angular', slug: 'angularjs', language: javascript,
                                 image_url: '/images/platformicons/svg/angularjs.svg')
    cordova = Framework.create(name: 'Cordova', slug: 'cordova', image_url: '/images/platformicons/cordova.svg')
    electron = Framework.create(name: 'Electron', slug: 'electron', language: javascript,
                                image_url: '/images/platformicons/svg/electron.svg')
    django = Framework.create(name: 'Django', slug: 'django', language: python,
                              image_url: '/images/platformicons/svg/django.svg')
    dotnet = Framework.create(name: '.NET', slug: 'dotnet', language: csharp,
                              image_url: '/images/platformicons/svg/dotnet.svg')
    ember = Framework.create(name: 'Ember', slug: 'ember', language: javascript,
                             image_url: '/images/platformicons/svg/ember.svg')
    flask = Framework.create(name: 'Flask', slug: 'flask', image_url: '/images/platformicons/svg/flask.svg')
    laravel = Framework.create(name: 'Laravel', slug: 'laravel', language: php,
                               image_url: '/images/platformicons/svg/laravel.svg')
    rails = Framework.create(name: 'Rails', slug: 'rails', language: ruby,
                             image_url: '/images/platformicons/svg/rails.svg')
    symfony = Framework.create(name: 'Symfony', slug: 'symfony', language: php,
                               image_url: '/images/platformicons/svg/symfony.svg')
    react = Framework.create(name: 'React', slug: 'react', language: javascript,
                             image_url: '/images/platformicons/svg/react.svg')
    react_native = Framework.create(name: 'React Native', slug: 'react-native', language: javascript,
                                    image_url: '/images/platformicons/svg/react-native.svg')
    vue = Framework.create(name: 'Vue', slug: 'vue', language: javascript,
                           image_url: '/images/platformicons/svg/vue.svg')

    Platform.create(name: 'App Engine', slug: 'app-engine', image_url: '/images/platformicons/svg/app-engine.svg')
    Platform.create(name: 'Angular', slug: 'angularjs', language: javascript, framework: angularjs,
                    image_url: '/images/platformicons/svg/angularjs.svg')
    Platform.create(name: 'C', slug: 'c', language: c, image_url: '/images/platformicons/svg/c.svg')
    Platform.create(name: 'C++', slug: 'cplusplus', language: cplusplus,
                    image_url: '/images/platformicons/svg/cplusplus.svg')
    Platform.create(name: 'C#', slug: 'csharp', language: csharp, image_url: '/images/platformicons/svg/csharp.svg')
    Platform.create(name: 'Cordova', slug: 'cordova', framework: cordova,
                    image_url: '/images/platformicons/svg/cordova.svg')
    Platform.create(name: 'Ember', slug: 'ember', framework: ember, image_url: '/images/platformicons/svg/ember.svg')
    Platform.create(name: 'Electron', slug: 'electron', language: javascript, framework: electron,
                    image_url: '/images/platformicons/svg/electron.svg')
    Platform.create(name: '.NET', slug: 'dotnet', framework: dotnet, image_url: '/images/platformicons/svg/dotnet.svg')
    Platform.create(name: 'Django', slug: 'django', language: python, framework: django,
                    image_url: '/images/platformicons/svg/django.svg')
    Platform.create(name: 'Flask', slug: 'flask', framework: flask, image_url: '/images/platformicons/svg/flask.svg')
    Platform.create(name: 'Go', slug: 'go', language: go, image_url: '/images/platformicons/svg/go.svg')
    Platform.create(name: 'HTML', slug: 'html', language: html, image_url: '/images/platformicons/svg/HTML5.svg')
    Platform.create(name: 'Java', slug: 'java', language: java, image_url: '/images/platformicons/svg/java.svg')
    Platform.create(name: 'Javascript', slug: 'javascript', language: javascript,
                    image_url: '/images/platformicons/svg/javascript.svg')
    Platform.create(name: 'Laravel', slug: 'laravel', language: php, framework: laravel,
                    image_url: '/images/platformicons/svg/laravel.svg')
    Platform.create(name: 'NodeJS', slug: 'nodejs', language: javascript,
                    image_url: '/images/platformicons/svg/nodejs.svg')
    Platform.create(name: 'Objective-C', slug: 'objective-c', language: objective_c,
                    image_url: '/images/platformicons/svg/objective-c.svg')
    Platform.create(name: 'Perl', slug: 'perl', language: perl, image_url: '/images/platformicons/svg/perl.svg')
    Platform.create(name: 'PHP', slug: 'php', language: php, image_url: '/images/platformicons/svg/php.svg')
    Platform.create(name: 'Rust', slug: 'rust', image_url: '/images/platformicons/svg/rust.svg')
    Platform.create(name: 'Python', slug: 'python', language: python, image_url: '/images/platformicons/svg/python.svg')
    Platform.create(name: 'Ruby', slug: 'ruby', language: ruby, image_url: '/images/platformicons/svg/ruby.svg')
    Platform.create(name: 'Rails', slug: 'rails', language: ruby, framework: rails,
                    image_url: '/images/platformicons/svg/rails.svg')
    Platform.create(name: 'React', slug: 'react', language: javascript, framework: react,
                    image_url: '/images/platformicons/svg/react.svg')
    Platform.create(name: 'React Native', slug: 'react-native', language: javascript, framework: react_native,
                    image_url: '/images/platformicons/svg/react-native.svg')
    Platform.create(name: 'Swift', slug: 'swift', language: swift, image_url: '/images/platformicons/svg/swift.svg')
    Platform.create(name: 'Symfony', slug: 'symfony', language: php, framework: symfony,
                    image_url: '/images/platformicons/svg/symfony.svg')
    Platform.create(name: 'Vue', slug: 'vue', language: javascript, framework: vue,
                    image_url: '/images/platformicons/svg/vue.svg')
    Platform.create(name: 'Other', slug: '', image_url: '/images/platformicons/svg/generic.svg')
  end
end
