import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:minor_io/widgets/base_scaffold.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:minor_io/models/nota_diaria.dart';

class DiarioPersonalScreen extends StatefulWidget {
  final String educadorCodigo;
  const DiarioPersonalScreen({super.key, required this.educadorCodigo});

  @override
  State<DiarioPersonalScreen> createState() => _DiarioPersonalScreenState();
}

class _DiarioPersonalScreenState extends State<DiarioPersonalScreen> {
  final TextEditingController _notaController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  bool _mostrarCalendario = false;
  bool _modoEdicion = true;

  List<File> _archivosAdjuntos = [];
  List<String> _tiposArchivos = [];

  late Box<NotaDiaria> _notasBox;

  @override
  void initState() {
    super.initState();
    _abrirCajaHive();
  }

  Future<void> _abrirCajaHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NotaDiariaAdapter());
    }
    _notasBox = await Hive.openBox<NotaDiaria>('notas');
    _loadNotaParaDia(_selectedDay);
  }

  void _loadNotaParaDia(DateTime date) {
    final key = _formatearFecha(date);
    final nota = _notasBox.get(key);
    setState(() {
      _notaController.text = nota?.texto ?? '';
      _archivosAdjuntos = nota?.rutas.map((r) => File(r)).toList() ?? [];
      _tiposArchivos = nota?.tipos ?? [];
      _modoEdicion = nota == null;
    });
  }

  void _guardarNota() {
    final key = _formatearFecha(_selectedDay);
    final nota = NotaDiaria(
      texto: _notaController.text,
      rutas: _archivosAdjuntos.map((f) => f.path).toList(),
      tipos: List<String>.from(_tiposArchivos),
    );
    _notasBox.put(key, nota);
    setState(() {
      _modoEdicion = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Nota guardada")),
    );
  }

  Future<void> _seleccionarImagenes() async {
    final List<XFile> imagenes = await _picker.pickMultiImage();
    if (imagenes.isNotEmpty) {
      setState(() {
        _archivosAdjuntos.addAll(imagenes.map((x) => File(x.path)));
        _tiposArchivos.addAll(List.filled(imagenes.length, 'imagen'));
      });
    }
  }

  Future<void> _seleccionarVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _archivosAdjuntos.add(File(video.path));
        _tiposArchivos.add('video');
      });
    }
  }

  String _formatearFecha(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatearFecha(_selectedDay);
    final tieneAdjunto = _archivosAdjuntos.isNotEmpty;

    return BaseScaffold(
      appBar: AppBar(title: const Text("Diario Personal",
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: _notasBox.isOpen
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_mostrarCalendario)
                    TableCalendar(
                      firstDay: DateTime(2020),
                      lastDay: DateTime(2100),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onDaySelected: (selected, focused) {
                        setState(() {
                          _selectedDay = selected;
                          _focusedDay = focused;
                          _loadNotaParaDia(selected);
                        });
                      },
                      eventLoader: (day) {
                        final formatted = _formatearFecha(day);
                        return _notasBox.containsKey(formatted) ? ['nota'] : [];
                      },
                      calendarStyle: const CalendarStyle(
                        markerDecoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Mes',
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _mostrarCalendario = !_mostrarCalendario;
                          });
                        },
                        icon: const Icon(Icons.calendar_month_outlined, size: 18),
                        label: Text(_mostrarCalendario ? "Ocultar calendario" : "Calendario", 
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size.zero,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notaController,
                    maxLines: 8,
                    readOnly: !_modoEdicion,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Escribe aquí...",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: _modoEdicion ? Colors.white : Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (tieneAdjunto)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(_archivosAdjuntos.length, (index) {
                        final archivo = _archivosAdjuntos[index];
                        final tipo = _tiposArchivos[index];
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                    child: tipo == 'imagen'
                                        ? Image.file(archivo, fit: BoxFit.contain)
                                        : SizedBox(
                                            width: 300,
                                            height: 300,
                                            child: VideoPlayerWidget(videoFile: archivo),
                                          ),
                                  ),
                                );
                              },
                              child: tipo == 'imagen'
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        archivo,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.play_circle_fill, size: 48, color: Colors.white),
                                    ),
                            ),
                            if (_modoEdicion)
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _archivosAdjuntos.removeAt(index);
                                    _tiposArchivos.removeAt(index);
                                  });
                                },
                              ),
                          ],
                        );
                      }),
                    ),
                  const SizedBox(height: 16),
                  if (_modoEdicion) ...[
                    const Text(
                      "Adjuntar Archivos",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: _seleccionarImagenes,
                            icon: const Icon(Icons.image, size: 24),
                            color: Colors.blueAccent,
                            tooltip: 'Seleccionar imágenes',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: _seleccionarVideo,
                            icon: const Icon(Icons.videocam, size: 24),
                            color: Colors.blueAccent,
                            tooltip: 'Seleccionar vídeo',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _guardarNota,
                        icon: const Icon(Icons.save),
                        label: const Text("Guardar Nota", 
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 61, 107, 187)),
                      ),
                    ),
                  ],
                  if (_notasBox.containsKey(formattedDate) && !_modoEdicion)
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _modoEdicion = true;
                            });
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text("Editar",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            _notasBox.delete(formattedDate);
                            setState(() {
                              _modoEdicion = true;
                              _notaController.clear();
                              _archivosAdjuntos.clear();
                              _tiposArchivos.clear();
                            });
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text("Borrar Nota", 
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        ),
                      ],
                    ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;
  const VideoPlayerWidget({super.key, required this.videoFile});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
