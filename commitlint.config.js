export default { 
  extends: [
    '@commitlint/config-conventional',
  ],
  // "parserPreset": {
  //   "parserOpts": {
  //     "headerPattern": "^(\\S+\\s[^\\s(:]+)(?:\\(([^)]+)\\))?:\\s(.+)$",
  //     "headerCorrespondence": ["type", "scope", "subject"]
  //   }
  // },
  "rules": {
    "type-enum": [
      2,
      "always",
      [
        "✨ feat",
        "🐛 fix",
        "♻️ refactor",
        "⚡️ chore",
        "⏪ revert",
        "🚑️ hotfix",
        "🚧 wip",
        "🚀 BREAKING CHANGE",
        "📝 docs",
        "✅ test",
        "🔧 config",
        "🔒 security",
        "⚡ perf",
        "⭐ enhance"
      ]
    ],
    "type-empty": [2, "never"],
    "type-case": [0, "never"],
    "subject-empty": [2, "never"],
    "scope-case": [0, "never"],
    "header-max-length": [2, "always", 160]
  }
};
