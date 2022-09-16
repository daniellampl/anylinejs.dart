@JS()
library anylinejs;

import 'dart:html' as html;
import 'dart:js_util';

import 'package:js/js.dart';

@JS('window.anylinejs.init')
external AnylineJS init(AnylineJSParams params);

@JS('AnylineJS')
class AnylineJS {
  @JS('preload')
  external void preload();

  /// {@template anylinejs.camera}
  /// Camera API
  /// {@endTemplate}
  external CameraAPI get camera;
  external set camera(CameraAPI v);

  /// {@template anyline.stopScanning}
  /// Stops the scan process
  /// {@endTemplate}
  @JS('stopScanning')
  external void stopScanning();

  /// {@template anyline.pauseScanning}
  /// Pause the scan process
  /// {@endTemplate}
  @JS('pauseScanning')
  external void pauseScanning();

  /// {@template anyline.dispose}
  /// Disposes anylineJS by unmounting it from the dom and cleaning up
  /// {@endTemplate}
  @JS('dispose')
  external void dispose();
}

typedef OnErrorAnylineJSCallback = void Function(LegacyErrorObject);

typedef OnLoadAnylineJSCallback = void Function(html.VideoElement);

typedef OnResultAnylineJSCallback = void Function(AnylineJSResult);

typedef OnPerformanceLogAnylineJSCallback = void Function(dynamic);

typedef OnFrameAnylineJSCallback = void Function(String, String);

@JS('AnylineJS')
abstract class _AnylineJS {
  external Promise<String> getFaceAuthToken();

  /// {@template anylinejs.onError}
  /// Callback called when some (not all) Errors occur.
  ///
  /// Since version 31.0.0 (Errors should be catched when calling the methods,
  /// which provides proper stack-trace)
  /// {endTemplate}
  external OnErrorAnylineJSCallback get onError;
  external set onError(OnErrorAnylineJSCallback v);

  /// {@template anylinejs.onLoad}
  /// Callback called when scanning is started.
  ///
  /// Since version 31.0.0 (startScanning is now resolving a Promise).
  /// {@endTemplate}
  external OnLoadAnylineJSCallback get onLoad;
  external set onLoad(OnLoadAnylineJSCallback v);

  /// {@template anylinejs.onResult}
  /// Callback called when a scan yielded in a result.
  /// @endTemplate
  external OnResultAnylineJSCallback get onResult;
  external set onResult(OnResultAnylineJSCallback v);

  /// {@template anylinejs.onPerformanceLog}
  /// Callback called when a scan yielded in a performance log.
  /// @endTemplate
  external OnPerformanceLogAnylineJSCallback get onPerformanceLog;
  external set onPerformanceLog(OnPerformanceLogAnylineJSCallback v);

  /// {@template anylinejs.onFrame}
  /// Callback called before a new frame is being processed.
  /// {@endTemplate}
  external OnFrameAnylineJSCallback get onFrame;
  external set onFrame(OnFrameAnylineJSCallback v);

  /// {@template anylinejs.getState}
  /// Get current state of AnylineJS
  /// {@endTemplate}
  @JS('getState')
  external String getState();

  @JS('handleImageRequest')
  external Promise<void> handleImageRequest();

  /// {@template anylinejs.startScanning}
  /// Starts the scan process
  /// {@endTemplate}
  @JS('startScanning')
  external Promise<html.VideoElement> startScanning();

  /// {@template anylinejs.resumeScanning}
  /// Resumes the scan process
  /// {@endTemplate}
  @JS('resumeScanning')
  external Promise<void> resumeScanning();
}

extension AnylineJSExtensions on AnylineJS {
  Future<String> getFaceAuthToken() {
    return promiseToFuture((this as _AnylineJS).getFaceAuthToken());
  }

  /// {@macro anylinejs.onError}
  OnErrorAnylineJSCallback get onError => (this as _AnylineJS).onError;
  set onError(OnErrorAnylineJSCallback callback) =>
      (this as _AnylineJS).onError = allowInterop(callback);

  /// {@macro anylinejs.onLoad}
  OnLoadAnylineJSCallback get onLoad => (this as _AnylineJS).onLoad;
  set onLoad(OnLoadAnylineJSCallback callback) =>
      (this as _AnylineJS).onLoad = allowInterop(callback);

  /// {@macro anylinejs.onResult}
  OnResultAnylineJSCallback get onResult => (this as _AnylineJS).onResult;
  set onResult(OnResultAnylineJSCallback callback) =>
      (this as _AnylineJS).onResult = allowInterop(callback);

  /// {@macro anylinejs.onPerformanceLog}
  OnPerformanceLogAnylineJSCallback get onPerformanceLog =>
      (this as _AnylineJS).onPerformanceLog;
  set onPerformanceLog(OnPerformanceLogAnylineJSCallback callback) =>
      (this as _AnylineJS).onPerformanceLog = allowInterop(callback);

