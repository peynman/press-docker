<?php

include 'embed.php';
if (isset($_GET['slider']))
?>
<html>
<head>
    <?php echo RevSliderEmbedder::cssIncludes(); ?>
</head>
<body style="margin: 0; padding: 0;">
<?php 	echo RevSliderEmbedder::putRevSlider( $_GET['slider'] ); ?>
<?php 	echo RevSliderEmbedder::jsIncludes(); ?>
</body>
</html>
