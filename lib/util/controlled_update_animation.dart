import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/map/map_paint.dart';
import 'package:bonfire/util/assets_loader.dart';
import 'package:bonfire/util/vector2rect.dart';

class ControlledUpdateAnimation {
  bool _alreadyUpdate = false;
  SpriteAnimation? animation;
  AssetsLoader? _loader;

  ControlledUpdateAnimation(Future<SpriteAnimation> animation) {
    _loader = AssetsLoader();
    _loader?.add(AssetToLoad(animation, (value) => this.animation = value));
  }

  ControlledUpdateAnimation.fromInstance(SpriteAnimation animation) {
    this.animation = animation;
  }

  void render(Canvas canvas, Vector2Rect position) {
    if (animation != null) {
      animation?.getSprite().renderFromVector2Rect(
            canvas,
            position,
            overridePaint: MapPaint.instance.paint,
          );
    }
    _alreadyUpdate = false;
  }

  void update(double dt) {
    if (!_alreadyUpdate) {
      _alreadyUpdate = true;
      animation?.update(dt);
    }
  }

  Future<void> onLoad() async {
    await _loader?.load();
  }
}
