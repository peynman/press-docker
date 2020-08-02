<?php

include 'embed.php';
if (isset($_GET['slider'])) {
	echo RevSliderEmbedder::cssIncludes();
	echo RevSliderEmbedder::putRevSlider( $_GET['slider'] );
}