import 'dart:async';
import 'package:aha_flutter_core/channel/platform_channel.dart';
import 'package:aha_flutter_core/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:test_flutter_build/src/core/extensions/context_extension.dart';
import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/colors.dart';
import '../../core/debouncer.dart';
import 'widgets/order_detail_widget/loading_dialog.dart';
import '../../utils/platform_channel.dart';

class MapWidget extends StatefulWidget {
  final Widget? header;
  final Widget? actionMenu;
  final Widget? footer;
  final Widget? onMapWidget;
  final Set<Polyline>? polylines;
  final LatLng? initialCameraPosition;
  final int delayMapMillis;
  final double zoom;
  final Function(
          GoogleMapController controller, MapWidgetController widgetController)?
      onMapCreated;
  final CameraPositionCallback? onCameraMoving;
  final CameraPositionCallback? onCameraMoved;
  final bool myLocationEnabled;
  final double mapBottom;
  static const double defaultZoom = 18.0;
  final bool loadingTransparent;
  final OrderDetailModel order;

  const MapWidget(
      {Key? key,
      this.header,
      this.actionMenu,
      this.footer,
      this.onMapWidget,
      this.onMapCreated,
      this.polylines,
      this.initialCameraPosition,
      this.zoom = defaultZoom,
      this.onCameraMoving,
      this.onCameraMoved,
      this.delayMapMillis = 0,
      this.myLocationEnabled = false,
      this.mapBottom = 100,
      this.loadingTransparent = false,
      required this.order})
      : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with TickerProviderStateMixin {
  final MapWidgetController _mapWidgetController = MapWidgetController();
  late CameraPosition _initialCameraPosition;
  final _defaultCameraPosition =
      const LatLng(10.769556570699754, 106.66369722678648);
  Set<Marker> _markers = {};
  bool _draggable = true;
  final Set<Polyline> _polylines = {};
  AnimationController? _animation;
  final _debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(
      target: widget.initialCameraPosition ?? _defaultCameraPosition,
      zoom: widget.zoom,
    );
    _mapWidgetController.addListener(() {
      setState(() {
        _markers = _mapWidgetController.markers;
        _draggable = _mapWidgetController.draggable;
        if (_draggable == false) {
          _debouncer.cancel();
        }
        _drawPolylines(_mapWidgetController.polylines,
            _mapWidgetController.polylinesAnimation);
      });
    });
    _showLoadingUtilMapCompleted();
  }

