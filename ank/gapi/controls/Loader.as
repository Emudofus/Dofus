// Action script...

// [Initial MovieClip Action of sprite 42]
#initclip 21
class ank.gapi.controls.Loader extends ank.gapi.core.UIBasicComponent
{
    var __get__enabled, __get__scaleContent, __get__autoLoad, __get__centerContent, _oParams, __get__contentParams, __get__contentPath, _nBytesLoaded, _nBytesTotal, __get__bytesLoaded, __get__bytesTotal, holder_mc, _bLoaded, _sPrevURL, _bInited, _mvlLoader, createEmptyMovieClip, __width, __height, dispatchEvent, _visible, __set__autoLoad, __set__centerContent, __get__content, __set__contentParams, __set__contentPath, __set__enabled, __get__holder, __get__loaded, __get__percentLoaded, __set__scaleContent;
    function Loader()
    {
        super();
    } // End of the function
    function set enabled(bEnabled)
    {
        super.__set__enabled(bEnabled);
        //return (this.enabled());
        null;
    } // End of the function
    function set scaleContent(bScaleContent)
    {
        _bScaleContent = bScaleContent;
        //return (this.scaleContent());
        null;
    } // End of the function
    function get scaleContent()
    {
        return (_bScaleContent);
    } // End of the function
    function set autoLoad(bAutoLoad)
    {
        _bAutoLoad = bAutoLoad;
        //return (this.autoLoad());
        null;
    } // End of the function
    function get autoLoad()
    {
        return (_bAutoLoad);
    } // End of the function
    function set centerContent(bCenterContent)
    {
        _bCenterContent = bCenterContent;
        //return (this.centerContent());
        null;
    } // End of the function
    function get centerContent()
    {
        return (_bCenterContent);
    } // End of the function
    function set contentParams(oParams)
    {
        _oParams = oParams;
        //return (this.contentParams());
        null;
    } // End of the function
    function get contentParams()
    {
        return (_oParams);
    } // End of the function
    function set contentPath(sURL)
    {
        _sURL = sURL;
        if (_bAutoLoad)
        {
            this.load();
        } // end if
        //return (this.contentPath());
        null;
    } // End of the function
    function get contentPath()
    {
        return (_sURL);
    } // End of the function
    function get bytesLoaded()
    {
        return (_nBytesLoaded);
    } // End of the function
    function get bytesTotal()
    {
        return (_nBytesTotal);
    } // End of the function
    function get percentLoaded()
    {
        var _loc2 = Math.round(this.__get__bytesLoaded() / this.__get__bytesTotal() * 100);
        _loc2 = isNaN(_loc2) ? (0) : (_loc2);
        return (_loc2);
    } // End of the function
    function get content()
    {
        return (holder_mc.content_mc);
    } // End of the function
    function get holder()
    {
        return (holder_mc);
    } // End of the function
    function get loaded()
    {
        return (_bLoaded);
    } // End of the function
    function forceNextLoad()
    {
        delete this._sPrevURL;
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.Loader.CLASS_NAME);
        if (_bScaleContent == undefined)
        {
            _bScaleContent = true;
        } // end if
        _bInited = true;
        _nBytesLoaded = 0;
        _nBytesTotal = 0;
        _bLoaded = false;
        _mvlLoader = new MovieClipLoader();
        _mvlLoader.addListener(this);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("holder_mc", 10);
        if (_bAutoLoad && _sURL != undefined)
        {
            this.load();
        } // end if
    } // End of the function
    function size()
    {
        super.size();
        if (holder_mc.content_mc != undefined)
        {
            if (_bScaleContent)
            {
                var _loc6 = holder_mc.content_mc._width;
                var _loc7 = holder_mc.content_mc._height;
                var _loc3 = _loc6 / _loc7;
                var _loc5 = __width / __height;
                if (_loc3 == _loc5)
                {
                    holder_mc._width = __width;
                    holder_mc._height = __height;
                }
                else if (_loc3 > _loc5)
                {
                    holder_mc._width = __width;
                    holder_mc._height = __width / _loc3;
                }
                else
                {
                    holder_mc._width = __height * _loc3;
                    holder_mc._height = __height;
                } // end else if
                var _loc4 = holder_mc.content_mc.getBounds();
                holder_mc.content_mc._x = -_loc4.xMin;
                holder_mc.content_mc._y = -_loc4.yMin;
                holder_mc._x = (__width - holder_mc._width) / 2;
                holder_mc._y = (__height - holder_mc._height) / 2;
            } // end if
            if (_bCenterContent)
            {
                holder_mc._x = __width / 2;
                holder_mc._y = __height / 2;
            } // end if
        } // end if
    } // End of the function
    function setEnabled()
    {
        if (_bEnabled)
        {
            function onRelease()
            {
                this.dispatchEvent({type: "click"});
            } // End of the function
        }
        else
        {
            delete this.onRelease;
        } // end else if
    } // End of the function
    function load()
    {
        if (_sPrevURL == undefined && _sURL == "")
        {
            return;
        } // end if
        if (_sPrevURL == _sURL || _sURL == undefined || holder_mc == undefined)
        {
            return;
        } // end if
        _visible = false;
        _bLoaded = false;
        _sPrevURL = _sURL;
        holder_mc.content_mc.removeMovieClip();
        holder_mc.attachMovie(_sURL, "content_mc", 1, _oParams);
        if (_sURL == "")
        {
            return;
        } // end if
        if (holder_mc.content_mc == undefined)
        {
            holder_mc.createEmptyMovieClip("content_mc", 1);
            _mvlLoader.loadClip(_sURL, holder_mc.content_mc);
        }
        else
        {
            this.onLoadComplete(holder_mc.content_mc);
            this.onLoadInit(holder_mc.content_mc);
        } // end else if
    } // End of the function
    function onLoadError(mc)
    {
        this.dispatchEvent({type: "error", target: this, clip: mc});
    } // End of the function
    function onLoadProgress(mc, bl, bt)
    {
        _nBytesLoaded = bl;
        _nBytesTotal = bt;
        this.dispatchEvent({type: "progress", target: this, clip: mc});
    } // End of the function
    function onLoadComplete(mc)
    {
        _bLoaded = true;
        this.dispatchEvent({type: "complete", clip: mc});
    } // End of the function
    function onLoadInit(mc)
    {
        this.size();
        _visible = true;
        this.dispatchEvent({type: "initialization", clip: mc});
    } // End of the function
    static var CLASS_NAME = "Loader";
    var _bEnabled = false;
    var _bAutoLoad = true;
    var _bScaleContent = false;
    var _bCenterContent = false;
    var _sURL = "";
} // End of Class
#endinitclip
