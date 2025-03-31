import 'package:flutter/material.dart';

class Institution {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String phone;
  final String email;
  final String? logo;
  final Color primaryColor;
  final Color secondaryColor;
  
  Institution({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.phone,
    required this.email,
    this.logo,
    required this.primaryColor,
    required this.secondaryColor,
  });
  
  // Método para criar a instância a partir de um JSON
  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      phone: json['phone'],
      email: json['email'],
      logo: json['logo'],
      // Converte string de cores para Color
      primaryColor: _hexToColor(json['primaryColor'] ?? '#1A237E'),
      secondaryColor: _hexToColor(json['secondaryColor'] ?? '#3949AB'),
    );
  }
  
  // Método para converter a instância em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'phone': phone,
      'email': email,
      'logo': logo,
      'primaryColor': '#${primaryColor.value.toRadixString(16).substring(2)}',
      'secondaryColor': '#${secondaryColor.value.toRadixString(16).substring(2)}',
    };
  }
  
  // Função utilitária para converter cor hexadecimal em Color
  static Color _hexToColor(String hexString) {
    // Remove o # se estiver presente
    final hexColor = hexString.replaceAll('#', '');
    
    // Converte para inteiro e adiciona a opacidade (FF)
    return Color(int.parse('FF$hexColor', radix: 16));
  }
  
  // Retorna o gradiente da instituição
  LinearGradient get gradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryColor,
        secondaryColor,
      ],
    );
  }
}