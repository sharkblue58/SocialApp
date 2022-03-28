class PostModel{

  String? name='';
  String? uId='';
  String? image='';
  String? dateTime='';
  String? text='';
  String? postImage='';



  PostModel(  {  this.name='' ,  this.uId='',  this.image='',this.dateTime='',this.text='',this.postImage=''});
  PostModel.fromJson(Map<String,dynamic>?jason){
    name=jason!['name'];
    image=jason['image'];
    uId=jason['uId'];
    dateTime=jason['date'];
    text=jason['text'];
    postImage=jason['postImage'];
  }
  Map<String,dynamic>toMap(){

    return {
      'name':name,
      'uId':uId,
      'image':image,
      'date':dateTime,
      'text':text,
      'postImage':postImage
    };
  }
}