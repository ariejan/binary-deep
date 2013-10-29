#!/usr/bin/env bash

BINARY_DEEP_HOME=$HOME/.binarydeep
BINARY_DEEP_SCRIPT=$BINARY_DEEP_HOME/update.sh

SCRIPT_URL=https://raw.github.com/ariejan/binary-deep/master/update.sh

JOB="*/1 * * * * $BINARY_DEEP_SCRIPT"

log()  { printf "%b\n" "$*"; }
fail() { log "\nERROR: $*\n" ; exit 1 ; }

log "Binary Deep Monitoring Installer"
log

# Create ~/.binarydeep
if [ ! -d $BINARY_DEEP_HOME ]; then
	log "- Creating $BINARY_DEEP_HOME"
	mkdir -p $BINARY_DEEP_HOME
else
	log "- Using $BINARY_DEEP_HOME"
fi

# Force-download the update script
log "- Downloading update script to $BINARY_DEEP_SCRIPT"
wget -q -O $BINARY_DEEP_SCRIPT $SCRIPT_URL
chmod u+x $BINARY_DEEP_SCRIPT

# Update Crontab
log "- Updating crontab"
cat <(fgrep -i -v "$BINARY_DEEP_SCRIPT" <(crontab -l)) <(echo "$JOB") | crontab -

# First time execution
log "- Performing first-time update"
$BINARY_DEEP_SCRIPT

log
log "All done."
