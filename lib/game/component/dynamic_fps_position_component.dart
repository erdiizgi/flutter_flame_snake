import 'package:flame/components.dart';

abstract class DynamicFpsPositionComponent extends PositionComponent {

  double _fps = 60;
  double _targetDt = 1 / 60;
  double _dtTotal = 0;

  DynamicFpsPositionComponent(double fps) {
    setFps(fps);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _dtTotal += dt;

    if (_dtTotal >= _targetDt) {
      _dtTotal = 0;
      updateDynamic(dt);
    }
  }

  void updateDynamic(double dt);

  void setFps(double fps) {
    _fps = fps;
    _targetDt = 1 / _fps;
  }
}