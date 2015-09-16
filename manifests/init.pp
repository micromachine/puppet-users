class accounts (
  $users2add  = ['greg','greg2'],
  $group2add  = 'superadmins',
  $homepath = '/home'
)  {

define ceateaccount($group,$hpath) {

  file { "${hpath}/${name}":
    ensure => directory,
    mode   => 0750,
  }

  group { $name:
    ensure => "present",
  } 

  file { "${hpath}/${name}/.ssh":
    ensure            =>  directory,
    owner             =>  $name,
    group             =>  $name,
    mode              =>  '0700',
    require           =>  File["${hpath}/${name}"],
  }


  user { $name:
    ensure => present,
    home   =>  "${hpath}/${name}",
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
        hpath => $homepath,
		}

}

