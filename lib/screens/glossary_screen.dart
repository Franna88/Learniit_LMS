import 'package:flutter/material.dart';

class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({super.key});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<GlossaryTerm> _allTerms = [];
  List<GlossaryTerm> _filteredTerms = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _initializeGlossaryData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _initializeGlossaryData() {
    _allTerms = [
      GlossaryTerm(
        term: 'Injured Person (IP)',
        abbreviation: 'IP',
        definition: 'This refers to the person who is injured or ill and requiring care as an Injured Person (IP).',
      ),
      GlossaryTerm(
        term: 'Personal Protective Equipment (PPE)',
        abbreviation: 'PPE',
        definition: 'In addition to hand hygiene, the use of personal protective equipment should be guided by risk assessment and the extent of contact anticipated with blood and body fluids, or pathogens.',
      ),
      GlossaryTerm(
        term: 'Cardiopulmonary Resuscitation (CPR)',
        abbreviation: 'CPR',
        definition: 'An emergency procedure that combines chest compressions with artificial ventilation to manually preserve intact brain function until further measures are taken to restore spontaneous blood circulation and breathing.',
      ),
      GlossaryTerm(
        term: 'Automated External Defibrillator (AED)',
        abbreviation: 'AED',
        definition: 'A portable electronic device that automatically diagnoses life-threatening cardiac arrhythmias and treats them through defibrillation.',
      ),
      GlossaryTerm(
        term: 'First Aid',
        abbreviation: 'FA',
        definition: 'Emergency care or treatment given to an ill or injured person before regular medical aid can be obtained.',
      ),
      GlossaryTerm(
        term: 'Emergency Medical Services (EMS)',
        abbreviation: 'EMS',
        definition: 'A system that provides emergency medical care to people who are seriously ill or injured.',
      ),
      GlossaryTerm(
        term: 'Vital Signs',
        abbreviation: 'VS',
        definition: 'Clinical measurements that indicate the state of a person\'s essential body functions, including temperature, pulse, respiration, and blood pressure.',
      ),
      GlossaryTerm(
        term: 'Shock',
        abbreviation: 'SH',
        definition: 'A life-threatening condition that occurs when the body is not getting enough blood flow, leading to damage to multiple organs.',
      ),
      GlossaryTerm(
        term: 'Hemorrhage',
        abbreviation: 'HEM',
        definition: 'Excessive bleeding, either internal or external, that can lead to shock and death if not controlled.',
      ),
      GlossaryTerm(
        term: 'Fracture',
        abbreviation: 'FX',
        definition: 'A broken bone that occurs when a force exerted against a bone is stronger than the bone can structurally withstand.',
      ),
      GlossaryTerm(
        term: 'Concussion',
        abbreviation: 'CONC',
        definition: 'A traumatic brain injury that affects brain function, usually caused by a blow to the head or violent shaking.',
      ),
      GlossaryTerm(
        term: 'Anaphylaxis',
        abbreviation: 'ANA',
        definition: 'A severe, potentially life-threatening allergic reaction that can occur within seconds or minutes of exposure to an allergen.',
      ),
      GlossaryTerm(
        term: 'Diabetes',
        abbreviation: 'DM',
        definition: 'A chronic disease that affects how your body turns food into energy, characterized by high blood sugar levels.',
      ),
      GlossaryTerm(
        term: 'Asthma',
        abbreviation: 'AST',
        definition: 'A condition that affects the airways in the lungs, causing them to narrow and swell, making breathing difficult.',
      ),
      GlossaryTerm(
        term: 'Epilepsy',
        abbreviation: 'EPI',
        definition: 'A neurological disorder characterized by recurrent seizures, which are sudden, uncontrolled electrical disturbances in the brain.',
      ),
    ];
    _filteredTerms = List.from(_allTerms);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredTerms = List.from(_allTerms);
      } else {
        _filteredTerms = _allTerms.where((term) {
          return term.term.toLowerCase().contains(query) ||
                 term.abbreviation.toLowerCase().contains(query) ||
                 term.definition.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchSection(),
            Expanded(
              child: _buildGlossaryList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF0D2A4C),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Top row with back button and profile icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF0D2A4C),
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Document icon with magnifying glass overlay
            Stack(
              children: [
                const Icon(
                  Icons.description,
                  color: Colors.white,
                  size: 48,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFAE26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Glossary text
            const Text(
              'Glossary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Search the glossary to find definitions and key information fast.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: _isSearching ? '' : 'Search terms...',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF666666),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlossaryList() {
    if (_filteredTerms.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Color(0xFFCCCCCC),
            ),
            SizedBox(height: 16),
            Text(
              'No terms found',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF666666),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Try searching for a different term',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _filteredTerms.length,
      itemBuilder: (context, index) {
        final term = _filteredTerms[index];
        return _buildGlossaryCard(term);
      },
    );
  }

  Widget _buildGlossaryCard(GlossaryTerm term) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF0D2A4C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: term.term.replaceAll('(${term.abbreviation})', '')),
                  TextSpan(
                    text: ' (${term.abbreviation})',
                    style: const TextStyle(
                      color: Color(0xFFDFAE26),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              term.definition,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF333333),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlossaryTerm {
  final String term;
  final String abbreviation;
  final String definition;

  GlossaryTerm({
    required this.term,
    required this.abbreviation,
    required this.definition,
  });
}
