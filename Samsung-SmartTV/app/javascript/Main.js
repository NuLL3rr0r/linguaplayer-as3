var widgetAPI = new Common.API.Widget();
var pluginAPI = new Common.API.Plugin();
var tvKey = new Common.API.TVKeyValue();

function MouseDownEventHandler(event) {
	Main.SetFocus();
	switch(event.button) {
		case 2: // right click
			event.preventDefault();  //dispatch
			break;
		default:
			break;
	}
	Main.SetFocus();
}

var Main =
{
};

Main.onLoad = function()
{
 	widgetAPI.sendReadyEvent();
	window.onShow = Main.initKeys;
	Main.player = window["player"];
	Main.SetFocus();
	document.getElementById('player').onmousedown = MouseDownEventHandler;
};

Main.initKeys = function()
{
	var NNaviPlugin = document.getElementById("pluginObjectNNavi");
	
	NNaviPlugin.SetBannerState(2);

	// For volume OSD	
	pluginAPI.unregistKey(tvKey.KEY_VOL_UP);
	pluginAPI.unregistKey(tvKey.KEY_VOL_DOWN);
	pluginAPI.unregistKey(tvKey.KEY_MUTE);

	// For Menu key, Info.L key 
	pluginAPI.unregistKey(tvKey.KEY_MENU);
	pluginAPI.unregistKey(tvKey.KEY_INFOLINK);

	// For Exit key	
	pluginAPI.unregistKey(tvKey.KEY_EXIT);

	// For Help
	pluginAPI.unregistKey(tvKey.KEY_RED);
};

Main.handleExit = function()
{
    widgetAPI.sendReturnEvent(); //widgetAPI.sendExitEvent();
};


Main.SetFocus = function()
{
	document.getElementById('player').focus();
};

Main.OnKeyDownHandler = function()
{
	document.getElementById('player').focus();

	var keyCode = window.event.keyCode;

	switch (keyCode) {
		case 84:
			Main.SetFocus();
			Main.player.JSKeyDownHandler(35);
			break;
		case 88:
			Main.SetFocus();
			Main.player.JSKeyDownHandler(35);
			break;
		case 45:
			Main.SetFocus();
			Main.player.JSKeyDownHandler(36);
			break;
		case 108:
			Main.SetFocus();
			Main.player.JSKeyDownHandler(34);
			break;
		default:
			break;
	}
};