  void _showLoadingUtilMapCompleted() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      widget.loadingTransparent
          ? LoadingDialog.showTransparent(context)
          : LoadingDialog.show(context);
      await Future.delayed(const Duration(seconds: 1));
      LoadingDialog.hide();
    });
  }

  @override
  void dispose() {
    _mapWidgetController.dispose();
    _animation?.dispose();
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
                left: 0,
                top: -widget.mapBottom,
                bottom: widget.mapBottom,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _delayMapWidget(),
                    IgnorePointer(
                      child: SizedBox(
                        width: context.screenWidth(),
                        height: context.screenHeight(),
                        child: widget.onMapWidget ?? Container(),
                      ),
                    )
                  ],
                )),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: widget.mapBottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SafeArea(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          widget.header ?? Container(),
                          widget.actionMenu ?? Container(),
                        ],
                      )),
                    ],
                  )),
                  SafeArea(
                    top: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        widget.footer ?? Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _mapWithCoverWidget() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _mapWidget(),
        _coverWidget(),
      ],
    );
  }

  Widget _mapWidget() {
    return AbsorbPointer(
        absorbing: !_draggable,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: 400,
                child: GoogleMap(
                  // mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    widget.onMapCreated?.call(controller, _mapWidgetController);
                    _setMapStyle(controller);
                  },
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  minMaxZoomPreference: const MinMaxZoomPreference(15, null),
                  compassEnabled: false,
                  markers: _markers,
                  polylines: _polylines,
                  onCameraMove: (position) {
                    if (_draggable) {
                      widget.onCameraMoving?.call(position);
                      _debouncer.run(() {
                        if (_draggable) {
                          widget.onCameraMoved?.call(position);
                        }
                      });
                    } else {
                      _debouncer.cancel();
                    }
                  },
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  buildingsEnabled: false,
                ),
              ),
              Positioned(
                bottom: 30.0, // Adjust position as needed
                right: 140.0, // Adjust position as needed
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  onPressed: () {
                    // Handle current location button press (e.g., move camera to current location)
                    print('Current location button pressed!');
                  },
                  child: const Icon(Icons.my_location,
                      color: Colors
                          .blue), // Customize current location icon and set tint color to blue
                  backgroundColor:
                      Colors.white, // Set background color to white
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(40), // Set corner radius to 16
                  ),
                ),
              ),
              Positioned(
                bottom: 30.0, // Adjust position as needed
                right: 20.0, // Adjust position as needed
                width: 110,
                height: 40,
                child: FloatingActionButton(
                  onPressed: () {
                    print('Direction button pressed!');
                    _googleButtonDidTouch();
                  },
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(36), // Set corner radius to 16
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.directions, color: Colors.white),
                      const Text('Điều hướng',
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future _onMyLocationTap() async {
    final currentLocation = await PlatformChannelMethod.getCurrentLocation();
    if (currentLocation != null) {
      /*
final GoogleMapController controller =
          await _mapControllerCompleter.future;
      await controller
          .animateCamera(CameraUpdate.newCameraPosition(_newCamera));
      */
      // _mapWidgetController?.processing(true);
      // _mapController?.moveCamera(CameraUpdate.newLatLngZoom(
      //     LatLng(currentLocation.lat, currentLocation.lng), MapWidget.defaultZoom)
      // );
      // _mapWidgetController?.processing(false);
      // _pickAddressCubit.onMapCameraMoved(
      //     LatLng(currentLocation.lat, currentLocation.lng)
      // );
    }
  }

  void _googleButtonDidTouch() {
    String directionString =
        "https://www.google.com/maps/dir/?api=1&dir_action=navigate";

    String? waypointString;
    final paths = widget.order.path;
    final showUserDirection = true;
    for (var i = 0; i < paths.length; i++) {
      var path = paths[i];
      if (path == paths.first) {
        if (showUserDirection) {
          if (paths.length == 1) {
            var destString = "destination=${path.lat},${path.lng}";
            directionString = "$directionString&$destString";
          } else {
            if (waypointString != null) {
              waypointString = "$waypointString%7C${path.lat},${path.lng}";
            } else {
              waypointString = "waypoints=${path.lat},${path.lng}";
            }
          }
        } else {
          var originString = "origin=${path.lat},${path.lng}";
          directionString = "$directionString&$originString";
        }
      } else if (path == paths.last) {
        var destString = "destination=${path.lat},${path.lng}";
        directionString = "$directionString&$destString";
      } else {
        //Waypoints
        if (waypointString != null) {
          waypointString = "$waypointString%7C${path.lat},${path.lng}";
        } else {
          waypointString = "waypoints=${path.lat},${path.lng}";
        }
      }
    }

    if (waypointString != null) {
      directionString = "$directionString&$waypointString";
    }

    var directionsURL = Uri.parse(directionString);
    launchUrl(directionsURL);
  }

  Widget _delayMapWidget() {
    if (widget.delayMapMillis <= 0) {
      return _mapWithCoverWidget();
    } else {
      return FutureBuilder(
          future: Future.delayed(
              Duration(milliseconds: widget.delayMapMillis), () => true),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return _mapWithCoverWidget();
            } else {
              return Container();
            }
          });
    }
  }

  void _drawPolylines(List<LatLng>? polylines, bool animation) {
    if (_animation != null || _animation?.isAnimating == true) {
      _animation?.stop(canceled: true);
    }
    _polylines.clear();
    if (polylines?.isNotEmpty == true) {
      if (animation) {
        _animatePolylines(polylines!);
      } else {
        setState(() {
          _polylines.add(Polyline(
              polylineId: const PolylineId("Polyline_bg"),
              points: polylines!,
              color: polyline,
              width: 3));
        });
      }
    } else {
      setState(() {});
    }
  }

  void _animatePolylines(List<LatLng> polylines) {
    if (polylines.isNotEmpty == true) {
      final bgPolyline = Polyline(
          polylineId: const PolylineId("Polyline_bg"),
          points: polylines,
          color: secondaryColor.withOpacity(0.5),
          width: 3);
      _polylines.add(bgPolyline);
      _animation = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this, //From the widget
      );
      Animation<int> tween =
          IntTween(begin: 0, end: polylines.length).animate(_animation!);
      tween.addListener(() {
        _polylines.clear();
        final polyline = Polyline(
            polylineId: const PolylineId("Polyline_route"),
            points: polylines.sublist(0, tween.value),
            color: secondaryColor,
            width: 3);
        setState(() {
          _polylines.add(bgPolyline);
          _polylines.add(polyline);
        });
      });
      _animation?.repeat();
    } else {
      setState(() {
        _polylines.clear();
      });
    }
  }

  Future _setMapStyle(GoogleMapController controller) async {
    try {
      String mapStyle = await DefaultAssetBundle.of(context)
          .loadString("res/map/map_style.json");
      controller.setMapStyle(mapStyle);
    } catch (e) {
      logger.e("Set map style error", e);
    }
  }

  Widget _coverWidget() {
    return FutureBuilder(
        future: Future.delayed(Duration.zero, () => true),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          final opacity = snapshot.data == true ? 0.0 : 1.0;
          return IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: opacity,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          );
        });
  }
}

class MapWidgetController extends ChangeNotifier {
  Set<Marker> markers = {};
  bool draggable = true;
  List<LatLng>? polylines;
  bool polylinesAnimation = false;
  int _processing = 0;

  void addMarker(Marker marker) {
    markers.add(marker);
    notifyListeners();
  }

  void addMarkers(Set<Marker> m) {
    markers.addAll(m);
    notifyListeners();
  }

  void clearMarkers() {
    markers.clear();
    notifyListeners();
  }

  void processing(bool p) {
    if (p) {
      _processing++;
    } else {
      _processing--;
      if (_processing < 0) {
        _processing = 0;
      }
    }
    final idle = _processing == 0;
    if (draggable != idle) {
      draggable = idle;
      notifyListeners();
    }
  }

  void animatePolylines(List<LatLng>? points, bool animation) {
    if (points?.isNotEmpty == true) {
      try {
        polylinesAnimation = animation;
        polylines = points;
      } catch (e) {
        polylines = null;
        logger.e("Decode polyline error", e);
      }
    } else {
      polylines = null;
    }
    notifyListeners();
  }

  void clearPolylines() {
    polylines = null;
    notifyListeners();
  }
}
