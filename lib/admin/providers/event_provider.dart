import 'dart:io';

import 'package:event_management_system/admin/models/slots_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EventProvider with ChangeNotifier {
  DateTime? selectedDate;

  TimeOfDay? _selectedStartTime;
  TimeOfDay? get selectedStartTime => _selectedStartTime;

  TimeOfDay? _selectedEndTime;
  TimeOfDay? get selectedEndTime => _selectedEndTime;

  List<SlotsModel> slots = [];
  List<String> slotIDs = [];

  File? image;

  String _eventCategory = 'Movies & Theatre';
  String get eventCategory => _eventCategory;

  void setEventCategory(String category) {
    _eventCategory = category;
    notifyListeners();
  }

  void selectDate(BuildContext context) async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    notifyListeners();
  }

  void selectImage(ImageSource source) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      if (kDebugMode) {
        print('Image taken from gallary');
      }

      image = File(pickedFile.path);
      // CroppedFile? croppedImage =
      //     await ImageCropper.platform.cropImage(sourcePath: pickedFile.path);

      // if (croppedImage != null) {
      //   image = croppedImage as File?;
      // }
      if (kDebugMode) {
        print('path ${image!.path.toString()}');
      }
    } else {
      if (kDebugMode) {
        print('Failed to pick Image');
      }
    }
    notifyListeners();
  }

  void selecStartTime(BuildContext context) async {
    _selectedStartTime = await showTimePicker(
      context: context,
      initialTime:
          (selectedStartTime == null) ? TimeOfDay.now() : selectedStartTime!,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    notifyListeners();
  }

  void selectEndTime(BuildContext context) async {
    _selectedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: selectedStartTime!.hour + 1,
        minute: selectedStartTime!.minute,
      ),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    notifyListeners();
  }

  void addSlots(SlotsModel slot) {
    slots.add(slot);
    _selectedStartTime = null;
    _selectedEndTime = null;
    notifyListeners();
  }

  void deleteSlots(index) {
    slots.removeAt(index);
    slotIDs.removeAt(index);
    notifyListeners();
  }
}
