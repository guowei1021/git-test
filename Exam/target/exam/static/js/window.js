function iframeWindow(){
	if(self!=top){
		function_window = window;
		display_window = top;
		top.function_window = window;
		top.display_window = top;
	}else{
		function_window = window;
		display_window = window;
	}
}