import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:work_project/const/colors.dart' show whitecolor;
import 'package:work_project/const/text_style.dart';

import 'package:work_project/controller/player_controller.dart';
import 'package:work_project/view/player.dart';
import 'package:work_project/view/searchpage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 16, 4, 4).withOpacity(1.0),
            Color.fromARGB(175, 247, 107, 0).withOpacity(1.0),
            Color.fromARGB(246, 16, 13, 2).withOpacity(0.7),
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Icon(Icons.grid_view_rounded, color: whitecolor),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      'images/jason-rosewell-ASKeuOZqhYU-unsplash.jpg'),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                icon: Icon(
                  Icons.download,
                  color: const Color.fromARGB(255, 241, 241, 241),
                ),
              ),
              PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: Text('Play All'),
                    value: 'play',
                  ),
                ],
                onSelected: (value) async {
                  if (value == 'play') {
                    final songs = await controller.audioQuery.querySongs(
                      ignoreCase: true,
                      orderType: OrderType.ASC_OR_SMALLER,
                      sortType: null,
                      uriType: UriType.EXTERNAL,
                    );
                    controller.playAllSongs(songs);
                  }
                },
              )
            ],
            title: Text(
              "musicx",
              style: ourstyle(family: bold, size: 18),
            ),
          ),
          body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL,
            ),
            builder: (BuildContext context, Snapshot) {
              if (Snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (Snapshot.data!.isEmpty) {
                print(Snapshot.data);

                return Center(
                    child: Text(
                  'No Song',
                  style: ourstyle(),
                ));
              } else {
                const SizedBox(
                  height: 17,
                );
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: Snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: Obx(
                            () => ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              tileColor: Color.fromARGB(105, 58, 51, 21),
                              title: Text(
                                Snapshot.data![index].displayNameWOExt,
                                style: ourstyle(family: bold, size: 15),
                              ),
                              subtitle: Text(
                                '${Snapshot.data![index].artist}',
                                style: ourstyle(family: regular, size: 12),
                              ),
                              leading: QueryArtworkWidget(
                                id: Snapshot.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(Icons.music_note,
                                    color: whitecolor, size: 36),
                              ),
                              trailing: controller.playindex.value == index &&
                                      controller.isplaying.value
                                  ? const Icon(Icons.play_arrow,
                                      color: whitecolor, size: 26)
                                  : null,
                              onTap: () {
                                Get.to(() => Player(
                                      data: Snapshot.data!,
                                    ));

                                Transition.downToUp;
                                controller.playSong(
                                    Snapshot.data![index].uri, index);
                              },
                            ),
                          ),
                        );
                      }),
                );
              }
            },
          )),
    );
  }
}

class _CustomNavBar extends StatelessWidget {
  const _CustomNavBar();

  @override
  Widget build(Object context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar(
      {Key? key,
      required List<IconButton> actions,
      required Icon leading,
      required Text title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: const CircleAvatar(
            backgroundImage:
                AssetImage('images/jason-rosewell-ASKeuOZqhYU-unsplash.jpg'),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
