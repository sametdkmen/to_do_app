import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/note.dart';
import 'package:to_do_app/ui/cubit/home_cubit.dart';
import 'package:to_do_app/ui/screens/add_note_screen.dart';
import 'package:to_do_app/ui/screens/note_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                style: const TextStyle(fontSize: 23, color: Colors.white54, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  hintText: "Not Ara",
                  hintStyle: TextStyle(fontSize: 20, color: Colors.white54),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  context.read<HomeCubit>().search(query);
                },
              )
            : const Text(
                "To Do",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(-0.5, 0.5))],
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
              context.read<HomeCubit>().loadNotes();
            },
            icon: Icon(isSearching ? Icons.exit_to_app : Icons.search_rounded),
          ),
        ],
        backgroundColor: Colors.green.shade800,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              SizedBox(
                height: 200,
                child: BlocBuilder<HomeCubit, List<Note>>(
                  builder: (context, notes) {
                    if (notes.isEmpty) return const Center();
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
                              );
                            },
                            child: Stack(
                              children: [
                                _NoteCard(note: note),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: IconButton(
                                      onPressed: () => _confirmDelete(note),
                                      color: Colors.white,
                                      iconSize: 16,
                                      padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                                      icon: const Icon(Icons.remove_circle_outline_sharp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final homeCubit = context.read<HomeCubit>();
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
          homeCubit.loadNotes();
        },
        backgroundColor: Colors.green.shade800,
        child: const Icon(Icons.note_add),
      ),
    );
  }

  void _confirmDelete(Note note) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${note.name}.. notu silinsin mi ?"),
        action: SnackBarAction(
          label: "Evet",
          onPressed: () {
            context.read<HomeCubit>().delete(note.id);
          },
        ),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final Note note;

  const _NoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 220,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade200,
        image: const DecorationImage(
          image: AssetImage("assets/images/gradient2.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.4), blurRadius: 4, offset: const Offset(1, 1)),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text(
                note.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                  overflow: TextOverflow.visible,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(-0.5, 0.5))],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
