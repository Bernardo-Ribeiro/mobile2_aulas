import 'package:flutter/material.dart';

// =============================================================================
// AULA — ACESSIBILIDADE (CÓDIGO FINALIZADO)
// =============================================================================

class AulaAcessibilidadePage extends StatelessWidget {
  const AulaAcessibilidadePage({
    super.key,
    required this.mostrarRaioX,
    required this.aoAlternarRaioX,
  });

  final bool mostrarRaioX;
  final ValueChanged<bool> aoAlternarRaioX;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aula — Acessibilidade'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(
              mostrarRaioX ? Icons.accessibility : Icons.accessibility_new,
            ),
            tooltip: mostrarRaioX ? 'Desligar Raio-X' : 'Ligar Raio-X',
            onPressed: () => aoAlternarRaioX(!mostrarRaioX),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),

            // TODO: Envolver o avatar com Semantics. (CONCLUÍDO)
            Semantics(
              label: 'Foto de perfil de Maria Silva',
              image: true,
              child: CircleAvatar(
                radius: 56,
                backgroundColor: Colors.indigo.shade100,
                child: Icon(
                  Icons.person,
                  size: 56,
                  color: Colors.indigo.shade700,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // TODO: Envolver o texto do nome com Semantics. (CONCLUÍDO)
            Semantics(
              label: 'Nome do usuário',
              header: true,
              child: Text(
                'Maria Silva',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            const SizedBox(height: 8),

            // TODO: Garantir bom contraste no texto (WCAG 4,5:1). (CONCLUÍDO)
            // Alterado de shade200 (muito claro) para shade700 (escuro).
            Text(
              'maria.silva@email.com',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.grey.shade700),
            ),

            const SizedBox(height: 32),

            // TODO: Envolver o Card com Semantics. (CONCLUÍDO)
            Semantics(
              container: true,
              label: 'Informações do perfil',
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PerfilRow(
                        icon: Icons.badge_outlined,
                        label: 'Cargo',
                        value: 'Desenvolvedora Mobile',
                      ),
                      const Divider(height: 24),
                      _PerfilRow(
                        icon: Icons.phone_outlined,
                        label: 'Telefone',
                        value: '(11) 98765-4321',
                      ),
                      const Divider(height: 24),
                      _PerfilRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'Membro desde',
                        value: 'Jan/2024',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // TODO: Usar MergeSemantics e ExcludeSemantics. (CONCLUÍDO)
            MergeSemantics(
              child: ListTile(
                leading: ExcludeSemantics(
                  child: const Icon(Icons.settings),
                ),
                title: const Text('Configurações Avançadas'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 24),

            // TODO: Envolver o botão com Semantics e ConstrainedBox. (CONCLUÍDO)
            Semantics(
              button: true,
              label: 'Editar perfil',
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Editar perfil'),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // TODO: Envolver este Container com Semantics. (CONCLUÍDO)
            Semantics(
              container: true,
              label: 'Exemplo de texto com contraste ruim — não use em produção',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  border: Border.all(color: Colors.amber.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Evite texto amarelo claro em fundo claro: contraste < 4,5:1.',
                        style: TextStyle(
                          color: Colors.amber.shade200,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'O bloco acima tem contraste ruim de propósito. Nos seus apps, usem cores que passem no teste 4,5:1 (ex.: WebAIM Contrast Checker).',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PerfilRow extends StatelessWidget {
  const _PerfilRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    // Agrupando o rótulo e o valor para que o leitor de tela leia a linha como uma unidade.
    return MergeSemantics(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(child: Icon(icon, size: 22, color: Colors.grey.shade700)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey.shade900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}