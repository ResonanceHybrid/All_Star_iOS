import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/features/videos/presentation/cubit/videos_cubit.dart';
import 'package:all_star_learning/new/features/videos/presentation/cubit/videos_state.dart';
import 'package:all_star_learning/new/features/videos/presentation/view/page/video_player_page.dart';
import 'package:all_star_learning/new/features/videos/presentation/widget/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosView extends StatefulWidget {
  const VideosView({super.key});

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {
  CustomMethods cm = CustomMethods();

  @override
  initState() {
    super.initState();
    context.read<VideosCubit>().getAllVideos();
  }

  String getThumbnail({
    required String videoId,
    String quality = "0",
    bool webp = true,
  }) =>
      webp
          ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp'
          : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosCubit, VideosState>(
      builder: (context, state) {
        return Scaffold(
          appBar: cm.getAppBarWithTitle(context, "Videos"),
          body: Container(
            margin: const EdgeInsets.only(left: 10, top: 10, right: 8),
            child: state.isLoading
                ? const SizedBox(
                    height: 300,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    )),
                  )
                : state.videos.isEmpty
                    ? const Center(
                        child: Text('No Videos Found'),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Video
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<VideosCubit>()
                                    .selectVideo(state.videos[0]);
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => GalleryVideoPlayer(
                                //       videoUrl: state.videos[0].url ?? '',
                                //     ),
                                //   ),
                                // );
                              },
                              child: SizedBox(
                                width: 1.sw,
                                height: 280.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Video Thumbnail
                                    state.isPlaying
                                        ? VideoPlayerWidget(
                                            videoUrl:
                                                state.selectedVideo!.url ?? '')
                                        : Image.network(
                                            getThumbnail(
                                                videoId: YoutubePlayer
                                                        .convertUrlToId(state
                                                                .videos[0]
                                                                .url ??
                                                            "") ??
                                                    ''),
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    SizedBox(
                                              width: 1.sw,
                                              height: 200.h,
                                              child: const Icon(
                                                Icons.error,
                                              ),
                                            ),
                                            width: 1.sw,
                                            height: 200.h,
                                            fit: BoxFit.cover,
                                          ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    // Video Title
                                    Text(
                                      state.videos[0].name ?? '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      DateTime.parse(
                                              state.videos[0].updatedAt ?? '')
                                          .toString()
                                          .split('.')
                                          .first,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Remaining Videos In List
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: state.videos.length - 1,
                            itemBuilder: (context, index) {
                              final video = state.videos[index + 1];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<VideosCubit>()
                                        .selectVideo(video);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            GalleryVideoPlayer(
                                          videoUrl: video.url ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                        getThumbnail(
                                            videoId:
                                                YoutubePlayer.convertUrlToId(
                                                        video.url ?? "") ??
                                                    ''),
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                SizedBox(
                                          width: 80.w,
                                          height: 80.h,
                                          child: const Icon(
                                            Icons.error,
                                          ),
                                        ),
                                        width: 80.w,
                                        height: 80.h,
                                        fit: BoxFit.cover,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 240.w,
                                            child: Text(
                                              video.name ?? '',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            DateTime.parse(
                                                    video.updatedAt ?? '')
                                                .toString()
                                                .split('.')
                                                .first,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }
}
