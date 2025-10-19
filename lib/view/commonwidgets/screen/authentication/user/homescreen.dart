
import 'package:firebasetotalx/view/commonwidgets/screen/authentication/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebasetotalx/constants/appcolors.dart';
import 'package:firebasetotalx/constants/apptextstyles.dart';
import 'package:firebasetotalx/developmentonly/customdebugger.dart';
import 'package:firebasetotalx/model/usermodel.dart';
import 'package:firebasetotalx/providers/homescreenprovider.dart';
import 'package:firebasetotalx/providers/singoutprovider.dart';
import 'package:firebasetotalx/utils/customsnackbar.dart';
import 'package:firebasetotalx/view/commonwidgets/screen/authentication/user/widgets/usertile.dart';
import 'package:firebasetotalx/view/commonwidgets/screen/utils/bottomsheet.dart';
import 'package:firebasetotalx/view/commonwidgets/screen/utils/logoutalert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<UserModel> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    // Fetch all users when the screen loads
    Future.microtask(() {
      final homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);
      homeProvider.getAllUsers();
    });
  }

  void _filterUsers(String query, List<UserModel> users) {
    setState(() {
      _filteredUsers = users
          .where((user) => user.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    logInfo('We are now inside the HomeScreen widget...');
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          showCustomBottomSheet(context);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Nilambur',
          style: AppTextStyles.body.copyWith(color: Colors.white),
        ),
        actions: [
          Consumer<SignOutProvider>(
            builder: (context, signOutProvider, child) {
              // ✅ Proper state handling after logout
              if (signOutProvider.state == AuthState.signedOut) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtpScreen(verificationId: '',),
                    ),
                    (route) => false,
                  );
                });
              }

              return IconButton(
                onPressed: () => showLogoutConfirmationDialog(context),
                icon: const Icon(Icons.logout, color: Colors.white),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                final homeProvider =
                    Provider.of<HomeScreenProvider>(context, listen: false);
                _filterUsers(query, homeProvider.users);
              },
            ),
          ),
        ),
      ),
      body: Consumer<HomeScreenProvider>(
        builder: (context, homeProvider, child) {
          switch (homeProvider.state) {
            case HomeScreenState.loading:
              return const Center(child: CircularProgressIndicator());
            case HomeScreenState.error:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackbar(context, true, homeProvider.errorMessage),
                );
              });
              return const Center(child: Text('Error loading users'));
            case HomeScreenState.loaded:
            default:
              final usersToShow = _searchController.text.isEmpty
                  ? homeProvider.users
                  : _filteredUsers;

              if (usersToShow.isEmpty) {
                return const Center(child: Text('No users found'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: usersToShow.length,
                itemBuilder: (context, index) {
                  final user = usersToShow[index];
                  logInfo('The items in the list are ${usersToShow.length}');
                  return UserTile(userModel: user);
                },
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
