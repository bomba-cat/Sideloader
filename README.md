# Sideloader

*The missing open-source iOS sideloader.*

Sideloader is an application made to install third-party applications on iOS devices.

You can see it as an open-source replacement of _Cydia Impactor_.

Currently only working on Linux (it was the priority since no easy alternatives exists). \
Windows support is planned (it should not depend on iCloud!).

I tried to make the code as readable as possible, if you struggle to understand anything
I am here to help!

<center>Leave a star and a small tip if you feel like it! — more information at the end!</center>

## How to install

On Linux, when it will be ready, it will be as simple as installing the Flatpak on your
system, or wait for someone to package it for your distribution.

Otherwise, for every currently supported platform, there is an automated build in GitHub
Actions waiting for you — actually, that's more complicated than that, because other 
architectures automated builds relied on GDC cross-compilers, but GDC does not compile the
code currently :(.

Currently, not every built platform is functional, and Linux support is the main focus.

Dependencies (runtime): libimobiledevice, libplist-2.X (I attempted to support both 2.2
and 2.3). OpenSSL is currently also needed, but I plan to remove that dependency as soon
as possible (only networking is requiring it).

## How do I build it myself?

Get a recent version `ldc2` or `dmd` installed (an installation script is available on 
[dlang.org](https://dlang.org/)). GNU D compiler won't compile that code (the cryptography
libraries uses SIMD instructions that it can't compile yet).

## How it works?

It works by fetching an iOS development certificate as Xcode would do if you were
developing your own iOS application[^1] and use it to deploy a third party application.

It does not require any Mac or Windows computer, nor any Apple software to be
installed to work. It is just requiring `libimobiledevice` and `libplist`.

It is still requiring you to have an Apple account (which will play the role of the
app developer to Apple), you can use any account for that, don't need to use your actual
Apple ID used with your phone (I recommend making a burner Apple account, see SideStore 
wiki to have easy ways to do that, or on Linux, I'd recommend installing Apple Music on 
Waydroid).

**Your credentials are only ever sent to Apple servers, and you can easily verify this!**\
In general, never trust anyone to handle your credentials, even more if it is in a
closed-source obfuscated application (as-if there were something to hide there ^^).

[^1]: You may wonder if that would allow full iOS application development on Linux, and
the answer is yes! You can compile a native iOS app on Linux with
[theos](https://theos.dev), and then package it into an ipa with `PACKAGE_FORMAT = ipa` to
eventually install it with Sideloader on a real device (or maybe even an emulated one
in the future!) and debug it (with `idevicedebug` or remote `lldb`). _(TODO: add an option
to add the entitlement for debugging)_

## Notes on platform support

### Linux

Linux version currently only features a GTK frontend. I made one because I was already
familiar with GTK+. I made it in plain code because I really dislike GTK Builder's XML.

### Windows

Windows version uses a Win32 frontend. On Windows 11, it looks old and legacy. The current
state of GUI libraries on Windows is rather unsatisfying: we have one old well-supported
library across the major versions of Windows, Win32, the one I am using, and then we have
a lot of unsuccessful attempts to supplant it, and finally we have WinUI 3, which looks
good but has no bindings whatsoever (WinRT is supported in C# and C++ only, I would have
to make the bindings myself, which I could do but would take some effort), and is not 
supported everywhere (Windows 10+ only). This is why I used DFL, which is a Windows Forms
like wrapper of Win32 APIs.

**Requirements:** a USB muxer, which is generally iTunes or anything 
distirbuting AppleMobileDevice. netmuxd should work too. OpenSSL is also required,
unfortunately.

### macOS

It doesn't work yet. Even less with Apple Silicon. 

## Acknowledgements and references

- [People on this thread](https://github.com/horrorho/InflatableDonkey/issues/87): first
cues on the authentication systems for both machines and accounts.
- All the people in the SideStore team: testing, help on the machine authentication.
- All the people in the AltStore team: help on the account auth, and 2FA (especially 
kabiroberai's code).
- Apple Music for Android libraries: giving the opportunity to make all of this work 
neatly!
- Apple's AuthKit and AuthKitWin: giving me the skeleton of the authentication requests 
directly.
- Probably a lot of people I missed!

## If you like my software, consider starring or even better: sponsoring me :)

In late 2019, Cydia Impactor stopped working, and the underlying reason also affected
some of my personal projects at the time. At this time, I decided to start the development
of an alternative. I had no experience in reverse-engineering, or even just making complex
request for authentication on a server. Making this project made me a better developer,
but this was not easy to do. 

While most Cydia Impactor alternatives benefited of some Apple software available on
macOS or Windows, (and thus were able to hijack their libraries and reproduce their
behaviour), Apple never released anything targeting the end-user on Linux.

I took 2 years to find a way to overcome the problem that encountered Cydia Impactor
without resorting to reimplementing the full Windows API. I dedicated a lot of work
on this software (alongside my studies). 

That is why I am asking you, if you enjoyed my software and if you can afford it, to 
give me a small tip via [GitHub Sponsors](https://github.com/sponsors/Dadoum).
