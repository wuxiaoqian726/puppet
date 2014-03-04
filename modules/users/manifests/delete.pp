class users::delete($username){
    user{
       $username:
          ensure=>absent
    }
}