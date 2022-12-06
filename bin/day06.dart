import 'dart:io';

const packetMarkerLength = 4;
const messageMarkerLength = 14;

bool isMarker(List<String> marker, int markerLength) =>
    marker.toSet().length == markerLength;

int findMarkerEndIndex(String packet, int markerLength) {
  for (var idx = 0; idx < packet.length - markerLength; idx++) {
    final potentialMarker = packet.substring(idx, idx + markerLength).split('');
    if (isMarker(potentialMarker, markerLength)) {
      return idx + markerLength;
    }
  }
  return -1;
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day06.txt';
  final data = File(path).readAsLinesSync().first;

  print(findMarkerEndIndex(data, packetMarkerLength));
  print(findMarkerEndIndex(data, messageMarkerLength));
}
// coverage:ignore-end
