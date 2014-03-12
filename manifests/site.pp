import 'nodes/*.pp'
import 'modules/*.pp'

node base{
    include tomcat

    file{
        ["/opt/app","/opt/app/bin","/opt/app/logs","/opt/app/webapps"]:
         ensure=>directory,
         owner  => "appuser",
         group  => "appuser",
    }
}