import 'nodes/*.pp'
import 'modules/*.pp'

node base{
    include tomcat

    file{
        "/opt/app":
         ensure=>directory,
    }
}