import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Uploadpage extends StatefulWidget {
  const Uploadpage({super.key});

  @override
  State<Uploadpage> createState() => _UploadpageState();
}

class _UploadpageState extends State<Uploadpage> {
  //?why using File?
  /*
  Because the image you pick from the gallery exists as a file on the device, 
  and in Dart (especially when working with dart:io), 
  we use the File class to handle such local files.
  */
  File? _imageFile;
//*pick the image
  Future pickImage() async {
    //pick image
    final ImagePicker picker = ImagePicker();
    //pick from the gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //update the image preview
    if (image != null) {
      setState(() {
        //image.path is a string that gives the full path to the selected image on the device.
        //To read, display, upload, or manipulate the image file, you need to convert that path into a File object.
        _imageFile = File(image.path);
      });
    }
  }

//*upload the image
  Future uploadImage() async {
    if (_imageFile == null) return;
    //generate a unique file name
    final fileName = DateTime.now().microsecondsSinceEpoch.toString();
    final path = "upload/$fileName";
    //upload the image to storage
    await Supabase
        .instance
        .client
        //inside storage
        .storage
        //to this bucket
        .from("images")
        .upload(path, _imageFile!)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image uploaded successfully"))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Upload Image")),
      ),
      body: Center(
        child: Column(
          children: [
            //image preview
            SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    )
                  : const Center(child: Text("No image selected")),
            ),
            // image picker button
            ElevatedButton(
                onPressed: pickImage, child: const Text("Pick image")),
            //button to upload image
            ElevatedButton(
                onPressed: uploadImage, child: const Text("Upload image")),
          ],
        ),
      ),
    );
  }
}
