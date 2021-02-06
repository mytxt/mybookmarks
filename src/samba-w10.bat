// Windows 10 will try to negotiate SMB3_11, which Samba4 doesn't yet support
// except in the current 4.3 release candidate. I suspect for now disabling
// SMB2/3 on the Windows 10 client is your best, if not ideal, option.
// Which I have also heard isn't entirely correct as Windows 10 should have auto-negotiate capabilities, and should auto-negotiate back down to SMB 3. However, if this is the case then why do samba authentication requests only work with SMB 3 and 2 forcefully disabled?

// Commands used to disable SMB 3 and 2 within Windows 10:

// Code:

sc.exe config lanmanworkstation depend= bowser/mrxsmb10/nsi
sc.exe config mrxsmb20 start= disabled


