node 'host2' inherits base {
file{
    "/tmp/host2-puppet":
    content => "test"
}

tomcat::deploy{
    "test-service":
    instance_name=>"test-service",
    server_port=>"8005",
    http_port=>"8081",
    jvm_args=>"-Xms600m -Xmx600m -XX:+HeapDumpOnOutOfMemoryError",
    conf_dir => "puppet:///files/webapps/test-service/conf",
}

}
