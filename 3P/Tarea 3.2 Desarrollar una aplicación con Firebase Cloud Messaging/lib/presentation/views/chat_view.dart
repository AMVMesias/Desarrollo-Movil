import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_providers.dart';
import '../../domain.models/mensaje.dart';
import '../widgets/chat_bubble.dart';
import '../temas/chat_colors.dart';

class ChatView extends ConsumerWidget {
  ChatView({super.key});

  final TextEditingController controller = TextEditingController();
  
  // NOTA: Cambia este nombre por el tuyo
  final String miNombre = "Usuario";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mensajesAsync = ref.watch(mensajeProvider);
    final service = ref.read(firebaseServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Grupal'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.group),
            onPressed: () {
              // Acción para mostrar miembros del grupo
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: ChatColors.chatBackground,
        ),
        child: Column(
          children: [
            // Lista de mensajes
            Expanded(
              child: mensajesAsync.when(
                data: (mensajes) => ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: mensajes.length,
                  itemBuilder: (_, i) {
                    final mensaje = mensajes[i];
                    final isMyMessage = mensaje.autor == miNombre;

                    return ChatBubble(
                      mensaje: mensaje,
                      isMyMessage: isMyMessage,
                    );
                  },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ChatColors.primaryGreen),
                  ),
                ),
                error: (e, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: ChatColors.secondaryText,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error al cargar mensajes',
                        style: TextStyle(
                          color: ChatColors.secondaryText,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$e',
                        style: TextStyle(
                          color: ChatColors.secondaryText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Barra de entrada de mensaje
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: ChatColors.backgroundColor,
                border: Border(
                  top: BorderSide(
                    color: ChatColors.borderColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: ChatColors.otherMessageColor,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: ChatColors.shadowColor,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Escribe un mensaje...',
                            hintStyle: TextStyle(
                              color: ChatColors.secondaryText,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          style: const TextStyle(
                            color: ChatColors.primaryText,
                            fontSize: 16,
                          ),
                          onSubmitted: (value) =>
                              _enviarMensaje(service, context),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: const BoxDecoration(
                        color: ChatColors.primaryGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ChatColors.shadowColor,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: ChatColors.whiteText,
                          size: 20,
                        ),
                        onPressed: () => _enviarMensaje(service, context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _enviarMensaje(dynamic service, BuildContext context) async {
    if (controller.text.trim().isEmpty) return;

    // Cerrar el teclado
    FocusScope.of(context).unfocus();

    await service.enviarMensaje(
      Mensaje(
        texto: controller.text.trim(),
        autor: miNombre,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
    controller.clear();
  }
}
