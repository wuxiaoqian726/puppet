class tomcat::install($path="/opt/app",$package_file=$tomcat::params::package_file,$unpackage_directory=$tomcat::params::unpackage_directory)
{
$destination="${path}/${package_file}"

file{
    $destination:
    source=>"puppet:///files/tomcat/${package_file}",
}

exec{
    "extract and change owner":
    command=>"/bin/tar -xzf ${destination} -C ${path} && /bin/chown -R appuser.appuser ${path}/${unpackage_directory}",
    require=>File["${destination}"]
}
}