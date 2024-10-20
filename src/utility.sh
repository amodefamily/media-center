groupname='docker44'
username='dockeruser'

echo Checking user $username existance
if getent passwd $username > /dev/null 2>&1; then
  echo "User $username exists"
else
  echo "User $username doesn't exist"
  echo "Create user $username and install again"
  exit
fi

echo Checking group $groupname existance
if getent group $groupname > /dev/null 2>&1; then
  echo "Group $groupname exists"
else
  echo "Creating group $groupname"
  groupadd $groupname
fi

echo Adding user $username to group $groupname
if usermod -aG $groupname $username >/dev/null 2>&1; then
  echo "User $username added to group $groupname"
else
  echo "failed to add $username to $groupname"
  exit
fi

useruid=$(id -u $username)
echo "User uid is $useruid"
usergid=$(id -g $username)
echo "User gid is $usergid"
