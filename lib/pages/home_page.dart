import 'dart:math' as math;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
	const HomePage({super.key});

	@override
	State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
		with SingleTickerProviderStateMixin {
	late final AnimationController _animation = AnimationController(
		vsync: this,
		duration: const Duration(milliseconds: 700),
	)..repeat();

	@override
	void dispose() {
		_animation.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				decoration: const BoxDecoration(
					gradient: LinearGradient(
						begin: Alignment.topCenter,
						end: Alignment.bottomCenter,
						colors: [Color(0xff55cfff), Color(0xffd8f5ff)],
					),
				),
				child: Stack(
					children: [
						Positioned.fill(
							child: CustomPaint(painter: _GroundPainter()),
						),
						Center(
							child: AnimatedBuilder(
								animation: _animation,
								builder: (_, _) => CustomPaint(
									size: const Size(240, 330),
									painter: _SonicPainter(_animation.value),
								),
							),
						),
					],
				),
			),
		);
	}
}

class _GroundPainter extends CustomPainter {
	@override
	void paint(Canvas canvas, Size size) {
		final y = size.height * .72;
		canvas.drawRect(Rect.fromLTWH(0, y, size.width, size.height - y),
				Paint()..color = const Color(0xff35b853));
		final paint = Paint()
			..color = Colors.white.withValues(alpha: .75)
			..strokeWidth = 4;
		for (var x = -size.width; x < size.width * 2; x += 75) {
			canvas.drawLine(Offset(x, y + 24), Offset(x + 38, y + 24), paint);
		}
	}

	@override
	bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SonicPainter extends CustomPainter {
	_SonicPainter(this.progress);
	final double progress;

	@override
	void paint(Canvas canvas, Size size) {
		final phase = progress * math.pi * 2;
		final bounce = math.sin(phase * 2) * 4;
		final c = Offset(size.width / 2, size.height * .38 + bounce);
		final blue = Paint()..color = const Color(0xff126de8);
		final navy = Paint()..color = const Color(0xff073c9d);
		final red = Paint()..color = const Color(0xffe52f35);
		final white = Paint()..color = Colors.white;
		final movement = math.sin(phase) * 25;

		final spikes = Path()
			..moveTo(c.dx - 25, c.dy - 30)
			..lineTo(c.dx - 77, c.dy - 65)
			..lineTo(c.dx - 48, c.dy - 25)
			..lineTo(c.dx - 79, c.dy - 20)
			..lineTo(c.dx - 43, c.dy + 2)
			..lineTo(c.dx - 67, c.dy + 27)
			..lineTo(c.dx - 22, c.dy + 12)
			..close();
		canvas.drawPath(spikes, navy);
		canvas.drawCircle(Offset(c.dx - 8, c.dy - 15), 43, blue);
		canvas.drawOval(Rect.fromCenter(center: Offset(c.dx + 20, c.dy - 7), width: 28, height: 35), white);
		canvas.drawOval(Rect.fromCenter(center: Offset(c.dx + 25, c.dy - 7), width: 9, height: 20), navy);
		canvas.drawCircle(Offset(c.dx + 43, c.dy + 9), 7, navy);
		canvas.drawOval(Rect.fromCenter(center: Offset(c.dx, c.dy + 62), width: 52, height: 78), blue);

		final limb = Paint()
			..color = blue as Color
			..strokeWidth = 15
			..strokeCap = StrokeCap.round;
		canvas.drawLine(Offset(c.dx - 20, c.dy + 43), Offset(c.dx - 50, c.dy + 74 + movement), limb);
		canvas.drawLine(Offset(c.dx + 20, c.dy + 43), Offset(c.dx + 50, c.dy + 74 - movement), limb);
		canvas.drawLine(Offset(c.dx - 12, c.dy + 90), Offset(c.dx - 27, c.dy + 138 + movement), limb);
		canvas.drawLine(Offset(c.dx + 12, c.dy + 90), Offset(c.dx + 28, c.dy + 138 - movement), limb);

		final shoe = Paint()
			..color = red as Color
			..strokeWidth = 18
			..strokeCap = StrokeCap.round;
		canvas.drawLine(Offset(c.dx - 31, c.dy + 139 + movement), Offset(c.dx - 3, c.dy + 139 + movement), shoe);
		canvas.drawLine(Offset(c.dx + 22, c.dy + 139 - movement), Offset(c.dx + 51, c.dy + 139 - movement), shoe);
	}

	@override
	bool shouldRepaint(covariant _SonicPainter oldDelegate) => oldDelegate.progress != progress;
}
