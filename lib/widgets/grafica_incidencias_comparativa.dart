import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficaIncidenciasComparativa extends StatelessWidget {
  final Map<String, int> leves;
  final Map<String, int> moderadas;
  final Map<String, int> graves;

  const GraficaIncidenciasComparativa({
    super.key,
    required this.leves,
    required this.moderadas,
    required this.graves,
  });

  @override
  Widget build(BuildContext context) {
    final fechas = <String>{}..addAll(leves.keys)..addAll(moderadas.keys)..addAll(graves.keys);
    final fechasOrdenadas = fechas.toList()..sort();

    final allValues = [...leves.values, ...moderadas.values, ...graves.values];
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
              "Incidencias por gravedad",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                LegendItem(color: Colors.green, label: 'Leves'),
                SizedBox(width: 12),
                LegendItem(color: Colors.orange, label: 'Moderadas'),
                SizedBox(width: 12),
                LegendItem(color: Colors.red, label: 'Graves'),
              ],
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
                          toY: (leves[fecha] ?? 0).toDouble(),
                          width: 6,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFA8E6CF), Color(0xFF56AB2F)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: yMax,
                            color: Colors.grey[200],
                          ),
                        ),
                        BarChartRodData(
                          toY: (moderadas[fecha] ?? 0).toDouble(),
                          width: 6,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFE082), Color(0xFFFF6F00)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: yMax,
                            color: Colors.grey[200],
                          ),
                        ),
                        BarChartRodData(
                          toY: (graves[fecha] ?? 0).toDouble(),
                          width: 6,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF8A80), Color(0xFFD32F2F)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(12),
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
            )
          ],
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
