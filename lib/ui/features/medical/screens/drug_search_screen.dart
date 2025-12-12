import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/models/drug_info.dart';
import '../../../../data/datasources/remote/remote_fda_datasource.dart';
import '../../../shared/di/locator.dart';
import '../state/medical_state.dart';
import '../../ai_reference/widgets/drug_result_card.dart';
import 'drug_detail_screen.dart';

/// Источник данных для поиска лекарств.
enum DrugDataSource { rxNorm, fdaNdc, fdaDrugs }

/// Экран поиска лекарств.
class DrugSearchScreen extends StatefulWidget {
  const DrugSearchScreen({super.key});

  @override
  State<DrugSearchScreen> createState() => _DrugSearchScreenState();
}

class _DrugSearchScreenState extends State<DrugSearchScreen> {
  late final MedicalState _medicalState;
  late final RemoteFdaDataSource _fdaDataSource;
  final TextEditingController _searchController = TextEditingController();
  
  DrugDataSource _selectedSource = DrugDataSource.rxNorm;
  
  // FDA search state
  bool _isFdaLoading = false;
  String? _fdaError;
  List<DrugInfo> _fdaDrugs = [];
  int _fdaTotalFound = 0;
  String _fdaQuery = '';

  @override
  void initState() {
    super.initState();
    _medicalState = getIt<MedicalState>();
    _fdaDataSource = getIt<RemoteFdaDataSource>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Справочник лекарств'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Панель поиска
          Container(
            padding: const EdgeInsets.all(16),
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
                // Выбор источника данных
                Row(
                  children: [
                    Expanded(
                      child: _buildSourceSelector(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Поле поиска
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Название препарата (на англ.)',
                          prefixIcon: const Icon(Icons.medication_outlined),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: _clearSearch,
                                )
                              : null,
                          border: const OutlineInputBorder(),
                          isDense: true,
                        ),
                        onSubmitted: (_) => _searchDrugs(),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildSearchButton(),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Быстрые подсказки
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSuggestionChip('Aspirin'),
                      const SizedBox(width: 8),
                      _buildSuggestionChip('Ibuprofen'),
                      const SizedBox(width: 8),
                      _buildSuggestionChip('Metformin'),
                      const SizedBox(width: 8),
                      _buildSuggestionChip('Amoxicillin'),
                      const SizedBox(width: 8),
                      _buildSuggestionChip('Tylenol'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Результаты
          Expanded(
            child: _buildResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceSelector() {
    return SegmentedButton<DrugDataSource>(
      segments: const [
        ButtonSegment(
          value: DrugDataSource.rxNorm,
          label: Text('RxNorm', style: TextStyle(fontSize: 12)),
          icon: Icon(Icons.science, size: 16),
        ),
        ButtonSegment(
          value: DrugDataSource.fdaNdc,
          label: Text('FDA NDC', style: TextStyle(fontSize: 12)),
          icon: Icon(Icons.verified, size: 16),
        ),
        ButtonSegment(
          value: DrugDataSource.fdaDrugs,
          label: Text('Drugs@FDA', style: TextStyle(fontSize: 12)),
          icon: Icon(Icons.star, size: 16),
        ),
      ],
      selected: {_selectedSource},
      onSelectionChanged: (selection) {
        setState(() {
          _selectedSource = selection.first;
          // Clear previous results when switching
          _fdaDrugs = [];
          _fdaError = null;
          _fdaQuery = '';
        });
      },
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildSearchButton() {
    final isLoading = _selectedSource == DrugDataSource.rxNorm
        ? _medicalState.isLoadingDrugs
        : _isFdaLoading;
    
    return FilledButton.icon(
      onPressed: isLoading ? null : _searchDrugs,
      icon: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.search),
      label: const Text('Найти'),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text, style: const TextStyle(fontSize: 12)),
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        _searchController.text = text;
        _searchDrugs();
      },
    );
  }

  Widget _buildResults() {
    if (_selectedSource == DrugDataSource.rxNorm) {
      return Observer(builder: (_) => _buildRxNormResults());
    } else {
      return _buildFdaResults();
    }
  }

  Widget _buildRxNormResults() {
    if (_medicalState.isLoadingDrugs) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_medicalState.drugError != null) {
      return _buildErrorWidget(_medicalState.drugError!, isRxNorm: true);
    }

    if (_medicalState.drugSearchQuery.isEmpty) {
      return _buildEmptyState();
    }

    if (!_medicalState.hasDrugResults) {
      return _buildNoResults();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _medicalState.drugs.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildResultsHeader(
            'RxNorm API (NIH)',
            _medicalState.totalDrugsFound,
          );
        }
        final drug = _medicalState.drugs[index - 1];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: DrugResultCard(
            drug: drug,
            source: DrugDetailSource.rxNorm,
          ),
        );
      },
    );
  }

  Widget _buildFdaResults() {
    if (_isFdaLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_fdaError != null) {
      return _buildErrorWidget(_fdaError!, isRxNorm: false);
    }

    if (_fdaQuery.isEmpty) {
      return _buildEmptyState();
    }

    if (_fdaDrugs.isEmpty) {
      return _buildNoResults();
    }

    final sourceName = _selectedSource == DrugDataSource.fdaNdc 
        ? 'OpenFDA NDC Directory' 
        : 'Drugs@FDA';

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _fdaDrugs.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildResultsHeader(sourceName, _fdaTotalFound);
        }
        final drug = _fdaDrugs[index - 1];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: DrugResultCard(
            drug: drug,
            source: DrugDetailSource.fda,
          ),
        );
      },
    );
  }

  Widget _buildResultsHeader(String source, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              source,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Найдено результатов: $count',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Ничего не найдено',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Попробуйте изменить запрос или выбрать другой источник',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medication_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 24),
            Text(
              'Справочник лекарств',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Введите название препарата на английском языке',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 16),
            _buildSourceInfo(),
            const SizedBox(height: 24),
            Text(
              'Примеры: Aspirin, Ibuprofen, Tylenol',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceInfo() {
    String info;
    IconData icon;
    Color color;
    
    switch (_selectedSource) {
      case DrugDataSource.rxNorm:
        info = 'RxNorm (NIH) - нормализованные названия лекарств США';
        icon = Icons.science;
        color = Colors.blue;
        break;
      case DrugDataSource.fdaNdc:
        info = 'FDA NDC Directory - национальный реестр кодов лекарств';
        icon = Icons.verified;
        color = Colors.green;
        break;
      case DrugDataSource.fdaDrugs:
        info = 'Drugs@FDA - одобренные FDA препараты';
        icon = Icons.star;
        color = Colors.orange;
        break;
    }
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              info,
              style: TextStyle(fontSize: 12, color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error, {required bool isRxNorm}) {
    final isFdaBlocked = error.toLowerCase().contains('403') || 
                         error.toLowerCase().contains('forbidden') ||
                         error.toLowerCase().contains('waf');
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFdaBlocked ? Icons.block : Icons.error_outline, 
              size: 64, 
              color: isFdaBlocked ? Colors.orange.shade300 : Colors.red.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              isFdaBlocked ? 'Доступ заблокирован' : 'Ошибка загрузки',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            if (isFdaBlocked && !isRxNorm) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'FDA API блокирует запросы',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'WAF/CDN защита FDA блокирует не-браузерные запросы. '
                      'Используйте RxNorm API как альтернативу.',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() => _selectedSource = DrugDataSource.rxNorm);
                },
                icon: const Icon(Icons.swap_horiz),
                label: const Text('Переключиться на RxNorm'),
              ),
            ],
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _searchDrugs,
              icon: const Icon(Icons.refresh),
              label: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _searchDrugs() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    if (_selectedSource == DrugDataSource.rxNorm) {
      _medicalState.searchDrugs(query);
    } else {
      await _searchFda(query);
    }
  }

  Future<void> _searchFda(String query) async {
    setState(() {
      _isFdaLoading = true;
      _fdaError = null;
      _fdaQuery = query;
    });

    try {
      DrugSearchResult result;
      
      if (_selectedSource == DrugDataSource.fdaNdc) {
        result = await _fdaDataSource.searchByNdc(query);
      } else {
        result = await _fdaDataSource.searchDrugsFda(query);
      }

      setState(() {
        _fdaDrugs = result.drugs;
        _fdaTotalFound = result.totalCount;
        _isFdaLoading = false;
      });
    } catch (e) {
      setState(() {
        _fdaError = e.toString();
        _isFdaLoading = false;
        _fdaDrugs = [];
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _medicalState.clearDrugSearch();
    setState(() {
      _fdaDrugs = [];
      _fdaError = null;
      _fdaQuery = '';
    });
  }
}
