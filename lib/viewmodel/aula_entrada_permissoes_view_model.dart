import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

// =============================================================================
// AULA ENTRADA E PERMISSÕES — VIEW MODEL (MVVM) — VERSÃO EXERCÍCIO
// =============================================================================
// Guarda os controllers do formulário (entrada) e o status das permissões.
// Nesta versão, escondemos a lógica principal e marcamos pontos com // TODO
// para vocês implementarem em aula.
// =============================================================================

class AulaEntradaPermissoesViewModel extends ChangeNotifier {
  AulaEntradaPermissoesViewModel() {
    _nomeController = TextEditingController();
    _emailController = TextEditingController();
    _telefoneController = TextEditingController();
  }

  late final TextEditingController _nomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _telefoneController;

  TextEditingController get nomeController => _nomeController;
  TextEditingController get emailController => _emailController;
  TextEditingController get telefoneController => _telefoneController;

  String _cameraStatus = 'Não verificado';
  String _locationStatus = 'Não verificado';
  bool _locationLoading = false;
  bool _cameraLoading = false;

  String get cameraStatus => _cameraStatus;
  String get locationStatus => _locationStatus;
  bool get locationLoading => _locationLoading;
  bool get cameraLoading => _cameraLoading;

  Future<void> requestCamera() async {
    _cameraLoading = true;
    notifyListeners();
    try {
      var status = await Permission.camera.status;
      if (!status.isGranted) {
        status = await Permission.camera.request();
      }
      if (status.isGranted) {
        _cameraStatus = 'Permissão concedida';
      } else if (status.isDenied) {
        _cameraStatus = 'Permissão negada';
      } else if (status.isPermanentlyDenied) {
        _cameraStatus = 'Permissão permanentemente negada';
      } else if (status.isRestricted) {
        _cameraStatus = 'Permissão restrita';
      } else {
        _cameraStatus = 'Status desconhecido';
      }
    } catch (e) {
      _cameraStatus = 'Erro: ${e.toString()}';
    }
    _cameraLoading = false;
    notifyListeners();
  }

  Future<void> requestLocation() async {
    _locationLoading = true;
    notifyListeners();
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _locationStatus = 'Serviço de localização desativado';
        _locationLoading = false;
        notifyListeners();
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        _locationStatus = 'Permissão de localização negada';
      } else if (permission == LocationPermission.deniedForever) {
        _locationStatus = 'Permissão de localização permanentemente negada';
      } else {
        try {
          Position pos = await Geolocator.getCurrentPosition();
          _locationStatus = 'Lat: ${pos.latitude.toStringAsFixed(4)}, Long: ${pos.longitude.toStringAsFixed(4)}';
        } catch (e) {
          _locationStatus = 'Erro ao obter localização: ${e.toString()}';
        }
      }
    } catch (e) {
      _locationStatus = 'Erro: ${e.toString()}';
    }
    _locationLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }
}