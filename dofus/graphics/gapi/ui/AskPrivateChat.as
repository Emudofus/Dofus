// Action script...

// [Initial MovieClip Action of sprite 988]
#initclip 205
class dofus.graphics.gapi.ui.AskPrivateChat extends ank.gapi.ui.FlyWindow
{
    var gapi, getStyle, _winBackground, api, __get__params, dispatchEvent, unloadThis;
    function AskPrivateChat()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.AskPrivateChat.CLASS_NAME);
        gapi.getUIComponent("Banner").chatAutoFocus = false;
    } // End of the function
    function destroy()
    {
        gapi.getUIComponent("Banner").chatAutoFocus = true;
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
    } // End of the function
    function initWindowContent()
    {
        var _loc2 = _winBackground.__get__content();
        _loc2._txtMessage.maxChars = dofus.Constants.MAX_DATA_LENGTH;
        _loc2._btnCancel.label = api.lang.getText("CANCEL_SMALL");
        _loc2._btnAddFriend.label = api.lang.getText("ADD_TO_FRIENDS");
        _loc2._btnSend.label = api.lang.getText("SEND");
        _loc2._btnCancel.addEventListener("click", this);
        _loc2._btnAddFriend.addEventListener("click", this);
        _loc2._btnSend.addEventListener("click", this);
        Key.addListener(this);
        Selection.setFocus(_loc2._txtMessage._tText);
    } // End of the function
    function onKeyUp()
    {
        if (Key.getCode() == 13)
        {
            this.click({target: _winBackground.content._btnSend});
            Key.removeListener(this);
        } // end if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnCancel":
            {
                this.dispatchEvent({type: "cancel", params: this.__get__params()});
                this.unloadThis();
                break;
            } 
            case "_btnSend":
            {
                var _loc2 = _winBackground.content._txtMessage.text;
                _loc2 = _loc2.replace(String.fromCharCode(13), " ");
                this.dispatchEvent({type: "send", message: _loc2, params: this.__get__params()});
                this.unloadThis();
                break;
            } 
            case "_btnAddFriend":
            {
                this.dispatchEvent({type: "addfriend", params: this.__get__params()});
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "AskPrivateChat";
} // End of Class
#endinitclip
