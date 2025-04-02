// lib/services/slider_service.dart
import 'dart:async';
import '../models/slider_image_model.dart';
import '../utils/mock_data_service.dart';

class SliderService {
  // Singleton pattern
  static final SliderService _instance = SliderService._internal();
  factory SliderService() => _instance;
  SliderService._internal();
  
  // Referência para o serviço de dados
  final _mockDataService = MockDataService();
  
  // Cache de imagens do slider por instituição
  final Map<String, List<SliderImage>> _slidersCache = {};
  
  // Método para obter imagens do slider para uma instituição
  Future<List<SliderImage>> getSlidersByInstitution(String institutionId) async {
    // Verificar se já temos no cache
    if (_slidersCache.containsKey(institutionId)) {
      return _slidersCache[institutionId]!;
    }
    
    try {
      // Obter dados do serviço mock
      final response = await _mockDataService.getSlidersByInstitution(institutionId);
      
      if (response['success']) {
        final List<dynamic> data = response['data'];
        final sliders = data.map((json) => SliderImage.fromJson(json)).toList();
        
        // Ordenar pelo campo order
        sliders.sort((a, b) => a.order.compareTo(b.order));
        
        // Armazenar no cache
        _slidersCache[institutionId] = sliders;
        
        return sliders;
      }
      
      return [];
    } catch (e) {
      print('Erro ao carregar imagens do slider: $e');
      return [];
    }
  }
  
  // Limpar cache para uma instituição específica
  void clearCache(String institutionId) {
    _slidersCache.remove(institutionId);
  }
  
  // Limpar todo o cache
  void clearAllCache() {
    _slidersCache.clear();
  }
}