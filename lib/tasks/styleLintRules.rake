namespace :styleLint do
  desc 'Generate Rules'

  task generate: :environment do
    styleLint = Linter.where(name: 'StyleLint', command: 'stylelint').first
    styleLint = Linter.create(name: 'StyleLint', command: 'stylelint') if styleLint.blank?

    Rule.create(name: 'No invalid hex colors', slug: 'color-no-invalid-hex',
                description: 'Longhand hex colors can be either 6 or 8 (with alpha channel) hexadecimal characters. And their shorthand variants are 3 and 4 characters respectively.', type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow duplicate font family names',
                slug: 'font-family-no-duplicate-names', description: 'This rule prevents from using duplicate font family names.This rule ignores $sass, @less, and var(--custom-property) variable syntaxes.', type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow missing generic families',
                slug: 'font-family-no-missing-generic-family-keyword', description: 'This rule checks the font and font-family properties. Those must have generic family name specified', type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow an unspaced operator within calc functions',
                slug: 'function-calc-no-unspaced-operator', description: 'Before the operator, there must be a single whitespace or a newline plus indentation. After the operator, there must be a single whitespace or a newline.', type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow gradients non valid direction values',
                slug: 'function-linear-gradient-no-nonstandard-direction', description: "A valid and standard direction value is one of the following: -an angle \n-to plus a side-or-corner (to top, to bottom, to left, to right; to top right, to right top, to bottom left, etc.) A common mistake (matching outdated non-standard syntax) is to use just a side-or-corner without the preceding to.", type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow (unescaped) newlines in strings', slug: 'string-no-newline',
                description: 'In css a string cannot directly contain a newline. To include a newline in a string, use an escape representing the line feed character in ISO-10646 (U+000A), such as "\\A" or "\\00000a". A backslash is also valid.', type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow unknown units', slug: 'unit-no-unknown',
                description: "This rule considers valid units the ones defined in the CSS Specifications, up to and including Editor's Drafts, to be known.", type: 'Possible errors', linter: styleLint)

    propertyNoUnknown = Rule.create(name: 'Disallow unknown properties', slug: 'property-no-unknown',
                                    description: 'This rule considers properties defined in the CSS Specifications and browser specific properties to be known.This rule ignores variables ($sass, @less, --custom-property).', options: 'false', type: 'Possible errors', linter: styleLint)
    RuleOption.create(name: 'Check Prefixed', slug: 'checkPrefixed', value: '',
                      description: 'If true, this rule will check vendor-prefixed properties.(default: false)', value_type: 'boolean', units: '', condition_value: '', rule: propertyNoUnknown)

    Rule.create(name: 'Disallow "!important" within keyframe declarations',
                slug: 'keyframe-declaration-no-important', description: 'Using "!important" within keyframes declarations is completely ignored in some browsers.', type: 'Possible errors', linter: styleLint)

    declarationBlockNoDuplicateProperties = Rule.create(
      name: 'Disallow duplicate properties within declaration blocks', slug: 'declaration-block-no-duplicate-properties', description: 'Prevent using twice the same property in a block.', type: 'Possible errors', linter: styleLint
    )
    declarationBlockNoDuplicatePropertiesOption = RuleOption.create(name: 'Ignore', slug: 'ignore', value: '',
                                                                    description: 'Ignore either consecutive duplicated properties or when they have different values', value_type: 'array-multiple', units: '', condition_value: '', rule: declarationBlockNoDuplicateProperties)
    RuleOptionOption.create(
      rule_option: declarationBlockNoDuplicatePropertiesOption, value: 'consecutive-duplicates'
    )
    RuleOptionOption.create(
      rule_option: declarationBlockNoDuplicatePropertiesOption, value: 'consecutive-duplicates-with-different-values'
    )

    Rule.create(
      name: 'Disallow shorthand properties that override related longhand properties', slug: 'declaration-block-no-shorthand-property-overrides', description: 'In almost every case, this is just an authorial oversight.', type: 'Possible errors', linter: styleLint
    )

    Rule.create(name: 'Disallow empty blocks', slug: 'block-no-empty',
                description: 'Prevent empty block.', type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow unknown pseudo-class selectors',
                slug: 'selector-pseudo-class-no-unknown', description: "This rule considers pseudo-class selectors defined in the CSS Specifications, up to and including Editor's Drafts, to be known.", type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow unknown pseudo-element selectors',
                slug: 'selector-pseudo-element-no-unknown', description: "This rule considers pseudo-element selectors defined in the CSS Specifications, up to and including Editor's Drafts, to be known. This rule ignores vendor-prefixed pseudo-element selectors.", type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow unknown type selectors', slug: 'selector-type-no-unknown',
                description: 'This rule considers tags defined in the HTML, SVG, and MathML specifications to be known.', type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow unknown media feature names',
                slug: 'media-feature-name-no-unknown', description: "This rule considers media feature names defined in the CSS Specifications, up to and including Editor's Drafts, to be known.", type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow unknown at-rules', slug: 'at-rule-no-unknown',
                description: "This rule considers at-rules defined in the CSS Specifications, up to and including Editor's Drafts, to be known.", type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow empty comments', slug: 'comment-no-empty',
                description: 'This rule ignores comments within selector and value lists.', type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow empty comments', slug: 'comment-no-empty',
                description: 'This rule ignores comments within selector and value lists.', type: 'Possible errors', linter: styleLint)

    Rule.create(
      name: 'Disallow selectors of lower specificity from coming after overriding selectors of higher specificity', slug: 'no-descending-specificity', description: "Stylesheets are most legible when overriding selectors always come after the selectors they override. That way both mechanisms, source order and specificity, work together nicely. This rule enforces that practice as best it can. (It cannot catch every actual overriding selector (because it does not know the DOM structure, for one), but it can catch certain common mistakes.) Here's how it works: This rule looks at the last compound selector in every full selector, and then compares it with other selectors in the stylesheet that end in the same way.", type: 'Possible errors', linter: styleLint
    )

    Rule.create(name: 'Disallow duplicate @import rules within a stylesheet',
                slug: 'no-duplicate-at-import-rules', description: 'This rule ignores comments within selector and value lists.', type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow duplicate selectors within a stylesheet',
                slug: 'no-duplicate-selectors', description: "This rule checks for two types of duplication: Duplication of a single selector with a rule's selector list, e.g. a, b, a {}. Duplication of a selector list within a stylesheet, e.g. a, b {} a, b {}. Duplicates are found even if the selectors come in different orders or have different spacing, e.g. a d, b > c {} b>c, a d {}. The same selector is allowed to repeat in the following circumstances: It is used in different selector lists, e.g. a {} a, b {}. The duplicates are determined to originate in different stylesheets, e.g. you have concatenated or compiled files in a way that produces sourcemaps for PostCSS to read, e.g. postcss-import). The duplicates are in rules with different parent nodes, e.g. inside and outside of a media query. This rule resolves nested selectors. So a b {} a { & b {} } counts as a violation, because the resolved selectors end up with a duplicate.", type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow empty sources', slug: 'no-empty-source',
                description: 'A source containing only whitespace is considered empty.', type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow extra semicolons', slug: 'no-extra-semicolons',
                description: 'This rule ignores semicolons after Less mixins.', fixable: true, type: 'Possible errors', linter: styleLint)

    Rule.create(name: 'Disallow double-slash comments',
                slug: 'no-invalid-double-slash-comments', description: 'Double-slash comments (//...) are not supported by CSS and could lead to unexpected results.If you are using a preprocessor that allows // single-line comments (e.g. Sass, Less, Stylus), this rule will not complain about those. They are compiled into standard CSS comments by your preprocessor, so stylelint will consider them valid. This rule only complains about the lesser-known method of using // to "comment out" a single line of code in regular CSS. ', fixable: true, type: 'Possible errors', linter: styleLint)
  end
end
