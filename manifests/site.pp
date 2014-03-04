import 'nodes/*.pp'
import 'modules/*.pp'

node base{

    file{
        "/opt/app":
         ensure=>directory,
    }
}