  /// {@macro anylinejs.onFrame}
  OnFrameAnylineJSCallback get onFrame => (this as _AnylineJS).onFrame;
  set onFrame(OnFrameAnylineJSCallback callback) =>
      (this as _AnylineJS).onFrame = allowInterop(callback);

  /// {@macro anylinejs.getState}
  State getState() {
    switch ((this as _AnylineJS).getState()) {
      case 'initialized':
        return State.initalized;
      case 'paused':
        return State.paused;
      case 'scanning':
        return State.scanning;
      case 'stopped':
        return State.stopped;
      default:
        return State.disposed;
    }
  }

  Future<void> handleImageRequest() {
    return promiseToFuture((this as _AnylineJS).handleImageRequest());
  }

  /// {@macro anylinejs.startScanning}
  Future<html.VideoElement> startScanning() {
    return promiseToFuture((this as _AnylineJS).startScanning());
  }

  /// {@macro anylinejs.resumeScanning}
  Future<void> resumeScanning() {
    return promiseToFuture((this as _AnylineJS).resumeScanning());
  }
}

@JS()
abstract class Promise<T> {
  external factory Promise(
    void Function(void Function(T) resolve, void Function() reject) executor,
  );

  external Promise then(
    void Function(T) onFulfilled, [
    Function() onRejected,
  ]);
}

enum State { initalized, paused, scanning, stopped, disposed }

@anonymous
@JS('AnylineJSParams')
abstract class AnylineJSParams {
  external factory AnylineJSParams({
    required String license,
    required html.HtmlElement element, //HTMLElement
    String? lockPortraitOrientation,
    String? preset,
    bool? preload,
    String? anylinePath,
    AnylineJSConfig? config,
    ViewConfig? viewConfig,
    bool? debugAnyline,
    String? wasmPath,
  });

  /// AnylineJS license string
  external String get license;
  external set license(String v);

  /// HTMLElement where anylineJS should be mounted into
  external html.HtmlElement get element;
  external set element(html.HtmlElement v);

  /// If set locks the screen orientation to portrait.
  external LockPortraitOrientation? get lockPortraitOrientation;
  external set lockPortraitOrientation(LockPortraitOrientation? v);

  /// Module preset
  external String? get preset;
  external set preset(String? v);

  /// Preloads the assets by a given preset (eg. 'barcode')
  external bool? get preload;
  external set preload(bool? v);

  /// Path to anylineJS data assets (defaults to cdn hosted assets)
  external String? get anylinePath;
  external set anylinePath(String? v);

  /// AnylineJS configuration object
  external AnylineJSConfig? get config;
  external set config(AnylineJSConfig? v);

  /// Appearance configuration of the cutout
  external ViewConfig? get viewConfig;
  external set viewConfig(ViewConfig? v);

  /// Flag to output more verbose logs.
  external bool? get debugAnyline;
  external set debugAnyline(bool? v);

  external String? get wasmPath;
  external set wasmPath(String? v);
}

@anonymous
@JS('LockPortraitOrientation')
class LockPortraitOrientation {
  external factory LockPortraitOrientation({
    bool? useFaceAuth,
    bool? estimateMainCamera,
  });

  /// Defines whether or not the screen orientation should be locked to
  /// portrait.
  external bool? get lock;
  external set lock(bool? v);

  /// Element used for fullscreen mode. This is required in order to lock the
  /// screen.
  ///
  /// If no element was set it will default to the element set as root in the
  /// configuration (AnylineJSParams).
  external dynamic get element;
  external set element(dynamic v);
}

@anonymous
@JS('AnylineJSConfig')
class AnylineJSConfig {
  external factory AnylineJSConfig({
    bool? useFaceAuth,
    bool? estimateMainCamera,
    String? loadingScreen,
    bool? coverVideo,
    bool? initialFlashOn,
    bool? scaleDown,
    bool? hideFeedback,
    num? slowMessageTimeout,
    // MediaStreamConstraints? get mediaConstraints
    String? module,
    String? scanMode,
    num? minConfidence,
    String? charWhitelist,
    String? videoSrc,
    bool? retryCameraAccess,
    bool? useFullUrlBundleId,
    num? throttleImagePass,
    bool? mirrorOnDesktop,
  });

  /// Use face authentication
  external bool? get useFaceAuth;
  external set useFaceAuth(bool? v);

  /// Flag to disable camera estimation (not recommended)
  ///
  /// Defaults to `true`.
  external bool? get estimateMainCamera;
  external set estimateMainCamera(bool? v);

  /// HTML string to replace the default loader (`<div>loading...</div>`)
  external String? get loadingScreen;
  external set loadingScreen(String? v);

