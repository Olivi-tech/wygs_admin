class ProgressModel {
  String? name;
  String? leadGuitar;
  String? rhythmGuitar;
  String? bassGuitar;
  String? drums;
  String? mic;
  String? keyboard;
  String? piano;
  ProgressModel({
    this.name,
    this.leadGuitar,
    this.rhythmGuitar,
    this.bassGuitar,
    this.drums,
    this.mic,
    this.keyboard,
    this.piano,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lead_guitar': leadGuitar,
      'rhythm_guitar': rhythmGuitar,
      'bass_guitar': bassGuitar,
      'drums': drums,
      'mic': mic,
      'keyboard': keyboard,
      'piano': piano,
    };
  }

  factory ProgressModel.fromMap(Map<String, dynamic> map) {
    return ProgressModel(
      name: map['name'] != null ? map['name'] as String : null,
      leadGuitar: map['lead_guitar'] != null ? map['lead_guitar'] as String : null,
      rhythmGuitar: map['rhythm_guitar'] != null ? map['rhythm_guitar'] as String : null,
      bassGuitar: map['bass_guitar'] != null ? map['bass_guitar'] as String : null,
      drums: map['drums'] != null ? map['drums'] as String : null,
      mic: map['mic'] != null ? map['mic'] as String : null,
      keyboard: map['keyboard'] != null ? map['keyboard'] as String : null,
      piano: map['piano'] != null ? map['piano'] as String : null,
    );
  }

}
