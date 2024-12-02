import 'package:flutter/material.dart';
import 'package:guidedlayout2_1748/View/Profile/Camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Untuk File image
import 'package:flutter/services.dart'; // Untuk PlatformException
// import 'package:guidedlayout2_1748/View/Profile/Camera/camera.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? image; // Menyimpan gambar yang diambil

  // Fungsi untuk memilih gambar dari galeri
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      setState(() {
        this.image = File(image.path);
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  // Fungsi untuk mengambil gambar dengan kamera
  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      setState(() {
        this.image = File(image.path);
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            backgroundImage: image != null ? FileImage(image!) : null,
            child: image == null ? Icon(Icons.person, size: 50, color: Colors.grey[700]) : null,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Tampilkan pop-up untuk pilihan foto
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (BuildContext context) {
                  return PopupUploadFoto(
                    pickImage: pickImage,
                    pickImageC: pickImageC,
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Upload Foto',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          ProfileTextField(
            icon: Icons.person,
            label: 'Username',
          ),
          ProfileTextField(
            icon: Icons.height,
            label: 'Tinggi',
          ),
          ProfileTextField(
            icon: Icons.monitor_weight,
            label: 'Berat',
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save the profile changes
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
            ),
            child: Text(
              'Simpan',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final IconData icon;
  final String label;

  ProfileTextField({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.edit, color: Colors.grey[600]),
        ],
      ),
    );
  }
}

// Bottom sheet untuk pilihan foto profil
class PopupUploadFoto extends StatelessWidget {
  final Future Function() pickImage;
  final Future Function() pickImageC;

  PopupUploadFoto({required this.pickImage, required this.pickImageC});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Foto Profil',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Menutup pop-up
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Icon(
            Icons.person,
            size: 40,
            color: Colors.grey[700],
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity, // Mengatur lebar tombol sampai mentok
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraView()),
                );
                // pickImageC(); // Mengambil gambar dari kamera
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              icon: Icon(Icons.camera_alt, color: Colors.white),
              label: Text('Unggah Foto', style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity, // Mengatur lebar tombol sampai mentok
            child: OutlinedButton.icon(
              onPressed: () {
                pickImage(); // Mengambil gambar dari galeri
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              icon: Icon(Icons.photo_library, color: Colors.black),
              label: Text('Gunakan Galeri', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
