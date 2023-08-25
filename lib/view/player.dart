import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:work_project/const/colors.dart';
import 'package:work_project/controller/player_controller.dart';
import '../const/text_style.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 58, 32, 1),
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => Expanded(
                    child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 500,
                        width: 500,
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        alignment: Alignment.center,
                        child: QueryArtworkWidget(
                          id: data[controller.playindex.value].id,
                          type: ArtworkType.AUDIO,
                          artworkHeight: double.infinity,
                          artworkWidth: double.infinity,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: whitecolor,
                          ),
                        ))),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    )),
                child: Obx(
                  () => Column(children: [
                    Text(
                      data[controller.playindex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style:
                          ourstyle(Color: bgdarkcolor, family: bold, size: 21),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      data[controller.playindex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: ourstyle(
                          Color: bgdarkcolor, family: regular, size: 21),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            controller.position.value,
                            style: ourstyle(Color: bgdarkcolor),
                          ),
                          Expanded(
                              child: Slider(
                                  thumbColor: slidercolor,
                                  inactiveColor: bgcolor,
                                  activeColor: slidercolor,
                                  min: const Duration(seconds: 0)
                                      .inSeconds
                                      .toDouble(),
                                  max: controller.max.value,
                                  value: controller.value.value,
                                  onChanged: (newvalue) {
                                    controller.changeDurationToseconds(
                                        newvalue.toInt());
                                    newvalue = newvalue;
                                  })),
                          Text(controller.duration.value,
                              style: ourstyle(Color: bgdarkcolor))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.playSong(
                                  data[controller.playindex.value - 1].uri,
                                  controller.playindex.value - 1);
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              size: 40,
                              color: bgdarkcolor,
                            )),
                        Obx(
                          () => Transform.scale(
                            scale: 2.5,
                            child: IconButton(
                              onPressed: () {
                                if (controller.isplaying.value) {
                                  controller.audioplayer.pause();
                                  controller.isplaying(false);
                                } else {
                                  controller.audioplayer.play();
                                  controller.isplaying(true);
                                }
                              },
                              icon: controller.isplaying.value
                                  ? const Icon(
                                      Icons.pause,
                                      color: bgcolor,
                                      size: 15,
                                    )
                                  : const Icon(
                                      Icons.play_arrow_rounded,
                                      color: bgcolor,
                                      size: 15,
                                    ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.playSong(
                                  data[controller.playindex.value + 1].uri,
                                  controller.playindex.value + 1);
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              size: 40,
                              color: bgdarkcolor,
                            )),
                        IconButton(
                          onPressed: () {
                            controller
                                .shuffleSongs(data); // Call the shuffle method
                          },
                          icon: const Icon(Icons.shuffle),
                        ),
                      ],
                    )
                  ]),
                ),
              ))
            ],
          )),
    );
  }
}
