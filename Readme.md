Overview
===========

This is a Bash language binding (glue code) for using [Pashua](http://www.bluem.net/jump/pashua) from Bash scripts. Pashua is a macOS application for using native GUI dialog windows in various programming languages.

This code can be found in a GitHub repository at https://github.com/BlueM/Pashua-Binding-Bash. For examples in other programming languages, see https://github.com/BlueM/Pashua-Bindings.


Usage
======
This repository contains two code files:

* “example.sh” is an example, which does not do much more than define how the dialog window should look like and use the functions in the second file (which it includes by using `source`).
* “pashua.sh” contains two functions. Usually you will only need `pashua_run()`, but if you would like to find out where Pashua is, you can also use `locate_pashua()`. You can put “pashua.sh” anywhere you like, and if it is in your `$PATH`, you can just use a simple `source pashua.sh` to load it (instead of dynamically determining the path, as in “example.sh”). Of course, you can also just take the functions use them inlined in your code.

Of course, you will need Pashua on your Mac to run the example. The code expects Pashua.app in one of the “typical” locations, such as the global or the user’s “Applications” folder, or in the folder which contains “example.sh”.


Compatibility
=============
This code should run with a Bash that shipped with any macOS that is able to run Pashua.

It is compatible with Pashua 0.10. It will work with earlier versions of Pashua, but non-ASCII characters will not be displayed correctly, as any versions before 0.10 required an argument for marking input as UTF-8.


Author
=========
This code was written by Carsten Blüm, with a contribution by Tor Sigurdsson


License
=========
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

