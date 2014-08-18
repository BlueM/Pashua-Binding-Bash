Overview
===========

This is a Bash language binding (glue code) for using [Pashua](www.bluem.net/jump/pashua) from Bash scripts. Pashua is a Mac OS X application for using native GUI dialog windows in various programming languages.

The only code file in this repository, `example.sh`, contains a generic function `pashua_run()` which can be used to manage the communication with Pashua. The way `pashua_run()` works is neither the best nor the only way to “talk” to Pashua from Bash, but rather one out of several possibe ways.

Requirements
=============
This code requires a Bash shell (any recent version should do) and Pashua.
