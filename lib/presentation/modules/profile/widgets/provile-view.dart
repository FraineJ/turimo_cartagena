import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/city.model.dart';
import 'package:turismo_cartagena/presentation/bloc/user/user_bloc.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as Global;
import 'package:turismo_cartagena/presentation/global/utils/debouncer.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as W;

class ProfileDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(sl()),
      child: _ProfileDetailContent(),
    );
  }
}

class _ProfileDetailContent extends StatefulWidget {
  @override
  State<_ProfileDetailContent> createState() => _ProfileDetailContentState();
}

class _ProfileDetailContentState extends State<_ProfileDetailContent> {
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String avatar = "";
  String name = "";
  List<CityModel> cities = [];
  final debouncer = Debouncer();
  final FocusNode usernameFocusNode = FocusNode();
  String searchQuery = "";
  String selectedPlace = "";
  DateTime? selectedDate;
  List<String> userSelectedInterests = [];
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();


  void _handleInterestsChanged(List<String> interests) {
    setState(() {
      userSelectedInterests = interests;
    });
    print("Intereses seleccionados: $userSelectedInterests");
  }


  void getInfo() async {
    Map<String, String> userDetails = await Global.Utils.getUserDetails();

    setState(() {
      name = userDetails['name']!;
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Si el TextFormField recibe foco, desplazar hacia arriba
        _scrollController.animateTo(
          100.0, // Ajusta este valor según necesites
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }



  final List<Map<String, String>> options = [
    {'icon': 'place', 'title': 'Donde vives'},
    {'icon': 'cake', 'title': 'Que edad tienes'},
    {'icon': 'music_note', 'title': 'Qué música te gusta'},
    {'icon': 'speaker_notes', 'title': 'Nota'},
    {'icon': 'help_outline', 'title': 'Intereses'},
  ];

  Future<void> _openCamera() async {

    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      final ImagePicker _picker = ImagePicker();

      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        final event = UploadAvatarUserEvent(image);
        context.read<UserBloc>().add(event);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de cámara denegado')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserInfoEvent());
    getInfo();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Si el TextFormField recibe foco, desplazar hacia arriba
        _scrollController.animateTo(
          100.0, // Ajusta este valor según necesites
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:  AppBar(
        title: Text("Editar Perfil"),
        elevation: 1,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.grey.withOpacity(0.8),
              height: 1.0,
            )),

      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is LoadingRequestedState) {
            return _buildLoadingIndicator();
          } else if (state is GetUsersSuccessState) {
            _usuarioController.text = state.userModel?.nationality ?? "";
            _telefonoController.text = state.userModel?.lastName ?? "";
            avatar = state.userModel?.avatar ?? "";
          }
          return _buildProfileContent(state);
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }


  Widget _buildProfileContent(UserState state) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Column(
          children: [
            const SizedBox(height: 16,),
            _buildProfileHeader(),
            const SizedBox(height: 16),
            _buildUserDetails(),
            const SizedBox(height: 16),
            const Text("La información que compartas se utilizará para mejorar tu experiencia dentro de la app y ofrecerte recomendaciones más personalizadas.",
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            _buildProfileForm(),
            _listInteresUser(),
            _buildLogoutButton(),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildProfileImage(),
                _buildEditButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () => _openCamera(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: avatar == null || avatar.isEmpty
            ? Center(
          child: Text(
            name != null && name.isNotEmpty
                ? name.toUpperCase().substring(0, 1)
                : "?", // Muestra un "?" si el nombre es vacío o nulo
            style: const TextStyle(
              fontSize: 60,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : ClipOval(
          child: Image.network(
            avatar,
            fit: BoxFit.cover,
            width: 100, // Ajusta el tamaño de la imagen según sea necesario
            height: 100,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Text(
                name.toUpperCase().substring(0, 1),
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return Positioned(
      bottom: 0,
      right: 24,
      child: GestureDetector(
        onTap: (){
          _openCamera();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal:  7.0, vertical: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            children: [
              Icon(Icons.camera_alt_rounded),
              SizedBox(width: 6.0,),
              Text("Agregar",
                style: TextStyle(
                    fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails() {
    return Column(
      children: [
        _buildUserInfoRow(name),
      ],
    );
  }

  Widget _buildUserInfoRow(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileForm() {
    return ListView.builder(
      shrinkWrap: true,  // Permite que el ListView ocupe solo el espacio necesario.
      itemCount: options.length,  // El número de elementos de la lista
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final option = options[index];
        return Column(
          children: [
            ListTile(
              leading: Icon(_getIcon(option['icon']!)),
              title: Text(option['title']!),
              onTap: () {
                _popupEdit(option['icon']!);
              },
            ),
            // Agregar Divider entre los elementos
            const Divider(
              color: Colors.grey, // Color del Divider
              thickness: 0.5, // Grosor del Divider
            ),
          ],
        );
      },
    );
  }


  Widget _buildLogoutButton() {
    return W.ButtonPrimaryCustom(
      text: "Listo",
      color: Colors.black,
      onPressed: (){

      },
    );
  }

  Widget _buildUpdateButton(UserState state) {
    return FloatingActionButton.extended(
      onPressed: () {


        if (state is SuccessUpdateUserState) {
          W.AlertScreen(
            message: "Usuario actualizado con éxito",
            title: "Actualización exitosa",
            icon: Icons.check_circle,
            colorIcon: Color(0xFF01e63d),
            onPressed: () => Navigator.pop(context),
          ).mostrarAlerta(context);
        } else if (state is ErrorUpdateUserState) {
          W.AlertScreen(
            message: "No fue posible actualizar los datos del usuario",
            title: "Actualización Fallida",
            icon: Icons.cancel,
            colorIcon: Color(0xFFf03705),
            onPressed: () => Navigator.pop(context),
          ).mostrarAlerta(context);
        }
      },
      heroTag: 'Actualizar',
      elevation: 0,
      label: Text("Actualizar"),
      icon: Icon(Icons.save_as_rounded),
    );
  }

  Future<void> _popupEdit(String typeInput) async {


    if (typeInput == "music_note") {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Bottom Sheet Content'),
                  TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Ingrese el nombre de usuario',
                    ),
                    onChanged: (value) {
                      // Lógica para manejar el cambio
                      print('Valor ingresado: $value');
                    },
                    autofocus: true, // Esto asegura que el foco se ponga automáticamente cuando se muestre la pantalla
                  ),
                  SizedBox(height: 16,),
                  _buildLogoutButton(),
                ],
              ),
            ),
          );
        },
      );


    }


  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'school':
        return Icons.school;
      case 'work':
        return Icons.work;
      case 'place':
        return Icons.place;
      case 'cake':
        return Icons.cake;
      case 'music_note':
        return Icons.music_note;
      case 'help_outline':
        return Icons.help_outline;
      case 'speaker_notes':
        return Icons.speaker_notes_rounded;
      default:
        return Icons.help_outline;
    }
  }

  Widget _listInteresUser() {
    return userSelectedInterests.isNotEmpty
        ? Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: userSelectedInterests.map((interest) {
        return ChoiceChip(
          label: Text(interest),
          checkmarkColor:  Colors.white ,
          showCheckmark: false,
          selected: true, // O según la lógica que necesites
          onSelected: (bool selected) {
            setState(() {
              userSelectedInterests.remove(interest);
            });
          },

          selectedColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Bordes ovalados
          ),
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          backgroundColor: Colors.grey.shade200,
          avatar: const Icon(
            Icons.cancel,
            color: Colors.white, // Color de la "X"
          ),
        );
      }).toList(),
    )
        : SizedBox.shrink();
  }

}