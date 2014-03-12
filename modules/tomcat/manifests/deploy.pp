define tomcat::deploy($instance_name,$server_port,$http_port,$jvm_args,$conf_dir){

file{
    ["/opt/app/webapps/${instance_name}","/opt/app/webapps/${instance_name}/webapps","/opt/app/webapps/${instance_name}/temp"]:
    mode  => '0755',
    owner  => $tomcat::params::tomcat_user,
    group  =>  $tomcat::params::tomcat_group,
    ensure =>  directory
}

file {
    "/opt/app/webapps/${instance_name}/conf":
    ensure  =>  directory,
    mode  => '0755',
    owner  =>  $tomcat::params::tomcat_user,
    group  =>  $tomcat::params::tomcat_group,
    recurse  => true,
    ignore  => '.svn',
    source  =>  "${conf_dir}",
    require  =>  File["/opt/app/webapps/${instance_name}"],
}

file{
    "/opt/app/bin/tomcat-${instance_name}-start.sh":
    mode   => "0744",
    owner  => $tomcat::params::tomcat_user,
    group  => $tomcat::params::tomcat_group,
    content =>template("tomcat/tomcat-start.sh.erb"),
#notify => Service["tomcat-${instance_name}"],
}

file{
    "/opt/app/bin/tomcat-${instance_name}-stop.sh":
    mode=> "0744",
    owner  => $tomcat::params::tomcat_user,
    group  => $tomcat::params::tomcat_group,
    content =>template("tomcat/tomcat-stop.sh.erb"),
}

file {
    "/opt/app/logs/${instance_name}" :
    owner => $tomcat::params::tomcat_user,
    group => $tomcat::params::tomcat_group,
    ensure => directory,
    mode => '0775',
}

file {
    "/etc/init.d/tomcat-${instance_name}":
    ensure  => present,
    owner  => 'root',
    group  => 'root',
    mode  => '0755',
    content  => template('tomcat/etc/init.d/tomcat.erb'),
    require  => File["/opt/app/bin/tomcat-${instance_name}-start.sh", "/opt/app/bin/tomcat-${instance_name}-stop.sh"],
}

#
#service {
#    "tomcat-${instance_name}":
#    enable  => true,
#    ensure  => running,
#    hasstatus  => true,
#    hasrestart  => true,
#    require  => File["/etc/init.d/tomcat-${instance_name}"],
#}


}