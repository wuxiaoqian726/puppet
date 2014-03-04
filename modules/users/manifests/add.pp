class users::add($username,$usergroup,$uid='',$home='/home/$username',$shell='/bin/bash',$password){

  user{
      $username:
          ensure=>present,
          uid=>$uid,
          groups=>$usergroup,
          home=>$home,
          shell=>$shell,
          password=>$password
  }
  #allow the uid parameter not init

}