# Assets

Assets are currently stored in a Google Drive. To access them contact a project admin. Once access is granted follow the steps below.

## Configure sync

1. Download and install rclone: https://rclone.org/downloads/

    a. Windows users need to put 'rclone.exe' inside the 'Windows/System32' directory.

2. Open a bash terminal in the root directory of the project.

3. Run the `sync` script with the configure flag. It will open a browser window to authenticate. Make sure you select the google account that has access to the project assets:
    
    `./sync -c`

4. Run the sync script with the apropriate sync flag.
   
   * To sync local assets to the Google drive:

        `./sync -u`
   
   * To sync Google Drive to the local directory:

        `./sync -d`

5. At anytime you can use `./sync -h` to see a list of all options.

## Sync from Google Drive to local
`./sync -d`

## Sync from local to Google Drive
`./sync -u`

## Get a list of sync options
`./sync -h`