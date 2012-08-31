// Action script...

// [Initial MovieClip Action of sprite 1012]
#initclip 232
class dofus.graphics.gapi.controls.Chat extends ank.gapi.core.UIAdvancedComponent
{
    var _btnFilter5, _btnFilter4, _btnFilter3, _btnFilter2, _btnFilter1, _btnOpenClose, _txtChat, _y, _sSmileys, _bSmileysOpened, _btnSmileys, addToQueue, dispatchEvent, api, gapi, __get__filters;
    function Chat()
    {
        super();
    } // End of the function
    function get filters()
    {
        //return (new Array(_btnFilter1.selected(), _btnFilter2.__get__selected(), _btnFilter3.__get__selected(), _btnFilter4.__get__selected(), _btnFilter5.__get__selected()));
    } // End of the function
    function open(bOpen)
    {
        if (bOpen == !_bOpened)
        {
            return;
        } // end if
        _btnOpenClose.__set__selected(!bOpen);
        var _loc2;
        if (bOpen)
        {
            _loc2 = -1;
        }
        else
        {
            _loc2 = 1;
        } // end else if
        _txtChat.setSize(_txtChat.__get__width(), _txtChat.__get__height() + _loc2 * dofus.graphics.gapi.controls.Chat.OPEN_OFFSET);
        _y = _y - _loc2 * dofus.graphics.gapi.controls.Chat.OPEN_OFFSET;
        _bOpened = !bOpen;
    } // End of the function
    function setText(sText)
    {
        _txtChat.__set__text(sText);
    } // End of the function
    function updateSmileysEmotes()
    {
        _sSmileys.update();
    } // End of the function
    function hideSmileys(bHide)
    {
        _sSmileys._visible = !bHide;
        _bSmileysOpened = !bHide;
        _btnSmileys.__set__selected(_bSmileysOpened);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.Chat.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.hideSmileys(true);
    } // End of the function
    function addListeners()
    {
        _btnOpenClose.addEventListener("click", this);
        _btnSmileys.addEventListener("click", this);
        _btnFilter1.addEventListener("click", this);
        _btnFilter2.addEventListener("click", this);
        _btnFilter3.addEventListener("click", this);
        _btnFilter4.addEventListener("click", this);
        _btnFilter5.addEventListener("click", this);
        _btnOpenClose.addEventListener("over", this);
        _btnSmileys.addEventListener("over", this);
        _btnFilter1.addEventListener("over", this);
        _btnFilter2.addEventListener("over", this);
        _btnFilter3.addEventListener("over", this);
        _btnFilter4.addEventListener("over", this);
        _btnFilter5.addEventListener("over", this);
        _btnOpenClose.addEventListener("out", this);
        _btnSmileys.addEventListener("out", this);
        _btnFilter1.addEventListener("out", this);
        _btnFilter2.addEventListener("out", this);
        _btnFilter3.addEventListener("out", this);
        _btnFilter4.addEventListener("out", this);
        _btnFilter5.addEventListener("out", this);
        _sSmileys.addEventListener("selectSmiley", this);
        _sSmileys.addEventListener("selectEmote", this);
        _txtChat.addEventListener("href", this);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnSmileys":
            {
                this.hideSmileys(_bSmileysOpened);
                break;
            } 
            case "_btnOpenClose":
            {
                this.open(!oEvent.target.selected);
                break;
            } 
            case "_btnFilter1":
            case "_btnFilter2":
            case "_btnFilter3":
            case "_btnFilter4":
            case "_btnFilter5":
            {
                this.dispatchEvent({type: "filterChanged"});
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnSmileys":
            {
                gapi.showTooltip(api.lang.getText("CHAT_SHOW_SMILEYS"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnOpenClose":
            {
                gapi.showTooltip(api.lang.getText("CHAT_SHOW_MORE"), oEvent.target, -33, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnFilter1":
            {
                gapi.showTooltip(api.lang.getText("CHAT_TYPE3"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnFilter2":
            {
                gapi.showTooltip(api.lang.getText("CHAT_TYPE4"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnFilter3":
            {
                gapi.showTooltip(api.lang.getText("CHAT_TYPE1"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnFilter4":
            {
                gapi.showTooltip(api.lang.getText("CHAT_TYPE2"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
            case "_btnFilter5":
            {
                gapi.showTooltip(api.lang.getText("CHAT_TYPE5"), oEvent.target, -20, {bXLimit: true, bYLimit: false});
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function selectSmiley(oEvent)
    {
        if (!api.datacenter.Player.data.isInMove)
        {
            this.dispatchEvent(oEvent);
            if (api.kernel.OptionsManager.getOption("AutoHideSmileys"))
            {
                this.hideSmileys(true);
            } // end if
        } // end if
    } // End of the function
    function selectEmote(oEvent)
    {
        if (!api.datacenter.Player.data.isInMove)
        {
            this.dispatchEvent(oEvent);
            if (api.kernel.OptionsManager.getOption("AutoHideSmileys"))
            {
                this.hideSmileys(true);
            } // end if
        } // end if
    } // End of the function
    function href(oEvent)
    {
        this.dispatchEvent(oEvent);
    } // End of the function
    static var CLASS_NAME = "Chat";
    static var OPEN_OFFSET = 350;
    var _bOpened = false;
} // End of Class
#endinitclip
