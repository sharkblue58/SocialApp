class SocialUserModel{

   String name='';
   String email='';
   String phone='';
   String uId='';
   String image='';
   String cover='';
   String bio='';
   bool isEmailVerified=false;

  SocialUserModel(  { this.email='' ,   this.name='' , this.phone='',  this.uId='', this.isEmailVerified=false, this.image='', this.bio='', this.cover=''});
  SocialUserModel.fromJson(Map<String,dynamic>?jason){
    name=jason!['name'];
    email=jason['email'];
    phone=jason['phone'];
    image=jason['image'];
    cover=jason['cover'];
    bio=jason['bio'];
    uId=jason['uId'];
    isEmailVerified=jason['isEmailVerified'];
  }
  Map<String,dynamic>toMap(){

    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}