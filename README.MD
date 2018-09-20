# AUTO INSTALL QT

## Purpose
This repos sole purpose is to automatically install QT at the given install prefix. It does that by downloading the official installer for Qt for the platform, then automatically runs through the installer using an automated build script. It will then install the QT libs and bin and such in the intended place. 

## When to use this
This is only to be used with Robo's version of the cura-build-environment. We noticed that when we were building from source we were missing vital libraries and resources. 

## Usage
You must know beforehand where you would like to put QT

### Linux
```
configure_QT.sh <Your Install location>
```

### Windows
not made yet

### OSX
not made yet