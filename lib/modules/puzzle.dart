class Puzzle {
  final String unsolved;
  final String solved;

  const Puzzle({
    required this.unsolved,
    required this.solved,
  });

  factory Puzzle.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'solved': String solved,
        'unsolved': String unsolved,
      } =>
        Puzzle(
          unsolved: unsolved,
          solved: solved,
        ),
      _ => throw const FormatException('Failed to load puzzle'),
    };
  }
}
