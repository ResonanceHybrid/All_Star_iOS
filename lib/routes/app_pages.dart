import 'package:all_star_learning/Pages/SelectSchool/select_school_page.dart';
import 'package:all_star_learning/Pages/Settings/notification_page.dart';
import 'package:all_star_learning/Pages/Settings/settings_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Attendence/attendance_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Auth/change_password_first_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Auth/login_page.dart';
// import 'package:all_star_learning/Pages/StudentPages/Canteen/canteen_fee_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Downloads/download_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Fee/fee_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Fee/statement_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Homework/homework_download_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Homework/homework_view_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Homework/student_submitted_homework_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Results/result_details_page.dart';
import 'package:all_star_learning/Pages/StudentPages/StudentCommingSoon/student_comming_soon.dart';
import 'package:all_star_learning/Pages/StudentPages/StudentHome/student_home_page.dart';
import 'package:all_star_learning/Pages/StudentPages/OnlineClass/online_class.dart';
import 'package:all_star_learning/Pages/StudentPages/Results/results_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Student%20Details/student_profile_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Subjects/subject_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Teacher/teacher_page.dart';
// import 'package:all_star_learning/Pages/StudentPages/Transportation/transportation_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Assign%20CAS/assign_cas_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Assign%20ECA/assign_eca_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Assign%20Marks/assign_marks_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Attandance/teacher_attandance_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/AttendanceReport/teacher_attendance_report_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/CasEvaluation/cas_evaluation_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/CommingSoon/comming_soon.dart';
import 'package:all_star_learning/Pages/TeacherPages/Homework/home_work_list_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Homework/homework_evaluate.dart';
import 'package:all_star_learning/Pages/TeacherPages/Homework/teacher_homework_view_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Homework/view_homework_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Marks%20Ledger/marks_ledger_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Marks%20Ledger/marks_ledger_search_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Profile/teacher_profile_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Search/search_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/SearchAttendance/search_attendance_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Teacher%20Notice/teacher_notices.dart';
import 'package:all_star_learning/Pages/TeacherPages/TeacherHome/teacher_home_page.dart';
import 'package:all_star_learning/new/features/call_log/presentation/view/call_log_view.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/view/complain_box_view.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/view/pages/create_complain_page.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/view/pages/update_complain_page.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/view/pages/view_complain_page.dart';
import 'package:all_star_learning/new/features/exam_routine/presentation/view/exam_routine_teacher_view.dart';
import 'package:all_star_learning/new/features/exam_routine/presentation/view/exam_routine_view.dart';
import 'package:all_star_learning/new/features/leave/presentation/view/leave_view.dart';
import 'package:all_star_learning/new/features/leave/presentation/view/pages/create_leave_page.dart';
import 'package:all_star_learning/new/features/leave/presentation/view/pages/edit_leave_page.dart';
import 'package:all_star_learning/new/features/qr/presentation/pages/qr_attendance_report_page.dart';
import 'package:all_star_learning/new/features/qr/presentation/pages/qr_attendance_report_view.dart';
import 'package:all_star_learning/new/features/qr/presentation/pages/student_qr_attendance_report.dart';
import 'package:all_star_learning/new/features/qr/presentation/view/qr_view.dart';
import 'package:all_star_learning/new/features/student_list/presentation/view/pages/student_detail_page.dart';
import 'package:all_star_learning/new/features/student_list/presentation/view/student_list_view.dart';
import 'package:all_star_learning/new/features/videos/presentation/view/videos_view.dart';
import 'package:all_star_learning/widgets/common_widgets/full_image_viewer.dart';
import 'package:all_star_learning/widgets/photo_view.dart';

import 'package:all_star_learning/Pages/student_navigation_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Homework/add_home_work.dart';
import 'package:all_star_learning/Pages/teacher_navigation_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../Pages/StudentPages/Auth/change_password_page.dart';
import '../Pages/StudentPages/Auth/edit_profile_page.dart';
import '../Pages/StudentPages/Auth/otp_verification_page.dart';
import '../Pages/StudentPages/Auth/reset_password_page.dart';
import '../Pages/TeacherPages/CasEvaluation/search_cas_evaluation_page.dart';
import '../Pages/TeacherPages/SelfAttendanceReport/self_attendance_report_page.dart';

