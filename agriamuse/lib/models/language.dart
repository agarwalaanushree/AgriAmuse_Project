class Language {
  final int id;
  final String name;
  final String languageCode;

  Language({required this.id, required this.name, required this.languageCode});

  static List<Language> languageList() {
    return <Language>[
      Language(id: 0, name: 'English', languageCode: 'en'),
      Language(id: 1, name: 'हिंदी', languageCode: 'hi'),
    ];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Language &&
          runtimeType == other.runtimeType &&
          languageCode == other.languageCode;

  @override
  int get hashCode => languageCode.hashCode;
}
