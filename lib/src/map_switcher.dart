import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:huawei_map/huawei_map.dart' as huawei;

class MapSwitcher extends StatelessWidget {
  final google.LatLng initialTarget;
  final Function(google.GoogleMapController) onMapCreated;
  final Function(google.CameraPosition) onCameraMove;
  final Function() onCameraMoveStarted;
  final Function() onCameraIdle;
  final bool isHuaweiDevice;
  final google.MapType mapType;
  final bool hasLocationPermission;

  const MapSwitcher({
    Key? key,
    required this.initialTarget,
    required this.onMapCreated,
    required this.onCameraMove,
    required this.onCameraMoveStarted,
    required this.onCameraIdle,
    required this.isHuaweiDevice,
    required this.mapType,
    required this.hasLocationPermission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isHuaweiDevice) {
      return huawei.HuaweiMap(
        initialCameraPosition: huawei.CameraPosition(
          target: huawei.LatLng(initialTarget.latitude, initialTarget.longitude),
          zoom: 15,
        ),
        myLocationEnabled: hasLocationPermission,
        myLocationButtonEnabled: false,
        logoPosition: huawei.HuaweiMap.UPPER_LEFT,
        logoPadding: EdgeInsets.only(top: 10, left: 10),
        compassEnabled: false,
        trafficEnabled: false,
        mapType: _convertMapType(mapType),
        onMapCreated: (huawei.HuaweiMapController controller) {
          // TODO: Implement Huawei map controller handling
        },
        onCameraMove: (huawei.CameraPosition position) {
          onCameraMove(google.CameraPosition(
            target: google.LatLng(position.target.lat, position.target.lng),
            zoom: position.zoom,
            tilt: position.tilt,
            bearing: position.bearing,
          ));
        },
        onCameraMoveStarted: (_) {
          onCameraMoveStarted();
        },
        onCameraIdle: () {
          onCameraIdle();
        },
      );
    }

    return google.GoogleMap(
      myLocationButtonEnabled: false,
      mapType: mapType,
      compassEnabled: false,
      mapToolbarEnabled: false,
      initialCameraPosition: google.CameraPosition(target: initialTarget, zoom: 15),
      myLocationEnabled: hasLocationPermission,
      onMapCreated: onMapCreated,
      onCameraIdle: onCameraIdle,
      onCameraMoveStarted: onCameraMoveStarted,
      onCameraMove: onCameraMove,
    );
  }

  huawei.MapType _convertMapType(google.MapType googleMapType) {
    switch (googleMapType) {
      case google.MapType.normal:
        return huawei.MapType.normal;
      case google.MapType.terrain:
        return huawei.MapType.terrain;
      default:
        return huawei.MapType.normal;
    }
  }
}
