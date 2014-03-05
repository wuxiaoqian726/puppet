class tomcat::install($path="/opt/app",$package_file=$tomcat::params::package_file)
{
   $destination="${path}/${package_file}"
   $real_directory="${path}/tomcat"
   file{
     $destination:
      source=>"puppet:///files/tomcat/",
   }

   file{
      "${real_directory}":
         ensure=>directory
   }

   exec{
     "extract and change owner":
       command=>"/bin/tar -xzf ${destination} -C ${real_directory} && /bin/chown -R appuser.appuser ${real_directory}",
       require=>File["${destination}"],
       require=>File["${real_directory}"]
   }
}