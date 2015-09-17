class accounts (
  $users2add  = ['greg','greg2'],
  $group2add  = 'superadmins',
  $homepath = '/home',
  $initpass = '$1$OURVnD5i$BqgRIOODiaEFTXvr5JyE51'
)  {

define ceateaccount($group,$hpath,$password) {

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

  case $::osfamily {
            'RedHat': {$action = "/bin/sed -i -e 's/$name:!!:/$name:$password:/g' /etc/shadow; chage -d 0 $name"
			notice("REDHAT")

			}
            'Debian': {$action = "/bin/sed -i -e 's/$name:!:/$name:$password:/g' /etc/shadow; chage -d 0 $name"
			notice("Debian")

			}
	    'default':{fail( 'OS unsupported by account class' )
			notice("Default")

			} 
  }
 
  exec { "$action":
            path => "/usr/bin:/usr/sbin:/bin",
            onlyif => "egrep -q  -e '$name:!!:' -e '$name:x:' -e '$name:!:' /etc/shadow",
            require => User[$name]
  }

}
group { $group2add:
    ensure => "present",
    gid    => 10000, 
  } 

ceateaccount {$users2add:
	group => $group2add,
        hpath => $homepath,
        password => $initpass,
		}

}