  /// Reverts a letterboxing fix (not recommended to set to false)
  ///
  /// Defaults to `true`.
  external bool? get coverVideo;
  external set coverVideo(bool? v);

  /// Starts scanning with camera flash state (only Android Chrome support)
  ///
  /// Defaults to `false`.
  external bool? get initialFlashOn;
  external set initialFlashOn(bool? v);

  /// Scales down the processed image for potential performance
  /// boost in a few use cases (barcode)
  ///
  /// Defaults to `false`.
  external bool? get scaleDown;
  external set scaleDown(bool? v);

  /// Hides the visual feedback while scanning
  ///
  /// Defaults to `false`.s
  external bool? get hideFeedback;
  external set hideFeedback(bool? v);

  external num? get slowMessageTimeout;
  external set slowMessageTimeout(num? v);

  /// Overwrite mediaConstraints of the camera feed (i.E to use a certain
  /// resolution or a specific camera)
  // external MediaStreamConstraints? get mediaConstraints;
  // external set mediaConstraints(MediaStreamConstraints? v);

  /// Manually set the scan module being used (not recommended, use the top
  /// level preset parameter)
  external String? get module;
  external set module(String? v);

  external String? get scanMode;
  external set scanMode(String? v);

  /// Percentage of minimal confidence when a result should be returned
  external num? get minConfidence;
  external set minConfidence(num? v);

  /// Limit the scope of characters to be scanned (example "ABCDE0123")
  external String? get charWhitelist;
  external set charWhitelist(String? v);

  /// Https url pointing to a video stream to exchange the camera feed (for
  /// debugging, testing purposes)
  external String? get videoSrc;
  external set videoSrc(String? v);

  /// Flag if the system should retry camera access with fallback default media
  /// constraints
  external bool? get retryCameraAccess;
  external set retryCameraAccess(bool? v);

  /// Flag to consider the whole url path as the bundleId (i.E
  /// example.com/apps/scanner vs. example.com)
  external bool? get useFullUrlBundleId;
  external set useFullUrlBundleId(bool? v);

  /// Throttle the time between processing images (in ms)
  external num? get throttleImagePass;
  external set throttleImagePass(num? v);

  /// Disable mirroring on desktop browsers (i.E if you are using a back-facing
  /// camera on desktop)
  ///
  /// Defaults to`true`.
  external bool? get mirrorOnDesktop;
  external set mirrorOnDesktop(bool? v);
}

@anonymous
@JS('ViewConfig')
class ViewConfig {
  external factory ViewConfig({
    String? outerColor,
    num? outerAlpha,
    String? feedbackAnimationStyle,
    List<Object> cutouts,
  });

  external String? get outerColor;
  external set outerColor(String? v);

  external num? get outerAlpha;
  external set outerAlpha(num? v);

  /// Feedback animation style.
  ///
  /// Defaults to a 'BLINK_ANIMATION' animation.
  ///
  /// blink - sets the feedback to a blink animation (DEFAULT)
  /// path - sets the feedback to a path animation
  external String? get feedbackAnimationStyle;
  external set feedbackAnimationStyle(String? v);

  external List<Object>? get cutouts;
  external set cutouts(List<Object>? v);
}

@anonymous
@JS('AnylineJSResult')
class AnylineJSResult {
  external factory AnylineJSResult({
    required List<dynamic> result,
    required String fullImage,
    required num scanTime,
  });

  external List<dynamic> get result;
  external set result(List<dynamic> v);

  external String get fullImage;
  external set fullImage(String v);

  external num get scanTime;
  external set scanTime(num v);
}

@anonymous
@JS('LegacyErrorObject')
class LegacyErrorObject {
  external factory LegacyErrorObject({
    required num code,
    required String message,
  });

  external num get code;
  external set code(num v);

  external String get message;
  external set message(String v);
}

@anonymous
@JS()
abstract class CameraAPI {
  /// Mirrors the stream (i.E for front-facing cameras)
  external void mirrorStream(bool state);

  /// Sets a specific camera as input
  external void setCamera(String deviceId);

  /// Reappends the camera. This can help in case you experience a camera stream
  /// failure when resuming to the webapp after sleep / longer suspension.
  ///
  /// Example: window.onfocus = () => anyline.camera.reappend();
  external void reappend();
}

@anonymous
@JS()
abstract class _CameraAPI {
  /// Refocus the camera
  ///
  /// This feature works currently only on Google Chrome for Android
  external Promise<void> refocus();

  /// Activates the camera flash light
  ///
  /// This feature works currently only on Google Chrome for Android
  external Promise<void> activateFlash(bool state);
}

extension CameraAPIExtensions on CameraAPI {
  Future<void> refocus() {
    return promiseToFuture((this as _CameraAPI).refocus());
  }

  Future<void> activateFlash(bool state) {
    return promiseToFuture((this as _CameraAPI).activateFlash(state));
  }
}
