import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:iota/models/category.dart';
import 'package:iota/models/notification.dart';

import '../../utils/local_images.dart';

class HomeViewModel with ChangeNotifier {
  List<NotificationModel> notificationList = new List();
  List<CategoryModel> categoryList = new List();

  void addNoificationList() {
    notificationList.clear();
    notificationList.add(new NotificationModel(LocalImages.ic_notification_1, "It was some time before when he com...", "18 Feb,2020", "4:30 am"));
    notificationList.add(new NotificationModel(LocalImages.ic_notification_2, "Reply , when made ...", "17 Feb,2020", "12:30 pm"));
    notificationList.add(new NotificationModel(LocalImages.ic_notification_3, "was superb dish ...", "17 Feb,2020", "09:30 pm"));
    notificationList.add(new NotificationModel(LocalImages.ic_notification_4, "How are you, my friend", "16 Feb,2020", "4:30 am"));
    notificationList.add(new NotificationModel(LocalImages.ic_notification_5, "Reply , when made ...", "16 Feb,2020", "10:30 am"));
    notificationList.add(new NotificationModel(LocalImages.ic_notification_6, "was superb dish ...", "16 Feb,2020", "09:30 am"));
    notifyListeners();
  }

  void addCategoryList() {
    categoryList.clear();
    categoryList.add(new CategoryModel("Bully Reports", LocalImages.ic_bully_reports));
    categoryList.add(new CategoryModel("Create Polls", LocalImages.ic_create_polls));
    categoryList.add(new CategoryModel("Student Doubts", LocalImages.ic_student_doubts));
    categoryList.add(new CategoryModel("Assign Tasks", LocalImages.ic_assign_tasks));
    categoryList.add(new CategoryModel("Bully Reports", LocalImages.ic_bully_reports));
    categoryList.add(new CategoryModel("Create Polls", LocalImages.ic_create_polls));
    categoryList.add(new CategoryModel("Student Doubts", LocalImages.ic_student_doubts));
    categoryList.add(new CategoryModel("Assign Tasks", LocalImages.ic_assign_tasks));
    categoryList.add(new CategoryModel("Bully Reports", LocalImages.ic_bully_reports));
    categoryList.add(new CategoryModel("Create Polls", LocalImages.ic_create_polls));
    categoryList.add(new CategoryModel("Student Doubts", LocalImages.ic_student_doubts));
    categoryList.add(new CategoryModel("Assign Tasks", LocalImages.ic_assign_tasks));
    notifyListeners();
  }
}
