<?php
$directories = glob('Samples/*' , GLOB_ONLYDIR);
if(isset($_GET["i"])) {
    $theinput = $_GET["i"];
} else {
    $theinput = "";
}
echo "<html>";
?>

<head>
<title>QB64 Resources</title>
<meta name="description" content="QB64 Resources, Sample Programs" />
<script type="text/javascript"></script>
<link rel="stylesheet" href="stylesqb.css">
<link rel="icon" href="favicon.ico">
</head>

<?php
echo "<body>";
?>

<center>
<div class="container">
  <div class="alignleft">
    <div class="title">
      QB64 Resources
    </div>
  </div>
</div>
</center>

<center>
<div class="container">
  <div class="alignright">
    <div class="subtitle">
      Sample Programs
    </div>
  </div>
  <br/><br/>
  <hr/>
</div>
</center>

<center>
<div class="container">
  <br/>
  <a href="../qb64-samples/index.php?i="><img src="Qb64.png"></a>
  <br/><br/>
</div>
</center>

<?php if ($theinput == "") { ?>

<center>
<div class="container" style="text-align:left">
<?php foreach ($directories as $folder) {
  $tags = file_get_contents($folder . "/tags.txt");
  $author = file_get_contents($folder . "/author.txt");
  echo "<a href=\"index.php?i=" . $folder . "\">" . substr($folder, 8) . "</a> - $author <div class=\"alignright\">" . $tags . "</div><br/>";
} ?>
</div>
</center>

<?php } else { ?>

<?php
$srcbulk = scandir($theinput."/src");
$imgbulk = scandir($theinput."/img");
?>

<center>
<div class="container"> <div class="subtitle"> <?php echo substr($theinput, 8); ?> </div> </div>
</center>

<center>
<div class="container" style="text-align:left">
<h2>Meta</h2>
<?php
  echo "Title: "; $metadat=substr($theinput, 8); echo $metadat . "<br/>"; 
  echo "Author: "; $metadat=file_get_contents($theinput . "/author.txt"); echo $metadat . "<br/>";   
  echo "URL: "; $metadat=file_get_contents($theinput . "/url.txt"); echo "<a href=\"$metadat\">$metadat</a>" . "<br/>";
  echo "Tags: "; $metadat=file_get_contents($theinput . "/tags.txt"); echo $metadat . "<br/>";   
?>
</div>
</center>

<center>
<div class="container" style="text-align:left">
<h2>Download</h2>
<ul>
<?php foreach ($srcbulk as $srcfile) {
  if (($srcfile != ".") & ($srcfile != "..") & (strpos($srcfile, ".") !== false)) {
    $file_info = pathinfo($srcfile);
    $file_extension = $file_info['extension'];
    if ((strtoupper($file_extension) == "BAS") | (strtoupper($file_extension) == "ZIP")) {
      echo "<li><a href=\"" . $theinput . "/src/" . $srcfile . "\">" . $srcfile . "</a></li>";
    }
  }
} ?>
</ul>
</div>
</center>

<center>
<div class="container" style="text-align:left">
<h2>Description</h2>
<i>
<?php foreach (explode("\n", file_get_contents($theinput . "/description.txt")) as $descdat) {
  echo $descdat . "<br/>";
} ?>
</i>
</div>
</center>

<center>
<div class="container" style="text-align:left">
<h2>Code</h2>
<?php foreach ($srcbulk as $srcfile) {
  $flag = 0;
  if (($srcfile != ".") & ($srcfile != "..")) {
    $file_info = pathinfo($srcfile);
    $file_extension = $file_info['extension'];
    if (strtoupper($file_extension) == "BAS") {
      $flag = 1;
      echo $srcfile . "<br/>";
      ?>
      <textarea id="" class="console" cols="90" rows="15"><?php echo file_get_contents($theinput . "/src/" . $srcfile); ?> </textarea>
      <br/><br/>
      <?php
    }
  }
} 
if ($flag == 0) {
  echo "See Download(s) above.";
} ?>
</div>
</center>

<center>
<div class="container" style="text-align:left">
<h2>Screenshots</h2>
<?php foreach ($imgbulk as $imgfile) {
  if (($imgfile != ".") & ($imgfile != "..")) {
    $pth = $theinput . "/img/" . $imgfile;
    if(@is_array(getimagesize($pth))){
      echo "<a href=\"" . $pth . "\"><img src=\"" . $pth . "\"</a><br/><br/>";
    }
  }
} ?>
</div>
</center>

<?php }
echo "<br/><br/></body>";
echo "</html>";
?>