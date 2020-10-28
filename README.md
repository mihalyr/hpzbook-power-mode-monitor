# HP ZBook Power Mode Monitor

On some HP ZBook models the battery/AC change power\_supply event is not trigerred
at all and TLP won't automatically change the power modes from battery to AC
and vice-versa resulting in either low perf mode on AC or consuming too much
power on battery.

To fix this, I've added a systemd timer to poll for battery status
changes and trigger udev events on power supply changes.

Contents:
* systemd timer
* systemd service that is executed by the timer
* shell script that is executed by the systemd service

## Usage

Install: `sudo make install`
Uninstall: `sudo make uninstall`
Enable/start: `sudo make enable`
Stop/disable: `sudo make disable`

The events are logged in the systemd service output and can be retrieved via
usual means (`journalctl`).

The state file that is used for storing the previous (last seen) state is
stored under `/var/run`. When the current power supply state is different from
the stored state, an UDEV event is triggered and other services can be
informed.

