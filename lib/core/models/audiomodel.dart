class Audiomodel {
  final String title;
  final String description;
  final String path;
  Audiomodel({
    required this.description,
    required this.path,
    required this.title,
  });
}

final List<Audiomodel> musicList = [
    Audiomodel(
        description: "Birds At Morning",
        path: "audio/birds.mp3",
        title: "Calm"),
    Audiomodel(
        description: "Ocean Sound",
        path: "audio/oceansound.mp3",
        title: "Calm"),
    Audiomodel(
        description: "Heavy Rain", path: "audio/heavyrain.mp3", title: "Calm"),
    Audiomodel(
        description: "Birds At Morning",
        path: "audio/birds.mp3",
        title: "Calm"),
  ];