class accounts (
  $users2add  = ['greg','greg2'],
  $group2add  = ['neoadmins']
)  {

define ceateaccount {

  file { "/home/$name":
    ensure => directory,
    mode   => 0750,
  }

  user { $name:
    ensure => present,
    gid    =>  10000,
    home   =>  "/home/${name}",
    managehome =>  true,
  }


}
group { $group2add:
    ensure => "present",
    gid    => 10000, 
  }

ceateaccount {$users2add:}

}

