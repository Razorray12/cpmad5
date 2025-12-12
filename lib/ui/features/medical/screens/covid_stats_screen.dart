import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/models/covid_stats.dart';
import '../../../shared/di/locator.dart';
import '../state/medical_state.dart';
import '../../ai_reference/widgets/covid_stats_card.dart';
import '../../ai_reference/widgets/covid_country_card.dart';

/// Экран статистики COVID-19 с полным использованием Disease.sh API.
/// 
/// Использует 5 запросов из Disease.sh API:
/// 1. getGlobalStats() - глобальная статистика
/// 2. getCountryStats() - статистика по стране
/// 3. getAllCountriesStats() - список всех стран
/// 4. getCountryHistorical() - история по стране
/// 5. getGlobalHistorical() - глобальная история
class CovidStatsScreen extends StatefulWidget {
  const CovidStatsScreen({super.key});

  @override
  State<CovidStatsScreen> createState() => _CovidStatsScreenState();
}

class _CovidStatsScreenState extends State<CovidStatsScreen>
    with SingleTickerProviderStateMixin {
  late final MedicalState _medicalState;
  late final TabController _tabController;
  final TextEditingController _countryController = TextEditingController();
  
  String _sortBy = 'cases';
  String _selectedHistoryCountry = 'Russia';

  @override
  void initState() {
    super.initState();
    _medicalState = getIt<MedicalState>();
    _tabController = TabController(length: 3, vsync: this);
    
    // Загружаем данные при инициализации
    _loadInitialData();
  }

  void _loadInitialData() {
    // 1. Глобальная статистика
    _medicalState.loadGlobalCovidStats();
    // 3. Список всех стран
    _medicalState.loadAllCountriesStats(sortBy: _sortBy);
    // 5. Глобальная история
    _medicalState.loadCovidHistorical(lastDays: 30);
  }

  @override
  void dispose() {
    _countryController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика COVID-19'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadInitialData,
            tooltip: 'Обновить данные',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.public), text: 'Обзор'),
            Tab(icon: Icon(Icons.list), text: 'Страны'),
            Tab(icon: Icon(Icons.show_chart), text: 'История'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildCountriesTab(),
          _buildHistoryTab(),
        ],
      ),
    );
  }

  // ==================== TAB 1: ОБЗОР ====================
  
  Widget _buildOverviewTab() {
    return Observer(
      builder: (_) {
        if (_medicalState.isLoadingCovid && _medicalState.globalCovidStats == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_medicalState.covidError != null && _medicalState.globalCovidStats == null) {
          return _buildErrorWidget(_medicalState.covidError!);
        }

        return RefreshIndicator(
          onRefresh: () => _medicalState.loadGlobalCovidStats(),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildApiInfoBanner(),
              const SizedBox(height: 16),
              
              // Глобальная статистика (запрос 1)
              if (_medicalState.globalCovidStats != null)
                CovidStatsCard(stats: _medicalState.globalCovidStats!),
              
              const SizedBox(height: 24),
              
              // Поиск по стране (запрос 2)
              Text(
                'Статистика по стране',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              _buildCountrySearch(),
              
              if (_medicalState.selectedCountryStats != null) ...[
                const SizedBox(height: 16),
                CovidCountryCard(stats: _medicalState.selectedCountryStats!),
              ],

              const SizedBox(height: 24),
              Text(
                'Популярные страны',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              _buildQuickCountries(),
            ],
          ),
        );
      },
    );
  }

  // ==================== TAB 2: ВСЕ СТРАНЫ ====================
  
  Widget _buildCountriesTab() {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            // Панель сортировки
            _buildSortPanel(),
            
            // Список стран (запрос 3)
            Expanded(
              child: _medicalState.isLoadingCovid && _medicalState.countriesStats.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => _medicalState.loadAllCountriesStats(sortBy: _sortBy),
                      child: _buildCountriesList(),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSortPanel() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.sort, size: 20),
          const SizedBox(width: 8),
          const Text('Сортировка:'),
          const SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildSortChip('cases', 'Случаи'),
                  const SizedBox(width: 8),
                  _buildSortChip('deaths', 'Смерти'),
                  const SizedBox(width: 8),
                  _buildSortChip('recovered', 'Выздоровели'),
                  const SizedBox(width: 8),
                  _buildSortChip('active', 'Активные'),
                  const SizedBox(width: 8),
                  _buildSortChip('tests', 'Тесты'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip(String value, String label) {
    final isSelected = _sortBy == value;
    return FilterChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: isSelected,
      onSelected: (_) {
        setState(() => _sortBy = value);
        _medicalState.loadAllCountriesStats(sortBy: value);
      },
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildCountriesList() {
    final countries = _medicalState.countriesStats;
    
    if (countries.isEmpty) {
      return const Center(
        child: Text('Нет данных о странах'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        return _buildCountryListItem(country, index + 1);
      },
    );
  }

  Widget _buildCountryListItem(CovidCountryStats country, int rank) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRankColor(rank),
          child: Text(
            '$rank',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        title: Row(
          children: [
            if (country.flagUrl != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.network(
                  country.flagUrl!,
                  width: 24,
                  height: 16,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(width: 24),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                country.country,
                style: const TextStyle(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Text(
          'Случаев: ${_formatNumber(country.totalCases)} • '
          'Смертей: ${_formatNumber(country.totalDeaths)}',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '+${_formatNumber(country.todayCases)}',
              style: TextStyle(
                color: Colors.orange.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            Text(
              'сегодня',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
            ),
          ],
        ),
        onTap: () {
          _medicalState.loadCountryCovidStats(country.country);
          _tabController.animateTo(0);
        },
      ),
    );
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return Colors.red.shade700;
    if (rank == 2) return Colors.orange.shade700;
    if (rank == 3) return Colors.amber.shade700;
    if (rank <= 10) return Colors.blue.shade600;
    return Colors.grey.shade600;
  }

  // ==================== TAB 3: ИСТОРИЯ ====================
  
  Widget _buildHistoryTab() {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            // Выбор страны для истории
            _buildHistoryControls(),
            
            // График/данные истории (запросы 4 и 5)
            Expanded(
              child: _medicalState.isLoadingCovid && _medicalState.covidHistoricalData == null
                  ? const Center(child: CircularProgressIndicator())
                  : _buildHistoricalData(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHistoryControls() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Запрос 5: Глобальная история
                    _medicalState.loadCovidHistorical(lastDays: 30);
                    setState(() => _selectedHistoryCountry = 'Мир');
                  },
                  icon: const Icon(Icons.public, size: 18),
                  label: const Text('Глобально'),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: _selectedHistoryCountry == 'Мир' 
                        ? Theme.of(context).colorScheme.primaryContainer 
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showCountryPicker(),
                  icon: const Icon(Icons.flag, size: 18),
                  label: Text(
                    _selectedHistoryCountry == 'Мир' ? 'По стране' : _selectedHistoryCountry,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Быстрый выбор страны
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildHistoryCountryChip('Russia', '🇷🇺'),
                _buildHistoryCountryChip('USA', '🇺🇸'),
                _buildHistoryCountryChip('Germany', '🇩🇪'),
                _buildHistoryCountryChip('China', '🇨🇳'),
                _buildHistoryCountryChip('India', '🇮🇳'),
                _buildHistoryCountryChip('Brazil', '🇧🇷'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCountryChip(String country, String flag) {
    final isSelected = _selectedHistoryCountry == country;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        avatar: Text(flag),
        label: Text(country, style: const TextStyle(fontSize: 12)),
        backgroundColor: isSelected 
            ? Theme.of(context).colorScheme.primaryContainer 
            : null,
        onPressed: () {
          setState(() => _selectedHistoryCountry = country);
          // Запрос 4: История по стране
          _medicalState.loadCovidHistorical(country: country, lastDays: 30);
        },
      ),
    );
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Выберите страну',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Название страны (на англ.)',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    setState(() => _selectedHistoryCountry = value.trim());
                    // Запрос 4: История по стране
                    _medicalState.loadCovidHistorical(country: value.trim(), lastDays: 30);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHistoricalData() {
    final data = _medicalState.covidHistoricalData;
    
    if (data == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.show_chart, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Выберите страну или глобальные данные',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    final stats = data.dailyStats;
    if (stats.isEmpty) {
      return const Center(child: Text('Нет исторических данных'));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Заголовок
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.show_chart, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      'История за ${stats.length} дней',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  data.country ?? 'Глобальные данные',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 16),
                // Сводка
                Row(
                  children: [
                    _buildHistorySummaryItem(
                      'Прирост случаев',
                      '+${_formatNumber(data.totalCasesGrowth)}',
                      Colors.orange,
                    ),
                    const SizedBox(width: 16),
                    _buildHistorySummaryItem(
                      'Последний день',
                      _formatNumber(stats.last.cases),
                      Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Простой график (бары)
        Text(
          'Динамика случаев',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        _buildSimpleChart(stats),
        
        const SizedBox(height: 16),
        
        // Таблица данных
        Text(
          'Данные по дням',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        _buildHistoryTable(stats),
      ],
    );
  }

  Widget _buildHistorySummaryItem(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleChart(List<CovidDailyStats> stats) {
    // Берём последние 14 дней для графика
    final recentStats = stats.length > 14 
        ? stats.sublist(stats.length - 14) 
        : stats;
    
    final maxCases = recentStats.map((s) => s.cases).reduce((a, b) => a > b ? a : b);
    
    return Container(
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: recentStats.asMap().entries.map((entry) {
          final stat = entry.value;
          final height = maxCases > 0 ? (stat.cases / maxCases) * 80 : 0.0;
          
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Tooltip(
                message: '${stat.date.day}.${stat.date.month}: ${_formatNumber(stat.cases)}',
                child: Container(
                  height: height + 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHistoryTable(List<CovidDailyStats> stats) {
    // Показываем последние 10 дней
    final recentStats = stats.length > 10 
        ? stats.sublist(stats.length - 10).reversed.toList() 
        : stats.reversed.toList();

    return Card(
      child: Column(
        children: [
          // Заголовок таблицы
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Row(
              children: [
                Expanded(flex: 2, child: Text('Дата', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Случаи', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Смерти', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Выздор.', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          // Строки данных
          ...recentStats.map((stat) => Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '${stat.date.day}.${stat.date.month}',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    _formatNumber(stat.cases),
                    style: TextStyle(color: Colors.orange.shade700),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    _formatNumber(stat.deaths),
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    _formatNumber(stat.recovered),
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // ==================== ОБЩИЕ ВИДЖЕТЫ ====================

  Widget _buildApiInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.update,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Данные обновляются в реальном времени из Disease.sh API',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountrySearch() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _countryController,
            decoration: const InputDecoration(
              hintText: 'Название страны (на англ.)',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onSubmitted: (_) => _searchCountry(),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: _searchCountry,
          child: const Text('Найти'),
        ),
      ],
    );
  }

  Widget _buildQuickCountries() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildCountryChip('Russia', '🇷🇺'),
        _buildCountryChip('USA', '🇺🇸'),
        _buildCountryChip('Germany', '🇩🇪'),
        _buildCountryChip('China', '🇨🇳'),
        _buildCountryChip('India', '🇮🇳'),
        _buildCountryChip('Brazil', '🇧🇷'),
        _buildCountryChip('UK', '🇬🇧'),
        _buildCountryChip('France', '🇫🇷'),
      ],
    );
  }

  Widget _buildCountryChip(String country, String flag) {
    return ActionChip(
      avatar: Text(flag),
      label: Text(country),
      onPressed: () {
        _countryController.text = country;
        // Запрос 2: Статистика по стране
        _medicalState.loadCountryCovidStats(country);
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            const SizedBox(height: 16),
            Text(
              'Ошибка загрузки',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _loadInitialData,
              icon: const Icon(Icons.refresh),
              label: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }

  void _searchCountry() {
    final country = _countryController.text.trim();
    if (country.isNotEmpty) {
      // Запрос 2: Статистика по стране
      _medicalState.loadCountryCovidStats(country);
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(2)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
