import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:aha_flutter_core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/colors.dart';

class MapUtil {
  MapUtil._();

  static const markerIconSize = 40;
  static const markerDriverIconSize = 20;
  static BitmapDescriptor? suggestIcon;

  static List<LatLng>? decodePolylines(String encodedPath) {
    try {
      final codeUnits = encodedPath.codeUnits;
      int len = encodedPath.length;
      List<LatLng> path = [];
      int index = 0;
      int lat = 0;
      int lng = 0;

      while(index < len) {
        int result = 1;
        int shift = 0;

        int b;
        do {
          b = codeUnits[index++] - 63 - 1;
          result += b << shift;
          shift += 5;
        } while(b >= 31);

        lat += (result & 1) != 0 ? ~(result >> 1) : result >> 1;
        result = 1;
        shift = 0;

        do {
          b = codeUnits[index++] - 63 - 1;
          result += b << shift;
          shift += 5;
        } while(b >= 31);

        lng += (result & 1) != 0 ? ~(result >> 1) : result >> 1;
        path.add(LatLng(lat * 1.0E-5, lng * 1.0E-5));
      }
      return path;
    } catch (e) {
      logger.e("Decode polyline error", e);
      return null;
    }
  }

  // static List<LatLng> erichPointsByDistance(List<LatLng> points) {
  //   try {
  //     if (points.isEmpty) {
  //       return [];
  //     }
  //     final List<LatLng> result = [];
  //     result.add(points[0]);
  //     var minDistance = getMinDistance(points);
  //     for (int i = 0; i < points.length - 1; i++) {
  //       final dLat = points[i+1].latitude - points[i].latitude;
  //       final dLng = points[i+1].longitude - points[i].longitude;
  //       final distance = sqrt(dLat*dLat + dLng*dLng);
  //       final steps = (distance/minDistance).ceil();
  //       for (int j = 1; j <= steps; j++) {
  //         if (j >= steps) {
  //           result.add(points[i+1]);
  //         } else {
  //           final midPoint = LatLng(
  //             points[i].latitude + j*dLat/steps,
  //             points[i].longitude + j*dLng/steps,
  //           );
  //           result.add(midPoint);
  //         }
  //       }
  //     }
  //     return result;
  //   } catch (e) {
  //     logger.e("erichPointsByDistance error", e);
  //     return points;
  //   }
  // }

  // static double getMinDistance(List<LatLng> points) {
  //   var minDistance = 0.1;
  //   for (int i = 0; i < points.length - 1; i++) {
  //     final distance = points[i].distanceTo(points[i+1]);
  //     if (minDistance > distance) {
  //       minDistance = distance;
  //     }
  //   }
  //   return minDistance;
  // }

