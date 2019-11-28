import 'package:flutter/material.dart';

import 'package:physics/physics/particle_system.dart';
import 'package:physics/physics/physics_painter.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

class PhysicsHome extends StatefulWidget {
  @override
  _PhysicsHomeState createState() => _PhysicsHomeState();
}

class _PhysicsHomeState extends State<PhysicsHome>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Offset _offset = Offset(.4, .7);

  ParticleSystem system;

  @override
  initState() {
    super.initState();
    system = ParticleSystem(count: 1);
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..addListener(() {
            system.updateParticles();
          })..addStatusListener((status){
            if(status == AnimationStatus.completed){
              controller.reset();
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    print('being build');
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: GestureDetector(
        onHorizontalDragUpdate: (details){
          controller.reset();
          system.tapPos = Vector2(details.globalPosition.dx,details.globalPosition.dy);
          controller.forward();
        },
        onTap: () {
          controller.forward();
        },
        child: CustomPaint(
          painter: PhysicsPainter(
            system: system,
          ),
          child: Container(
            color: Colors.black12,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    controller.dispose();
    super.dispose();
  }
}
