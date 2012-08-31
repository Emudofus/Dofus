// Action script...

// [Initial MovieClip Action of sprite 1058]
#initclip 25
class dofus.graphics.gapi.ui.Debug extends ank.gapi.core.UIAdvancedComponent
{
    var _lblPrompt, _tiCommandLine, _cLogs, api, _fps, _mcFpsPlacer, getNextHighestDepth, attachMovie, unloadThis, addToQueue, _btnClose, _btnClear, _btnCopy, _btnMinimize, _srLogsBack, _srCommandLineBack;
    function Debug()
    {
        super();
    } // End of the function
    function setPrompt(sPrompt)
    {
        _lblPrompt.__set__text(sPrompt + " > ");
        _tiCommandLine._x = _lblPrompt._x + _lblPrompt.__get__textWidth() + 2;
        _lblPrompt.setPreferedSize("left");
    } // End of the function
    function setLogsText(sLogs)
    {
        _cLogs.__set__text(sLogs);
    } // End of the function
    function clear()
    {
        api.datacenter.Basics.aks_a_logs = "";
        this.setLogsText("");
    } // End of the function
    function showFps()
    {
        if (_fps == undefined)
        {
            this.attachMovie("Fps", "_fps", this.getNextHighestDepth(), {_x: _mcFpsPlacer._x, _y: _mcFpsPlacer._y, _width: _mcFpsPlacer._width, _height: _mcFpsPlacer._height, styleName: "DofusFps"});
        }
        else
        {
            _fps.removeMovieClip();
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Debug.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: applySizeIndex});
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnClear.addEventListener("click", this);
        _btnCopy.addEventListener("click", this);
        _btnMinimize.addEventListener("click", this);
        Key.addListener(this);
    } // End of the function
    function initFocus()
    {
        _tiCommandLine.setFocus();
    } // End of the function
    function initData()
    {
        _cLogs.__set__text(api.datacenter.Basics.aks_a_logs);
        this.setPrompt(api.datacenter.Basics.aks_a_prompt);
    } // End of the function
    function placeCursorAtTheEnd()
    {
        _tiCommandLine.setFocus();
        Selection.setSelection(_tiCommandLine.text.length, 1000);
    } // End of the function
    function applySizeIndex()
    {
        switch (api.kernel.OptionsManager.getOption("DebugSizeIndex"))
        {
            case 0:
            {
                this.maximize(dofus.graphics.gapi.ui.Debug.MIDDLE_SIZE);
                break;
            } 
            case 1:
            {
                this.minimize();
                break;
            } 
            case 2:
            {
                this.maximize(dofus.graphics.gapi.ui.Debug.BIG_SIZE);
                break;
            } 
        } // End of switch
        this.initFocus();
    } // End of the function
    function minimize()
    {
        _cLogs._visible = false;
        _srLogsBack.setSize(undefined, 20);
        _srCommandLineBack._y = _tiCommandLine._y = _lblPrompt._y = _cLogs._y;
    } // End of the function
    function maximize(nHeight)
    {
        _cLogs._visible = true;
        _cLogs.setSize(undefined, nHeight);
        _srLogsBack.setSize(undefined, nHeight + 20);
        _srCommandLineBack._y = _tiCommandLine._y = _lblPrompt._y = _cLogs._y + nHeight;
    } // End of the function
    function onKeyUp()
    {
        switch (Key.getCode())
        {
            case 38:
            {
                _tiCommandLine.__set__text(api.kernel.DebugConsole.getHistoryUp());
                this.placeCursorAtTheEnd();
                break;
            } 
            case 40:
            {
                _tiCommandLine.__set__text(api.kernel.DebugConsole.getHistoryDown());
                this.placeCursorAtTheEnd();
                break;
            } 
            case 13:
            {
                if (Key.isDown(17))
                {
                    var _loc2 = api.kernel.OptionsManager.getOption("DebugSizeIndex") + 1;
                    _loc2 = _loc2 % 3;
                    api.kernel.OptionsManager.setOption("DebugSizeIndex", _loc2);
                    this.applySizeIndex();
                    break;
                } // end if
                if (_tiCommandLine.__get__focused())
                {
                    var _loc3 = _tiCommandLine.__get__text();
                    if (_loc3.length == 0)
                    {
                        return;
                    } // end if
                    _tiCommandLine.__set__text("");
                    api.kernel.DebugConsole.process(_loc3);
                }
                else
                {
                    _tiCommandLine.setFocus();
                } // end else if
                break;
            } 
        } // End of switch
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target)
        {
            case _btnClose:
            {
                this.callClose();
                break;
            } 
            case _btnClear:
            {
                this.clear();
                break;
            } 
            case _btnCopy:
            {
                System.setClipboard(_cLogs.__get__text());
                break;
            } 
            case _btnMinimize:
            {
                var _loc2 = api.kernel.OptionsManager.getOption("DebugSizeIndex") + 1;
                _loc2 = _loc2 % 3;
                api.kernel.OptionsManager.setOption("DebugSizeIndex", _loc2);
                this.applySizeIndex();
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "Debug";
    static var MIDDLE_SIZE = 200;
    static var BIG_SIZE = 370;
} // End of Class
#endinitclip
