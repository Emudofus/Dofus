// Action script...

// [Initial MovieClip Action of sprite 1040]
#initclip 7
class dofus.graphics.gapi.controls.Emblem extends ank.gapi.core.UIBasicComponent
{
    var __get__shadow, _sBackFile, __get__initialized, __get__backID, _nBackColor, __get__backColor, _sUpFile, __get__upID, _nUpColor, __get__upColor, __get__data, addToQueue, _ldrEmblemBack, _ldrEmblemUp, _ldrEmblemShadow, setMovieClipColor, __set__backColor, __set__backID, __set__data, __set__shadow, __set__upColor, __set__upID;
    function Emblem()
    {
        super();
    } // End of the function
    function set shadow(bShadow)
    {
        _bShadow = bShadow;
        //return (this.shadow());
        null;
    } // End of the function
    function get shadow()
    {
        return (_bShadow);
    } // End of the function
    function set backID(nBackID)
    {
        _sBackFile = dofus.Constants.EMBLEMS_BACK_PATH + nBackID + ".swf";
        if (this.__get__initialized())
        {
            this.layoutBack();
        } // end if
        //return (this.backID());
        null;
    } // End of the function
    function set backColor(nBackColor)
    {
        _nBackColor = nBackColor;
        if (this.__get__initialized())
        {
            this.layoutBack();
        } // end if
        //return (this.backColor());
        null;
    } // End of the function
    function set upID(nUpID)
    {
        _sUpFile = dofus.Constants.EMBLEMS_UP_PATH + nUpID + ".swf";
        if (this.__get__initialized())
        {
            this.layoutUp();
        } // end if
        //return (this.upID());
        null;
    } // End of the function
    function set upColor(nUpColor)
    {
        _nUpColor = nUpColor;
        if (this.__get__initialized())
        {
            this.layoutUp();
        } // end if
        //return (this.upColor());
        null;
    } // End of the function
    function set data(oData)
    {
        _sBackFile = dofus.Constants.EMBLEMS_BACK_PATH + oData.backID + ".swf";
        _nBackColor = oData.backColor;
        _sUpFile = dofus.Constants.EMBLEMS_UP_PATH + oData.upID + ".swf";
        _nUpColor = oData.upColor;
        //return (this.data());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.Emblem.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: layoutContent});
    } // End of the function
    function initScale()
    {
    } // End of the function
    function addListeners()
    {
        _ldrEmblemBack.addEventListener("initialization", this);
        _ldrEmblemUp.addEventListener("initialization", this);
    } // End of the function
    function layoutContent()
    {
        if (_sBackFile != undefined)
        {
            if (_bShadow)
            {
                _ldrEmblemShadow.__set__contentPath(_sBackFile);
                var _loc2 = new Color(_ldrEmblemShadow);
                _loc2.setRGB(16777215);
            } // end if
            _ldrEmblemShadow._visible = _bShadow;
            this.layoutBack();
            this.layoutUp();
        } // end if
    } // End of the function
    function layoutBack()
    {
        if (_ldrEmblemBack.__get__contentPath() == _sBackFile)
        {
            this.applyBackColor();
        }
        else
        {
            _ldrEmblemBack.__set__contentPath(_sBackFile);
        } // end else if
    } // End of the function
    function layoutUp()
    {
        if (_ldrEmblemUp.__get__contentPath() == _sUpFile)
        {
            this.applyUpColor();
        }
        else
        {
            _ldrEmblemUp.__set__contentPath(_sUpFile);
        } // end else if
    } // End of the function
    function applyBackColor()
    {
        this.setMovieClipColor(_ldrEmblemBack.content.back, _nBackColor);
    } // End of the function
    function applyUpColor()
    {
        this.setMovieClipColor(_ldrEmblemUp.__get__content(), _nUpColor);
    } // End of the function
    function initialization(oEvent)
    {
        var _loc2 = oEvent.target;
        switch (_loc2._name)
        {
            case "_ldrEmblemBack":
            {
                this.applyBackColor();
                break;
            } 
            case "_ldrEmblemUp":
            {
                this.applyUpColor();
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "Emblem";
    var _bShadow = false;
} // End of Class
#endinitclip
