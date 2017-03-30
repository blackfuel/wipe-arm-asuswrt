<body>

<h1 align="center">WIPE</h1>

<a href="#NAME">NAME</a><br>
<a href="#SYNOPSIS">SYNOPSIS</a><br>
<a href="#DEFAULT">DEFAULT</a><br>
<a href="#DESCRIPTION">DESCRIPTION</a><br>
<a href="#OPTIONS">OPTIONS</a><br>
<a href="#FILES">FILES</a><br>
<a href="#DIAGNOSTICS">DIAGNOSTICS</a><br>
<a href="#BUGS">BUGS</a><br>
<a href="#NOTES">NOTES</a><br>
<a href="#ALTERNATIVES">ALTERNATIVES</a><br>
<a href="#SEE ALSO">SEE ALSO</a><br>
<a href="#AUTHORS">AUTHORS</a><br>

<hr>


<h2>NAME
<a name="NAME"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">wipe &minus;
secure file deletion utility</p>

<h2>SYNOPSIS
<a name="SYNOPSIS"></a>
</h2>



<p style="margin-left:11%; margin-top: 1em"><b>wipe</b></p>


<p style="margin-left:11%; margin-top: 1em">[&minus;ucwsiIhfFdDnNvVzZrRtTkKaAeE]
[&minus;B(count)] [&minus;S(size)] [&minus;C(size)]
[&minus;o[size] &minus;O] [&minus;l[0&minus;2]]
[&minus;x[1&minus;32] &minus;X] [&minus;p(1&minus;32)]
[&minus;b(0&minus;255)] [files]</p>

<h2>DEFAULT
<a name="DEFAULT"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>wipe</b>
&minus;ZdNTVEAkO &minus;S512 &minus;C4096 &minus;l1
&minus;x1 &minus;p1</p>

<h2>DESCRIPTION
<a name="DESCRIPTION"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">Wipe is a
secure file wiping utility. There are some low level issues
that must be taken into consideration. One of these is that
there must be some sort of write barrier between passes.
Wipe uses fdatasync(2) (or fsync(2)) as a write barrier, or
if fsync(2) isn&rsquo;t available, the file is opened with
the O_DSYNC or O_SYNC flag. For wipe to be effective, each
pass must be completely written. To ensure this, the drive
must support some form of a write barrier, write cache
flush, or write cache disabling. SCSI supports ordered
command tags, has a force media access bit for commands, and
write cache can be disable on mode page 8. IDE/ATA drives
support write cache flushes and write cache disabling.
Unfortunetly, not all drives actually disable write cache
when asked to. Those drives are broken. Write caching should
always be disabled, unless your system is battery backed and
always powers down cleanly.</p>

<p style="margin-left:11%; margin-top: 1em">Under linux,
the mount option &quot;mand&quot; must be used (see
linux/Documentation/mandatory.txt) for mandatory file locks
to be enabled. Wipe should make it extremely difficult for
all but the most determined person(s) to recover the
original plaintext data. Utilities such as PGP and the GNU
Privacy Guard provide strong encryption, but encryption is
useless if the original plaintext can be recovered. When
using PGP and GPG, temporary files that are disk-backed
should be stored on an encrypted file system. That way, the
plaintext never hits the platters. Wipe is designed for
situations where an encrypted file system isn&rsquo;t
practical.</p>

<p style="margin-left:11%; margin-top: 1em">Wipe uses
/dev/urandom, or if unavailable, /dev/random, as a source
for entropy. The Mersenne Twister PRNG is used for speed.
The MT site is at:</p>


<p style="margin-left:11%; margin-top: 1em"><i>http://www.math.keio.ac.jp/~matumoto/emt.html</i></p>

<p style="margin-left:11%; margin-top: 1em">For more
information on the secure deletion of magnetic media and
solid state storage devices (such as DRAM) see the USENIX
article by Peter Gutmann at:</p>


<p style="margin-left:11%; margin-top: 1em"><i>http://www.cs.auckland.ac.nz/~pgut001/secure_del.html</i></p>

<h2>OPTIONS
<a name="OPTIONS"></a>
</h2>


<table width="100%" border="0" rules="none" frame="void"
       cellspacing="0" cellpadding="0">
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p style="margin-top: 1em"><i><b>&minus;h</b></i></p></td>
<td width="8%"></td>
<td width="78%">


