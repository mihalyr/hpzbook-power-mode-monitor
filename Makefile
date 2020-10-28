# Installs the scripts for veramount
SHELL=/bin/sh

# Where scripts go
SBINDIR=/usr/local/sbin
# Where systemd files go
SYSTEMDDIR=/etc/systemd/system

.SUFFIXES:
.PHONY: help install uninstall enable disable

help: 			# Show available targets
	@echo
	@echo "Available targets:"
	@echo
	@grep -P '^\w+:' Makefile | sed 's/^/\t/'
	@echo

enable: 		# Enable and start systemd timer
	@systemctl enable hpzbook-power-mode-monitor.timer
	@systemctl start hpzbook-power-mode-monitor.timer

disable: 		# Stop and disable systemd timer
	@systemctl stop hpzbook-power-mode-monitor.timer
	@systemctl disable hpzbook-power-mode-monitor.timer

install: 		# Install scripts and systemd files
	@echo "Installing..."
	@mkdir -vp $(SBINDIR)
	@mkdir -vp $(SYSTEMDDIR)
	@install -v -m 755 sbin/* $(SBINDIR)
	@install -v -m 644 systemd/* $(SYSTEMDDIR)
	@systemctl daemon-reload
	@echo "Done"

uninstall: disable 	# Remove scripts and systemd files
	@echo "Uninstalling..."
	@rm -vf $(SBINDIR)/hpzbook-power-mode-check
	@rm -vf $(SYSTEMDDIR)/hpzbook-power-mode-monitor.timer
	@rm -vf $(SYSTEMDDIR)/hpzbook-power-mode-monitor.service
	@systemctl daemon-reload
	@echo "Done"

