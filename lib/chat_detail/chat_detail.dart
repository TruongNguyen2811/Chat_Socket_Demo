import 'package:chat_socket/chat_detail/chat_detail_cubit.dart';
import 'package:chat_socket/chat_detail/chat_detail_state.dart';
import 'package:chat_socket/input/input.dart';
import 'package:chat_socket/list_message/list_message.dart';
import 'package:chat_socket/model/message_response.dart';
// import 'package:chat_socket/list_message/list_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail({super.key});

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  late RefreshController controller;
  late ChatDetailCubit _cubit;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    controller = RefreshController();
    _cubit = ChatDetailCubit();
    _cubit.joinRoom();
  }

  scrollToEnd() {
    final double end = controller.position!.minScrollExtent;
    controller.position!.animateTo(end,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 500));
    // itemScrollController.scrollTo(
    //     index: _cubit.listMessage.lengt,
    //     duration: Duration(milliseconds: 500),
    //     curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocConsumer<ChatDetailCubit, ChatDetailState>(
        bloc: _cubit,
        listener: (context, state) async {},
        builder: (context, state) {
          return _buildPage(state);
        },
      ),
    );
  }

  Widget _buildPage(ChatDetailState state) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: Text('123123'),
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
        ),
        // resizeToAvoidBottomInset: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SmartRefresher(
                enablePullUp: true,
                reverse: true,
                footer: CustomFooter(
                  loadStyle: LoadStyle.ShowAlways,
                  builder: (context, mode) {
                    if (mode == LoadStatus.loading ||
                        mode == LoadStatus.canLoading) {
                      return Container(
                        height: 60.0,
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    } else
                      return Container();
                  },
                ),
                header: CustomHeader(
                  builder: (context, mode) {
                    if (mode == RefreshStatus.canRefresh ||
                        mode == RefreshStatus.refreshing) {
                      return Container(
                        height: 60.0,
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    } else
                      return Container();
                  },
                ),
                enablePullDown: true,
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                  // setState(() {
                  //   _cubit.listMessage.addAll(
                  //     [
                  //       SendMessageResponse(originalMessage: '123'),
                  //       SendMessageResponse(originalMessage: '123'),
                  //       SendMessageResponse(originalMessage: '123'),
                  //       SendMessageResponse(originalMessage: '123'),
                  //       SendMessageResponse(originalMessage: '123'),
                  //       SendMessageResponse(originalMessage: '123'),
                  //       SendMessageResponse(originalMessage: '123'),
                  //       SendMessageResponse(originalMessage: '123'),
                  //       SendMessageResponse(originalMessage: '123'),
                  //       SendMessageResponse(
                  //           originalMessage:
                  //               '"{\\\"key\\\":\\\"form\\\",\\\"urlVideo\\\":null,\\\"value\\\":null,\\\"valueImage\\\":[{\\\"image\\\":\\\"https://upload.aggregatoricapaci.com/cardoctor-dev/2024/04/chat-data/image_picker_80C134E9-DD65-495C-9941-72B22A6A32F3-86736-000029FFE42D21C2_4017000.jpg\\\"},{\\\"image\\\":\\\"https://upload.aggregatoricapaci.com/cardoctor-dev/2024/04/chat-data/image_picker_2297EA4C-956B-42FA-A561-1206F3595026-86736-000029FFE44229A9_5709000.jpg\\\"},{\\\"image\\\":\\\"https://upload.aggregatoricapaci.com/cardoctor-dev/2024/04/chat-data/image_picker_A32916BB-3E8E-46FD-A423-E9FCD38CD11C-86736-000029FFE418FC2F_6796000.jpg\\\"},{\\\"image\\\":\\\"https://upload.aggregatoricapaci.com/cardoctor-dev/2024/04/chat-data/image_picker_2CF7CF37-B723-4D8C-88A9-4BBF082E3225-86736-000029FFE4616977_7812000.jpg\\\"}],\\\"valueFiles\\\":null}\",\"attachmentType\":\"1712131117780\",\"linkPreview\":\"\"')
                  //     ],
                  //   );
                  // });
                  controller.refreshCompleted();
                },
                onLoading: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                  // setState(() {
                  //   _cubit.listMessage.insertAll(0, [
                  //     SendMessageResponse(originalMessage: '123'),
                  //     SendMessageResponse(originalMessage: '123'),
                  //     SendMessageResponse(originalMessage: '123'),
                  //     SendMessageResponse(originalMessage: '123'),
                  //     SendMessageResponse(originalMessage: '123'),
                  //     SendMessageResponse(originalMessage: '123'),
                  //     SendMessageResponse(originalMessage: '123'),
                  //     SendMessageResponse(originalMessage: '123'),
                  //     SendMessageResponse(originalMessage: '123'),
                  //     SendMessageResponse(
                  //         originalMessage:
                  //             "{\\\"key\\\":\\\"form\\\",\\\"urlVideo\\\":null,\\\"value\\\":null,\\\"valueImage\\\":[{\\\"image\\\":\\\"https://upload.aggregatoricapaci.com/cardoctor-dev/2024/04/chat-data/image_picker_80C134E9-DD65-495C-9941-72B22A6A32F3-86736-000029FFE42D21C2_4017000.jpg\\\"},{\\\"image\\\":\\\"https://upload.aggregatoricapaci.com/cardoctor-dev/2024/04/chat-data/image_picker_2297EA4C-956B-42FA-A561-1206F3595026-86736-000029FFE44229A9_5709000.jpg\\\"},{\\\"image\\\":\\\"https://upload.aggregatoricapaci.com/cardoctor-dev/2024/04/chat-data/image_picker_A32916BB-3E8E-46FD-A423-E9FCD38CD11C-86736-000029FFE418FC2F_6796000.jpg\\\"},{\\\"image\\\":\\\"https://upload.aggregatoricapaci.com/cardoctor-dev/2024/04/chat-data/image_picker_2CF7CF37-B723-4D8C-88A9-4BBF082E3225-86736-000029FFE4616977_7812000.jpg\\\"}],\\\"valueFiles\\\":null}\"")
                  //   ]);
                  // });
                  controller.loadComplete();
                },
                controller: controller,
                child: ScrollablePositionedList.builder(
                  padding: EdgeInsets.only(bottom: 16),
                  // reverse: true,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _cubit.listMessage.length,
                  itemBuilder: ((context, index) {
                    // return Container();
                    bool isMe = false;
                    // final message Message = messages[index];
                    if (_cubit.listMessage[index].username ==
                        "CarDoctor447GARAGE_OWNER") {
                      isMe = true;
                    }

                    return BuildMessage(
                      message: _cubit.listMessage[index],
                      isMe: isMe,
                    );
                  }),
                ),
              ),
            ),
            InputComponent(
              onTap: () async {
                // await Future.delayed(Duration(milliseconds: 500));
                // scrollToEnd();
              },
              press: (value) {
                SendMessageResponse message = SendMessageResponse(
                  originalMessage: value['originalMessage'],
                  filteredMessage: value['originalMessage'],
                  username: "CarDoctor447GARAGE_OWNER",
                );
                scrollToEnd();
                // final double end = controller.position!.maxScrollExtent;
                _cubit.addMessage(message);
                // controller.position!.animateTo(end,
                //     curve: Curves.easeIn,
                //     duration: const Duration(milliseconds: 500));
              },
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     addMessage();
        //   },
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}
