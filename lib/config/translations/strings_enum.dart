class Strings {
  static const String hello = 'hello';
  static const String loading = 'loading';

  static const String changeTheme = 'change_theme';
  static const String changeLanguage = 'change_language';

  static const String noInternetConnection = 'no internet connection';
  static const String serverNotResponding = 'server not responding';
  static const String someThingWentWorng = 'something went wrong';
  static const String apiNotFound = 'api not found';
  static const String serverError = 'Server error';
  static const String urlNotFound = 'Url not found';

  static const String email = 'Email';
  static const String password = 'Password';
  static const String newPassword = 'New Password';
  static const String selectSchool = 'Select School';
  static const String signIn = 'Sign In';
  static const String updatePassword = 'Update Password';

  static const String studentProfile = 'Student Profile';
  static const String fees = 'Fees';
  static const String results = 'Results';
  static const String attendance = 'Attendance';
  static const String subjects = 'Subjects';
  static const String routine = 'Routine';
  static const String library = 'Library';
  static const String onlineExams = 'Online Exams';
  static const String teachers = 'Teachers';
  static const String dormitory = 'Dormitory';
  // static const String transport = 'Transport';
  static const String downloads = 'Downloads';
  // static const String canteen = 'Canteen';

  // network erros
  static const String sslError = 'SSL Error';
  static const String badResponse = 'Bad Response';
  static const String requestCancelled = 'Request Cancelled';
  static const String connectionError = 'Connection Error';
  static const String connectionTimeout = 'Connection Timeout';
  static const String responseTimeout = 'Response Timeout';
  static const String sendTimeout = 'Send Timeout';
  static const String somethingWentWrong = 'Something went wrong';

  // network urls
  static const String baseUrl = "https://demo.allstarems.com/api/";
  static const String loginUrl = "login";
  static const String updatePasswordUrl = "user/change-password";
  static const String editProfileUrl = "profile/update";
  static const String resetPasswordUrl = "reset-password";
  static const String verifyOTPUrl = "otp-verification";

  static const String examsUrl = "exam-list";
  static const String subjectsUrl = "subject-list";
  static const String classesUrl = "teacher/classes";
  static const String classCASUrl = "teacher/classes";
  static const String techerSubjectUrl = "teacher/exam/get-subjects";
  static const String monthUrl = "month-list";

  static const String schoolList = "school/list";
  static const String sectionsUrl = "teacher/get-sections";
  static const String assignMarksUrl = "teacher/exam/assign-marks";
  static const String storeMarksUrl = "teacher/exam/assign-marks/store";
  static const String assingEcaMarksUrl = "teacher/exam/assign-marks/eca";
  static const String storeEcaMarksUrl = "teacher/exam/assign-marks/store";
  static const String assignCasMarksUrl = "teacher/exam/assign-marks/cas";
  static const String casTypes = "/teacher/exam/get-cas-types";
  static const String examTypes = "/teacher/exam/get-exam-types";
  static const String getExamsList = "/teacher/exam/get-exams-for-ut";
  static const String fetchUtMarks = "/teacher/exam/get-unit-test-marks";
  static const String storeCasMarksUrl = "teacher/exam/assign-marks/store";
  static const String marksLedgerUrl = "teacher/exam/marks-ledger";
  static const String storeStudentAttendanceUrl =
      "teacher/student-attendance/store";
  static const String addHomework = "homework";
  static const String homeworkDetails = "homework";
  static const String homeworkEvaluation = "homework-evaluation";
  static const String getStudentHomeworkDetails = "homework-list-view";
  static const String deleteHomeworkFile = "homework/file/delete";
  static const String addhomeworkComment = "homework-comment";
  static const String getNotices = "notice-board";
  static const String storeCasEvaluation = "teacher/exam/cas-evaluation/store";


  //STUDENT API

  static const String studentExamYearList = "student/exams";
  static const String studentExamDetails = "student/exam-result";
  static const String studentProfileData = "student/profile";
  static const String studentFees = "student/fees";
  static const String studentDueDetails = "student/payment/bill";
  static const String studentFeesDetails = "student/fees/details";
  static const String uploadProfile = "student/profile/store";
  static const String studentSubjects = "student/subjects";
  static const String studentTeachers = "student/teachers";
  static const String studentContentTypes = "student/get-content-types";
  static const String studentContentData = "student/get-content";
  static const String studentHomework = "homework-student";
  static const String studentHomeworkDelete = "homework/file/delete";
  static const String uploadFCMToken = "store-device-token";
  static const String getEvents = "events";
  static const String getAttendance = "student/attendance";
  static const String getBioAttendance = "student/biometric-attendance";
  static const String getNotifications = "notifications";
}
