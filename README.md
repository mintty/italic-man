## italic-man
enable italics in man pages

---

The italic-man wrapper scripts `grotty` and `iroff` enable italic display 
in manual pages (where italic is specified in the page) 
in terminals supporting italic mode.

The scripts are invoked implicitly within the workflow of man.
They detect the terminal type using a device attributes request. 
Italic support is enabled for mintty (from version 2.0.3), KDE-konsole, 
rxvt-unicode (from version 3.8), xterm (from version 305).

See comments in `grotty` and the manual page about deployment options.
For cygwin, automatic deployment using option 2 "Global configuration" 
is achieved by the postinstall/preremove scripts.

---

These configuration scripts and hints are free to copy, modify, and redistribute according to the GPL:
https://www.gnu.org/licenses/gpl-3.0.en.html