class AppPages {
  AppPages._();
  //this is to prevent anyone from instantiating this object
  static const initial = "/home";
  static const selectSchool = "/selectSchool";
  static const home = "/home";
  static const login = "/login";
  static const changePasswordFirstTime = "/changePasswordFirstTime";
  static const changePassword = "/changePassword";
  static const editProfile = "/editProfile";
  static const resetPassword = "/resetPassword";
  static const otpVerification = "/otpVerification";

  //student
  static const studentNavigation = "/studentNavigation";
  static const onlineclass = "/onlineclass";
  static const fees = "/fees";
  static const statements = "/statements";
  static const results = "/results";
  static const resultDetails = "/resultDetails";
  static const attendance = "/attendance";
  static const subjects = "/subjects";
  static const examRoutine = "/examRoutine";
  static const teachers = "/teachers";
  // static const canteen = "/canteen";
  static const transport = "/transport";
  static const downloads = "/downloads";
  static const onlineExam = "/onlineExam";
  static const routine = "/routine";
  static const library = "/library";
  static const dromitory = "/dromitory";
  static const studentprofile = "/studentProfile";
  static const studenthomeworkview = "/studentHomeworkView";
  static const studentSubmittedHomework = "/studentSubmittedHomework";
  static const studentHomeworkDownload = "/studentHomeworkDownload";
  static const complainBox = "/complainBox";
  static const createComplain = "/createComplain";
  static const updateComplain = "/updateComplain";
  static const viewComplain = "/viewComplain";
  static const calender = "/calender";
  static const studentCommingSoonPage = "/studentCommingSoonPage";
  static const studentCommingSoonPageWithBackAppBar =
      "/studentCommingSoonPageWithBackAppBar";
  static const events = "/events";
  static const videos = "/videos";
  static const callLog = "/call-logs";
  static const videoPage = "/videoPage";
  static const studentQrReport = "/studentQrReport";

  //global
  static const settings = "/settings";
  static const photoView = "/photoView";

  //teacher
  static const teacherNavigation = "/teacherNavigation";
  static const teacherProfile = "/teacherProfile";
  static const teacherHome = "/teacherHome";
  static const teacherOnlineClass = "/teacherOnlineClass";
  static const teacherAttendance = "/teacherAttendance";
  static const teacherExamRoutine = "/teacherExamRoutine";
  static const teacherSelfAttendanceReport = "/teacherSelfAttendanceReport";
  static const teacherAttandanceReport = "/teacherAttandanceReport";
  static const teacherQRAttendanceReport = "/teacherQRAttandanceReport";
  static const teacherNotices = "/teacherNotices";
  static const searchPage = "/searchPage";
  static const assignMarks = "/assignMarks";
  static const assignECA = "/assignECA";
  static const assignCAS = "/assignCAS";
  static const marksLedger = "/marksLedger";
  static const addHomeWork = "/addHomeWork";
  static const homeworkList = "/homeworkList";
  static const addLessonPlan = "/addLessonPlan";
  static const lessonPlanList = "/lessonPlanList";
  static const uploadContent = "/uploadContent";
  static const teacherAssignment = "/teacherAssignment";
  static const studyMaterial = "/studyMaterial";
  static const uploadLeaveApplication = "/uploadLeaveApplication";
  static const leaveApplicationList = "/leaveApplicationList";
  static const attendanceSearchPage = "/attendanceSearchPage";
  static const marksLedgerSearchPage = "/marksLedgerSearchPage";
  static const homeworkEvaluatePage = "/homeworkEvaluatePage";
  static const teacherHomeworkDetailsView = "/teacherHomeworkDetailsView";
  static const teacherHomeworkView = "/teacherHomeworkView";
  static const commingSoonPageWithBackAppbar = "/commingSoonPageWithBackAppbar";
  static const commingSoonPage = "/commingSoon";
  static const notificationPage = "/notification";
  static const qrPage = "/qrPage";
  static const qrAttendanceReportSearchPage = "/qrAttendanceReportSearchPage";
  static const leavePage = "/leavePage";
  static const createLeavePage = "/createLeave";
  static const updateLeavePage = "/updateLeave";
  static const studentListPage = "/studentListPage";
  static const studentDetailPage = "/studentDetailPage";
  static const searchCasEvaluation = "/searchCasEvaluation";
  static const casEvaluation = "/casEvaluation";
  static const fullImageViewer = "/fullImageViewer";

