// Action script...

// [Initial MovieClip Action of sprite 1052]
#initclip 19
class dofus.graphics.gapi.ui.Tips extends ank.gapi.core.UIAdvancedComponent
{
    var gapi, unloadThis, addToQueue, api, _winBg, _btnClose2, _lblTipsOnStart, _btnClose, _btnTipsOnStart, _btnNext, _btnPrevious, _btnTipsOnStartTooltip, _txtTip;
    function Tips()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Tips.CLASS_NAME);
    } // End of the function
    function destroy()
    {
        gapi.hideTooltip();
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: showTip});
    } // End of the function
    function initTexts()
    {
        _winBg.__set__title(api.lang.getText("TIPS"));
        _btnClose2.__set__label(api.lang.getText("CLOSE"));
        _lblTipsOnStart.__set__text(api.lang.getText("SHOW_TIPS_ON_STARTUP"));
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnClose2.addEventListener("click", this);
        _btnTipsOnStart.addEventListener("click", this);
        _btnNext.addEventListener("click", this);
        _btnPrevious.addEventListener("click", this);
        _btnTipsOnStartTooltip.addEventListener("over", this);
        _btnTipsOnStartTooltip.addEventListener("out", this);
    } // End of the function
    function initData()
    {
        SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).onStatus = function (oEvent)
        {
            if (oEvent.level == "status" && oEvent.code == "SharedObject.Flush.Success")
            {
                _btnTipsOnStart._visible = true;
                _lblTipsOnStart._visible = true;
                _btnTipsOnStart.enabled = true;
                _btnTipsOnStartTooltip._visible = false;
                _bSOEnabled = true;
            } // end if
        };
        if (SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).flush() != true)
        {
            _btnTipsOnStart.__set__enabled(false);
            _btnTipsOnStart.__set__selected(false);
            _bSOEnabled = false;
        }
        else
        {
            _btnTipsOnStartTooltip._visible = false;
            _btnTipsOnStart.__set__selected(api.kernel.OptionsManager.getOption("TipsOnStart"));
        } // end else if
    } // End of the function
    function showTip(nID)
    {
        var _loc3 = api.lang.getTips().length - 1;
        if (nID == undefined)
        {
            nID = random(_loc3);
        } // end if
        if (nID > _loc3)
        {
            nID = 0;
        } // end if
        if (nID < 0)
        {
            nID = _loc3;
        } // end if
        _nCurrentID = nID;
        var _loc4 = api.lang.getTip(nID);
        if (_loc4 != undefined)
        {
            _txtTip.__set__text(_loc4);
        }
        else
        {
            this.unloadThis();
        } // end else if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            case "_btnClose2":
            {
                this.callClose();
                break;
            } 
            case "_btnTipsOnStart":
            {
                api.kernel.OptionsManager.setOption("TipsOnStart", oEvent.target.selected);
                break;
            } 
            case "_btnPrevious":
            {
                this.showTip(_nCurrentID - 1);
                break;
            } 
            case "_btnNext":
            {
                this.showTip(_nCurrentID + 1);
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        if (_bSOEnabled == false)
        {
            gapi.showTooltip("Les cookies flash doivent être activés pour accèder à cette fonctionnalité.", _btnTipsOnStart, -30);
        } // end if
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    static var CLASS_NAME = "Tips";
    var _bSOEnabled = true;
    var _nCurrentID = 0;
} // End of Class
#endinitclip