<p style="margin-top: 1em">Display help screen. Shows
options and what they do.</p></td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;u</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>usage &minus; shows options</p></td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;c</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>shows copywrite information</p></td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;w</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>shows warranty</p></td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;i</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>interactive &minus; prompt whether to remove each file
explicitly checks file permissions</p></td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;I</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>disables interaction</p></td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;f</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>forces file wiping and suppresses permission
warnings</p> </td></tr>
</table>

<p style="margin-left:11%;"><b>&minus;r or &minus;R</b></p>

<p style="margin-left:22%;">recursion &minus; traverse
subdirectories</p>

<table width="100%" border="0" rules="none" frame="void"
       cellspacing="0" cellpadding="0">
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;s</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>silent &minus; disable percent reporting and some
warnings</p> </td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;V</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>verbose &minus; shows percentage if file size is above a
certain limit (see wipe -h)</p></td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;v</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>force verbose &minus; always show percentage</p></td></tr>
</table>

<p style="margin-left:11%;"><b>&minus;e and
&minus;E</b></p>

<p style="margin-left:22%;">on (-e) makes the percentage
(only if shown) more accurate by calling fdatasync() before
each update off (-E) will be slightly less accurate, but
wipe will only call fdatasync() between passes</p>

<p style="margin-left:11%;"><b>&minus;d and
&minus;D</b></p>

<p style="margin-left:22%;">delete (&minus;d) or keep
(&minus;D) after wiping</p>

<p style="margin-left:11%;"><b>&minus;n and
&minus;N</b></p>

<p style="margin-left:22%;">delete (&minus;n) or skip
(&minus;N) fifos, sockets, sym links, and char devices</p>

<p style="margin-left:11%;"><b>&minus;k and
&minus;K</b></p>

<p style="margin-left:22%;">lock (&minus;k) or don&rsquo;t
lock (&minus;K) files during wiping</p>

<table width="100%" border="0" rules="none" frame="void"
       cellspacing="0" cellpadding="0">
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;z</b></p></td>
<td width="8%"></td>
<td width="72%">


<p>zero-out file &minus; performs a single pass of
zeros</p> </td>
<td width="6%">
</td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;Z</b></p></td>
<td width="8%"></td>
<td width="72%">


<p>perform normal passes &minus; overrides &minus;z</p></td>
<td width="6%">
</td></tr>
</table>

<p style="margin-left:11%;"><b>&minus;t and
&minus;T</b></p>

<p style="margin-left:22%;">enable (&minus;t) or disable
(&minus;T) static passes</p>

<p style="margin-left:11%;"><b>&minus;a and
&minus;A</b></p>

<p style="margin-left:22%;">write until out of space
(&minus;a) or don&rsquo;t (&minus;A)</p>

<p style="margin-left:11%;"><b>&minus;o and
&minus;O</b></p>

<p style="margin-left:22%;">write [size] to stdout
(&minus;o) or use files (&minus;O)</p>

<p style="margin-left:22%; margin-top: 1em">Since wipe does
not have specific support for char devs, like it does for
block devs, this is the preferred method of wiping them,
such as tape drives; eg, wipe &minus;za -o | buffer &gt;
/dev/nst0 It can also be used for block devs; eg wipe
&minus;To | dd count=size of=blkdev</p>

<p style="margin-left:22%; margin-top: 1em">You can also
use this to create files containing pseudo-random output
from the MT PRNG; eg, wipe &minus;To10240 -x1 &gt; prand</p>

<p style="margin-left:22%; margin-top: 1em">For static
passes, you must specify a stdout length.</p>

<table width="100%" border="0" rules="none" frame="void"
       cellspacing="0" cellpadding="0">
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;B</b></p></td>
<td width="8%"></td>
<td width="63%">


<p>override block device sector count</p></td>
<td width="15%">
</td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;S</b></p></td>
<td width="8%"></td>
<td width="63%">


<p>override block device sector size</p></td>
<td width="15%">
</td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;C</b></p></td>
<td width="8%"></td>
<td width="63%">


<p>chunk size - the maximum file buffer size</p></td>
<td width="15%">
</td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;l</b></p></td>
<td width="8%"></td>
<td width="63%">


<p>sets generic security level</p></td>
<td width="15%">
</td></tr>
</table>

<p style="margin-left:22%; margin-top: 1em">level 0, the
PRNG is only seeded once</p>

