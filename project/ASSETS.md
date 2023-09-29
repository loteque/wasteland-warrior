# Assets

Assets are currently stored in a Google Drive. To access them contact a project admin. Once access is granted add the assets directory from Google Drive to the project/ directory.

https://rclone.org/downloads/

Follow this guide: https://rclone.org/drive/

For the remote name use "wasteland-warrior"

enter the number for "google drive", eg. 18

Leave these empty:
Option client_id.
Google Application Client Id
client_secret

Option scope: 1

For the root folder ID use "assets"

For the service account file, press enter.

Edit advanced config? No

Use web browser to automatically authenticate rclone with remote? Yes

Shared drive? No

Keep this wastland-warrior remote? Yes

Quit config

## Now setup sync directory

Once you have the remote setup you can sync the assets directory with the following command:

`./sync.sh`

## To sync

`./sync.sh`
