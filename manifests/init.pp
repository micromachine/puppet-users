class accounts (
  $users2add  = ['greg','greg2'],
<<<<<<< HEAD
  $group2add  = ['neoadmins']
=======
  $group2add  = ['superadmins']
>>>>>>> 522dac39fc90552b6ffe17031ad87d7ca993a633
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

