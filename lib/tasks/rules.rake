namespace :rules do

  desc "Generate Rules"

  task generate: :environment do
    # RuleOptionOption.delete_all
    # PolicyRuleOptionOption.delete_all
    # PolicyRuleOption.delete_all
    # RuleOption.delete_all
    # PolicyRule.delete_all
    # Repository.update_all(policy_id: nil)
    # RuleCheck.delete_all
    # PolicyCheck.delete_all
    # Rule.delete_all
    # Linter.delete_all
    # Policy.delete_all

    # eslint = Linter.create(name: "ESlint", command: "eslint")
    # rubocop = Linter.create(name: "Rubocop", command: "rubocop")
    # prettier = Linter.create(name: "Prettier", command: "prettier")
    eslint = Linter.where(name: "ESlint", command: "eslint").first
    rubocop = Linter.where(name: "Rubocop", command: "rubocop").first
    prettier = Linter.where(name: "Prettier", command: "prettier").first

    if !eslint.present?
      eslint = Linter.create(name: "ESlint", command: "eslint")
    end

    if !rubocop.present?
      rubocop = Linter.create(name: "Rubocop", command: "rubocop")
    end

    if !prettier.present?
      prettier = Linter.create(name: "Prettier", command: "prettier")
    end
    #Prettier rules
    printWidth = Rule.create(name: "Print Width", slug: "printWidth", description: "Specify the line length that the printer will wrap on.", options: "80", type: "Formatting", linter: prettier)
    RuleOption.create( name: "line length", slug: "printWidth", value: "", value_type: "integer", units: "", condition_value: "" , rule: printWidth)
    tabWidth = Rule.create(name: "Tab Width", slug: "tabWidth", description: "Specify the number of spaces per indentation-level.", options: "2", type: "Formatting", linter: prettier)
    RuleOption.create( name: "tab width", slug: "tabWidth", value: "", value_type: "integer", units: "", condition_value: "" , rule: tabWidth)
    useTabs = Rule.create(name: "Tabs", slug: "useTabs", description: "Indent lines with tabs instead of spaces.", options: "false", type: "Formatting", linter: prettier)
    RuleOption.create( name: "Tabs", slug: "useTabs", value: "", value_type: "boolean", units: "", condition_value: "" , rule: useTabs)

    quotes = Rule.create(name: "Quotes", slug: "singleQuote", description: "Use single quotes instead of double quotes.", options: "false", type: "Formatting", linter: prettier)
    RuleOption.create( name: "Quotes", slug: "singleQuote", value: "", value_type: "boolean", units: "", condition_value: "" , rule: quotes)

    jsxQuotes = Rule.create(name: "JSX Quotes", slug: "jsxSingleQuote", description: "Use single quotes instead of double quotes in JSX.", options: "false", type: "Formatting", linter: prettier)
    RuleOption.create( name: "JSX Quotes", slug: "jsxSingleQuote", value: "", value_type: "boolean", units: "", condition_value: "" , rule: jsxQuotes)

    trailingComma = Rule.create(name: "Trailing Commas", slug: "trailingComma", description: "Print trailing commas wherever possible when multi-line. (A single-line array, for example, never gets trailing commas.)", options: "none", type: "Formatting", linter: prettier)
    trailingCommaOption = RuleOption.create( name: "Trailing Commas", slug: "trailingComma", value: "", value_type: "array-single", units: "", description: "Valid options:\n \"none\" - No trailing commas.\n \"es5\" - Trailing commas where valid in ES5 (objects, arrays, etc.)\n \"all\" - Trailing commas wherever possible (including function arguments). This requires node 8 or a transform.", condition_value: "" , rule: trailingComma)
    RuleOptionOption.create(rule_option: trailingCommaOption, value: "none")
    RuleOptionOption.create(rule_option: trailingCommaOption, value: "es5")
    RuleOptionOption.create(rule_option: trailingCommaOption, value: "all")


    bracketSpacing = Rule.create(name: "Bracket Spacing", slug: "bracketSpacing", description: "Indent lines with tabs instead of spaces.", options: "true", type: "Formatting", linter: prettier)
    RuleOption.create( name: "bracketSpacing", slug: "bracketSpacing", value: "", value_type: "boolean", units: "", condition_value: "" , rule: bracketSpacing)

    jsxBracketSameLine = Rule.create(name: "JSX Brackets", slug: "jsxBracketSameLine", description: "Put the > of a multi-line JSX element at the end of the last line instead of being alone on the next line (does not apply to self closing elements).", options: "false", type: "Formatting", linter: prettier)
    RuleOption.create( name: "JSX Brackets", slug: "jsxBracketSameLine", value: "", value_type: "boolean", units: "", condition_value: "" , rule: jsxBracketSameLine)


    arrowParens = Rule.create(name: "Arrow Function Parentheses", slug: "arrowParens", description: "Include parentheses around a sole arrow function parameter.", options: "avoid", type: "Formatting", linter: prettier)
    arrowParensOption = RuleOption.create( name: "Arrow Function Parentheses", slug: "arrowParens", value: "", value_type: "array-single", units: "", condition_value: "", description: "Valid options:\n \"avoid\" - Omit parens when possible. Example: x => x\n \"always\" - Always include parens. Example: (x) => x" , rule: arrowParens)
    RuleOptionOption.create(rule_option: arrowParensOption, value: "avoid")
    RuleOptionOption.create(rule_option: arrowParensOption, value: "always")


    requirePragma = Rule.create(name: "Require pragma", slug: "requirePragma", description: "Prettier can restrict itself to only format files that contain a special comment, called a pragma, at the top of the file. This is very useful when gradually transitioning large, unformatted codebases to prettier.\n Example:\n /**\n * @prettier\n */\n", options: "false", type: "Formatting", linter: prettier)
    RuleOption.create( name: "Require pragma", slug: "useTabs", value: "", value_type: "boolean", units: "", condition_value: "" , rule: requirePragma)

    insertPragma = Rule.create(name: "Insert Pragma", slug: "insertPragma", description: "Prettier can insert a special @format marker at the top of files specifying that the file has been formatted with prettier. If there is already a docblock at the top of the file then this option will add a newline to it with the @format marker.", options: "false", type: "Formatting", linter: prettier)
    RuleOption.create( name: "Insert Pragma", slug: "insertPragma", value: "", value_type: "boolean", units: "", condition_value: "" , rule: insertPragma)

    proseWrap = Rule.create(name: "Prose Wrap", slug: "proseWrap", description: "By default, Prettier will wrap markdown text as-is since some services use a linebreak-sensitive renderer, e.g. GitHub comment and BitBucket.", type: "Formatting", linter: prettier)
    proseWrapOption = RuleOption.create( name: "Prose Wrap", slug: "proseWrap", value: "", value_type: "array-single", units: "", condition_value: "", rule: proseWrap)
    RuleOptionOption.create(rule_option: proseWrapOption, value: "preserve")
    RuleOptionOption.create(rule_option: proseWrapOption, value: "never")
    RuleOptionOption.create(rule_option: proseWrapOption, value: "always")



    htmlWhitespaceSensitivity = Rule.create(name: "HTML Whitespace Sensitivity", slug: "htmlWhitespaceSensitivity", description: "Specify the global whitespace sensitivity for HTML files.", type: "Formatting", linter: prettier)
    htmlWhitespaceSensitivityOption = RuleOption.create( name: "HTML Whitespace Sensitivity", slug: "htmlWhitespaceSensitivity", value: "", value_type: "array-single", units: "", condition_value: "", description: "\"css\" - Respect the default value of CSS display property.\n \"strict\" - Whitespaces are considered sensitive.\n \"ignore\" - Whitespaces are considered insensitive.\n", rule: htmlWhitespaceSensitivity)
    RuleOptionOption.create(rule_option: htmlWhitespaceSensitivityOption, value: "css")
    RuleOptionOption.create(rule_option: htmlWhitespaceSensitivityOption, value: "strict")
    RuleOptionOption.create(rule_option: htmlWhitespaceSensitivityOption, value: "ignore")

    endOfLine = Rule.create(name: "End of Line", slug: "endOfLine", description: "For historical reasons, there exist two commonly used flavors of line endings in text files. That is \n (or LF for Line Feed) and \r\n (or CRLF for Carriage Return + Line Feed). The former is common on Linux and macOS, while the latter is prevalent on Windows. Some details explaining why it is so can be found on Wikipedia.\n\n By default, Prettier preserves a flavor of line endings a given file has already used. It also converts mixed line endings within one file to what it finds at the end of the first line.\n\n When people collaborate on a project from different operating systems, it becomes easy to end up with mixed line endings in the central git repository. It is also possible for Windows users to accidentally change line endings in an already committed file from LF to CRLF. Doing so produces a large git diff, and if it get unnoticed during code review, all line-by-line history for the file (git blame) gets lost.", type: "Formatting", linter: prettier)
    endOfLineOption = RuleOption.create( name: "End of Line", slug: "endOfLine", value: "", value_type: "array-single", units: "", condition_value: "", description: "\"auto\" - Maintain existing line endings (mixed values within one file are normalised by looking at what's used after the first line)\n \"lf\" – Line Feed only, common on Linux and macOS as well as inside git repos\n \"crlf\" - Carriage Return + Line Feed characters, common on Windows\n \"cr\" - Carriage Return character only, used very rarely\n", rule: endOfLine)
    RuleOptionOption.create(rule_option: endOfLineOption, value: "auto")
    RuleOptionOption.create(rule_option: endOfLineOption, value: "lf")
    RuleOptionOption.create(rule_option: endOfLineOption, value: "crlf")
    RuleOptionOption.create(rule_option: endOfLineOption, value: "cr")


    #ESLint Rules
    ##Possible Error
    forDirection = Rule.create(name: "Enforce loop right direction", slug: "for-direction", description: "A for loop with a stop condition that can never be reached, such as one with a counter that moves in the wrong direction, will run infinitely. While there are occasions when an infinite loop is intended, the convention is to construct such loops as while loops. More typically, an infinite for loop is a bug.", type: "Possible Errors", linter: eslint)
    getterReturn = Rule.create(name: "Enforce return in getters", slug: "getter-return", description: "This rule enforces that a return statement is present in property getters.", options: "false", type: "Possible Errors", linter: eslint)
    getterReturnOption = RuleOption.create( name: "Allow implicitly returning undefined", slug: "allowImplicit", value: "", value_type: "boolean", description: "Allow/disallows implicitly returning undefined with a return statement", units: "", condition_value: "", rule: getterReturn)
    noAsyncPromiseExecutor = Rule.create(name: "No async function as a Promise executor", slug: "no-async-promise-executor", description: "This rule aims to disallow async Promise executor functions.", type: "Possible Errors", linter: eslint)
    noAwaitInLoop = Rule.create(name: "Disallow await inside of loops", slug: "no-await-in-loop", description: "Performing an operation on each element of an iterable is a common task. However, performing an await as part of each operation is an indication that the program is not taking full advantage of the parallelization benefits of async/await.\n\nUsually, the code should be refactored to create all the promises at once, then get access to the results using Promise.all(). Otherwise, each successive operation will not start until the previous one has completed.\n\nThis rule disallows the use of await within loop bodies.", type: "Possible Errors", linter: eslint)
    noCompareNegZero = Rule.create(name: "Prevent comparing against -0", slug: "no-compare-neg-zero", description: "The rule should warn against code that tries to compare against -0, since that will not work as intended. That is, code like x === -0 will pass for both +0 and -0. The author probably intended Object.is(x, -0).", type: "Possible Errors", linter: eslint)
    noCondAssign = Rule.create(name: "No operators in conditions", slug: "no-cond-assign", description: "This rule disallows ambiguous assignment operators in test conditions of if, for, while, and do...while statements.", type: "Possible Errors", linter: eslint)
    noCondAssignOption = RuleOption.create( name: "No operators in conditions", slug: "no-cond-assign", value: "", value_type: "array-single", description: "\"except-parens\" (default) allows assignments in test conditions only if they are enclosed in parentheses (for example, to allow reassigning a variable in the test of a while or do...while loop)\n\"always\" disallows all assignments in test conditions", units: "", condition_value: "", rule: noCondAssign)
    RuleOptionOption.create(rule_option: noCondAssignOption, value: "except-parens")
    RuleOptionOption.create(rule_option: noCondAssignOption, value: "always")
    noConsole = Rule.create(name: "No Console Message", slug: "no-console", description: "This rule disallows constant expressions in the test condition of:\n if, for, while, or do...while statement ?: ternary expression", type: "Possible Errors", linter: eslint)
    noConsoleOption = RuleOption.create( name: "Allow certain message", slug: "allow", value: "", value_type: "array-multiple", description: "Allow console message types", units: "", condition_value: "", rule: noConsole)
    RuleOptionOption.create(rule_option: noConsoleOption, value: "log")
    RuleOptionOption.create(rule_option: noConsoleOption, value: "warn")
    RuleOptionOption.create(rule_option: noConsoleOption, value: "error")

    noConstantCondition = Rule.create(name: "No constant expression as a test condition", slug: "no-constant-condition", description: "A constant expression (for example, a literal) as a test condition might be a typo or development trigger for a specific behavior. ", type: "Possible Errors", options: "true", linter: eslint)
    noConstantConditionOption = RuleOption.create( name: "checkLoops", slug: "checkLoops", value: "", value_type: "boolean", description: "Set to true by default. Setting this option to false allows constant expressions in loops.", units: "", condition_value: "", rule: noConstantCondition)

    noControlRegex = Rule.create(name: "No Control Regex", slug: "no-control-regex", description: "Control characters are special, invisible characters in the ASCII range 0-31. These characters are rarely used in JavaScript strings so a regular expression containing these characters is most likely a mistake.", type: "Possible Errors", linter: eslint)
    noDebugger = Rule.create(name: "No debugger", slug: "no-debugger", description: "The debugger statement is used to tell the executing JavaScript environment to stop execution and start up a debugger at the current point in the code. This has fallen out of favor as a good practice with the advent of modern debugging and development tools. Production code should definitely not contain debugger, as it will cause the browser to stop executing code and open an appropriate debugger.", type: "Possible Errors", linter: eslint)
    noDupeArgs = Rule.create(name: "No duplicate arguments", slug: "no-dupe-args", description: "If more than one parameter has the same name in a function definition, the last occurrence “shadows” the preceding occurrences. A duplicated name might be a typing error.", type: "Possible Errors", linter: eslint)
    noDupeKeys = Rule.create(name: "No duplicate keys", slug: "no-dupe-keys", description: "Multiple properties with the same key in object literals can cause unexpected behavior in your application.", type: "Possible Errors", linter: eslint)
    noDupeCase = Rule.create(name: "No duplicate case in switch", slug: "no-duplicate-case", description: "This rule disallows duplicate test expressions in case clauses of switch statements.", type: "Possible Errors", linter: eslint)

    noEmptyBlock = Rule.create(name: "No Empty block", slug: "no-empty", description: "Empty block statements, while not technically errors, usually occur due to refactoring that wasn’t completed. They can cause confusion when reading code.", type: "Possible Errors", linter: eslint)
    noEmptyBlockOption = RuleOption.create( name: "Allow Empty Catch", slug: "allowEmptyCatch", value: "", value_type: "boolean", description: "\"allowEmptyCatch\": true allows empty catch clauses (that is, which do not contain a comment).", units: "", condition_value: "", rule: noEmptyBlock)

    noEmptyCharacterClass = Rule.create(name: "No empty character classes in regular expressions", slug: "no-empty-character-class", description: "Because empty character classes in regular expressions do not match anything, they might be typing mistakes. This rule does not report empty character classes in the string argument of calls to the RegExp constructor.", type: "Possible Errors", linter: eslint)


    noExAssign = Rule.create(name: "Disallow reassigning exceptions in catch clauses", slug: "no-ex-assign", description: "If a catch clause in a try statement accidentally (or purposely) assigns another value to the exception parameter, it impossible to refer to the error from that point on. Since there is no arguments object to offer alternative access to this data, assignment of the parameter is absolutely destructive.", fixable: true, type: "Possible Errors", linter: eslint)


    noExtraBooleanCast = Rule.create(name: "Disallow unnecessary boolean casts", slug: "no-extra-boolean-cast", description: "In contexts such as an if statement’s test where the result of the expression will already be coerced to a Boolean, casting to a Boolean via double negation (!!) or a Boolean call is unnecessary.", fixable: true, type: "Possible Errors", linter: eslint)

    noFuncAssign = Rule.create(name: "Disallow reassigning function declarations", slug: "no-func-assign", description: "JavaScript functions can be written as a FunctionDeclaration function foo() { ... } or as a FunctionExpression var foo = function() { ... };. While a JavaScript interpreter might tolerate it, overwriting/reassigning a function written as a FunctionDeclaration is often indicative of a mistake or issue.", type: "Possible Errors", linter: eslint)

    noInnerDeclarations = Rule.create(name: "Disallow variable or function declarations in nested blocks ", slug: "no-inner-declarations", description: "This rule requires that function declarations and, optionally, variable declarations be in the root of a program or the body of a function.", type: "Possible Errors", linter: eslint)
    noInnerDeclarationsOption = RuleOption.create( name: "Disallows function and/or variables", slug: "disallow", value: "", value_type: "array-single", description: "\"functions\" (default) disallows function declarations in nested blocks \n \n \"both\" disallows function and var declarations in nested blocks", units: "", condition_value: "", rule: noInnerDeclarations)
    RuleOptionOption.create(rule_option: noInnerDeclarationsOption, value: "functions")
    RuleOptionOption.create(rule_option: noInnerDeclarationsOption, value: "both")

    noInvalidRegexp = Rule.create(name: "Disallow invalid regexp", slug: "no-invalid-regexp", description: "An invalid pattern in a regular expression literal is a SyntaxError when the code is parsed, but an invalid string in RegExp constructors throws a SyntaxError only when the code is executed.", type: "Possible Errors", linter: eslint)
    noInvalidRegexpOption = RuleOption.create( name: "Allow flags", slug: "allowConstructorFlags", value: "", value_type: "array-multiple", description: "\"u\" (unicode) \n \"y\" (sticky)", units: "", condition_value: "", rule: noInvalidRegexp)
    RuleOptionOption.create(rule_option: noInvalidRegexpOption, value: "u")
    RuleOptionOption.create(rule_option: noInvalidRegexpOption, value: "y")

    noIrregularWhitespace = Rule.create(name: "No irregular whitespace", slug: "no-irregular-whitespace", description: "This rule is aimed at catching invalid whitespace that is not a normal tab and space. Some of these characters may cause issues in modern browsers and others will be a debugging issue to spot.", type: "Possible Errors", linter: eslint)
    noIrregularWhitespaceOptionSkipStrings = RuleOption.create( name: "Skip in strings", slug: "skipStrings", value: "", value_type: "boolean", description: "allows any whitespace characters in string literals", units: "", condition_value: "", rule: noIrregularWhitespace)
    noIrregularWhitespaceOptionSkipComments = RuleOption.create( name: "Skip in comments", slug: "skipComments", value: "", value_type: "boolean", description: "allows any whitespace characters in comments", units: "", condition_value: "", rule: noIrregularWhitespace)
    noIrregularWhitespaceOptionSkipRegExps = RuleOption.create( name: "Skip in regular expression", slug: "skipRegExps", value: "", value_type: "boolean", description: "allows any whitespace characters in regular expression literals", units: "", condition_value: "", rule: noIrregularWhitespace)
    noIrregularWhitespaceOptionSkipTemplates = RuleOption.create( name: "Skip in template", slug: "skipTemplates", value: "", value_type: "boolean", description: "allows any whitespace characters in template literals", units: "", condition_value: "", rule: noIrregularWhitespace)


    noObjCalls = Rule.create(name: "Prevent calling objects as functions", slug: "no-obj-calls", description: "This rule disallows calling the Math, JSON and Reflect objects as functions.\nExample: var json = JSON();.", type: "Possible Errors", linter: eslint)

    noPrototypeBuiltins = Rule.create(name: "Disallow use of Object.prototypes builtins", slug: "no-prototype-builtins", description: "In ECMAScript 5.1, Object.create was added, which enables the creation of objects with a specified [[Prototype]]. Object.create(null) is a common pattern used to create objects that will be used as a Map. This can lead to errors when it is assumed that objects will have properties from Object.prototype. This rule prevents calling some Object.prototype methods directly from an object.", type: "Possible Errors", linter: eslint)

    noRegexSpaces = Rule.create(name: "Prevent multiple spaces in regular expression", slug: "no-regex-spaces", description: "This rule disallows multiple spaces in regular expression literals.", fixable: true, type: "Possible Errors", linter: eslint)

    noSparseArrays = Rule.create(name: "Disallow sparse arrays", slug: "no-sparse-arrays", description: "This rule disallows sparse array literals which have “holes” where commas are not preceded by elements. It does not apply to a trailing comma following the last element.", type: "Possible Errors", linter: eslint)

    noTemplateCurlyInString = Rule.create(name: "${variable} between two backtick quotes (\`) only", slug: "no-template-curly-in-string", description: "ECMAScript 6 allows programmers to create strings containing variable or expressions using template literals, instead of string concatenation, by writing expressions like ${variable} between two backtick quotes (\`). It can be easy to use the wrong quotes when wanting to use template literals, by writing \"${variable}\", and end up with the literal value \"${variable}\" instead of a string containing the value of the injected expressions.", type: "Possible Errors", linter: eslint)


    noUnreachable = Rule.create(name: "Disallow unreachable code", slug: "no-unreachable", description: "This rule disallows unreachable code after return, throw, continue, and break statements.", type: "Possible Errors", linter: eslint)

    noUnsafeFinally = Rule.create(name: "No flow statements in finally blocks", slug: "no-unsafe-finally", description: "JavaScript suspends the control flow statements of try and catch blocks until the execution of finally block finishes. So, when return, throw, break, or continue is used in finally, control flow statements inside try and catch are overwritten, which is considered as unexpected behavior.", type: "Possible Errors", linter: eslint)

    noUnsafeNegation = Rule.create(name: "Prevent unsafe negation", slug: "no-unsafe-negation", description: "Just as developers might type -a + b when they mean -(a + b) for the negative of a sum, they might type !key in object by mistake when they almost certainly mean !(key in object) to test that a key is not in an object. !obj instanceof Ctor is similar.", fixable: true, type: "Possible Errors", linter: eslint)

    requireAtomicUpdates = Rule.create(name: "Require Atomic Updates", slug: "require-atomic-updates", description: "Disallow assignments that can lead to race conditions due to usage of await or yield.", type: "Possible Errors", linter: eslint)

    useIsNan = Rule.create(name: "Require to call isNaN() when checking for NaN", slug: "use-isnan", description: "This rule disallows comparisons to 'NaN', and enforces using isNaN() method.", type: "Possible Errors", linter: eslint)

    validJSdoc = Rule.create(name: "Enforce valid JSDoc comments", slug: "valid-jsdoc", description: "This rule enforces valid and consistent JSDoc comments. It reports any of the following problems:\n\n missing parameter tag: @arg, @argument, or @param\n inconsistent order of parameter names in a comment compared to the function or method\n missing return tag: @return or @returns\n missing parameter or return type\n missing parameter or return description\n syntax error\n This rule does not report missing JSDoc comments for classes, functions, or methods.", fixable: true, type: "Possible Errors", linter: eslint)

    validTypeOf = Rule.create(name: "Enforce comparing typeof expressions against valid strings", slug: "valid-typeof", description: "For a vast majority of use cases, the result of the typeof operator is one of the following string literals: \"undefined\", \"object\", \"boolean\", \"number\", \"string\", \"function\" and \"symbol\". It is usually a typing mistake to compare the result of a typeof operator to other string literals.", type: "Possible Errors", linter: eslint)


    ##Best Practices

    accessorPairs = Rule.create(name: "Enforces getter/setter pairs in objects", slug: "accessor-pairs", description: "This rule enforces a style where it requires to have a getter for every property which has a setter defined. By activating the option getWithoutSet it enforces the presence of a setter for every property which has a getter defined.", type: "Best Practices", linter: eslint)
    accessorPairsSetWithoutGetOption = RuleOption.create(name: "Warn setters only", slug: "setWithoutGet", value: "", value_type: "boolean", description: "Set to true will warn for setters without getters (Default true).", units: "", condition_value: "", rule: accessorPairs)
    accessorPairsGetWithoutSetOption = RuleOption.create(name: "Warn getters only", slug: "getWithoutSet", value: "", value_type: "boolean", description: "Set to true will warn for getters without setters (Default false).", units: "", condition_value: "", rule: accessorPairs)

    arrayCallbackReturn = Rule.create(name: "Enforces getter/setter pairs in objects", slug: "array-callback-return", description: "This rule enforces a style where it requires to have a getter for every property which has a setter defined. By activating the option getWithoutSet it enforces the presence of a setter for every property which has a getter defined.", type: "Best Practices", linter: eslint)
    arrayCallbackReturnOption = RuleOption.create( name: "Allow implicitly returning undefined", slug: "allowImplicit", value: "", value_type: "boolean", description: "Allow/disallows implicitly returning undefined with a return statement", units: "", condition_value: "", rule: arrayCallbackReturn)

    blockScopedVar = Rule.create(name: "Treat var as Block Scoped", slug: "block-scoped-var", description: "The block-scoped-var rule generates warnings when variables are used outside of the block in which they were defined. This emulates C-style block scope.", type: "Best Practices", linter: eslint)

    classMethodsUseThis = Rule.create(name: "Enforce that class methods utilize this", slug: "class-methods-use-this", description: "If a class method does not use this, it can sometimes be made into a static function. If you do convert the method into a static function, instances of the class that call that particular method have to be converted to a static call as well (MyClass.callStaticMethod().", type: "Best Practices", linter: eslint)

    complexity = Rule.create(name: "Limit Cyclomatic Complexity to 20", slug: "complexity", description: "This rule is aimed at reducing code complexity by capping the amount of cyclomatic complexity allowed in a program. As such, it will warn when the cyclomatic complexity crosses the configured threshold (default is 20).", options:"20", type: "Best Practices", linter: eslint)
    # complexityOption = RuleOption.create(name: "Set Max Cyclomatic Complexity", value: "", value_type: "integer", description: "Set the maximum Cyclomatic Complexity.", units: "", condition_value: "", rule: complexity)

    consistentReturn = Rule.create(name: "Requires return statements to either always or never specify values", slug: "consistent-return", description: "This rule requires return statements to either always or never specify values. This rule ignores function definitions where the name begins with an uppercase letter, because constructors (when invoked with the new operator) return the instantiated object implicitly if they do not return another object explicitly.", options:"false", type: "Best Practices", linter: eslint)
    consistentReturnOption = RuleOption.create(name: "Always specify value", slug: "treatUndefinedAsUnspecified", value: "", value_type: "boolean", description: "true: always either specify values or return undefined explicitly or implicitly. false: (default) always either specify values or return undefined implicitly only.", units: "", condition_value: "", rule: consistentReturn)

    curly = Rule.create(name: "Require Curly Brace Conventions", slug: "curly", description: "This rule is aimed at preventing bugs and increasing code clarity by ensuring that block statements are wrapped in curly braces. It will warn when it encounters blocks that omit curly braces.", fixable: true, type: "Best Practices", linter: eslint)
    curlyOption = RuleOption.create(name: "Always specify value", slug: "treatUndefinedAsUnspecified", value: "", value_type: "array-multiple", description: "\"all\": (default) enforce all. \n \"multi\":By default, this rule warns whenever if, else, for, while, or do are used without block statements as their body. However, you can specify that block statements should be used only when there are multiple statements in the block and warn when there is only one statement in the block.\n \"multi-line\": Alternatively, you can relax the rule to allow brace-less single-line if, else if, else, for, while, or do, while still enforcing the use of curly braces for other instances.\n\"multi-or-nest\":You can use another configuration that forces brace-less if, else if, else, for, while, or do if their body contains only one single-line statement. And forces braces in all other cases.", units: "", condition_value: "", rule: curly)
    RuleOptionOption.create(rule_option: curlyOption, value: "all")
    RuleOptionOption.create(rule_option: curlyOption, value: "multi")
    RuleOptionOption.create(rule_option: curlyOption, value: "multi-line")
    RuleOptionOption.create(rule_option: curlyOption, value: "multi-or-nest")

    defaultCase = Rule.create(name: "Require default for swift statments", slug: "default-case", description: "This rule aims to require default case in switch statements. You may optionally include a // no default after the last case if there is no default case. The comment may be in any desired case, such as // No Default.", type: "Best Practices", linter: eslint)

    dotLocation = Rule.create(name: "Enforce newline before and after dot", slug: "dot-location", description: "JavaScript allows you to place newlines before or after a dot in a member expression.\nConsistency in placing a newline before or after the dot can greatly increase readability.", fixable: true, type: "Best Practices", linter: eslint)
    dotLocationOption = RuleOption.create(name: "Always specify value", slug: "treatUndefinedAsUnspecified", value: "", value_type: "array-single", description: "If it is \"object\" (default), the dot in a member expression should be on the same line as the object portion.\nIf it is \"property\", the dot in a member expression should be on the same line as the property portion.", units: "", condition_value: "", rule: dotLocation)
    RuleOptionOption.create(rule_option: dotLocationOption, value: "object")
    RuleOptionOption.create(rule_option: dotLocationOption, value: "property")

    dotNotation = Rule.create(name: "Require Dot Notation", slug: "dot-notation", description: "In JavaScript, one can access properties using the dot notation (foo.bar) or square-bracket notation (foo[\"bar\"]). However, the dot notation is often preferred because it is easier to read, less verbose, and works better with aggressive JavaScript minimizers.", fixable: true, type: "Best Practices", linter: eslint)

    eqeqeq = Rule.create(name: "Require type-safe equality operators", slug: "eqeqeq", description: "It is considered good practice to use the type-safe equality operators === and !== instead of their regular counterparts == and !=.", fixable: true, type: "Best Practices", linter: eslint)
    eqeqeqOption = RuleOption.create(name: "Always require or only on specific occasion", slug: "required", value: "", value_type: "array-single", description: "\"always\" option (default) enforces the use of === and !== in every situation.\n \"smart\" option enforces the use of === and !== except for these cases:\n\n Comparing two literal values\n Evaluating the value of typeof\n Comparing against null\n", units: "", condition_value: "", rule: eqeqeq)
    RuleOptionOption.create(rule_option: eqeqeqOption, value: "always")
    RuleOptionOption.create(rule_option: eqeqeqOption, value: "smart")

    guardForIn = Rule.create(name: "Require Guarding for-in", slug: "guard-for-in", description: "This rule is aimed at preventing unexpected behavior that could arise from using a for in loop without filtering the results in the loop. As such, it will warn when for in loops do not filter their results with an if statement.", type: "Best Practices", linter: eslint)


    # Hard to Implement atm maxClassesPerFile = Rule.create(name: "Enforce a maximum number of classes per file", slug: "max-classes-per-file", description: "Files containing multiple classes can often result in a less navigable and poorly structured codebase. Best practice is to keep each file limited to a single responsibility.", type: "Best Practices", linter: eslint)
    # Hard to Implement atm maxClassesPerFileOption = RuleOption.create(name: "Always require or only on specific occasion", slug: "required", value: "", value_type: "array-single", description: "\"always\" option (default) enforces the use of === and !== in every situation.\n \"smart\" option enforces the use of === and !== except for these cases:\n\n Comparing two literal values\n Evaluating the value of typeof\n Comparing against null\n", units: "", condition_value: "", rule: eqeqeq)


    noAlert = Rule.create(name: "No Alert Prompt", slug: "no-alert", description: "disallow the use of alert, confirm, and prompt", type: "Best Practices", linter: eslint)
    noCaller = Rule.create(name: "No caller", slug: "no-caller", description: "disallow the use of arguments.caller or arguments.callee", type: "Best Practices", linter: eslint)

    noCaseDeclarations = Rule.create(name: "Disallow lexical declarations in switch", slug: "no-case-declarations", description: "This rule disallows lexical declarations (let, const, function and class) in case/default clauses. The reason is that the lexical declaration is visible in the entire switch block but it only gets initialized when it is assigned, which will only happen if the case where it is defined is reached.\n\nTo ensure that the lexical declaration only applies to the current case clause wrap your clauses in blocks.", type: "Best Practices", linter: eslint)
    noDivRegex = Rule.create(name: "No Div Regex", slug: "no-div-regex", description: "Require regex literals to escape division operators.", type: "Best Practices", linter: eslint)
    noElseReturn = Rule.create(name: "Disallow return before else", slug: "no-else-return", description: "If an if block contains a return statement, the else block becomes unnecessary. Its contents can be placed outside of the block.", type: "Best Practices", linter: eslint)

    noEmptyFunction = Rule.create(name: "Disallow empty functions", slug: "no-empty-function", description: "This rule is aimed at eliminating empty functions. A function will not be considered a problem if it contains a comment.", type: "Best Practices", linter: eslint)
    noEmptyFunctionOption = RuleOption.create(name: "Allow some functions to be empty", slug: "allow", value: "", value_type: "array-multiple", description: " \"functions\" - Normal functions.\n \"arrowFunctions\" - Arrow functions.\n \"generatorFunctions\" - Generator functions.\n \"methods\" - Class methods and method shorthands of object literals.\n \"generatorMethods\" - Class methods and method shorthands of object literals with generator.\n \"getters\" - Getters.\n \"setters\" - Setters.\n \"constructors\" - Class constructors.", units: "", condition_value: "", rule: noEmptyFunction)
    RuleOptionOption.create(rule_option: noEmptyFunctionOption, value: "functions")
    RuleOptionOption.create(rule_option: noEmptyFunctionOption, value: "arrowFunctions")
    RuleOptionOption.create(rule_option: noEmptyFunctionOption, value: "generatorFunctions")
    RuleOptionOption.create(rule_option: noEmptyFunctionOption, value: "methods")
    RuleOptionOption.create(rule_option: noEmptyFunctionOption, value: "generatorMethods")
    RuleOptionOption.create(rule_option: noEmptyFunctionOption, value: "getters")
    RuleOptionOption.create(rule_option: noEmptyFunctionOption, value: "setters")
    RuleOptionOption.create(rule_option: noEmptyFunctionOption, value: "constructors")

    noEqNull = Rule.create(name: "Disallow Null Comparisons", slug: "no-eq-null", description: "Comparing to null without a type-checking operator (== or !=), can have unintended results as the comparison will evaluate to true when comparing to not just a null, but also an undefined value.", type: "Best Practices", linter: eslint)
    noEval = Rule.create(name: "Disallow eval()", slug: "no-eval", description: "JavaScript’s eval() function is potentially dangerous and is often misused. Using eval() on untrusted code can open a program up to several different injection attacks. The use of eval() in most contexts can be substituted for a better, alternative approach to a problem.", type: "Best Practices", linter: eslint)
    noExtraBind = Rule.create(name: "Disallow unnecessary function binding", slug: "no-extra-bind", description: "The bind() method is used to create functions with specific this values and, optionally, binds arguments to specific values. When used to specify the value of this, it’s important that the function actually use this in its function body.This rule is aimed at avoiding the unnecessary use of bind() and as such will warn whenever an immediately-invoked function expression (IIFE) is using bind() and doesn’t have an appropriate this value. This rule won’t flag usage of bind() that includes function argument binding. Note: Arrow functions can never have their this value set using bind(). This rule flags all uses of bind() with arrow functions as a problem", fixable: true, type: "Best Practices", linter: eslint)
    noExtraLabel = Rule.create(name: "Disallow Unnecessary Labels", slug: "no-extra-label", description: "If a loop contains no nested loops or switches, labeling the loop is unnecessary.", fixable: true, type: "Best Practices", linter: eslint)


    nofallthrough = Rule.create(name: "Disallow Case Statement Fallthrough", slug: "no-fallthrough", description: "This rule is aimed at eliminating unintentional fallthrough of one case to the other. As such, it flags any fallthrough scenarios that are not marked by a comment.", type: "Best Practices", linter: eslint)
    noFloatingDecimal = Rule.create(name: "Disallow Floating Decimals", slug: "no-floating-decimal", description: "This rule is aimed at eliminating floating decimal points and will warn whenever a numeric value has a decimal point but is missing a number either before or after it.", fixable: true, type: "Best Practices", linter: eslint)
    noGlobalAssign = Rule.create(name: "Disallow assignment to native objects/read-only global variables", slug: "no-global-assign", description: "JavaScript environments contain a number of built-in global variables, such as window in browsers and process in Node.js. In almost all cases, you don’t want to assign a value to these global variables as doing so could result in losing access to important functionality.", type: "Best Practices", linter: eslint)

    noImplicitCoercion = Rule.create(name: "Disallow the type conversion with shorter notations", slug: "no-implicit-coercion", description: "This rule is aimed to flag shorter notations for the type conversion, then suggest a more self-explanatory notation.", fixable: true, options: "true", type: "Best Practices", linter: eslint)
    noImplicitCoercionBooleanOption = RuleOption.create(name: "Check on short notation of boolean", slug: "boolean", value: "", value_type: "boolean", description: "", units: "", condition_value: "", rule: noImplicitCoercion)
    noImplicitCoercionNumberOption = RuleOption.create(name: "Check on short notation of number", slug: "number", value: "", value_type: "boolean", description: "", units: "", condition_value: "", rule: noImplicitCoercion)
    noImplicitCoercionStringOption = RuleOption.create(name: "Check on short notation of string", slug: "string", value: "", value_type: "boolean", description: "", units: "", condition_value: "", rule: noImplicitCoercion)

    noImplicitGlobals = Rule.create(name: "Disallow variable and function declarations in the global scope", slug: "no-implicit-globals", description: "This rule disallows var and named function declarations at the top-level script scope. This does not apply to ES and CommonJS modules since they have a module scope.", type: "Best Practices", linter: eslint)

    noImpliedEval = Rule.create(name: "Disallow Implied eval", slug: "no-implied-eval", description: "It’s considered a good practice to avoid using eval() in JavaScript. There are security and performance implications involved with doing so, which is why many linters recommend disallowing eval(). However, there are some other ways to pass a string and have it interpreted as JavaScript code that have similar concerns.
    The first is using setTimeout(), setInterval() or execScript() (Internet Explorer only), all of which can accept a string of JavaScript code as their first argument.", type: "Best Practices", linter: eslint)
    noLabels = Rule.create(name: "Disallow Labeled Statements", slug: "no-labels", description: "This rule aims to eliminate the use of labeled statements in JavaScript. It will warn whenever a labeled statement is encountered and whenever break or continue are used with a label.", options: "false", fixable: true, type: "Best Practices", linter: eslint)
    noLabelsOptionAllowLoop = RuleOption.create( name: "allow labels in Loop", slug: "allowLoop", value: "", value_type: "boolean", description: "If this option was set true, this rule ignores labels which are sticking to loop statements.", units: "", condition_value: "", rule: noLabels)
    noLabelsOptionAllowSwitch = RuleOption.create( name: "allow labels in switch", slug: "allowSwitch", value: "", value_type: "boolean", description: "If this option was set true, this rule ignores labels which are sticking to switch statements.", units: "", condition_value: "", rule: noLabels)
    noLoneBlock = Rule.create(name: "Disallow Unnecessary Nested Blocks", slug: "no-lone-blocks", description: "This rule aims to eliminate unnecessary and potentially confusing blocks at the top level of a script or within other blocks.", options: "false", fixable: true, type: "Best Practices", linter: eslint)
    noLoopFunc = Rule.create(name: "Disallow Functions in Loops", slug: "no-loop-func", description: "This error is raised to highlight a piece of code that may not work as you expect it to and could also indicate a misunderstanding of how the language works. Your code may run without any problems if you do not fix this error, but in some situations it could behave unexpectedly.", fixable: true, type: "Best Practices", linter: eslint)
    noMagicNumbers = Rule.create(name: "Disallow Magic Numbers", slug: "no-magic-numbers", description: "‘Magic numbers’ are numbers that occur multiple time in code without an explicit meaning. They should preferably be replaced by named constants.\nThe no-magic-numbers rule aims to make code more readable and refactoring easier by ensuring that special numbers are declared as constants to make their meaning explicit.", type: "Best Practices", linter: eslint)
    noMultiSpaces = Rule.create(name: "Disallow multiple spaces", slug: "no-multi-spaces", description: "Multiple spaces in a row that are not used for indentation are typically mistakes", fixable: true, type: "Best Practices", linter: eslint)
    noMultiSTR = Rule.create(name: "Disallow Multiline Strings", slug: "no-multi-str", description: "This rule is aimed at preventing the use of multiline strings.", type: "Best Practices", linter: eslint)

    noNew = Rule.create(name: "Disallow new For Side Effects", slug: "no-new", description: "This rule is aimed at maintaining consistency and convention by disallowing constructor calls using the new keyword that do not assign the resulting object to a variable.", type: "Best Practices", linter: eslint)
    noNewFunc = Rule.create(name: "Disallow Function Constructor", slug: "no-new-func", description: "It’s possible to create functions in JavaScript using the Function constructor, this rule prevents it.", type: "Best Practices", linter: eslint)

    noNewWrappers = Rule.create(name: "Disallow Primitive Wrapper Instances", slug: "no-new-wrappers", description: "This rule aims to eliminate the use of String, Number, and Boolean with the new operator. As such, it warns whenever it sees new String, new Number, or new Boolean.", type: "Best Practices", linter: eslint)

    noOctal = Rule.create(name: "Disallow octal literals", slug: "no-octal", description: "Octal literals are numerals that begin with a leading zero. Example: var num = 071;      // 57. This rule prevents the use of octal literals", type: "Best Practices", linter: eslint)

    noProto = Rule.create(name: "Disallow Use of __proto__", slug: "no-proto", description: "__proto__ property has been deprecated as of ECMAScript 3.1 and shouldn’t be used in the code. Use getPrototypeOf method instead.", type: "Best Practices", linter: eslint)

    noRedeclare = Rule.create(name: "No Variable redecleration", slug: "no-redeclare", description: "This rule is aimed at eliminating variables that have multiple declarations in the same scope.", type: "Best Practices", linter: eslint)

    #no-restricted-properties -- Option extremly specific

    noReturnAssign = Rule.create(name: "Disallow Assignment in return Statement", slug: "no-return-assign", description: "This rule aims to eliminate assignments from return statements. As such, it will warn whenever an assignment is found as part of return.", type: "Best Practices", linter: eslint)
    noReturnAssignOption = RuleOption.create( name: "Disallow assignment everywhere or not", slug: "no-return-assign", value: "", value_type: "array-single", description: "except-parens (default): Disallow assignments unless they are enclosed in parentheses.\n always: Disallow all assignments.", units: "", condition_value: "", rule: noReturnAssign)
    RuleOptionOption.create(rule_option: noReturnAssignOption, value: "except-parens")
    RuleOptionOption.create(rule_option: noReturnAssignOption, value: "always")

    noReturnAwait = Rule.create(name: "Disallows unnecessary return await", slug: "no-return-await", description: "Inside an async function, return await is seldom useful. Since the return value of an async function is always wrapped in Promise.resolve, return await doesn’t actually do anything except add extra time before the overarching Promise resolves or rejects. The only valid exception is if return await is used in a try/catch statement to catch errors from another Promise-based function.", type: "Best Practices", linter: eslint)


    noScriptUrl = Rule.create(name: "Disallow Script URLs", slug: "no-script-url", description: "Using javascript: URLs is considered by some as a form of eval. Code passed in javascript: URLs has to be parsed and evaluated by the browser in the same way that eval is processed.", type: "Best Practices", linter: eslint)

    noSelfAssign = Rule.create(name: "Disallow Self Assignment", slug: "no-self-assign", description: "Self assignments have no effect, so probably those are an error due to incomplete refactoring. Those indicate that what you should do is still remaining.", options: "true", type: "Best Practices", linter: eslint)
    noSelfAssignOption = RuleOption.create( name: "Check properties as well", slug: "props", value: "", value_type: "boolean", description: "if this is true, no-self-assign rule warns self-assignments of properties. Default is true.", units: "", condition_value: "", rule: noSelfAssign)

    noSelfCompare = Rule.create(name: "Disallow Self Compare", slug: "no-self-compare", description: "This error is raised to highlight a potentially confusing and potentially pointless piece of code. There are almost no situations in which you would need to compare something to itself.", type: "Best Practices", linter: eslint)
    noThrowLiteral = Rule.create(name: "Restrict what can be thrown as an exception", slug: "no-throw-literal", description: "This error is raised to highlight a potentially confusing and potentially pointless piece of code. There are almost no situations in which you would need to compare something to itself.", type: "Best Practices", linter: eslint)

    noUnmodifiedLoopCondition = Rule.create(name: "Disallow unmodified conditions of loops", slug: "no-unmodified-loop-condition", description: "This rule finds references which are inside of loop conditions, then checks the variables of those references are modified in the loop.\n\nIf a reference is inside of a binary expression or a ternary expression, this rule checks the result of the expression instead. If a reference is inside of a dynamic expression (e.g. CallExpression, YieldExpression, …), this rule ignores it.", type: "Best Practices", linter: eslint)

    noUnusedExpressions = Rule.create(name: "Disallow Unused Expressions", slug: "no-unused-expressions", description: "This rule aims to eliminate unused expressions which have no effect on the state of the program. This rule does not apply to function calls or constructor calls with the new operator, because they could have side effects on the state of the program.", options: "false", type: "Best Practices", linter: eslint)
    noUnusedExpressionsOption = RuleOption.create( name: "Allow you to use short circuit evaluations", slug: "allowShortCircuit", value: "", value_type: "boolean", description: "", units: "", condition_value: "", rule: noUnusedExpressions)

    noUnusedLabels = Rule.create(name: "Disallow Unused Labels", slug: "no-unused-labels", description: "ThisThis rule is aimed at eliminating unused labels.", fixable: true, type: "Best Practices", linter: eslint)

    noUselessCall = Rule.create(name: "Disallow unnecessary .call() and .apply()", slug: "no-useless-call", description: "This rule is aimed to flag usage of Function.prototype.call() and Function.prototype.apply() that can be replaced with the normal function invocation.", type: "Best Practices", linter: eslint)
    noUselessConcat = Rule.create(name: "Disallow unnecessary concatenation of strings", slug: "no-useless-concat", description: "This rule aims to flag the concatenation of 2 literals when they could be combined into a single literal. Literals can be strings or template literals.", type: "Best Practices", linter: eslint)
    noUselessEscape = Rule.create(name: "Disallow unnecessary escape usage", slug: "no-useless-escape", description: "This rule flags escapes that can be safely removed without changing behavior.", type: "Best Practices", linter: eslint)
    noUselessReturn = Rule.create(name: "Disallow redundant return statements", slug: "no-useless-return", description: "A return; statement with nothing after it is redundant, and has no effect on the runtime behavior of a function. This can be confusing, so it’s better to disallow these redundant statements.", type: "Best Practices", linter: eslint)

    noVoid = Rule.create(name: "Disallow use of the void operator", slug: "no-void", description: "This rule aims to eliminate use of void operator.", options: "false", type: "Best Practices", linter: eslint)

    noWarningComments = Rule.create(name: "Disallow Warning Comments", slug: "no-warning-comments", description: "Developers often add comments to code which is not complete or needs review. Most likely you want to fix or review the code, and then remove the comment, before you consider the code to be production ready.", type: "Best Practices", linter: eslint)

    noWith = Rule.create(name: "Disallow with statements", slug: "no-with", description: "The with statement is potentially problematic because it adds members of an object to the current scope, making it impossible to tell what a variable inside the block actually refers to.", type: "Best Practices", linter: eslint)

    preferPromiseRejectErrors = Rule.create(name: "Require using Error objects as Promise rejection reasons", slug: "prefer-promise-reject-errors", description: "It is considered good practice to only pass instances of the built-in Error object to the reject() function for user-defined errors in Promises. Error objects automatically store a stack trace, which can be used to debug an error by determining where it came from. If a Promise is rejected with a non-Error value, it can be difficult to determine where the rejection occurred. This rule aims to ensure that Promises are only rejected with Error objects.", options: "false", type: "Best Practices", linter: eslint)
    preferPromiseRejectErrorsOption = RuleOption.create( name: "Allow calls to Promise.reject() with no arguments", slug: "allowEmptyReject", value: "", value_type: "boolean", description: "", units: "", condition_value: "", rule: preferPromiseRejectErrors)
    radix = Rule.create(name: "Require Radix Parameter", slug: "radix", description: "When using the parseInt() function it is common to omit the second argument, the radix, and let the function try to determine from the first argument what type of number it is. By default, parseInt() will autodetect decimal and hexadecimal (via 0x prefix). Prior to ECMAScript 5, parseInt() also autodetected octal literals, which caused problems because many developers assumed a leading 0 would be ignored. This rule is aimed at preventing the unintended conversion of a string to a number of a different base than intended or at preventing the redundant 10 radix if targeting modern environments only.", type: "Best Practices", linter: eslint)
    radixOption = RuleOption.create( name: "Always enforces providing a radix or as needed", slug: "allow", value: "", value_type: "array-single", description: "\"always\" enforces providing a radix (default)\n\"as-needed\" disallows providing the 10 radix", units: "", condition_value: "", rule: radix)
    RuleOptionOption.create(rule_option: radixOption, value: "always")
    RuleOptionOption.create(rule_option: radixOption, value: "never")

    requireAwait = Rule.create(name: "No async functions which have no await expression ", slug: "require-await", description: "This rule warns async functions which have no await expression.", type: "Best Practices", linter: eslint)
    requireUnicodeRegexp = Rule.create(name: "Enforce the use of \"u\" flag on RegExp", slug: "require-unicode-regexp", description: "This rule aims to enforce the use of u flag on regular expressions.", type: "Best Practices", linter: eslint)
    varsOnTop = Rule.create(name: "Enforce variable declaration at the top of the scope", slug: "vars-on-top", description: "Require Variable Declarations to be at the top of their scope.", type: "Best Practices", linter: eslint)

    wrapIife = Rule.create(name: "Require IIFEs to be Wrapped", slug: "wrap-iife", description: "You can immediately invoke function expressions, but not function declarations. A common technique to create an immediately-invoked function expression (IIFE) is to wrap a function declaration in parentheses. The opening parentheses causes the contained function to be parsed as an expression, rather than a declaration.", type: "Best Practices", linter: eslint)

    yoda = Rule.create(name: "Require or disallow Yoda Conditions", slug: "yoda", description: "Yoda conditions are so named because the literal value of the condition comes first while the variable comes second. Proponents of Yoda conditions highlight that it is impossible to mistakenly use = instead of == because you cannot assign to a literal value. Doing so will cause a syntax error and you will be informed of the mistake early on. This practice was therefore very common in early programming where tools were not yet available. Opponents of Yoda conditions point out that tooling has made us better programmers because tools will catch the mistaken use of = instead of == (ESLint will catch this for you). Therefore, they argue, the utility of the pattern doesn’t outweigh the readability hit the code takes while using Yoda conditions.", type: "Best Practices", linter: eslint)

    yodaOption = RuleOption.create( name: "Set yoda as comparaison syntax", slug: "yoda-option", value: "", value_type: "array-single", description: "never (default): comparisons must never be Yoda conditions.\n always: the literal value must always come first.", units: "", condition_value: "", rule: yodaOption)
    RuleOptionOption.create(rule_option: yodaOption, value: "never")
    RuleOptionOption.create(rule_option: yodaOption, value: "always")


    ##Variables
    initDeclarations = Rule.create(name: "Require or disallow initialization in variable declarations", slug: "init-declarations", description: "This rule is aimed at enforcing or eliminating variable initializations during declaration.", type: "Variables", linter: eslint)
    initDeclarationsOption = RuleOption.create( name: "Require or disallow", slug: "yoda-option", value: "", value_type: "array-single", description: "always (default): enforce initialization at declaration.\nnever : disallow initialization during declaration.", units: "", condition_value: "", rule: initDeclarations)
    RuleOptionOption.create(rule_option: initDeclarationsOption, value: "always")
    RuleOptionOption.create(rule_option: initDeclarationsOption, value: "never")

    noDeleteVar = Rule.create(name: "No Delete Var", slug: "no-delete-var", description: "The purpose of the delete operator is to remove a property from an object. Using the delete operator on a variable might lead to unexpected behavior.", type: "Variables", linter: eslint)
    noLabelVar = Rule.create(name: "Disallow Labels That Are Variables Names", slug: "no-label-var", description: "This rule aims to create clearer code by disallowing the bad practice of creating a label that shares a name with a variable that is in scope.", type: "Variables", linter: eslint)

    # no-restricted-globals options hard to implement

    noShadow = Rule.create(name: "No Shadow", slug: "no-shadow", description: "disallow variable declarations from shadowing variables declared in the outer scope", type: "Variables", linter: eslint)
    noShadowRestrictedNames = Rule.create(name: "No Shadow Restricted Names", slug: "no-shadow-restricted-names", description: "ES5 §15.1.1 Value Properties of the Global Object (NaN, Infinity, undefined) as well as strict mode restricted identifiers eval and arguments are considered to be restricted names in JavaScript. Defining them to mean something else can have unintended consequences and confuse others reading the code.", type: "Variables", linter: eslint)


    noUndef = Rule.create(name: "No Undeclared Variables", slug: "no-undef", description: "This rule can help you locate potential ReferenceErrors resulting from misspellings of variable and parameter names, or accidental implicit globals (for example, from forgetting the var keyword in a for loop initializer).", options: "false", type: "Variables", linter: eslint)
    noUndefOption = RuleOption.create( name: "Warn for variables used inside typeof check", slug: "typeof", value: "", value_type: "boolean", description: "Set to true will warn for variables used inside typeof check (Default false).", units: "", condition_value: "", rule: noUndef)

    noUndefInit = Rule.create(name: "Disallow Initializing to undefined", slug: "no-undef-init", description: "This rule aims to eliminate variable declarations that initialize to undefined.", fixable: true, type: "Variables", linter: eslint)

    noUndefined = Rule.create(name: "Disallow Use of undefined Variable", slug: "no-undefined", description: "This rule aims to eliminate the use of undefined, and as such, generates a warning whenever it is used.", type: "Variables", linter: eslint)

    noUnusedVars = Rule.create(name: "Disallow Unused Variables", slug: "no-unused-vars", description: "This rule is aimed at eliminating unused variables, functions, and parameters of functions.\n\n A variable is considered to be used if any of the following are true:\n \n\n It represents a function that is called (doSomething())\n It is read (var y = x)\n It is passed into a function as an argument (doSomething(x))\n It is read inside of a function that is passed to another function (doSomething(function() { foo(); }))\n A variable is not considered to be used if it is only ever assigned to (var x = 5) or declared.", type: "Variables", linter: eslint)
    #Options hard to implement
    # noUnusedVarsVarsOption = RuleOption.create( name: "Which vars to allow", slug: "vars", value: "", value_type: "array-single", description: "all checks all variables for usage, including those in the global scope. This is the default setting.
    # local checks only that locally-declared variables are used but will allow global variables to be unused.", units: "", condition_value: "", rule: noUnusedVars)
    # RuleOptionOption.create(rule_option: noUnusedVarsVarsOption, value: "all")
    # RuleOptionOption.create(rule_option: noUnusedVarsVarsOption, value: "local")
    #
    # noUnusedVarsArgsOption = RuleOption.create( name: "Which args to check", slug: "args", value: "", value_type: "array-single", description: "after-used - unused positional arguments that occur before the last used argument will not be checked, but all named arguments and all positional arguments after the last used argument will be checked.\nall - all named arguments must be used.\nnone - do not check arguments.", units: "", condition_value: "", rule: noUnusedVars)
    # RuleOptionOption.create(rule_option: noUnusedVarsArgsOption, value: "after-used")
    # RuleOptionOption.create(rule_option: noUnusedVarsArgsOption, value: "all")
    # RuleOptionOption.create(rule_option: noUnusedVarsArgsOption, value: "none")

    noUseBeforeDefine = Rule.create(name: "Disallow Early Use", slug: "no-use-before-define", description: "In JavaScript, prior to ES6, variable and function declarations are hoisted to the top of a scope, so it’s possible to use identifiers before their formal declarations in code. This can be confusing and some believe it is best to always declare variables and functions before using them.
    In ES6, block-level bindings (let and const) introduce a “temporal dead zone” where a ReferenceError will be thrown with any attempt to access the variable before its declaration.", options: "true", type: "Variables", linter: eslint)
    noUseBeforeDefineFunctionOption = RuleOption.create( name: "Warn on reference to a function before the function declaration", slug: "functions", value: "", value_type: "boolean", description: "The flag which shows whether or not this rule checks function declarations. If this is true, this rule warns every reference to a function before the function declaration. Otherwise, ignores those references. Function declarations are hoisted, so it’s safe. Default is true.", units: "", condition_value: "", rule: noUseBeforeDefine)
    noUseBeforeDefineClassesOption = RuleOption.create( name: "Warn on reference to a classes before the classes declaration", slug: "classes", value: "", value_type: "boolean", description: "The flag which shows whether or not this rule checks class declarations of upper scopes. If this is true, this rule warns every reference to a class before the class declaration. Otherwise, ignores those references if the declaration is in upper function scopes. Class declarations are not hoisted, so it might be danger. Default is true.", units: "", condition_value: "", rule: noUseBeforeDefine)
    noUseBeforeDefineVariablesOption = RuleOption.create( name: "Warn on reference to a variables before the variables declaration", slug: "variables", value: "", value_type: "boolean", description: "This flag determines whether or not the rule checks variable declarations in upper scopes. If this is true, the rule warns every reference to a variable before the variable declaration. Otherwise, the rule ignores a reference if the declaration is in an upper scope, while still reporting the reference if it’s in the same scope as the declaration. Default is true.", units: "", condition_value: "", rule: noUseBeforeDefine)

    ##Node.js and CommonJS

    ##Stylistic Issues
    noArrayConstructor = Rule.create(name: "No array constructor", slug: "no-array-constructor", description: "disallow Array constructors", type: "Stylistic Issues", linter: eslint)
    camelCase = Rule.create(name: "Camelcase", slug: "camelcase", description: "Require CamelCase", type: "Stylistic Issues", linter: eslint)
    commaDangle = Rule.create(name: "Comma Dangle", slug: "comma-dangle", description: "require or disallow trailing commas", type: "Stylistic Issues", linter: eslint)
    commaDangleOption = RuleOption.create( name: "Comma Dangle", slug: "comma-dangle", value: "", value_type: "array-single", description: "\"never\" (default) disallows trailing commas \"always\" requires trailing commas \"always-multiline\" requires trailing commas when the last element or property is in a different line than the closing ] or } and disallows trailing commas when the last element or property is on the same line as the closing ] or } \"only-multiline\" allows (but does not require) trailing commas when the last element or property is in a different line than the closing ] or } and disallows trailing commas when the last element or property is on the same line as the closing ] or }", units: "", condition_value: "", rule: commaDangle)
    RuleOptionOption.create(rule_option: commaDangleOption, value: "never")
    RuleOptionOption.create(rule_option: commaDangleOption, value: "always")
    RuleOptionOption.create(rule_option: commaDangleOption, value: "always-multiline")
    RuleOptionOption.create(rule_option: commaDangleOption, value: "only-multiline")
    noInlineComments = Rule.create(name: "Prevent comments on the same line as code", slug: "no-inline-comments", description: "Some style guides disallow comments on the same line as code. Code can become difficult to read if comments immediately follow the code on the same line. On the other hand, it is sometimes faster and more obvious to put comments immediately following code.", type: "Stylistic Issues", linter: eslint)

    noLonelyIf = Rule.create(name: "No if as only statment in else", slug: "no-lonely-if", description: "If an if statement is the only statement in the else block, it is often clearer to use an else if form.", type: "Stylistic Issues", linter: eslint)

    noMixedSpacesAndTabs = Rule.create(name: "Indent either with tab or space only", slug: "no-mixed-spaces-and-tabs", description: "Most code conventions require either tabs or spaces be used for indentation. As such, it’s usually an error if a single line of code is indented with both tabs and spaces.", type: "Stylistic Issues", linter: eslint)
    noMixedSpacesAndTabsOption = RuleOption.create( name: "Allow for alignement purpose", slug: "smart-tabs", value: "", value_type: "array-multiple", description: "allows mixed tabs and spaces when the spaces are used for alignment", units: "", condition_value: "", rule: noMixedSpacesAndTabs)
    RuleOptionOption.create(rule_option: noMixedSpacesAndTabsOption, value: "smart-tabs")
    RuleOptionOption.create(rule_option: noMixedSpacesAndTabsOption, value: nil)


    noMultipleEmptyLines = Rule.create(name: "Indent either with tab or space only", slug: "no-mixed-spaces-and-tabs", description: "Most code conventions require either tabs or spaces be used for indentation. As such, it’s usually an error if a single line of code is indented with both tabs and spaces.", type: "Stylistic Issues", linter: eslint)
    noNestedTernary = Rule.create(name: "No nested ternary", slug: "no-nested-ternary", description: "Nesting ternary expressions can make code more difficult to understand.", type: "Stylistic Issues", linter: eslint)
    noNewObject = Rule.create(name: "Disallow Object constructors", slug: "no-new-object", description: "This rule disallows Object constructors.", type: "Stylistic Issues", linter: eslint)

    noPlusPlus = Rule.create(name: "Disallow the unary operators ++ and -- ", slug: "no-plusplus", description: "This rule disallows the unary operators ++ and --.", type: "Stylistic Issues", linter: eslint)
    noPlusPlusOption = RuleOption.create( name: "Allow in the loop afterthought", slug: "allowForLoopAfterthoughts", value: "", value_type: "boolean", description: "\"allowForLoopAfterthoughts\": true allows unary operators ++ and -- in the afterthought (final expression) of a for loop.", units: "", condition_value: "", rule: noPlusPlus)

    quoteProps = Rule.create(name: "Require quotes around object literal property names", slug: "quote-props", description: "This rule requires quotes around object literal property names.", type: "Stylistic Issues", linter: eslint)
    quotePropsStringOption = RuleOption.create( name: "Allow always or on specific times", slug: "string-option", value: "", value_type: "array-single", description: "\"always\" (default) requires quotes around all object literal property names \"as-needed\" disallows quotes around object literal property names that are not strictly required \"consistent\" enforces a consistent quote style; in a given object, either all of the properties should be quoted, or none of the properties should be quoted \"consistent-as-needed\" requires quotes around all object literal property names if any name strictly requires quotes, otherwise disallows quotes around object property names", units: "", condition_value: "", rule: quoteProps)
    RuleOptionOption.create(rule_option: quotePropsStringOption, value: "always")
    RuleOptionOption.create(rule_option: quotePropsStringOption, value: "as-needed")
    RuleOptionOption.create(rule_option: quotePropsStringOption, value: "consistent")
    RuleOptionOption.create(rule_option: quotePropsStringOption, value: "consistent-as-needed")



    quotePropsObjectOption = RuleOption.create( name: "Allow for alignement purpose", slug: "smart-tabs", value: "", value_type: "array-multiple", description: "allows mixed tabs and spaces when the spaces are used for alignment", units: "", condition_value: "", rule: noMixedSpacesAndTabs)



    ##Node.js and CommonJS
    noNewRequire = Rule.create(name: "Disallow new require", slug: "no-new-require", description: "This rule aims to eliminate use of the new require expression.", type: "Node.js and CommonJS", linter: eslint)
    noPathConcat = Rule.create(name: "No path concatenation", slug: "no-path-concat", description: "Prevent string concatenation when using __dirname and __filename.", type: "Node.js and CommonJS", linter: eslint)
    noProcessEnv = Rule.create(name: "Disallow the use of process.env", slug: "no-process-env", description: "The process.env object in Node.js is used to store deployment/configuration parameters. Littering it through out a project could lead to maintenance issues as it’s another kind of global dependency. As such, it could lead to merge conflicts in a multi-user setup and deployment issues in a multi-server setup. Instead, one of the best practices is to define all those parameters in a single configuration/settings file which could be accessed throughout the project.", type: "Node.js and CommonJS", linter: eslint)
    noProcessExit = Rule.create(name: "Disallow the use of process.exit", slug: "no-process-exit", description: "This rule aims to prevent the use of process.exit() in Node.js JavaScript. As such, it warns whenever process.exit() is found in code.", type: "Node.js and CommonJS", linter: eslint)

    noSynch = Rule.create(name: "No Synchronous methods", slug: "no-sync", description: "This rule is aimed at preventing synchronous methods from being called in Node.js. It looks specifically for the method suffix “Sync” (as is the convention with Node.js operations.", options: "false", type: "Node.js and CommonJS", linter: eslint)
    noSynchOption = RuleOption.create( name: "Allow At Root Level", slug: "allowAtRootLevel", value: "", value_type: "boolean", description: "Determines whether synchronous methods should be allowed at the top level of a file, outside of any functions. This option defaults to false.", units: "", condition_value: "", rule: noSynch)


    ##ECMAScript 6
    noVar = Rule.create(name: "Require let or const instead of var", slug: "no-var", description: "This rule is aimed at discouraging the use of var and encouraging the use of const or let instead.", type: "ECMAScript 6", linter: eslint)

    #Rubocop Rules
    ##Layout Cops

    ##Linting Cops
    lint  = Rule.create(name: "Lint/Lint", slug: "Lint/Lint", description: "This cop checks for ambiguous block association with method when param passed without parentheses.", type: "Linting Cops", linter: rubocop)
    lintAmbiguousOperator  = Rule.create(name: "Lint/AmbiguousOperator", slug: "Lint/AmbiguousOperator", description: "This cop checks for ambiguous operators in the first argument of a method invocation without parentheses.", type: "Linting Cops", linter: rubocop)
    lintAmbiguousRegexpLiteral  = Rule.create(name: "Lint/AmbiguousRegexpLiteral", slug: "Lint/AmbiguousRegexpLiteral", description: "This cop checks for ambiguous regexp literals in the first argument of a method invocation without parentheses.", type: "Linting Cops", linter: rubocop)

    lintAssignmentInCondition  = Rule.create(name: "Lint/AssignmentInCondition", slug: "Lint/AssignmentInCondition", description: "This cop checks for assignments in the conditions of if/while/until.", type: "Linting Cops", linter: rubocop)

    lintAssignmentInCondition  = Rule.create(name: "Lint/AssignmentInCondition", slug: "Lint/AssignmentInCondition", description: "This cop checks for assignments in the conditions of if/while/until.", options: "true", type: "Linting Cops", linter: rubocop)
    lintAssignmentInConditionOption = RuleOption.create( name: "Allow Safe Assignment", slug: "AllowSafeAssignment", value: "", value_type: "boolean", description: "Don't use the return value of = (an assignment) in conditional expressions unless the assignment is wrapped in parentheses. This is a fairly popular idiom among Rubyists that's sometimes referred to as safe assignment in condition.", units: "", condition_value: "", rule: lintAssignmentInCondition)

    lintBigDecimalNew  = Rule.create(name: "Lint/BigDecimalNew", slug: "Lint/BigDecimalNew", description: "BigDecimal.new() is deprecated since BigDecimal 1.3.3. This cop identifies places where BigDecimal.new() can be replaced by BigDecimal() .", type: "Linting Cops", linter: rubocop)

    lintBooleanSymbol  = Rule.create(name: "Lint/BooleanSymbol", slug: "Lint/BooleanSymbol", description: "This cop checks for :true and :false symbols. In most cases it would be a typo.", type: "Linting Cops", linter: rubocop)

    lintCircularArgumentReference  = Rule.create(name: "Lint/CircularArgumentReference", slug: "Lint/CircularArgumentReference", description: "This cop checks for circular argument references in optional keyword arguments and optional ordinal arguments.", type: "Linting Cops", linter: rubocop)

    lintDebugger  = Rule.create(name: "Lint/Debugger", slug: "Lint/Debugger", description: "This cop checks for calls to debugger or pry.", type: "Linting Cops", linter: rubocop)

    lintDeprecatedClassMethods  = Rule.create(name: "Lint/DeprecatedClassMethods", slug: "Lint/DeprecatedClassMethods", description: "This cop checks for uses of the deprecated class method usages.", type: "Linting Cops", linter: rubocop)

    lintDuplicateCaseCondition  = Rule.create(name: "Lint/DuplicateCaseCondition", slug: "Lint/DuplicateCaseCondition", description: "This cop checks that there are no repeated conditions used in case 'when' expressions.", type: "Linting Cops", linter: rubocop)

    lintDuplicateMethods  = Rule.create(name: "Lint/DuplicateMethods", slug: "Lint/DuplicateMethods", description: "This cop checks for duplicated instance (or singleton) method definitions.", type: "Linting Cops", linter: rubocop)

    lintDuplicatedKey  = Rule.create(name: "Lint/DuplicatedKey", slug: "Lint/DuplicatedKey", description: "This cop checks for duplicated keys in hash literals.", type: "Linting Cops", linter: rubocop)

    lintEachWithObjectArgument  = Rule.create(name: "Lint/EachWithObjectArgument", slug: "Lint/EachWithObjectArgument", description: "This cop checks if each_with_object is called with an immutable argument. Since the argument is the object that the given block shall make calls on to build something based on the enumerable that each_with_object iterates over, an immutable argument makes no sense. It's definitely a bug.", type: "Linting Cops", linter: rubocop)

    lintElseLayout  = Rule.create(name: "Lint/ElseLayout", slug: "Lint/ElseLayout", description: "This cop checks for odd else block layout - like having an expression on the same line as the else keyword, which is usually a mistake.", type: "Linting Cops", linter: rubocop)

    lintEmptyEnsure  = Rule.create(name: "Lint/EmptyEnsure", slug: "Lint/EmptyEnsure", description: "This cop checks for empty ensure blocks.", type: "Linting Cops", linter: rubocop)

    lintEmptyEnsure  = Rule.create(name: "Lint/EmptyEnsure", slug: "Lint/EmptyEnsure", description: "This cop checks for empty ensure blocks.", options: "false", type: "Linting Cops", linter: rubocop)
    lintEmptyEnsureOption = RuleOption.create( name: "AutoCorrect", slug: "AutoCorrect", value: "", value_type: "boolean", description: "Remove the ensure block if empty.", units: "", condition_value: "", rule: lintEmptyEnsure)

    lintEmptyExpression  = Rule.create(name: "Lint/EmptyExpression", slug: "Lint/EmptyExpression", description: "This cop checks for the presence of empty expressions.", type: "Linting Cops", linter: rubocop)

    lintEmptyInterpolation  = Rule.create(name: "Lint/EmptyInterpolation", slug: "Lint/EmptyInterpolation", description: "This cop checks for empty interpolation.", type: "Linting Cops", linter: rubocop)

    lintEmptyWhen  = Rule.create(name: "Lint/EmptyWhen", slug: "Lint/EmptyWhen", description: "This cop checks for the presence of when branches without a body.", type: "Linting Cops", linter: rubocop)

    lintEndInMethod  = Rule.create(name: "Lint/EndInMethod", slug: "Lint/EndInMethod", description: "This cop checks for END blocks in method definitions.", type: "Linting Cops", linter: rubocop)

    lintEnsureReturn  = Rule.create(name: "Lint/EnsureReturn", slug: "Lint/EnsureReturn", description: "This cop checks for return from an ensure block. Explicit return from an ensure block alters the control flow as the return will take precedence over any exception being raised, and the exception will be silently thrown away as if it were rescued.", type: "Linting Cops", linter: rubocop)

    lintErbNewArguments  = Rule.create(name: "Lint/ErbNewArguments", slug: "Lint/ErbNewArguments", description: "This cop emulates the following Ruby warnings in Ruby 2.6.\nNow non-keyword arguments other than first one are softly deprecated and will be removed when Ruby 2.5 becomes EOL. ERB.new with non-keyword arguments is deprecated since ERB 2.2.0. Use :trim_mode and :eoutvar keyword arguments to ERB.new. This cop identifies places where ERB.new(str, trim_mode, eoutvar) can be replaced by ERB.new(str, :trim_mode: trim_mode, eoutvar: eoutvar).", type: "Linting Cops", linter: rubocop)

    lintFloatOutOfRange  = Rule.create(name: "Lint/FloatOutOfRange", slug: "Lint/FloatOutOfRange", description: "This cop identifies Float literals which are, like, really really really really really really really really big. Too big. No-one needs Floats that big. If you need a float that big, something is wrong with you.", type: "Linting Cops", linter: rubocop)

    lintFormatParameterMismatch  = Rule.create(name: "Lint/FormatParameterMismatch", slug: "Lint/FormatParameterMismatch", description: "This lint sees if there is a mismatch between the number of expected fields for format/sprintf/#% and what is actually passed as arguments.", type: "Linting Cops", linter: rubocop)

    lintHandleExceptions  = Rule.create(name: "Lint/FormatParameterMismatch", slug: "Lint/FormatParameterMismatch", description: "This cop checks for rescue blocks with no body.", type: "Linting Cops", linter: rubocop)

    lintImplicitStringConcatenation  = Rule.create(name: "Lint/ImplicitStringConcatenation", slug: "Lint/ImplicitStringConcatenation", description: "This cop checks for implicit string concatenation of string literals which are on the same line.", type: "Linting Cops", linter: rubocop)

    lintIneffectiveAccessModifier  = Rule.create(name: "Lint/IneffectiveAccessModifier", slug: "Lint/IneffectiveAccessModifier", description: "This cop checks for private or protected access modifiers which are applied to a singleton method. These access modifiers do not make singleton methods private/protected. private_class_method can be used for that.", type: "Linting Cops", linter: rubocop)

    lintInheritException = Rule.create(name: "Lint/InheritException", slug: "Lint/InheritException", description: "This cop looks for error classes inheriting from Exception and its standard library subclasses, excluding subclasses of StandardError. It is configurable to suggest using either RuntimeError (default) or StandardError instead.", type: "Linting Cops", linter: rubocop)
    lintInheritExceptionOption = RuleOption.create( name: "RuntimeError or StandardError", slug: "EnforcedStyle", value: "", value_type: "array-single", description: "Use either RuntimeError (default) or StandardError instead.", units: "", condition_value: "", rule: lintInheritException)
    RuleOptionOption.create(rule_option: quotePropsStringOption, value: "runtime_error")
    RuleOptionOption.create(rule_option: quotePropsStringOption, value: "standard_error")

    lintInterpolationCheck = Rule.create(name: "Lint/InterpolationCheck", slug: "Lint/InterpolationCheck", description: "This cop checks for interpolation in a single quoted string.", type: "Linting Cops", linter: rubocop)

    lintLiteralAsCondition = Rule.create(name: "Lint/LiteralAsCondition", slug: "Lint/LiteralAsCondition", description: "This cop checks for literals used as the conditions or as operands in and/or expressions serving as the conditions of if/while/until.", type: "Linting Cops", linter: rubocop)

    lintLiteralInInterpolation = Rule.create(name: "Lint/LiteralInInterpolation", slug: "Lint/LiteralInInterpolation", description: "This cop checks for interpolated literals.", type: "Linting Cops", linter: rubocop)

    lintLoop = Rule.create(name: "Lint/Loop", slug: "Lint/Loop", description: "This cop checks for uses of begin...end while/until something.\n Use Kernel#loop with break rather than begin/end/until or begin/end/while for post-loop tests.", type: "Linting Cops", linter: rubocop)

    #lintMissingCopEnableDirective -- check to implement later

    lintMultipleCompare = Rule.create(name: "Lint/MultipleCompare", slug: "Lint/MultipleCompare", description: "In math and Python, we can use x < y < z style comparison to compare multiple value. However, we can't use the comparison in Ruby. However, the comparison is not syntax error. This cop checks the bad usage of comparison operators.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintNestedMethodDefinition = Rule.create(name: "Lint/NestedMethodDefinition", slug: "Lint/NestedMethodDefinition", description: "This cop checks for nested method definitions.", type: "Linting Cops", linter: rubocop)

    lintNestedPercentLiteral = Rule.create(name: "Lint/NestedPercentLiteral", slug: "Lint/NestedPercentLiteral", description: "This cop checks for nested percent literals.", type: "Linting Cops", linter: rubocop)

    lintNextWithoutAccumulator = Rule.create(name: "Lint/NextWithoutAccumulator", slug: "Lint/NextWithoutAccumulator", description: "Don't omit the accumulator when calling next in a reduce block.", type: "Linting Cops", linter: rubocop)

    lintNonLocalExitFromIterator = Rule.create(name: "Lint/NonLocalExitFromIterator", slug: "Lint/NonLocalExitFromIterator", description: "This cop checks for non-local exits from iterators without a return value. It registers an offense under these conditions: \n\nNo value is returned,\nthe block is preceded by a method chain,\nthe block has arguments,\nthe method which receives the block is not define_method or define_singleton_method,\nthe return is not contained in an inner scope, e.g. a lambda or a method definition.", type: "Linting Cops", linter: rubocop)

    lintNumberConversion = Rule.create(name: "Lint/NumberConversion", slug: "Lint/NumberConversion", description: "This cop warns the usage of unsafe number conversions. Unsafe number conversion can cause unexpected error if auto type conversion fails. Cop prefer parsing with number class instead.", type: "Linting Cops", linter: rubocop)

    lintOrderedMagicComments = Rule.create(name: "Lint/OrderedMagicComments", slug: "Lint/OrderedMagicComments", description: "Checks the proper ordering of magic comments and whether a magic comment is not placed before a shebang.", type: "Linting Cops", linter: rubocop)

    lintParenthesesAsGroupedExpression = Rule.create(name: "Lint/ParenthesesAsGroupedExpression", slug: "Lint/ParenthesesAsGroupedExpression", description: "Checks for space between the name of a called method and a left parenthesis.", type: "Linting Cops", linter: rubocop)

    lintPercentStringArray = Rule.create(name: "Lint/PercentStringArray", slug: "Lint/PercentStringArray", description: "This cop checks for quotes and commas in %w, e.g. %w('foo', \"bar\")\n\nIt is more likely that the additional characters are unintended (for example, mistranslating an array of literals to percent string notation) rather than meant to be part of the resulting strings.", type: "Linting Cops", linter: rubocop)

    lintPercentSymbolArray = Rule.create(name: "Lint/PercentSymbolArray", slug: "Lint/PercentSymbolArray", description: "This cop checks for colons and commas in %i, e.g. %i(:foo, :bar)\n\nIt is more likely that the additional characters are unintended (for example, mistranslating an array of literals to percent string notation) rather than meant to be part of the resulting symbols.", type: "Linting Cops", linter: rubocop)

    lintRandOne = Rule.create(name: "Lint/RandOne", slug: "Lint/RandOne", description: "This cop checks for rand(1) calls. Such calls always return 0. And is therefore considered a mistake.", type: "Linting Cops", linter: rubocop)

    lintRedundantWithIndex = Rule.create(name: "Lint/RedundantWithIndex", slug: "Lint/RedundantWithIndex", description: "This cop checks for redundant with_index.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintRedundantWithObject = Rule.create(name: "Lint/RedundantWithObject", slug: "Lint/RedundantWithObject", description: "This cop checks for redundant with_object.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintRegexpAsCondition = Rule.create(name: "Lint/RegexpAsCondition", slug: "Lint/RegexpAsCondition", description: "This cop checks for regexp literals used as match-current-line. If a regexp literal is in condition, the regexp matches $_ implicitly.", type: "Linting Cops", linter: rubocop)

    lintRequireParentheses = Rule.create(name: "Lint/RequireParentheses", slug: "Lint/RequireParentheses", description: "This cop checks for expressions where there is a call to a predicate method with at least one argument, where no parentheses are used around the parameter list, and a boolean operator, && or ||, is used in the last argument.\n\nThe idea behind warning for these constructs is that the user might be under the impression that the return value from the method call is an operand of &&/||.", type: "Linting Cops", linter: rubocop)

    lintRescueException = Rule.create(name: "Lint/RescueException", slug: "Lint/RescueException", description: "This cop checks for rescue blocks targeting the Exception class.", type: "Linting Cops", linter: rubocop)

    lintRescueType = Rule.create(name: "Lint/RescueType", slug: "Lint/RescueType", description: "Check for arguments to rescue that will result in a TypeError if an exception is raised.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintReturnInVoidContext = Rule.create(name: "Lint/ReturnInVoidContext", slug: "Lint/ReturnInVoidContext", description: "This cop checks for the use of a return with a value in a context where the value will be ignored. (initialize and setter methods).", type: "Linting Cops", linter: rubocop)

    lintSafeNavigationChain = Rule.create(name: "Lint/SafeNavigationChain", slug: "Lint/SafeNavigationChain", description: "The safe navigation operator returns nil if the receiver is nil. If you chain an ordinary method call after a safe navigation operator, it raises NoMethodError. We should use a safe navigation operator after a safe navigation operator. This cop checks for the problem outlined above.", type: "Linting Cops", linter: rubocop)

    lintSafeNavigationChain = Rule.create(name: "Lint/SafeNavigationChain", slug: "Lint/SafeNavigationChain", description: "The safe navigation operator returns nil if the receiver is nil. If you chain an ordinary method call after a safe navigation operator, it raises NoMethodError. We should use a safe navigation operator after a safe navigation operator. This cop checks for the problem outlined above.", type: "Linting Cops", linter: rubocop)
    # lintSafeNavigationChainnOption -- hard to implement

    lintSafeNavigationConsistency = Rule.create(name: "Lint/SafeNavigationConsistency", slug: "Lint/SafeNavigationConsistency", description: "This cop check to make sure that if safe navigation is used for a method call in an && or || condition that safe navigation is used for all method calls on that same object.", type: "Linting Cops", linter: rubocop)
    # lintSafeNavigationConsistencyOption -- hard to implement

    lintScriptPermission = Rule.create(name: "Lint/ScriptPermission", slug: "Lint/ScriptPermission", description: "This cop checks if a file which has a shebang line as its first line is granted execute permission.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintShadowedArgument = Rule.create(name: "Lint/ShadowedArgument", slug: "Lint/ShadowedArgument", description: "This cop checks if a file which has a shebang line as its first line is granted execute permission.", options: "false", type: "Linting Cops", linter: rubocop)
    lintShadowedArgumentOption = RuleOption.create( name: "Ignore Implicit References", slug: "IgnoreImplicitReferences", value: "", value_type: "boolean", description: "Argument shadowing is used in order to pass parameters to zero arity super when IgnoreImplicitReferences is true.", units: "", condition_value: "", rule: lintShadowedArgument)

    lintShadowedException = Rule.create(name: "Lint/ShadowedException", slug: "Lint/ShadowedException", description: "This cop checks for a rescued exception that get shadowed by a less specific exception being rescued before a more specific exception is rescued.", type: "Linting Cops", linter: rubocop)

    lintShadowingOuterLocalVariable = Rule.create(name: "Lint/ShadowingOuterLocalVariable", slug: "Lint/ShadowingOuterLocalVariable", description: "This cop looks for use of the same name as outer local variables for block arguments or block local variables.", type: "Linting Cops", linter: rubocop)

    lintStringConversionInInterpolation = Rule.create(name: "Lint/StringConversionInInterpolation", slug: "Lint/StringConversionInInterpolation", description: "This cop checks for string conversion in string interpolation, which is redundant.", fixable: true, type: "Linting Cops", linter: rubocop)

    #This is a category Name not a rule, this causes issues
    #lintSyntax = Rule.create(name: "Lint/Syntax", slug: "Lint/Syntax", description: "This is not actually a cop. It does not inspect anything. It just provides methods to repack Parser's diagnostics/errors into RuboCop's offenses.", type: "Linting Cops", linter: rubocop)

    lintUnderscorePrefixedVariableName = Rule.create(name: "Lint/UnderscorePrefixedVariableName", slug: "Lint/UnderscorePrefixedVariableName", description: "This cop checks for underscore-prefixed variables that are actually used.", type: "Linting Cops", linter: rubocop)

    lintUnifiedInteger = Rule.create(name: "Lint/UnifiedInteger", slug: "Lint/UnifiedInteger", description: "This cop checks for using Fixnum or Bignum constant.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintUnneededCopDisableDirective = Rule.create(name: "Lint/UnneededCopDisableDirective", slug: "Lint/UnneededCopDisableDirective", description: "This cop detects instances of rubocop:disable comments that can be removed without causing any offenses to be reported. It's implemented as a cop in that it inherits from the Cop base class and calls add_offense. The unusual part of its implementation is that it doesn't have any on_* methods or an investigate method. This means that it doesn't take part in the investigation phase when the other cops do their work. Instead, it waits until it's called in a later stage of the execution. The reason it can't be implemented as a normal cop is that it depends on the results of all other cops to do its work.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintUnneededCopEnableDirective = Rule.create(name: "Lint/UnneededCopEnableDirective", slug: "Lint/UnneededCopEnableDirective", description: "This cop detects instances of rubocop:enable comments that can be removed.\n\nWhen comment enables all cops at once rubocop:enable all that cop checks whether any cop was actually enabled.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintUnneededRequireStatement = Rule.create(name: "Lint/UnneededRequireStatement", slug: "Lint/UnneededRequireStatement", description: "Checks for unnecessary require statement.\n\nThe following features are unnecessary require statement because they are already loaded.\n\nruby -ve 'p $LOADED_FEATURES.reject { |feature| %r|/| =~ feature }' ruby 2.2.8p477 (2017-09-14 revision 59906) [x86_64-darwin13] [\"enumerator.so\", \"rational.so\", \"complex.so\", \"thread.rb\"]\n\nThis cop targets Ruby 2.2 or higher containing these 4 features.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintUnneededSplatExpansion = Rule.create(name: "Lint/UnneededRequireStatement", slug: "Lint/UnneededRequireStatement", description: "This cop checks for unneeded usages of splat expansion.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintUnreachableCode = Rule.create(name: "Lint/UnreachableCode", slug: "Lint/UnreachableCode", description: "This cop checks for unreachable code. The check are based on the presence of flow of control statement in non-final position in begin(implicit) blocks.", fixable: true, type: "Linting Cops", linter: rubocop)

    lintUnusedBlockArgument = Rule.create(name: "Lint/UnusedBlockArgument", slug: "Lint/UnusedBlockArgument", description: "This cop checks for unused block arguments.", options: "true", fixable: true, type: "Linting Cops", linter: rubocop)
    lintUnusedBlockArgumentOption = RuleOption.create( name: "Ignore Empty Blocks", slug: "IgnoreEmptyBlocks", value: "", value_type: "boolean", description: "Argument shadowing is used in order to pass parameters to zero arity super when IgnoreImplicitReferences is true.", units: "", condition_value: "", rule: lintUnusedBlockArgument)

    lintUnusedMethodArgument = Rule.create(name: "Lint/UnusedMethodArgument", slug: "Lint/UnusedMethodArgument", description: "This cop checks for unused method arguments.", options: "true", fixable: true, type: "Linting Cops", linter: rubocop)
    lintUnusedMethodArgumentOption = RuleOption.create( name: "Ignore Empty Methods", slug: "IgnoreEmptyMethods", value: "", value_type: "boolean", description: "Argument shadowing is used in order to pass parameters to zero arity super when IgnoreImplicitReferences is true.", units: "", condition_value: "", rule: lintUnusedMethodArgument)

    lintUriEscapeUnescape = Rule.create(name: "Lint/UriEscapeUnescape", slug: "Lint/UriEscapeUnescape", description: "This cop identifies places where URI.escape can be replaced by CGI.escape, URI.encode_www_form, or URI.encode_www_form_component depending on your specific use case. Also this cop identifies places where URI.unescape can be replaced by CGI.unescape, URI.decode_www_form, or URI.decode_www_form_component depending on your specific use case.", type: "Linting Cops", linter: rubocop)

    lintUriRegexp = Rule.create(name: "Lint/UriRegexp", slug: "Lint/UriRegexp", description: "This cop identifies places where URI.regexp is obsolete and should not be used. Instead, use URI::DEFAULT_PARSER.make_regexp.", type: "Linting Cops", linter: rubocop)

    lintUselessAccessModifier = Rule.create(name: "Lint/UselessAccessModifier", slug: "Lint/UselessAccessModifier", description: "This cop checks for redundant access modifiers, including those with no code, those which are repeated, and leading public modifiers in a class or module body. Conditionally-defined methods are considered as always being defined, and thus access modifiers guarding such methods are not redundant.", type: "Linting Cops", linter: rubocop)

    lintUriEscapeUnescape = Rule.create(name: "Lint/UriEscapeUnescape", slug: "Lint/UriEscapeUnescape", description: "This cop identifies places where URI.escape can be replaced by CGI.escape, URI.encode_www_form, or URI.encode_www_form_component depending on your specific use case. Also this cop identifies places where URI.unescape can be replaced by CGI.unescape, URI.decode_www_form, or URI.decode_www_form_component depending on your specific use case.", type: "Linting Cops", linter: rubocop)

    lintUselessAssignment = Rule.create(name: "Lint/UselessAssignment", slug: "Lint/UselessAssignment", description: "This cop checks for every useless assignment to local variable in every scope. The basic idea for this cop was from the warning of ruby -cw: \n\n assigned but unused variable - foo \n\n Currently this cop has advanced logic that detects unreferenced reassignments and properly handles varied cases such as branch, loop, rescue, ensure, etc.", type: "Linting Cops", linter: rubocop)

    lintUselessComparison = Rule.create(name: "Lint/UselessComparison", slug: "Lint/UselessComparison", description: "This cop checks for comparison of something with itself.", type: "Linting Cops", linter: rubocop)

    lintUselessElseWithoutRescue = Rule.create(name: "Lint/UselessElseWithoutRescue", slug: "Lint/UselessElseWithoutRescue", description: "This cop checks for useless else in begin..end without rescue.", type: "Linting Cops", linter: rubocop)

    lintUselessSetterCall = Rule.create(name: "Lint/UselessSetterCall", slug: "Lint/UselessSetterCall", description: "This cop checks for setter call to local variable as the final expression of a function definition.", type: "Linting Cops", linter: rubocop)

    lintVoid  = Rule.create(name: "Lint/Void", slug: "Lint/Void", description: "This cop checks for shadowed arguments.\n\nThis cop has IgnoreImplicitReferences configuration option.", options:"false", type: "Linting Cops", linter: rubocop)
    lintVoidOption = RuleOption.create( name: "Check For Methods With No Side Effects", slug: "CheckForMethodsWithNoSideEffects", value: "", value_type: "boolean", description: "Shadowing is used in order to pass parameters to zero arity super when IgnoreImplicitReferences is true.", units: "", condition_value: "", rule: lintVoid)


    ##Metrics Cops -- Rules are commented as many may conflict with Prettier Ruby
    # metricsAbcSize  = Rule.create(name: "Metrics/AbcSize", slug: "Metrics/AbcSize", description: "This cop checks that the ABC size of methods is not higher than the configured maximum. The ABC size is based on assignments, branches (method calls), and conditions. See http://c2.com/cgi/wiki?AbcMetric.", options:"15", type: "Metrics Cops", linter: rubocop)
    # metricsAbcSizeOption = RuleOption.create( name: "Set maximum AbcSize", slug: "Max", value: "", value_type: "integer", description: "Shadowing is used in order to pass parameters to zero arity super when IgnoreImplicitReferences is true.", units: "", condition_value: "", rule: lintVoid)
    #
    # metricsBlockLength  = Rule.create(name: "Metrics/BlockLength", slug: "Metrics/BlockLength", description: "This cop checks if the length of a block exceeds some maximum value. Comment lines can optionally be ignored. The cop can be configured to ignore blocks passed to certain methods.", options:"25", type: "Metrics Cops", linter: rubocop)
    # metricsBlockLengthMaxOption = RuleOption.create( name: "Set maximum BlockLength", slug: "Max", value: "", value_type: "integer", description: "Maximum allowed length is configurable.", units: "", condition_value: "", rule: metricsBlockLength)
    # metricsBlockLengthCountCommentsOption = RuleOption.create( name: "Count comment", slug: "CountComments", value: "", value_type: "boolean", description: "Comment lines will be included.", units: "", condition_value: "", rule: metricsBlockLength)
    #
    # metricsBlockNesting  = Rule.create(name: "Metrics/BlockNesting", slug: "Metrics/BlockNesting", description: "This cop checks for excessive nesting of conditional and looping constructs.", options:"3", type: "Metrics Cops", linter: rubocop)
    # metricsBlockNestingMaxOption = RuleOption.create( name: "Set maximum level of nesting allowed", slug: "Max", value: "", value_type: "integer", description: "Maximum allowed length is configurable.", units: "", condition_value: "", rule: metricsBlockNesting)
    # metricsBlockNestingCountBlocksOption = RuleOption.create( name: "Blocks are considered", slug: "CountComments", value: "", value_type: "boolean", description: "When set to false (the default) blocks are not counted towards the nesting level. Set to true to count blocks as well.", units: "", condition_value: "", rule: metricsBlockNesting)
    #
    # metricsClassLength  = Rule.create(name: "Metrics/ClassLength", slug: "Metrics/ClassLength", description: "This cop checks if the length a class exceeds some maximum value. Comment lines can optionally be ignored. The maximum allowed length is configurable.", options:"100", type: "Metrics Cops", linter: rubocop)
    # metricsClassLengthMaxOption = RuleOption.create( name: "Set maximum class length", slug: "Max", value: "", value_type: "integer", description: "Maximum allowed length.", units: "", condition_value: "", rule: metricsClassLength)
    # metricsClassLengthCountCommentsOption = RuleOption.create( name: "Count comment", slug: "CountComments", value: "", value_type: "boolean", description: "Comment lines will be included.", units: "", condition_value: "", rule: metricsClassLength)
    #
    # metricsCyclomaticComplexity  = Rule.create(name: "Metrics/CyclomaticComplexity", slug: "Metrics/CyclomaticComplexity", description: "This cop checks that the cyclomatic complexity of methods is not higher than the configured maximum. The cyclomatic complexity is the number of linearly independent paths through a method. The algorithm counts decision points and adds one.\n\nAn if statement (or unless or ?:) increases the complexity by one. An else branch does not, since it doesn't add a decision point. The && operator (or keyword and) can be converted to a nested if statement, and ||/or is shorthand for a sequence of ifs, so they also add one. Loops can be said to have an exit condition, so they add one.", options:"6", type: "Metrics Cops", linter: rubocop)
    # metricsCyclomaticComplexityMaxOption = RuleOption.create( name: "Set maximum cyclomatic complexity", slug: "Max", value: "", value_type: "integer", description: "Maximum allowed length.", units: "", condition_value: "", rule: metricsCyclomaticComplexity)
    #
    # metricsLineLength  = Rule.create(name: "Metrics/LineLength", slug: "Metrics/LineLength", description: "This cop checks the length of lines in the source code. The maximum length is configurable. The tab size is configured in the IndentationWidth of the Layout/Tab cop.", options:"80", type: "Metrics Cops", linter: rubocop)
    # metricsLineLengthMaxOption = RuleOption.create( name: "Set maximum line length", slug: "Max", value: "", value_type: "integer", description: "Maximum line length.", units: "", condition_value: "", rule: metricsLineLength)
    #
    # metricsMethodLength  = Rule.create(name: "Metrics/MethodLength", slug: "Metrics/MethodLength", description: "This cop checks if the length of a method exceeds some maximum value. Comment lines can optionally be ignored.", options:"100", type: "Metrics Cops", linter: rubocop)
    # metricsMethodLengthMaxOption = RuleOption.create( name: "Set method length", slug: "Max", value: "", value_type: "integer", description: "Maximum method length.", units: "", condition_value: "", rule: metricsMethodLength)
    # metricsMethodLengthCountCommentsOption = RuleOption.create( name: "Count comment", slug: "CountComments", value: "", value_type: "boolean", description: "Comment lines will be included.", units: "", condition_value: "", rule: metricsMethodLength)
    #
    # metricsModuleLength  = Rule.create(name: "Metrics/ModuleLength", slug: "Metrics/ModuleLength", description: "This cop checks if the length a module exceeds some maximum value. Comment lines can optionally be ignored.", options:"100", type: "Metrics Cops", linter: rubocop)
    # metricsModuleLengthMaxOption = RuleOption.create( name: "Set odule length", slug: "Max", value: "", value_type: "integer", description: "Maximum method length.", units: "", condition_value: "", rule: metricsModuleLength)
    #
    # metricsParameterLists  = Rule.create(name: "Metrics/ParameterLists", slug: "Metrics/ParameterLists", description: "This cop checks for methods with too many parameters.", options:"5", type: "Metrics Cops", linter: rubocop)
    # metricsParameterListsMaxOption = RuleOption.create( name: "Set maximum number of parameters", slug: "Max", value: "", value_type: "integer", description: "Maximum number of parameters.", units: "", condition_value: "", rule: metricsParameterLists)
    # metricsParameterListsCountCommentsOption = RuleOption.create( name: "Count keyword arguments", slug: "CountKeywordArgs", value: "", value_type: "boolean", description: "Comment lines will be included.", units: "", condition_value: "", rule: metricsParameterLists)
    #
    # metricsPerceivedComplexity  = Rule.create(name: "Metrics/PerceivedComplexity", slug: "Metrics/PerceivedComplexity", description: "This cop tries to produce a complexity score that's a measure of the complexity the reader experiences when looking at a method. For that reason it considers when nodes as something that doesn't add as much complexity as an if or a &&. Except if it's one of those special case/when constructs where there's no expression after case. Then the cop treats it as an if/elsif/elsif... and lets all the when nodes count. In contrast to the CyclomaticComplexity cop, this cop considers else nodes as adding complexity.", options:"7", type: "Metrics Cops", linter: rubocop)
    # metricsParameterListsMaxOption = RuleOption.create( name: "Set maximum Complexity", slug: "Max", value: "", value_type: "integer", description: "Maximum Complexity.", units: "", condition_value: "", rule: metricsPerceivedComplexity)


    #Naming cops
    namingAccessorMethodName = Rule.create(name: "Naming/AccessorMethodName", slug: "Naming/AccessorMethodName", description: "This cop makes sure that accessor methods are named properly.", type: "Naming Cops", linter: rubocop)

    namingAsciiIdentifiers = Rule.create(name: "Naming/AsciiIdentifiers", slug: "Naming/AsciiIdentifiers", description: "This cop checks for non-ascii characters in identifier names.", type: "Naming Cops", linter: rubocop)

    namingBinaryOperatorParameterName  = Rule.create(name: "Naming/BinaryOperatorParameterName", slug: "Naming/BinaryOperatorParameterName", description: "This cop makes sure that certain binary operator methods have their sole parameter named other.", type: "Naming Cops", linter: rubocop)

    namingClassAndModuleCamelCase = Rule.create(name: "Naming/ClassAndModuleCamelCase", slug: "Naming/ClassAndModuleCamelCase", description: "This cop checks for class and module names with an underscore in them.", type: "Naming Cops", linter: rubocop)

    namingConstantName = Rule.create(name: "Naming/ConstantName", slug: "Naming/ConstantName", description: "This cop checks whether constant names are written using SCREAMING_SNAKE_CASE.\n\nTo avoid false positives, it ignores cases in which we cannot know for certain the type of value that would be assigned to a constant.", type: "Naming Cops", linter: rubocop)

    namingFileName = Rule.create(name: "Naming/FileName", slug: "Naming/FileName", description: "This cop makes sure that Ruby source files have snake_case names. Ruby scripts (i.e. source files with a shebang in the first line) are ignored.\n\nThe cop also ignores .gemspec files, because Bundler recommends using dashes to separate namespaces in nested gems (i.e. bundler-console becomes Bundler::Console). As such, the gemspec is supposed to be named bundler-console.gemspec.", type: "Naming Cops", linter: rubocop)

    namingHeredocDelimiterCase = Rule.create(name: "Naming/HeredocDelimiterCase", slug: "Naming/HeredocDelimiterCase", description: "This cop checks that your heredocs are using the configured case. By default it is configured to enforce uppercase heredocs.", type: "Naming Cops", linter: rubocop)
    namingHeredocDelimiterCaseOption = RuleOption.create( name: "Uppercase or Lowercase", slug: "EnforcedStyle", value: "", value_type: "array-single", description: "Enforce uppercase or lowercase heredocs.", units: "", condition_value: "", rule: namingHeredocDelimiterCase)
    RuleOptionOption.create(rule_option: namingHeredocDelimiterCaseOption, value: "uppercase")
    RuleOptionOption.create(rule_option: namingHeredocDelimiterCaseOption, value: "lowercase")

    namingMemoizedInstanceVariableName = Rule.create(name: "Naming/MemoizedInstanceVariableName", slug: "Naming/MemoizedInstanceVariableName", description: "This cop checks for memoized methods whose instance variable name does not match the method name.", type: "Naming Cops", linter: rubocop)
    namingMemoizedInstanceVariableNameOption = RuleOption.create( name: "Enforced Style For Leading Underscores", slug: "EnforcedStyleForLeadingUnderscores", value: "", value_type: "array-single", description: "It can be configured to allow for memoized instance variables prefixed with an underscore. Prefixing ivars with an underscore is a convention that is used to implicitly indicate that an ivar should not be set or referencd outside of the memoization method.", rule: namingMemoizedInstanceVariableName)
    RuleOptionOption.create(rule_option: namingMemoizedInstanceVariableNameOption, value: "disallowed")
    RuleOptionOption.create(rule_option: namingMemoizedInstanceVariableNameOption, value: "required")
    RuleOptionOption.create(rule_option: namingMemoizedInstanceVariableNameOption, value: "optional")

    namingMethodName = Rule.create(name: "Naming/MethodName", slug: "Naming/MethodName", description: "This cop makes sure that all methods use the configured style, snake_case or camelCase, for their names.", type: "Naming Cops", linter: rubocop)
    namingMethodNameOption = RuleOption.create( name: "Snake or Camel case", slug: "EnforcedStyle", value: "", value_type: "array-single", description: "Prefered snake or camel case for methods names.", rule: namingMethodName)
    RuleOptionOption.create(rule_option: namingMethodNameOption, value: "snake_case")
    RuleOptionOption.create(rule_option: namingMethodNameOption, value: "camelCase")

    namingPredicateName = Rule.create(name: "Naming/PredicateName", slug: "Naming/PredicateName", description: "This cop makes sure that predicates are named properly.", type: "Naming Cops", linter: rubocop)

    #namingUncommunicativeBlockParamName = Rule.create(name: "Naming/UncommunicativeBlockParamName", slug: "Naming/UncommunicativeBlockParamName", description: "This cop checks for non-ascii characters in identifier names.", type: "Naming Cops", linter: rubocop)
    #namingUncommunicativeBlockParamName -- Highly customizable so hard to implement atm

    namingUncommunicativeMethodParamName = Rule.create(name: "Naming/UncommunicativeMethodParamName", slug: "Naming/UncommunicativeMethodParamName", description: "This cop checks method parameter names for how descriptive they are. It is highly configurable.\n\nThe MinNameLength config option takes an integer. It represents the minimum amount of characters the name must be. Its default is 3. The AllowNamesEndingInNumbers config option takes a boolean. When set to false, this cop will register offenses for names ending with numbers. Its default is false. The AllowedNames config option takes an array of whitelisted names that will never register an offense. The ForbiddenNames config option takes an array of blacklisted names that will always register an offense.", type: "Naming Cops", linter: rubocop)
    #namingUncommunicativeMethodParamName -- Highly customizable so hard to implement atm

    namingVariableName = Rule.create(name: "Naming/VariableName", slug: "Naming/VariableName", description: "This cop makes sure that all variables use the configured style, snake_case or camelCase, for their names.", type: "Naming Cops", linter: rubocop)
    namingVariableNameOption = RuleOption.create( name: "Snake or Camel case", slug: "EnforcedStyle", value: "", value_type: "array-single", description: "Prefered snake or camel case for variable names.", rule: namingVariableName)
    RuleOptionOption.create(rule_option: namingVariableNameOption, value: "snake_case")
    RuleOptionOption.create(rule_option: namingVariableNameOption, value: "camelCase")

    namingVariableNumber = Rule.create(name: "Naming/VariableNumber", slug: "Naming/VariableNumber", description: "This cop makes sure that all numbered variables use the configured style, snake_case, normalcase, or non_integer, for their numbering.", type: "Naming Cops", linter: rubocop)
    namingVariableNumberOption = RuleOption.create( name: "Snake or Camel case", slug: "EnforcedStyle", value: "", value_type: "array-single", description: "Option examples: snake_case: variable_1 = 1 \nnormalcase: variable1 = 1 \non_integer: variable_one = 1.", rule: namingVariableNumber)
    RuleOptionOption.create(rule_option: namingVariableNumberOption, value: "normalcase")
    RuleOptionOption.create(rule_option: namingVariableNumberOption, value: "snake_case")
    RuleOptionOption.create(rule_option: namingVariableNumberOption, value: "non_integer")
    #Performance
    performanceCaller = Rule.create(name: "Performance/Caller", slug: "Performance/Caller", description: "This cop identifies places where caller[n] can be replaced by caller(n..n).first.", type: "Performance Cops", linter: rubocop)

    performanceCaseWhenSplat = Rule.create(name: "Performance/CaseWhenSplat", slug: "Performance/CaseWhenSplat", description: "Reordering when conditions with a splat to the end of the when branches can improve performance.\n\nRuby has to allocate memory for the splat expansion every time that the case when statement is run. Since Ruby does not support fall through inside of case when, like some other languages do, the order of the when branches should not matter. By placing any splat expansions at the end of the list of when branches we will reduce the number of times that memory has to be allocated for the expansion. The exception to this is if multiple of your when conditions can be true for any given condition. A likely scenario for this defining a higher level when condition to override a condition that is inside of the splat expansion.\n\nThis is not a guaranteed performance improvement. If the data being processed by the case condition is normalized in a manner that favors hitting a condition in the splat expansion, it is possible that moving the splat condition to the end will use more memory, and run slightly slower.", type: "Performance Cops", linter: rubocop)
    #performanceCaseWhenSplat -- has an auto correct option but it is labeled as unsafe.

    performanceCasecmp = Rule.create(name: "Performance/Casecmp", slug: "Performance/Casecmp", description: "This cop identifies places where a case-insensitive string comparison can better be implemented using casecmp.", type: "Performance Cops", linter: rubocop)

    performanceChainArrayAllocation = Rule.create(name: "Performance/ChainArrayAllocation", slug: "Performance/ChainArrayAllocation", description: "This cop is used to identify usages of Each of these methods (compact, flatten, map) will generate a new intermediate array that is promptly thrown away. Instead it is faster to mutate when we know it's safe.", type: "Performance Cops", linter: rubocop)

    performanceCompareWithBlock = Rule.create(name: "Performance/CompareWithBlock", slug: "Performance/CompareWithBlock", description: "This cop identifies places where sort { |a, b| a.foo <=> b.foo } can be replaced by sort_by(&:foo). This cop also checks max and min methods.", type: "Performance Cops", linter: rubocop)

    performanceCount = Rule.create(name: "Performance/Count", slug: "Performance/Count", description: "This cop is used to identify usages of count on an Enumerable that follow calls to select or reject. Querying logic can instead be passed to the count call. \n\n ActiveRecord compatibility: ActiveRecord will ignore the block that is passed to count. Other methods, such as select, will convert the association to an array and then run the block on the array. A simple work around to make count work with a block is to call to_a.count {...}. \n Example: Model.where(id: [1, 2, 3].select { |m| m.method == true }.size \n becomes:\n \n Model.where(id: [1, 2, 3]).to_a.count { |m| m.method == true }.", fixable: true, options: "true", type: "Performance Cops", linter: rubocop)
    performanceCountOption = RuleOption.create( name: "SafeMode Enabled", slug: "SafeMode", value: "", value_type: "boolean", description: "Enable common functionality for Rails safe mode.", rule: performanceCount)

    performanceDetect = Rule.create(name: "Performance/Detect", slug: "Performance/Detect", description: "This cop is used to identify usages of select.first, select.last, find_all.first, and find_all.last and change them to use detect instead.\n\nActiveRecord compatibility: ActiveRecord does not implement a detect method and find has its own meaning. Correcting ActiveRecord methods with this cop should be considered unsafe.", fixable: true, options: "true", type: "Performance Cops", linter: rubocop)
    performanceDetectOption = RuleOption.create( name: "SafeMode Enabled", slug: "SafeMode", value: "", value_type: "boolean", description: "Enable common functionality for Rails safe mode.", rule: performanceDetect)

    performanceDoubleStartEndWith = Rule.create(name: "Performance/DoubleStartEndWith", slug: "Performance/DoubleStartEndWith", description: "This cop checks for double #start_with? or #end_with? calls separated by ||. In some cases such calls can be replaced with an single #start_with?/#end_with? call.", fixable: true, options: "false", type: "Performance Cops", linter: rubocop)
    performanceDoubleStartEndWithOption = RuleOption.create( name: "Include Active Support Aliases", slug: "IncludeActiveSupportAliases", value: "", value_type: "boolean", description: "", rule: performanceDoubleStartEndWith)


    performanceEndWith = Rule.create(name: "Performance/EndWith", slug: "Performance/EndWith", description: "This cop identifies unnecessary use of a regex where String#end_with? would suffice.", type: "Performance Cops", linter: rubocop)
    #performanceEndWith -- has an auto correct option but it is labeled as unsafe.

    performanceFixedSize = Rule.create(name: "Performance/FixedSize", slug: "Performance/FixedSize", description: "Do not compute the size of statically sized objects.", type: "Performance Cops", linter: rubocop)

    performanceFlatMap = Rule.create(name: "Performance/FlatMap", slug: "Performance/FlatMap", description: "This cop is used to identify usages of.", options:"false", type: "Performance Cops", linter: rubocop)
    performanceFlatMapOption = RuleOption.create( name: "Enabled For Flatten Without Params", slug: "EnabledForFlattenWithoutParams", value: "", value_type: "boolean", description: "", rule: performanceFlatMap)

    performanceInefficientHashSearch = Rule.create(name: "Performance/InefficientHashSearch", slug: "Performance/InefficientHashSearch", description: "This cop checks for inefficient searching of keys and values within hashes.\n Hash#keys.include? is less efficient than Hash#key? because the former allocates a new array and then performs an O(n) search through that array, while Hash#key? does not allocate any array and performs a faster O(1) search for the key.\n Hash#values.include? is less efficient than Hash#value?. While they both perform an O(n) search through all of the values, calling values allocates a new array while using value? does not.", fixable: true, type: "Performance Cops", linter: rubocop)

    performanceLstripRstrip = Rule.create(name: "Performance/LstripRstrip", slug: "Performance/LstripRstrip", description: "This cop identifies places where lstrip.rstrip can be replaced by strip.", fixable: true, type: "Performance Cops", linter: rubocop)

    #This rules doesn't work
    #performanceOpenStruct = Rule.create(name: "Performance/OpenStruct", slug: "Performance/OpenStruct", description: "This cop checks for OpenStruct.new calls. Instantiation of an OpenStruct invalidates Ruby global method cache as it causes dynamic method definition during program runtime. This could have an effect on performance, especially in case of single-threaded applications with multiple OpenStruct instantiations.", type: "Performance Cops", linter: rubocop)

    performanceRangeInclude = Rule.create(name: "Performance/RangeInclude", slug: "Performance/RangeInclude", description: "This cop identifies uses of Range#include?, which iterates over each item in a Range to see if a specified item is there. In contrast, Range#cover? simply compares the target item with the beginning and end points of the Range. In a great majority of cases, this is what is wanted.", type: "Performance Cops", linter: rubocop)

    performanceRedundantBlockCall = Rule.create(name: "Performance/RedundantBlockCall", slug: "Performance/RedundantBlockCall", description: "This cop identifies the use of a &block parameter and block.call where yield would do just as well.", type: "Performance Cops", linter: rubocop)

    performanceRedundantMatch = Rule.create(name: "Performance/RedundantMatch", slug: "Performance/RedundantMatch", description: "This cop identifies the use of Regexp#match or String#match, which returns #<MatchData>/nil. The return value of =~ is an integral index/nil and is more performant.", type: "Performance Cops", linter: rubocop)

    performanceRedundantMerge = Rule.create(name: "Performance/RedundantMerge", slug: "Performance/RedundantMerge", description: "This cop identifies places where Hash#merge! can be replaced by Hash#[]=.", options: 2, type: "Performance Cops", linter: rubocop)
    performanceRedundantMergeOption = RuleOption.create( name: "Set max key value pairs", slug: "MaxKeyValuePairs", value: "", value_type: "integer", description: "", rule: performanceRedundantMergeOption)

    performanceRedundantSortBy = Rule.create(name: "Performance/RedundantSortBy", slug: "Performance/RedundantSortBy", description: "This cop identifies places where sort_by { ... } can be replaced by sort.", type: "Performance Cops", linter: rubocop)

    performanceRegexpMatch = Rule.create(name: "Performance/RegexpMatch", slug: "Performance/RegexpMatch", description: "In Ruby 2.4, String#match?, Regexp#match?, and Symbol#match? have been added. The methods are faster than match. Because the methods avoid creating a MatchData object or saving backref. So, when MatchData is not used, use match? instead of match.", fixable: true, type: "Performance Cops", linter: rubocop)

    performanceReverseEach = Rule.create(name: "Performance/ReverseEach", slug: "Performance/ReverseEach", description: "This cop is used to identify usages of reverse.each and change them to use reverse_each instead.", fixable: true, type: "Performance Cops", linter: rubocop)

    performanceSize = Rule.create(name: "Performance/Size", slug: "Performance/Size", description: "This cop is used to identify usages of count on an Array and Hash and change them to size.", fixable: true, type: "Performance Cops", linter: rubocop)

    performanceStartWith = Rule.create(name: "Performance/StartWith", slug: "Performance/StartWith", description: "This cop identifies unnecessary use of a regex where String#start_with? would suffice.", type: "Performance Cops", linter: rubocop)
    #performanceStartWith -- has an auto correct option but it is labeled as unsafe.

    performanceStringReplacement = Rule.create(name: "Performance/StringReplacement", slug: "Performance/StringReplacement", description: "This cop identifies places where gsub can be replaced by tr or delete.", type: "Performance Cops", linter: rubocop)

    performanceTimesMap = Rule.create(name: "Performance/TimesMap", slug: "Performance/TimesMap", description: "This cop checks for .times.map calls. In most cases such calls can be replaced with an explicit array creation.", type: "Performance Cops", linter: rubocop)
    #performanceTimesMap -- has an auto correct option but it is labeled as unsafe.

    performanceUnfreezeString = Rule.create(name: "Performance/UnfreezeString", slug: "Performance/UnfreezeString", description: "In Ruby 2.3 or later, use unary plus operator to unfreeze a string literal instead of String#dup and String.new. Unary plus operator is faster than String#dup. Note: String.new (without operator) is not exactly the same as +''. These differ in encoding. String.new.encoding is always ASCII-8BIT. However, (+'').encoding is the same as script encoding(e.g. UTF-8). So, if you expect ASCII-8BIT encoding, disable this cop.", type: "Performance Cops", linter: rubocop)


    performanceUnneededSort = Rule.create(name: "Performance/UnneededSort", slug: "Performance/UnneededSort", description: "This cop is used to identify instances of sorting and then taking only the first or last element. The same behavior can be accomplished without a relatively expensive sort by using Enumerable#min instead of sorting and taking the first element and Enumerable#max instead of sorting and taking the last element. Similarly, Enumerable#min_by and Enumerable#max_by can replace Enumerable#sort_by calls after which only the first or last element is used.", fixable: true, type: "Performance Cops", linter: rubocop)

    performanceUriDefaultParser = Rule.create(name: "Performance/UriDefaultParser", slug: "Performance/UriDefaultParser", description: "This cop is used to identify instances of sorting and then taking only the first or last element. The same behavior can be accomplished without a relatively expensive sort by using Enumerable#min instead of sorting and taking the first element and Enumerable#max instead of sorting and taking the last element. Similarly, Enumerable#min_by and Enumerable#max_by can replace Enumerable#sort_by calls after which only the first or last element is used.", fixable: true, type: "Performance Cops", linter: rubocop)

    performanceUnneededSort = Rule.create(name: "Performance/UnneededSort", slug: "Performance/UnneededSort", description: "This cop identifies places where URI::Parser.new can be replaced by URI::DEFAULT_PARSER.", fixable: true, type: "Performance Cops", linter: rubocop)

    #Rails
    railsActionFilter = Rule.create(name: "Rails/ActionFilter", slug: "Rails/ActionFilter", description: "This cop enforces the consistent use of action filter methods. If the TargetRailsVersion is set to less than 4.0, the cop will enforce the use of filter methods.", fixable: true, type: "Rails Cops", linter: rubocop)
    railsActionFilterOption = RuleOption.create( name: "Enforce something_filter or something_action methods", slug: "EnforcedStyle", value: "", value_type: "array-single", description: "Enforce the use of the older something_filter methods or the newer something_action methods.", rule: namingVariableNumber)
    RuleOptionOption.create(rule_option: namingVariableNumberOption, value: "action")
    RuleOptionOption.create(rule_option: namingVariableNumberOption, value: "filter")

    railsActiveRecordAliases = Rule.create(name: "Rails/ActiveRecordAliases", slug: "Rails/ActiveRecordAliases", description: "Checks that ActiveRecord aliases are not used. The direct method names are more clear and easier to read.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsActiveSupportAliases = Rule.create(name: "Rails/ActiveSupportAliases", slug: "Rails/ActiveSupportAliases", description: "This cop checks that ActiveSupport aliases to core ruby methods are not used.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsApplicationJob = Rule.create(name: "Rails/ApplicationJob", slug: "Rails/ApplicationJob", description: "This cop checks that jobs subclass ApplicationJob with Rails 5.0.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsApplicationRecord = Rule.create(name: "Rails/ApplicationRecord", slug: "Rails/ApplicationRecord", description: "This cop checks that models subclass ApplicationRecord with Rails 5.0.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsAssertNot = Rule.create(name: "Rails/AssertNot", slug: "Rails/AssertNot", description: "Use assert_not instead of 'assert !' .", fixable: true, type: "Rails Cops", linter: rubocop)

    railsBlank = Rule.create(name: "Rails/Blank", slug: "Rails/Blank", description: "This cop checks for code that can be written with simpler conditionals using Object#blank? defined by Active Support.", options: "true", type: "Rails Cops", linter: rubocop)
    railsBlankNilOrEmptyOption = RuleOption.create( name: "Nil Or Empty", slug: "NilOrEmpty", value: "", value_type: "boolean", description: "Converts usages of `nil? || empty?` to `blank?`.", rule: railsBlank)
    railsBlankNotPresentOption = RuleOption.create( name: "Not Present", slug: "NotPresent", value: "", value_type: "boolean", description: "Converts usages of `!present?` to `blank?`.", rule: railsBlank)
    railsBlankUnlessPresentOption = RuleOption.create( name: "Unless Present", slug: "UnlessPresent", value: "", value_type: "boolean", description: "Converts usages of `unless present?` to `if blank?`.", rule: railsBlank)

    #Rails/BulkChangeTable -- too specific to be applied

    railsCreateTableWithTimestamps = Rule.create(name: "Rails/CreateTableWithTimestamps", slug: "Rails/CreateTableWithTimestamps", description: "This cop checks the migration for which timestamps are not included when creating a new table. In many cases, timestamps are useful information and should be added.", type: "Rails Cops", linter: rubocop)
    #Rails/CreateTableWithTimestamps -- option too specific to implement

    railsCreateTableWithTimestamps = Rule.create(name: "Rails/CreateTableWithTimestamps", slug: "Rails/CreateTableWithTimestamps", description: "This cop checks the migration for which timestamps are not included when creating a new table. In many cases, timestamps are useful information and should be added.", type: "Rails Cops", linter: rubocop)

    railsDate = Rule.create(name: "Rails/Date", slug: "Rails/Date", description: "This cop checks for the correct use of Date methods, such as Date.today, Date.current etc. Using Date.today is dangerous, because it doesn't know anything about Rails time zone. You must use Time.zone.today instead.", type: "Rails Cops", linter: rubocop)

    railsDelegate = Rule.create(name: "Rails/Delegate", slug: "Rails/Delegate", description: "is cop looks for delegations that could have been created automatically with the delegate method.\n'Safe navigation &. is ignored because Rails' allow_nil option checks not just for nil but also delegates if nil responds to the delegated method.", fixable: true, options: "true", type: "Rails Cops", linter: rubocop)
    railsDelegateOption = RuleOption.create( name: "Enforce For Prefixed", slug: "EnforceForPrefixed", value: "", value_type: "EnforceForPrefixed", description: "The EnforceForPrefixed option (defaulted to true) means that using the target object as a prefix of the method name without using the delegate method will be a violation. When set to false, this case is legal.", rule: railsDelegate)

    railsDelegateAllowBlank = Rule.create(name: "Rails/DelegateAllowBlank", slug: "Rails/DelegateAllowBlank", description: "This cop looks for delegations that pass :allow_blank as an option instead of :allow_nil. :allow_blank is not a valid option to pass to ActiveSupport#delegate.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsDynamicFindBy = Rule.create(name: "Rails/DynamicFindBy", slug: "Rails/DynamicFindBy", description: "This cop checks dynamic find_by_* methods. Use find_by instead of dynamic method. See. https://github.com/rubocop-hq/rails-style-guide#find_by.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsEnumUniqueness = Rule.create(name: "Rails/EnumUniqueness", slug: "Rails/EnumUniqueness", description: "This cop looks for duplicate values in enum declarations.", type: "Rails Cops", linter: rubocop)

    railsEnvironmentComparison = Rule.create(name: "Rails/EnvironmentComparison", slug: "Rails/EnvironmentComparison", description: "This cop checks that Rails.env is compared using .production?-like methods instead of equality against a string or symbol.", type: "Rails Cops", linter: rubocop)

    railsExit = Rule.create(name: "Rails/Exit", slug: "Rails/Exit", description: "This cop enforces that exit calls are not used within a rails app. Valid options are instead to raise an error, break, return, or some other form of stopping execution of current request.", type: "Rails Cops", linter: rubocop)

    railsFilePath = Rule.create(name: "Rails/FilePath", slug: "Rails/FilePath", description: "This cop is used to identify usages of file path joining process to use Rails.root.join clause. It is used to add uniformity when joining paths.", type: "Rails Cops", linter: rubocop)

    railsFindBy = Rule.create(name: "Rails/FindBy", slug: "Rails/FindBy", description: "Disallow the use of where.first, enforce find_by instead.", type: "Rails Cops", linter: rubocop)

    railsFindBy = Rule.create(name: "Rails/FindBy", slug: "Rails/FindBy", description: "Disallow the use of where.first, enforce find_by instead.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsFindEach = Rule.create(name: "Rails/FindEach", slug: "Rails/FindEach", description: "This cop is used to identify usages of all.each and change them to use all.find_each instead.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsHasAndBelongsToMany = Rule.create(name: "Rails/HasAndBelongsToMany", slug: "Rails/HasAndBelongsToMany", description: "This cop checks for the use of the has_and_belongs_to_many macro.", type: "Rails Cops", linter: rubocop)

    railsHasManyOrHasOneDependent = Rule.create(name: "Rails/HasManyOrHasOneDependent", slug: "Rails/HasManyOrHasOneDependent", description: "This cop looks for has_many or has_one associations that don't specify a :dependent option. It doesn't register an offense if :through option was specified.", type: "Rails Cops", linter: rubocop)

    railsHttpPositionalArguments = Rule.create(name: "Rails/HttpPositionalArguments", slug: "Rails/HttpPositionalArguments", description: "This cop is used to identify usages of http methods like get, post, put, patch without the usage of keyword arguments in your tests and change them to use keyword args. This cop only applies to Rails >= 5. If you are running Rails < 5 you should disable the Rails/HttpPositionalArguments cop or set your TargetRailsVersion in your .rubocop.yml file to 4.0, etc.", type: "Rails Cops", linter: rubocop)

    railsHttpStatus = Rule.create(name: "Rails/HttpStatus", slug: "Rails/HttpStatus", description: "Enforces use of symbolic or numeric value to define HTTP status.", fixable: true, type: "Rails Cops", linter: rubocop)
    railsHttpStatusOption = RuleOption.create( name: "Enforce status code as numeric or symbolic value", slug: "EnforcedStyle", value: "", value_type: "array-single", description: "", rule: railsHttpStatus)
    RuleOptionOption.create(rule_option: railsHttpStatusOption, value: "symbolic")
    RuleOptionOption.create(rule_option: railsHttpStatusOption, value: "numeric")

    railsInverseOf = Rule.create(name: "Rails/InverseOf", slug: "Rails/InverseOf", description: "This cop looks for has_(one|many) and belongs_to associations where Active Record can't automatically determine the inverse association because of a scope or the options used. Using the blog with order scope example below, traversing the a Blog's association in both directions with blog.posts.first.blog would cause the blog to be loaded from the database twice.\n\n:inverse_of must be manually specified for Active Record to use the associated object in memory, or set to false to opt-out. Note that setting nil does not stop Active Record from trying to determine the inverse automatically, and is not considered a valid value for this.", type: "Rails Cops", linter: rubocop)

    railsLexicallyScopedActionFilter = Rule.create(name: "Rails/LexicallyScopedActionFilter", slug: "Rails/LexicallyScopedActionFilter", description: "This cop checks that methods specified in the filter's only or except options are defined within the same class or module.\n\n
    You can technically specify methods of superclass or methods added by mixins on the filter, but these confuse developers. If you specify methods that are defined in other classes or modules, you should define the filter in that class or module.", type: "Rails Cops", linter: rubocop)

    railsNotNullColumn = Rule.create(name: "Rails/NotNullColumn", slug: "Rails/NotNullColumn", description: "This cop checks for add_column call with NOT NULL constraint in migration file.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsOutput = Rule.create(name: "Rails/Output", slug: "Rails/Output", description: "This cop checks for the use of output calls like puts and print.", type: "Rails Cops", linter: rubocop)

    railsOutputSafety = Rule.create(name: "Rails/OutputSafety", slug: "Rails/OutputSafety", description: "This cop checks for the use of output safety calls like html_safe, raw, and safe_concat. These methods do not escape content. They simply return a SafeBuffer containing the content as is. Instead, use safe_join to join content and escape it and concat to concatenate content and escape it, ensuring its safety.", type: "Rails Cops", linter: rubocop)

    railsPluralizationGrammar = Rule.create(name: "Rails/PluralizationGrammar", slug: "Rails/PluralizationGrammar", description: "This cop checks for correct grammar when using ActiveSupport's core extensions to the numeric classes.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsPresence = Rule.create(name: "Rails/Presence", slug: "Rails/Presence", description: "This cop checks code that can be written more easily using Object#presence defined by Active Support.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsPresent = Rule.create(name: "Rails/Present", slug: "Rails/Present", description: "This cop checks for code that can be written with simpler conditionals using Object#present? defined by Active Support.", fixable: true, type: "Rails Cops", linter: rubocop)
    railsBlankNotNilAndNotEmptyOption = RuleOption.create( name: "Not Nil And Not Empty", slug: "NotNilAndNotEmpty", value: "", value_type: "boolean", description: "Converts usages of `!nil? && !empty?` to `present?`", rule: railsPresent)
    railsBlankNotBlankOption = RuleOption.create( name: "Not Blank", slug: "NotBlank", value: "", value_type: "boolean", description: "Converts usages of `!blank?` to `present?`", rule: railsPresent)
    railsBlankUnlessBlankOption = RuleOption.create( name: "Unless Blank", slug: "UnlessBlank", value: "", value_type: "boolean", description: "Converts usages of `unless blank?` to `if present?`", rule: railsPresent)

    railsReadWriteAttribute = Rule.create(name: "Rails/ReadWriteAttribute", slug: "Rails/ReadWriteAttribute", description: "This cop checks for the use of the read_attribute or write_attribute methods and recommends square brackets instead. If an attribute is missing from the instance (for example, when initialized by a partial select) then read_attribute will return nil, but square brackets will raise an ActiveModel::MissingAttributeError. Explicitly raising an error in this situation is preferable, and that is why rubocop recommends using square brackets.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsRedundantReceiverInWithOptions = Rule.create(name: "Rails/RedundantReceiverInWithOptions", slug: "Rails/RedundantReceiverInWithOptions", description: "This cop checks for the use of the read_attribute or write_attribute methods and recommends square brackets instead. If an attribute is missing from the instance (for example, when initialized by a partial select) then read_attribute will return nil, but square brackets will raise an ActiveModel::MissingAttributeError. Explicitly raising an error in this situation is preferable, and that is why rubocop recommends using square This cop checks for redundant receiver in with_options. Receiver is implicit from Rails 4.2 or higher.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsRefuteMethods = Rule.create(name: "Rails/RefuteMethods", slug: "Rails/RefuteMethods", description: "Use assert_not methods instead of refute methods.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsRelativeDateConstant = Rule.create(name: "Rails/RelativeDateConstant", slug: "Rails/RelativeDateConstant", description: "This cop checks whether constant value isn't relative date. Because the relative date will be evaluated only once.", fixable: true, type: "Rails Cops", linter: rubocop)

    railsRequestReferer = Rule.create(name: "Rails/RequestReferer", slug: "Rails/RequestReferer", description: "This cop checks for consistent uses of request.referer or request.referrer, depending on the cop's configuration.", fixable: true, type: "Rails Cops", linter: rubocop)
    railsRequestRefererOption = RuleOption.create( name: "Enforce uses of request.referer or request.referrer", slug: "EnforcedStyle", value: "", value_type: "array-single", description: "", rule: railsHttpStatus)
    RuleOptionOption.create(rule_option: railsHttpStatusOption, value: "referer")
    RuleOptionOption.create(rule_option: railsHttpStatusOption, value: "referrer")

    railsReversibleMigration = Rule.create(name: "Rails/ReversibleMigration", slug: "Rails/ReversibleMigration", description: "This cop checks whether the change method of the migration file is reversible.", type: "Rails Cops", linter: rubocop)

    railsSafeNavigation = Rule.create(name: "Rails/SafeNavigation", slug: "Rails/SafeNavigation", description: "This cop converts usages of try! to &.. It can also be configured to convert try. It will convert code to use safe navigation if the target Ruby version is set to 2.3+.", options: "false", fixable: true, type: "Rails Cops", linter: rubocop)
    railsSafeNavigationOption = RuleOption.create( name: "Convert Try", slug: "ConvertTry", value: "", value_type: "boolean", description: "Converts try to & also", rule: railsSafeNavigation)

    railsSaveBang = Rule.create(name: "Rails/SaveBang", slug: "Rails/SaveBang", description: "This cop identifies possible cases where Active Record save! or related should be used instead of save because the model might have failed to save and an exception is better than unhandled failure. This will allow: - update or save calls, assigned to a variable, or used as a condition in an if/unless/case statement. - create calls, assigned to a variable that then has a call to persisted?. - calls if the result is explicitly returned from methods and blocks, or provided as arguments. - calls whose signature doesn't look like an ActiveRecord persistence method.", options: "true", fixable: true, type: "Rails Cops", linter: rubocop)
    railsSaveBangOption = RuleOption.create( name: "Allow Implicit Return", slug: "AllowImplicitReturn", value: "", value_type: "boolean", description: "By default it will also allow implicit returns from methods and blocks. that behavior can be turned off with AllowImplicitReturn: false", rule: railsSaveBang)

    railsScopeArgs = Rule.create(name: "Rails/ScopeArgs", slug: "Rails/ScopeArgs", description: "This cop checks for scope calls where it was passed a method (usually a scope) instead of a lambda/proc.", options: "false", type: "Rails Cops", linter: rubocop)

    #railsSkipsModelValidations = Rule.create(name: "Rails/SkipsModelValidations", slug: "Rails/SkipsModelValidations", description: "This cop checks for the use of methods which skip validations which are listed in https://guides.rubyonrails.org/active_record_validations.html#skipping-validations.", options: "false", type: "Rails Cops", linter: rubocop)
    #railsSkipsModelValidations -- hard to implement

    railsTimeZone = Rule.create(name: "Rails/TimeZone", slug: "Rails/TimeZone", description: "This cop checks for the use of Time methods without zone.", type: "Rails Cops", linter: rubocop)
    railsTimeZoneOption = RuleOption.create( name: "Enforce use of Time.zone or also allowed to use Time.in_time_zone", slug: "EnforcedStyle", value: "", value_type: "array-single", description: "When EnforcedStyle is 'strict' then only use of Time.zone is allowed. When EnforcedStyle is 'flexible' then it's also allowed to use Time.in_time_zone", rule: railsTimeZone)
    RuleOptionOption.create(rule_option: railsTimeZoneOption, value: "flexible")
    RuleOptionOption.create(rule_option: railsTimeZoneOption, value: "strict")

    railsUniqBeforePluck = Rule.create(name: "Rails/UniqBeforePluck", slug: "Rails/UniqBeforePluck", description: "Prefer the use of uniq (or distinct), before pluck instead of after.\nThe use of uniq before pluck is preferred because it executes within the database.", type: "Rails Cops", linter: rubocop)
    railsUniqBeforePluckOption = RuleOption.create( name: "Enforce all calls to pluck before uniq are added as offenses or only on a constant", slug: "EnforcedStyle", value: "", value_type: "array-single", description: "When the EnforcedStyle is conservative (the default) then only calls to pluck on a constant (i.e. a model class) before uniq are added as offenses. When the EnforcedStyle is aggressive then all calls to pluck before uniq are added as offenses. This may lead to false positives as the cop cannot distinguish between calls to pluck on an ActiveRecord::Relation vs a call to pluck on an ActiveRecord::Associations::CollectionProxy.", rule: railsTimeZone)
    RuleOptionOption.create(rule_option: railsTimeZoneOption, value: "conservative")
    RuleOptionOption.create(rule_option: railsTimeZoneOption, value: "aggressive")

    railsValidation = Rule.create(name: "Rails/Validation", slug: "Rails/Validation", description: "This cop checks for the use of old-style attribute validation macros.", type: "Rails Cops", linter: rubocop)


    #Security
    securityEval = Rule.create(name: "Security/Eval", slug: "Security/Eval", description: "This cop checks for the use of Kernel#eval and Binding#eval.", type: "Rails Cops", linter: rubocop)

    securityJSONLoad = Rule.create(name: "Security/JSONLoad", slug: "Security/JSONLoad", description: "This cop checks for the use of JSON class methods which have potential security issues.", type: "Rails Cops", linter: rubocop)
    #securityJSONLoad -- Autocorrect is disabled because it's potentially dangerous

    securityMarshalLoad = Rule.create(name: "Security/MarshalLoad", slug: "Security/MarshalLoad", description: "This cop checks for the use of Marshal class methods which have potential security issues leading to remote code execution when loading from an untrusted source.", type: "Rails Cops", linter: rubocop)

    securityOpen = Rule.create(name: "Security/Open", slug: "Security/Open", description: "This cop checks for the use of Kernel#open. Kernel#open enables not only file access but also process invocation by prefixing a pipe symbol (e.g., open(\"| ls\")). So, it may lead to a serious security risk by using variable input to the argument of Kernel#open. It would be better to use File.open, IO.popen or URI#open explicitly.", type: "Security Cops", linter: rubocop)

    securityYAMLLoad = Rule.create(name: "Security/YAMLLoad", slug: "Security/YAMLLoad", description: "This cop checks for the use of YAML class methods which have potential security issues leading to remote code execution when loading from an untrusted source.", type: "Security Cops", linter: rubocop)

    #Style -- Might conflict with prettier, not implemented atm

    #Bundler
    bundlerDuplicatedGem = Rule.create(name: "Bundler/DuplicatedGem", slug: "Bundler/DuplicatedGem", description: "Prevent duplicate gem in gemfile.", type: "Bundler Cops", linter: rubocop)

    bundlerGemComment = Rule.create(name: "Bundler/GemComment", slug: "Bundler/GemComment", description: "Enforce adding a comment describing each gem in your Gemfile.", type: "Bundler Cops", linter: rubocop)

    bundlerInsecureProtocolSource = Rule.create(name: "Bundler/InsecureProtocolSource", slug: "Bundler/InsecureProtocolSource", description: "The symbol argument :gemcutter, :rubygems, and :rubyforge are deprecated. So please change your source to URL string that 'https://rubygems.org' if possible, or 'http://rubygems.org' if not.\n\nThis autocorrect will replace these symbols with 'https://rubygems.org'. Because it is secure, HTTPS request is strongly recommended. And in most use cases HTTPS will be fine.\n\nHowever, it don't replace all sources of http:// with https://. For example, when specifying an internal gem server using HTTP on the intranet, a use case where HTTPS can not be specified was considered. Consider using HTTP only if you can not use HTTPS.", type: "Bundler Cops", linter: rubocop)

    bundlerOrderedGems = Rule.create(name: "Bundler/OrderedGems", slug: "Bundler/OrderedGems", description: "Enforce gems to be alphabetically sorted within groups. Comments are considered group separators.", fixable: true, type: "Bundler Cops", linter: rubocop)

    #Gemspec
    gemspecDuplicatedAssignment = Rule.create(name: "Gemspec/DuplicatedAssignment", slug: "Gemspec/DuplicatedAssignment", description: "An attribute assignment method calls should be listed only once in a gemspec.\n\nAssigning to an attribute with the same name using spec.foo = will be an unintended usage. On the other hand, duplication of methods such as spec.requirements, spec.add_runtime_dependency, and others are permitted because it is the intended use of appending values.", type: "Gemspec Cops", linter: rubocop)

    gemspecOrderedDependencies = Rule.create(name: "Gemspec/OrderedDependencies", slug: "Gemspec/OrderedDependencies", description: "Dependencies in the gemspec should be alphabetically sorted.  Comments are considered group separators.", fixable: true, type: "Gemspec Cops", linter: rubocop)

    gemspecRequiredRubyVersion = Rule.create(name: "Gemspec/RequiredRubyVersion", slug: "Gemspec/RequiredRubyVersion", description: "Checks that required_ruby_version of gemspec and TargetRubyVersion of .rubocop.yml are equal. Thereby, RuboCop to perform static analysis working on the version required by gemspec.", fixable: true, type: "Gemspec Cops", linter: rubocop)

  end
end

   # "no-extend-native": 2, -- SEEMS TO BE CAUSING BUG NOT IMPLEMENTED
   # "no-extra-parens": 0, -- Conflict with Prettier
   # "no-extra-semi": 2,  -- Conflict with Prettier
   # "no-fallthrough": 2, -- Option complicated to implement
   # "no-iterator": 2, -- Obsolete
   # "no-mixed-requires": [0, false], -- too much specific, complicated to implement
   # "no-multiple-empty-lines": [0, {"max": 2}], -- Conflict with Prettier
   # "no-octal-escape": 2, -- not relevant
   # "no-restricted-modules": 0, -- Option complicated to implement
   # "no-sequences": 2, -- Seems to be conflicting
   # "no-space-before-semi": 0,-- Conflict with Prettier
   # "no-spaced-func": 2,-- Conflict with Prettier
   # "no-ternary": 0, -- Subjective
   # "no-trailing-spaces": 2,-- Conflict with Prettier
   # "no-underscore-dangle": 2,-- Conflict with Prettier
   # "no-unexpected-multiline": 2,-- Conflict with Prettier
   # "no-warning-comments": [0, { "terms": ["todo", "fixme", "xxx"], "location": "start" }], -- Options too specific to be implemented
   #no-misleading-character-class -- Weird
