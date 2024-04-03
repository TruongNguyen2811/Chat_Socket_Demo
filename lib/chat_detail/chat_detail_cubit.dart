import 'dart:convert';

import 'package:chat_socket/chat_detail/chat_detail_state.dart';
import 'package:chat_socket/model/message_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piesocket_channels/channels.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatDetailCubit() : super(ChatDetailInitial());

  late PieSocketOptions options;
  late Channel channel;
  List<SendMessageResponse> listMessage = [];

  joinRoom() {
    options = PieSocketOptions();
    options.setClusterId("free.blr2");
    // options.setApiKey("vmUe5lxo19WujTs0MsZxtVN3ZBa74SQx2nhFnDdt");
    options.setApiKey("y5sUErrtnWyif3LddZ97aXJ4xDi8sbkL91g1p3xa");

    PieSocket piesocket = PieSocket(options);
    channel = piesocket.join("GR_1697178354776");
    channel.listen("new_message", (PieSocketEvent event) {
      // print(event.toString());
      var x = SendMessageResponse.fromMap(json.decode(event.getData()));
      print('check var ${x}');
      emit(ChatDetailLoading());
      listMessage.add(x);
      emit(UpdateMessage());
    });
  }

  addMessage(SendMessageResponse value) {
    emit(ChatDetailLoading());
    print('check add');
    PieSocketEvent newMessage = PieSocketEvent("new_message");
    newMessage.setData(json.encode(value));
    //Publish event
    channel.publish(newMessage);
    emit(ChatDetailGetDataSuccess());
  }
}