  static Future<Uint8List> _getBytesFromAsset(String path, int size) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: size, allowUpscaling: true);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future _createMarker(String id, String iconRes, LatLng position, int size, double rotation) async {
    final bytesIcon = await _getBytesFromAsset(iconRes, size);
    final bitmapIcon = BitmapDescriptor.fromBytes(bytesIcon);
    return Marker(
      markerId: MarkerId(id),
      icon: bitmapIcon,
      position: position,
      anchor: const Offset(0.5, 0.75),
      rotation: rotation,
    );
  }

  static Future createPickupMarker(BuildContext context, String id, LatLng position) {
    final size = MediaQuery.of(context).devicePixelRatio * markerIconSize;
    return _createMarker(
        id, "res/images/ic_pickup_map.png", position, size.toInt(), 0);
  }

  static Future createDropOffMarker(BuildContext context, String id, LatLng position) {
    final size = MediaQuery.of(context).devicePixelRatio * markerIconSize;
    return _createMarker(
        id, "res/images/ic_dropoff_map.png", position, size.toInt(), 0);
  }

  static Future createDriverMarker(
      BuildContext context, String id, LatLng position, double rotation) {
    final size = MediaQuery.of(context).devicePixelRatio * markerDriverIconSize;
    return _createMarker(
        id, "res/images/ic_driver.png", position, size.toInt(), rotation);
  }

  static double distance(double lat1, double lon1, double lat2, double lon2) {
  // Based on http://www.ngs.noaa.gov/PUBS_LIB/inverse.pdf
  // using the "Inverse Formula" (section 4)

    int maxLoop = 20;
    // Convert lat/long to radians
    lat1 *= pi / 180.0;
    lat2 *= pi / 180.0;
    lon1 *= pi / 180.0;
    lon2 *= pi / 180.0;

    double a = 6378137.0; // WGS84 major axis
    double b = 6356752.3142; // WGS84 semi-major axis
    double f = (a - b) / a;
    double aSqMinusBSqOverBSq = (a * a - b * b) / (b * b);

    double L = lon2 - lon1;
    double A = 0.0;
    double u1 = atan((1.0 - f) * tan(lat1));
    double u2 = atan((1.0 - f) * tan(lat2));

    double cosU1 = cos(u1);
    double cosU2 = cos(u2);
    double sinU1 = sin(u1);
    double sinU2 = sin(u2);
    double cosU1cosU2 = cosU1 * cosU2;
    double sinU1sinU2 = sinU1 * sinU2;

    double sigma = 0.0;
    double deltaSigma = 0.0;
    double cosSqAlpha = 0.0;
    double cos2SM = 0.0;
    double cosSigma = 0.0;
    double sinSigma = 0.0;
    double cosLambda = 0.0;
    double sinLambda = 0.0;

    double lambda = L; // initial guess
    for (int i = 0; i < maxLoop; i++) {
      double lambdaOrig = lambda;
      cosLambda = cos(lambda);
      sinLambda = sin(lambda);
      double t1 = cosU2 * sinLambda;
      double t2 = cosU1 * sinU2 - sinU1 * cosU2 * cosLambda;
      double sinSqSigma = t1 * t1 + t2 * t2; // (14)
      sinSigma = sqrt(sinSqSigma);
      cosSigma = sinU1sinU2 + cosU1cosU2 * cosLambda; // (15)
      sigma = atan2(sinSigma, cosSigma); // (16)
      double sinAlpha = (sinSigma == 0) ? 0.0 :
      cosU1cosU2 * sinLambda / sinSigma; // (17)
      cosSqAlpha = 1.0 - sinAlpha * sinAlpha;
      cos2SM = (cosSqAlpha == 0) ? 0.0 :
      cosSigma - 2.0 * sinU1sinU2 / cosSqAlpha; // (18)

      double uSquared = cosSqAlpha * aSqMinusBSqOverBSq; // defn
      A = 1 + (uSquared / 16384.0) * // (3)
      (4096.0 + uSquared *
      (-768 + uSquared * (320.0 - 175.0 * uSquared)));
      double B = (uSquared / 1024.0) * // (4)
      (256.0 + uSquared *
      (-128.0 + uSquared * (74.0 - 47.0 * uSquared)));
      double C = (f / 16.0) *
      cosSqAlpha *
      (4.0 + f * (4.0 - 3.0 * cosSqAlpha)); // (10)
      double cos2SMSq = cos2SM * cos2SM;
      deltaSigma = B * sinSigma * // (6)
      (cos2SM + (B / 4.0) *
      (cosSigma * (-1.0 + 2.0 * cos2SMSq) -
      (B / 6.0) * cos2SM *
      (-3.0 + 4.0 * sinSigma * sinSigma) *
      (-3.0 + 4.0 * cos2SMSq)));

      lambda = L +
      (1.0 - C) * f * sinAlpha *
      (sigma + C * sinSigma *
      (cos2SM + C * cosSigma *
      (-1.0 + 2.0 * cos2SM * cos2SM))); // (11)

      double delta = (lambda - lambdaOrig) / lambda;
      if (delta.abs() < 1.0e-12) {
        break;
      }
    }

    return (b * A * (sigma - deltaSigma));
  }

  static Future<BitmapDescriptor> createSuggestionLocationIcon() async {
    final pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final paint = Paint();
    paint.color = Colors.white;
    final center = Offset(16, 16);
    canvas.drawCircle(center, 16, paint);
    paint.color = red;
    canvas.drawCircle(center, 12, paint);
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(32, 32);
    final bytes = await image.toByteData(format: ImageByteFormat.png);
    final bitmapIcon = BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
    return bitmapIcon;
  }

  static Future<Marker> createSuggestionMarker(String markerId, LatLng position) async {
    suggestIcon ??= await createSuggestionLocationIcon();
    return Marker(
        markerId: MarkerId(markerId),
        icon: suggestIcon!,
        position: position
    );
  }

  static LatLngBounds calculateLatLngBounds(List<LatLng> positionList) {
    double southeastLat = 90, northeastLat = -90, southeastLng = 180, northeastLng = -180;
    for (LatLng latLng in positionList) {
      if (latLng.latitude > northeastLat) northeastLat = latLng.latitude;
      if (latLng.latitude < southeastLat) southeastLat = latLng.latitude;
      if (latLng.longitude > northeastLng) northeastLng = latLng.longitude;
      if (latLng.longitude < southeastLng) southeastLng = latLng.longitude;
    }
    if (northeastLat < southeastLat) {
      final temp = southeastLat;
      southeastLat = northeastLat;
      northeastLat = temp;
    }
    return LatLngBounds(
        northeast: LatLng(northeastLat, northeastLng),
        southwest: LatLng(southeastLat, southeastLng)
    );
  }
}