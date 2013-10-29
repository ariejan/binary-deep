# Binary Deep 2 - Monitoring Script

This script is part of _Binary Deep 2_, an iOS app for monitoring your Digital Ocean Droplets. Although _Binary Deep 2_
is currently in development, you can get the original _Binary Deep_ right now in the App Store.

[Get Binary Deep in the iTunes App Store](http://appstore.com/forsakenlabs/binarydeep)

## Installation

Create a user to run this script. **Do not run this script as root!**. Choose a proper password, or randomly 
generate one.

    sudo adduser binarydeep
    
Then, login as the binarydeep user.

    su - binarydeep
    
And as the final step, install the updater. It will send basic information about your droplet to our server, and 
make them available in Binary Deep 2.

    curl -L https://raw.github.com/ariejan/binary-deep/master/install.sh | bash
    
## Making changes

Please don't make changes to the update script or the update frequency. Doing so may cause your statistics to not be 
recorded properly. 

If you find a bug, or have improvements, please fork this project and create a pull request for review.

## Security

This script is run every minute by your system cron as the `binarydeep` user. It does not open any ports or anything. 
Please review the installation and update scripts here:

 * [update.sh](update.sh)
 * [install.sh](install.sh)

Data sent to our servers is kept for 24 hours at most. It does contain the droplet's public IP address and hostname,
but otherwise it does not contain any personal or identifying information.

Data sent:

 * Public IP address
 * Hostname
 * Memory usage (total, free, used)
 * System load (1, 5 and 15m averages)
 * Number of CPU Cores
 * Uptime (timestamp of last system boot)

If you find any issue with the scripts, please let me know by opening an issue in this project.

## Uninstalling

Uninstalling is quite easy, start by disabling the cronjob. First, login as the `binarydeep` user and disable
the cronjob:

    su - binarydeep
    
Then edit your crontab, 

    crontab -e
    
and simple remove the line that looks like this:

    */1 * * * * /home/ariejan/.binarydeep/update.sh
    
Then save and exit, and crontab will pickup the changes. You can verify your updated crontab:

    crontab -l
    
And lastly, log out as `binarydeep` and remove the binarydeep user and home directory:

    exit
    sudo deluser binarydeep --remove-home
    
## License

The MIT License (MIT)

Copyright (c) 2013 Ariejan de Vroom, Forsaken Labs

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