  static final routes = [
    GetPage(
      name: initial,
      page: () => const HomePage(),
    ),

    GetPage(
      name: events,
      page: () => const AttendancePage(),
    ),

    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: commingSoonPageWithBackAppbar,
      page: () => const CommingSoonPage(
        backAppBar: true,
      ),
    ),
    GetPage(
      name: commingSoonPage,
      page: () => const CommingSoonPage(
        backAppBar: false,
      ),
    ),
    GetPage(
      name: studentCommingSoonPage,
      page: () => const StudentCommingSoonPage(
        backAppBar: false,
      ),
    ),
    GetPage(
      name: studentCommingSoonPageWithBackAppBar,
      page: () => const StudentCommingSoonPage(
        backAppBar: true,
      ),
    ),
    GetPage(
      name: photoView,
      page: () => PhotoviewPage(
        imageUrl: Get.arguments,
      ),
    ),
    GetPage(
      name: selectSchool,
      page: () {
        return SelectSchoolPage(
          selectedSchool: Get.arguments,
        );
      }
    ),
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: changePasswordFirstTime,
      page: () => const ChangePasswordFirstTimePage(),
    ),
    GetPage(
      name: changePassword,
      page: () => ChangePasswordPage(
        userId: Get.arguments,
      ),
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfilePage(),
    ),
    GetPage(
      name: resetPassword,
      page: () => const ResetPasswordPage(),
    ),
    GetPage(
      name: otpVerification,
      page: () {
        return OTPVerificationPage(
          phoneNum: Get.arguments["phone_number"],
          userId: Get.arguments["user_id"],
        );
      },
    ),
    //student pages
    GetPage(
      name: studentNavigation,
      page: () => const StudentNavigationPage(),
    ),
    GetPage(
      name: onlineclass,
      page: () => const OnlineClassPage(),
    ),
    GetPage(
      name: studentprofile,
      page: () => StudentProfilePage(
        fromNav: Get.arguments,
      ),
    ),
    GetPage(
      name: fees,
      page: () => const FeePage(),
    ),
    GetPage(
      name: statements,
      page: () => const StatementPage(),
    ),
    GetPage(
      name: marksLedgerSearchPage,
      page: () {
        return MarksLedgerSearchPage(
          pageTitle: Get.arguments["pageTitle"],
          route: Get.arguments["route"],
        );
      },
    ),
    GetPage(
      name: results,
      page: () => const ResultPage(),
    ),
    GetPage(
      name: resultDetails,
      page: () => ResultDetailsPage(
        resultId: Get.arguments,
      ),
    ),
    GetPage(
      name: attendance,
      page: () => const AttendancePage(),
    ),
    GetPage(
      name: subjects,
      page: () => const SubjectPage(),
    ),
    GetPage(
      name: examRoutine,
      page: () => const ExamRoutinePage(),
    ),
    GetPage(
      name: teacherExamRoutine,
      page: () => const TeacherExamRoutinePage(),
    ),
    GetPage(
      name: teacherSelfAttendanceReport,
      page: () => const TeacherSelfAttendanceReportPage(),
    ),
    GetPage(
      name: teachers,
      page: () => const TeachersPage(),
    ),
    GetPage(
      name: downloads,
      page: () => const DownloadPage(),
    ),
    // GetPage(
    //   name: transport,
    //   page: () => const TransportationPage(),
    // ),
    // GetPage(
    //   name: canteen,
    //   page: () => const CanteenFeePage(),
    // ),
    GetPage(
      name: studenthomeworkview,
      page: () => StudentHomeworkViewPage(
        homeworkFiles: Get.arguments['homeworkFiles'],
        description: Get.arguments['description'],
      ),
    ),
    GetPage(
      name: studentHomeworkDownload,
      page: () => StudentHomeworkDownloadPage(
        homeworkFiles: Get.arguments['homeworkFiles'],
      ),
    ),
    GetPage(
      name: studentSubmittedHomework,
      page: () => StudentSubmittedHomeworkPage(
        homeworkId: Get.arguments,
      ),
    ),
    GetPage(
      name: notificationPage,
      page: () => const NotificationPage(),
    ),
    GetPage(
      name: complainBox,
      page: () => const ComplainBoxView(),
    ),
    GetPage(
      name: createComplain,
      page: () => const CreateComplainPage(),
    ),
    GetPage(
      name: updateComplain,
      page: () => const UpdateComplainPage(),
    ),
    GetPage(
      name: viewComplain,
      page: () => const ViewComplainPage(),
    ),

    // teachers pages

    GetPage(
      name: teacherNavigation,
      page: () => const TeacherNavigationPage(),
    ),
    GetPage(
      name: teacherHome,
      page: () => const TeacherHomePage(),
    ),
    GetPage(
      name: teacherProfile,
      page: () => const TeacherProfilePage(),
    ),
    GetPage(
      name: assignMarks,
      page: () => AssignMarksPage(
        classId: Get.arguments['classId'],
        sectionId: Get.arguments['sectionId'],
        subjectId: Get.arguments['subjectId'],
        examId: Get.arguments['examId'],
        className: Get.arguments['className'],
        sectionName: Get.arguments['sectionName'],
        examName: Get.arguments['examName'],
        subjectName: Get.arguments['subjectName'],
      ),
    ),
    GetPage(
      name: assignECA,
      page: () => AssignEcaMarksPage(
        classId: Get.arguments['classId'],
        sectionId: Get.arguments['sectionId'],
        examId: Get.arguments['examId'],
        className: Get.arguments['className'],
        sectionName: Get.arguments['sectionName'],
        examName: Get.arguments['examName'],
      ),
    ),
    GetPage(
      name: assignCAS,
      page: () => AssignCasMarksPage(
        classId: Get.arguments['classId'],
        sectionId: Get.arguments['sectionId'],
        examId: Get.arguments['examId'],
        className: Get.arguments['className'],
        sectionName: Get.arguments['sectionName'],
        examName: Get.arguments['examName'],
        subjectId: Get.arguments['subjectId'],
      ),
    ),
    GetPage(
      name: teacherNotices,
      page: () => TeacherNoticesPage(isFromNotification: Get.arguments),
    ),
    GetPage(
      name: addHomeWork,
      page: () => const AddHomeworkPage(),
    ),
    GetPage(
      name: homeworkList,
      page: () => const HomeworkListPage(),
    ),
    GetPage(
      name: addLessonPlan,
      page: () => const CommingSoonPage(
        backAppBar: true,
      ),
    ),
    GetPage(
        name: searchPage,
        page: () {
          Map<String, dynamic> args = Get.arguments;
          return SearchPage(
            pageTitle: args['pageTitle'],
            route: args['route'],
          );
        }),
    GetPage(
      name: teacherOnlineClass,
      page: () => const CommingSoonPage(
        backAppBar: true,
      ),
    ),
    GetPage(
        name: teacherAttandanceReport,
        page: () {
          Map<String, dynamic>? args = Get.arguments;

          return args != null
              ? AttendanceReportsPage(
                  classList: args['classList'],
                  monthList: args['monthList'],
                  sectionList: args['sectionList'],
                  selectedClass: args['selectedClass'],
                  selectedMonth: args['selectedMonth'],
                  selectedSection: args['selectedSection'],
                  selectedType: args["selectedType"],
                )
              : const SizedBox(
                  height: 0,
                );
        }),
    GetPage(
        name: teacherQRAttendanceReport,
        page: () {
          Map<String, dynamic>? args = Get.arguments;

          return args != null
              ? QRAttendanceReportsPage(
                  classList: args['classList'],
                  monthList: args['monthList'],
                  sectionList: args['sectionList'],
                  selectedClass: args['selectedClass'],
                  selectedMonth: args['selectedMonth'],
                  selectedSection: args['selectedSection'],
                  attendanceTypes: args['attendanceTypes'],
                )
              : const SizedBox(
                  height: 0,
                );
        }),
    GetPage(
        name: attendanceSearchPage,
        page: () {
          Map<String, dynamic> args = Get.arguments;
          return SearchAttendancePage(
            pageTitle: args['pageTitle'],
            route: args['route'],
          );
        }),
    GetPage(
        name: teacherAttendance,
        page: () {
          return Get.arguments != null
              ? TeacherAttendancePage(
                  selectedType: Get.arguments["selectedType"],
                  attendanceDate: Get.arguments["attendanceDate"],
                  selectedClass: Get.arguments["selectedClass"],
                  selectedSection: Get.arguments["selectedSection"],
                  classList: Get.arguments["classList"],
                  sectionList: Get.arguments["sectionList"],
                )
              : const SizedBox(
                  height: 0,
                );
        }),
    GetPage(
        name: marksLedger,
        page: () {
          var args = Get.arguments;
          return MarksLedgerPage(
            classId: args['class_id'],
            sectionId: args['section_id'],
            examId: args['exam_id'],
            ledgerType: args['type'],
            className: args['class_name'],
            sectionName: args['section_name'],
            examName: args['exam_name'],
            ledgerTypeName: args['ledger_exam_type'],
          );
        }),
    GetPage(
      name: uploadContent,
      page: () => const CommingSoonPage(
        backAppBar: true,
      ),
    ),
    GetPage(
      name: homeworkEvaluatePage,
      page: () => TeacherEvaluateHomeworkPage(
        homeworkId: Get.arguments,
      ),
    ),
    GetPage(
      name: teacherHomeworkDetailsView,
      page: () => TeacherHomeWorkViewPage(
        homeworkId: Get.arguments["homeworkId"],
        userId: Get.arguments["userId"],
      ),
    ),
    GetPage(
      name: teacherHomeworkView,
      page: () => ViewHomeWorkPage(
        homeWork: Get.arguments,
      ),
    ),
    GetPage(
      name: studyMaterial,
      page: () => const CommingSoonPage(
        backAppBar: true,
      ),
    ),
    GetPage(
      name: uploadLeaveApplication,
      page: () => const CommingSoonPage(
        backAppBar: true,
      ),
    ),
    GetPage(
      name: leaveApplicationList,
      page: () => const LeaveView(),
    ),
    GetPage(
      name: studentQrReport,
      page: () => const StudentQrAttendanceReport(),
    ),

    //global
    GetPage(
      name: settings,
      page: () => const SettingsPage(),
    ),

    GetPage(
      name: qrPage,
      page: () => const QrView(),
    ),
    GetPage(
      name: leavePage,
      page: () => const LeaveView(),
    ),
    GetPage(
      name: createLeavePage,
      page: () => const CreateLeavePage(),
    ),
    GetPage(
      name: updateLeavePage,
      page: () => const EditLeavePage(),
    ),
    GetPage(
      name: studentListPage,
      page: () => const StudentListView(),
    ),
    GetPage(
      name: studentDetailPage,
      page: () => const DetailedStudentPage(),
    ),
    GetPage(
      name: videos,
      page: () => const VideosView(),
    ),
    GetPage(
      name: callLog,
      page: () => const CallLogView(),
    ),
    GetPage(
      arguments: Get.arguments,
      name: qrAttendanceReportSearchPage,
      page: () {
        Map<String, dynamic> args = Get.arguments;
        return QRSearchAttendancePage(
          route: args['route'],
        );
      },
    ),
    GetPage(
      name: searchCasEvaluation,
      page: () => const SearchCasEvaluationPage(),
    ),
    GetPage(
      name: casEvaluation,
      page: () {
        var args = Get.arguments;
        return CasEvaluationPage(
          classId: args['class'],
          sectionId: args['section'],
          subjectId: args['subject_id'],
          date: args['date'],
          monthId: args["month"],
          reportType: args["type"],
        );
      },
    ),
    GetPage(
      name: fullImageViewer,
      page: () {
        var args = Get.arguments;
        String imagePath = args["image_path"];
        return FullImageViewer(imageData: imagePath);
      },
    ),
  ];
}
