class accounts (
  $users2add  = ['greg','greg2'],
  $group2add  = 'superadmins'
)  {

define ceateaccount($group) {

  file { "/home/$name":
    ensure => directory,
    mode   => 0750,
  }

  group { $name:
    ensure => "present",
  } 


  user { $name:
    ensure => present,
    home   =>  "/home/${name}",
    managehome =>  true,
    groups => [$name,$group],
    require    => Group[$group],

  }
}
group { $group2add:
    ensure => "present",
    gid    => 10000, 
  } 

ceateaccount {$users2add:
	group => $group2add,
		}

}

