import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficaBarras extends StatelessWidget {
  final Map<String, int> datos;
  final String titulo;
  final Color color;

  const GraficaBarras({
    super.key,
    required this.datos,
    required this.titulo,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final fechasOrdenadas = datos.keys.toList()..sort();
    final allValues = datos.values;
    final maxYRaw = allValues.isEmpty ? 0 : allValues.reduce((a, b) => a > b ? a : b);
    final yMax = ((maxYRaw <= 10) ? 10 : (maxYRaw + 2)).toDouble();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 260,
              child: BarChart(
                BarChartData(
                  barGroups: List.generate(fechasOrdenadas.length, (index) {
                    final fecha = fechasOrdenadas[index];
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: (datos[fecha] ?? 0).toDouble(),
                          width: 10,
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [color.withOpacity(0.6), color],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: yMax,
                            color: Colors.grey[200],
                          ),
                        ),
                      ],
                    );
                  }),
                  groupsSpace: 24,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < fechasOrdenadas.length) {
                            return Transform.rotate(
                              angle: -0.5,
                              child: Text(
                                fechasOrdenadas[index],
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          final intValue = value.toInt();
                          if (intValue % 2 == 0) {
                            return Text('$intValue', style: const TextStyle(fontSize: 10));
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(enabled: false),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: yMax,
                ),
                swapAnimationDuration: const Duration(milliseconds: 1000),
                swapAnimationCurve: Curves.easeInOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
