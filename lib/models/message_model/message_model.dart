class MessageModel{

  String senderId='';
  String reciverId='';
  String dateTime='';
  String text='';


  MessageModel(  { this.senderId='' ,   this.reciverId='' , this.dateTime='',  this.text='', });
  MessageModel.fromJson(Map<String,dynamic>?jason){
    senderId=jason!['senderId'];
    reciverId=jason['reciverId'];
    dateTime=jason['dateTime'];
    text=jason['text'];
  }
  Map<String,dynamic>toMap(){

    return {
      'senderId':senderId,
      'reciverId':reciverId,
      'dateTime':dateTime,
      'text':text,

    };
  }
}