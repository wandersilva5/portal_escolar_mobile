import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';
import '../utils/constants.dart';
import '../widgets/admin_dashboard.dart';
import '../widgets/teacher_dashboard.dart';
import '../widgets/student_dashboard.dart';
import '../widgets/director_dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  final _authController = AuthController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showProfileOptions = false;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    _animationController.forward();
    
    // Configurar para tela fullscreen
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    // Restaurar UI do sistema ao sair
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtém usuário e instituição
    final user = _authController.currentUser;
    final institution = _authController.currentInstitution;
    
    if (user == null || institution == null) {
      // Se não houver usuário logado, redireciona para login
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    return Scaffold(
      key: _scaffoldKey,
      // Sem AppBar para fullscreen
      extendBodyBehindAppBar: true,
      drawer: _buildDrawer(user, institution),
      body: Stack(
        children: [
          // Fundo com gradiente da instituição
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: institution.gradient,
            ),
          ),
          
          // Conteúdo principal
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  _buildTopBar(user, institution),
                  
                  // Conteúdo principal baseado no tipo de usuário
                  Expanded(
                    child: _buildDashboardContent(user, institution),
                  ),
                ],
              ),
            ),
          ),
          
          // Overlay para opções de perfil
          if (_showProfileOptions)
            GestureDetector(
              onTap: () {
                setState(() {
                  _showProfileOptions = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 100,
                      right: 20,
                      child: _buildProfileMenu(context),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildTopBar(User user, Institution institution) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu e logo da instituição
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              const SizedBox(width: 12),
              if (institution.logo != null && institution.logo!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    institution.logo!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => 
                      Container(
                        width: 40,
                        height: 40,
                        color: Colors.white.withOpacity(0.2),
                        child: const Icon(Icons.school, color: Colors.white),
                      ),
                  ),
                )
              else
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.school, color: Colors.white),
                ),
              const SizedBox(width: 12),
              Text(
                institution.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          // Avatar do usuário
          GestureDetector(
            onTap: () {
              setState(() {
                _showProfileOptions = !_showProfileOptions;
              });
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(0.2),
              backgroundImage: user.profileImage != null && user.profileImage!.isNotEmpty
                ? NetworkImage(user.profileImage!)
                : null,
              child: user.profileImage == null || user.profileImage!.isEmpty
                ? Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                : null,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProfileMenu(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProfileMenuItem(
              icon: Icons.person,
              title: 'Meu Perfil',
              onTap: () {
                setState(() {
                  _showProfileOptions = false;
                });
                // Navegar para tela de perfil
              },
            ),
            const Divider(height: 1),
            _buildProfileMenuItem(
              icon: Icons.settings,
              title: 'Configurações',
              onTap: () {
                setState(() {
                  _showProfileOptions = false;
                });
                // Navegar para configurações
              },
            ),
            const Divider(height: 1),
            _buildProfileMenuItem(
              icon: Icons.exit_to_app,
              title: 'Sair',
              onTap: () async {
                setState(() {
                  _showProfileOptions = false;
                });
                await _authController.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey[700]),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDrawer(User user, Institution institution) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: institution.gradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  backgroundImage: user.profileImage != null && user.profileImage!.isNotEmpty
                    ? NetworkImage(user.profileImage!)
                    : null,
                  child: user.profileImage == null || user.profileImage!.isEmpty
                    ? Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      )
                    : null,
                ),
                const SizedBox(height: 10),
                Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getUserTypeLabel(user.userType),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Menu items based on user type
          _buildMenuItems(user),
          
          const Divider(),
          
          // Common items for all users
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Ajuda e Suporte'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to help
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () async {
              Navigator.pop(context);
              await _authController.logout(context);
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildMenuItems(User user) {
    if (user.isAdmin) {
      return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Usuários'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to users
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Instituições'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to institutions
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Cursos'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to courses
            },
          ),
        ],
      );
    } else if (user.isTeacher) {
      return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.class_),
            title: const Text('Minhas Turmas'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to classes
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Avaliações'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to assessments
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Material Didático'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to materials
            },
          ),
        ],
      );
    } else if (user.isStudent) {
      return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.class_),
            title: const Text('Minhas Aulas'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to classes
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Tarefas'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to assignments
            },
          ),
          ListTile(
            leading: const Icon(Icons.trending_up),
            title: const Text('Notas'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to grades
            },
          ),
        ],
      );
    } else if (user.isDirector) {
      return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Relatórios'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to reports
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Professores'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to teachers
            },
          ),
          ListTile(
            leading: const Icon(Icons.apartment),
            title: const Text('Departamentos'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to departments
            },
          ),
        ],
      );
    } else {
      return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      );
    }
  }
  
  Widget _buildDashboardContent(User user, Institution institution) {
    if (user.isAdmin) {
      return AdminDashboard(user: user, institution: institution);
    } else if (user.isTeacher) {
      return TeacherDashboard(user: user, institution: institution);
    } else if (user.isStudent) {
      return StudentDashboard(user: user, institution: institution);
    } else if (user.isDirector) {
      return DirectorDashboard(user: user, institution: institution);
    } else {
      return Center(
        child: Text(
          'Bem-vindo, ${user.name}!',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
  
  String _getUserTypeLabel(String userType) {
    switch (userType) {
      case 'admin':
        return 'Administrador';
      case 'teacher':
        return 'Professor';
      case 'student':
        return 'Aluno';
      case 'director':
        return 'Diretor';
      default:
        return 'Usuário';
    }
  }
}