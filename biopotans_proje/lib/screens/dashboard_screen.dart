import 'package:flutter/material.dart';
import '../widgets/app_footer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeTab(onNavigateToTab: _onNavigateToTab),
      const PersonalityTestTab(),
      const MeditationTab(),
      const GoalsTab(),
      const ProfileTab(),
    ];
  }

  void _onNavigateToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _screens[_selectedIndex]),
          const AppFooter(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF6366F1),
        unselectedItemColor: const Color(0xFF9CA3AF),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology_outlined),
            activeIcon: Icon(Icons.psychology),
            label: 'Kişilik Testi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement_outlined),
            activeIcon: Icon(Icons.self_improvement),
            label: 'Meditasyon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_outlined),
            activeIcon: Icon(Icons.flag),
            label: 'Hedefler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final void Function(int index) onNavigateToTab;
  const HomeTab({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BİOPOTANS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hoş geldin kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hoş Geldiniz! 👋',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bugün kendinizi geliştirmeye hazır mısınız?',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Hızlı erişim kartları
            const Text(
              'Hızlı Erişim',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildQuickAccessCard(
                  icon: Icons.psychology,
                  title: 'Kişilik Testi',
                  subtitle: 'Kendinizi keşfedin',
                  color: const Color(0xFF10B981),
                  onTap: () {
                    onNavigateToTab(1);
                  },
                ),
                _buildQuickAccessCard(
                  icon: Icons.self_improvement,
                  title: 'Meditasyon',
                  subtitle: 'Ruhunuzu dinlendirin',
                  color: const Color(0xFF8B5CF6),
                  onTap: () {
                    onNavigateToTab(2);
                  },
                ),
                _buildQuickAccessCard(
                  icon: Icons.flag,
                  title: 'Haftalık Hedefler',
                  subtitle: 'Hedeflerinizi takip edin',
                  color: const Color(0xFFF59E0B),
                  onTap: () {
                    onNavigateToTab(3);
                  },
                ),
                _buildQuickAccessCard(
                  icon: Icons.analytics,
                  title: 'İlerleme',
                  subtitle: 'Gelişiminizi görün',
                  color: const Color(0xFFEF4444),
                  onTap: () {
                    onNavigateToTab(4);
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Günlük aktiviteler
            const Text(
              'Günlük Aktiviteler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 16),

            _buildDailyActivityCard(
              title: 'Bugünkü Hedef',
              description: '5 dakika meditasyon yapın',
              progress: 0.3,
              icon: Icons.self_improvement,
            ),

            const SizedBox(height: 12),

            _buildDailyActivityCard(
              title: 'Kişilik Testi',
              description: 'Testinizi tamamlayın',
              progress: 0.0,
              icon: Icons.psychology,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyActivityCard({
    required String title,
    required String description,
    required double progress,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF6366F1), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFFE5E7EB),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF6366F1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Diğer tab'lar için placeholder widget'lar
class PersonalityTestTab extends StatefulWidget {
  const PersonalityTestTab({super.key});

  @override
  State<PersonalityTestTab> createState() => _PersonalityTestTabState();
}

class _PersonalityTestTabState extends State<PersonalityTestTab> {
  final List<String> _questions = const [
    'Yeni şeyler öğrenmekten keyif alırım',
    'Zor bir görevi görünce motive olurum',
    'Planlı ve düzenliyim',
    'Stresli durumlarda sakin kalırım',
    'Takım halinde çalışmayı severim',
    'Geri bildirim almaktan hoşlanırım',
    'Günlük hedefler belirlerim',
    'Zamanımı verimli kullanırım',
    'Kendimi geliştirmeye önem veririm',
    'Değişime kolay uyum sağlarım',
  ];

  late List<int?> _answers; // 1-5
  bool _submitted = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _answers = List<int?>.filled(_questions.length, null);
  }

  void _submit() {
    if (_answers.any((a) => a == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen tüm soruları yanıtlayın'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final total = _answers.fold<int>(0, (sum, a) => sum + (a ?? 0));
    setState(() {
      _score = total;
      _submitted = true;
    });
  }

  Widget _buildSuggestions(int score) {
    // Maksimum skor 50 (10 soru * 5)
    final int maxScore = _questions.length * 5;
    final double ratio = score / maxScore;

    String title;
    List<String> tips;

    if (ratio < 0.4) {
      title = 'Başlangıç Seviyesi Öneriler';
      tips = [
        'Küçük ve ulaşılabilir hedefler belirleyin',
        'Günlük 5-10 dakika meditasyon deneyin',
        'Haftalık plan yaparak işe başlayın',
      ];
    } else if (ratio < 0.7) {
      title = 'Gelişim Odaklı Öneriler';
      tips = [
        'Pomodoro tekniği ile odaklanma sürenizi artırın',
        'Her gün 1 yeni kavram öğrenin ve not alın',
        'Haftalık hedeflerinizi aylık vizyon ile eşleştirin',
      ];
    } else {
      title = 'İleri Seviye Öneriler';
      tips = [
        'Zaman bloklaması ile derin çalışma seansları planlayın',
        'Zor görevleri sabah saatlerine alın',
        'Edindiğiniz bilgileri başkalarına öğretin',
      ];
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skorunuz: $score / $maxScore',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),
          for (final tip in tips)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(color: Color(0xFF64748B))),
                Expanded(
                  child: Text(
                    tip,
                    style: const TextStyle(color: Color(0xFF64748B)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kişilik Testi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Aşağıdaki 10 soruyu 1 (Kesinlikle Katılmıyorum) - 5 (Kesinlikle Katılıyorum) arasında puanlayın.',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _questions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildQuestionCard(index);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Testi Tamamla'),
            ),
            const SizedBox(height: 16),
            if (_submitted) _buildSuggestions(_score),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    final q = _questions[index];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Soru ${index + 1}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 6),
          Text(q, style: const TextStyle(color: Color(0xFF334155))),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: List<Widget>.generate(5, (i) {
              final value = i + 1;
              final selected = _answers[index] == value;
              return ChoiceChip(
                label: Text(value.toString()),
                selected: selected,
                onSelected: (_) {
                  setState(() {
                    _answers[index] = value;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1: Kesinlikle Katılmıyorum',
                style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
              ),
              Text(
                '5: Kesinlikle Katılıyorum',
                style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MeditationTab extends StatefulWidget {
  const MeditationTab({super.key});

  @override
  State<MeditationTab> createState() => _MeditationTabState();
}

class _MeditationTabState extends State<MeditationTab>
    with SingleTickerProviderStateMixin {
  final List<int> _durations = const [1, 5, 10]; // dakikalar
  int _selectedMinutes = 5;
  bool _isRunning = false;
  late AnimationController _controller;
  late Animation<double> _scale;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _scale = Tween<double>(
      begin: 0.85,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startSession() {
    setState(() {
      _isRunning = true;
      _endTime = DateTime.now().add(Duration(minutes: _selectedMinutes));
    });
    _controller.repeat(reverse: true);
    _tickUntilEnd();
  }

  void _stopSession() {
    setState(() {
      _isRunning = false;
      _endTime = null;
    });
    _controller.stop();
  }

  Future<void> _tickUntilEnd() async {
    while (_isRunning && _endTime != null) {
      await Future.delayed(const Duration(seconds: 1));
      if (!_isRunning) break;
      if (DateTime.now().isAfter(_endTime!)) {
        _stopSession();
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Tebrikler'),
            content: const Text('Meditasyon tamamlandı.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Tamam'),
              ),
            ],
          ),
        );
        break;
      }
      if (!mounted) break;
      setState(() {});
    }
  }

  String _remainingText() {
    if (_endTime == null) return '';
    final diff = _endTime!.difference(DateTime.now());
    final mm = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = diff.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meditasyon')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Süre seçin ve nefes egzersizine başlayın. Daire genişlerken nefes alın, daralırken verin.',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: _durations.map((m) {
                final selected = _selectedMinutes == m;
                return ChoiceChip(
                  label: Text('${m.toString()} dk'),
                  selected: selected,
                  onSelected: _isRunning
                      ? null
                      : (_) {
                          setState(() {
                            _selectedMinutes = m;
                          });
                        },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 280,
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return Transform.scale(
                      scale: _isRunning ? _scale.value : 1.0,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6366F1).withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _isRunning
                              ? _remainingText()
                              : '${_selectedMinutes} dk',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : _startSession,
                  child: const Text('Başla'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: _isRunning ? _stopSession : null,
                  child: const Text('Bitir'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GoalsTab extends StatefulWidget {
  const GoalsTab({super.key});

  @override
  State<GoalsTab> createState() => _GoalsTabState();
}

class _GoalsTabState extends State<GoalsTab> {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final List<_GoalItem> _goals = <_GoalItem>[];

  @override
  void dispose() {
    _goalController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  void _addGoal() {
    final text = _goalController.text.trim();
    if (text.isEmpty) return;
    // Tarih kontrolü: geçmiş tarih olamaz
    DateTime? due;
    if (_dueDateController.text.isNotEmpty) {
      try {
        due = DateTime.parse(_dueDateController.text);
      } catch (_) {}
      if (due != null) {
        final today = DateTime.now();
        final onlyToday = DateTime(today.year, today.month, today.day);
        final onlyDue = DateTime(due.year, due.month, due.day);
        if (onlyDue.isBefore(onlyToday)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hedef tarihi geçmişte olamaz'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
      }
    }
    setState(() {
      _goals.add(_GoalItem(title: text, dueDate: due));
      _goalController.clear();
      _dueDateController.clear();
    });
  }

  void _toggleGoal(int index, bool? value) {
    setState(() {
      _goals[index] = _goals[index].copyWith(completed: value ?? false);
    });
  }

  void _removeGoal(int index) {
    setState(() {
      _goals.removeAt(index);
    });
  }

  double _progress() {
    if (_goals.isEmpty) return 0.0;
    final done = _goals.where((g) => g.completed).length;
    return done / _goals.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Haftalık Hedefler')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bu hafta için kişisel hedeflerinizi ekleyin. Tamamladıkça işaretleyin.',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 16),

            // İlerleme çubuğu
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'İlerleme',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      Text(
                        _goals.isEmpty
                            ? '0%'
                            : '${(_progress() * 100).round()}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _progress(),
                    backgroundColor: const Color(0xFFE5E7EB),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF6366F1),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Yeni hedef ekleme formu
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _goalController,
                        decoration: const InputDecoration(
                          labelText: 'Yeni hedef',
                          prefixIcon: Icon(Icons.flag_outlined),
                        ),
                        onSubmitted: (_) => _addGoal(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _dueDateController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Hedef Tarihi (isteğe bağlı)',
                          prefixIcon: Icon(Icons.event_outlined),
                        ),
                        onTap: () async {
                          final now = DateTime.now();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(now.year, now.month, now.day),
                            firstDate: DateTime(now.year, now.month, now.day),
                            lastDate: DateTime(now.year + 5),
                          );
                          if (picked != null) {
                            final formatted =
                                '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                            _dueDateController.text = formatted;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _addGoal,
                      child: const Text('Ekle'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Hedef listesi
            if (_goals.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Center(
                  child: Text(
                    'Henüz hedef yok. Hemen bir hedef ekleyin!',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _goals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final goal = _goals[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: goal.completed,
                        onChanged: (v) => _toggleGoal(index, v),
                        activeColor: const Color(0xFF10B981),
                      ),
                      title: Text(
                        goal.title,
                        style: TextStyle(
                          decoration: goal.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: goal.completed
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF1F2937),
                        ),
                      ),
                      subtitle: goal.dueDate == null
                          ? null
                          : Text(
                              'Tarih: ${goal.dueDate!.year}-${goal.dueDate!.month.toString().padLeft(2, '0')}-${goal.dueDate!.day.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _removeGoal(index),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _GoalItem {
  final String title;
  final bool completed;
  final DateTime? dueDate;

  const _GoalItem({required this.title, this.completed = false, this.dueDate});

  _GoalItem copyWith({String? title, bool? completed, DateTime? dueDate}) =>
      _GoalItem(
        title: title ?? this.title,
        completed: completed ?? this.completed,
        dueDate: dueDate ?? this.dueDate,
      );
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Profil Sayfası')));
  }
}