<p style="margin-left:22%; margin-top: 1em">level 1, the
PRNG is seeded once per file</p>

<p style="margin-left:22%; margin-top: 1em">level 2, the
PRNG is seeded once per random pass</p>

<table width="100%" border="0" rules="none" frame="void"
       cellspacing="0" cellpadding="0">
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p style="margin-top: 1em"><b>&minus;x</b></p></td>
<td width="8%"></td>
<td width="78%">


<p style="margin-top: 1em">enables random passes and
optionally, how many random passes to perform &minus; note
that this option now sets the number of random passes per
wipe loop &minus; in other words, the total number of random
passes will be random passes * wipe loops (&minus;p)</p></td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;X</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>disable random passes</p></td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;p</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>loop passes &minus; perform wipe sequence x times,
including random passes</p></td></tr>
<tr valign="top" align="left">
<td width="11%"></td>
<td width="3%">


<p><b>&minus;b</b></p></td>
<td width="8%"></td>
<td width="78%">


<p>custom byte &minus; overwrite once with a specific
byte</p> </td></tr>
</table>

<h2>FILES
<a name="FILES"></a>
</h2>



<p style="margin-left:11%; margin-top: 1em"><b>/dev/urandom</b></p>

<p style="margin-left:22%;">Wipe uses this character device
for a source of entropy</p>

<p style="margin-left:11%;"><b>/dev/random</b></p>

<p style="margin-left:22%;">Wipe falls back to using this
if /dev/urandom is not available</p>

<h2>DIAGNOSTICS
<a name="DIAGNOSTICS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">If an error
occurs, the exit code will be the errno value. An exit code
of 2 indicates bad usage.</p>

<h2>BUGS
<a name="BUGS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">Wipe does not
work on log structured file systems, or any other type of
file system or block device that reallocates sectors on
write.</p>

<p style="margin-left:11%; margin-top: 1em">Some programs
are vulnerable to symlink races. To avoid this problem with
wipe, only wipe files in directories that are not writable
by untrusted users.</p>

<h2>NOTES
<a name="NOTES"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>Tapes and
other sequential access devices</b></p>

<p style="margin-left:11%; margin-top: 1em">Choose an
appropriate buffer size to match the logic or physical block
size of the device. When using the pattern passes, you
should disable compression on the drive, and it&rsquo;s
generally best to so for other passes as well.</p>

<p style="margin-left:11%; margin-top: 1em">For VXA drives,
I used mt-st under linux to set the block size to 0
(variable) and turn off compression, and I run wipe with a
64k block size, to match the on-tape format&rsquo;&rsquo;s
native block size.</p>


<p style="margin-left:11%; margin-top: 1em"><b>Example:</b></p>

<p style="margin-left:11%; margin-top: 1em">mt-st setblk
0</p>

<p style="margin-left:11%; margin-top: 1em">mt-st
compression 0</p>

<p style="margin-left:11%; margin-top: 1em">wipe -C64
/dev/st0</p>

<h2>ALTERNATIVES
<a name="ALTERNATIVES"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>Other file
wiping utilities:</b></p>

<p style="margin-left:11%; margin-top: 1em">Another
&quot;wipe&quot; by Berke Durak
&lt;<i>durakb@crit2.univ-montp2.fr</i>&gt;</p>

<p style="margin-left:11%; margin-top: 1em">Colin
Plumb&rsquo;s &lt;<i>colin@nyx.net</i>&gt; sterilize.</p>

<p style="margin-left:11%; margin-top: 1em">Todd
Burgess&rsquo;s
&lt;<i>tburgess@eddie.cis.uoguelph.ca</i>&gt; srm is
available on sunsite/metalab in</p>


<p style="margin-left:11%; margin-top: 1em"><i>ftp://metalab.unc.edu/pub/Linux/system/filesystems/</i></p>

<h2>SEE ALSO
<a name="SEE ALSO"></a>
</h2>



<p style="margin-left:11%; margin-top: 1em">/usr/doc/wipe/README</p>

<h2>AUTHORS
<a name="AUTHORS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">Wipe <br>
Copyright (C) 1998-2009 Thomas M. Vier, Jr.
&lt;<i>nester@users.sf.net</i>&gt;</p>

<p style="margin-left:11%; margin-top: 1em">Mersenne
Twister PRNG module <br>
Copyright (C) 1997 Makoto Matsumoto and Takuji Nishimura</p>
<hr>
</body>
</html>
