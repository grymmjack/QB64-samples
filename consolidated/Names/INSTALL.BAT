rem * INSTALL.BAT * Install program

echo off
cls
echo . INSTALLATION PROGRAM:  Floppy drive to hard drive             (1 DISK)
echo . -----------------------------------------------------------------------------
echo . This program will automatically install the program on your hard drive.
echo .
echo . IMPORTANT:  Three things must be specified with the INSTALL command:
echo .             The PROGRAM on this disk to install on the hard drive,
echo .             The HARD DISK DRIVE on which MS-DOS 5.0 is located and the
echo .             PATH TO DOS on that drive.  The proper syntax is:
echo .
echo .             INSTALL X Y Z ... substitute program name for "X".
ECHO .                           ... substitute letter of destination hard disk
echo .                               drive for "Y".
echo .                           ... substitute path to DOS for "Z".
echo .
echo . Examples:   INSTALL NAMES C \DOS
echo . Your Entry: INSTALL %1 %2 %3
echo . -----------------------------------------------------------------------------
echo .  Press cntl-C to cancel, or any other key to continue ...
pause
cls

if exist \%1\*.* goto CHEKBAT
echo 
echo .             ERROR ... INSTALLATION ABORTED!
echo .
echo Install Disk is not in the default disk drive, or program was
echo improperly specified. Make the disk drive containing the
echo Install disk the default disk drive and restart this program.
goto END

:CHEKBAT
if exist %2:\*.* goto CHEKDOS
echo 
echo .             ERROR ... INSTALLATION ABORTED!
echo .
echo The Hard Drive was incorrectly specified.  You may have misidentified
echo or failed to identify the destination disk drive for this installation.
echo Check installation instructions.
echo .                                            ===
echo .                     Drive specified was ... %2
echo .                                            ===
goto END

:CHEKDOS
if exist %2:%3\qbasic.* goto CONTINUE
echo 
echo .             ERROR ... INSTALLATION ABORTED!
echo .
echo -  MS-DOS under directory %2:%3 has not been detected.
echo -
echo -  Drive & Path to MS-DOS may have been improperly specified.  Check
echo -  installation instructions.
echo -  ----------------------------------------------------------------------------
echo . IMPORTANT:  Three things must be specified with the INSTALL command.
echo .             The PROGRAM on this disk to install on the hard drive,
echo .             The HARD DISK DRIVE on which MS-DOS 5.0 is located and the
echo .             PATH TO DOS on that drive.  The proper syntax is:
echo .
echo .             INSTALL X Y Z ... substitute program name for "X".
ECHO .                           ... substitute letter of destination hard disk
echo .                               drive for "Y".
echo .                           ... substitute path to DOS for "Z".
echo .
echo . Examples:   INSTALL NAMES C \DOS
echo . Your Entry: INSTALL %1 %2 %3
echo . -----------------------------------------------------------------------------
goto END

:CONTINUE
echo STANDBY:  Program installation in progress . . .
echo .
copy \%1\*.bas %2:%3
copy \%1\*.bat %2:\
cls
echo This program has been successfully installed to drive %2
goto END

:END
echo on
