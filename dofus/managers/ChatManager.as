// Action script...

// [Initial MovieClip Action of sprite 884]
#initclip 96
class dofus.managers.ChatManager extends dofus.utils.ApiElement
{
    var _aMessages, api;
    function ChatManager(oAPI)
    {
        super();
        this.initialize(oAPI);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        this.clear();
    } // End of the function
    function clear()
    {
        _aMessages = new Array();
    } // End of the function
    function setTypes(aTypes)
    {
        _aVisibleTypes = aTypes;
        this.refresh(true);
    } // End of the function
    function addText(sText, sColor, bSound)
    {
        if (bSound == undefined)
        {
            bSound = true;
        } // end if
        var _loc2;
        switch (sColor)
        {
            case dofus.Constants.MSG_CHAT_COLOR:
            {
                _loc2 = dofus.managers.ChatManager.TYPE_MESSAGES;
                break;
            } 
            case dofus.Constants.MSGCHUCHOTE_CHAT_COLOR:
            {
                _loc2 = dofus.managers.ChatManager.TYPE_WISP;
                if (bSound)
                {
                    api.sounds.onChatWisper();
                } // end if
                break;
            } 
            case dofus.Constants.INFO_CHAT_COLOR:
            {
                _loc2 = dofus.managers.ChatManager.TYPE_INFOS;
                break;
            } 
            case dofus.Constants.ERROR_CHAT_COLOR:
            {
                _loc2 = dofus.managers.ChatManager.TYPE_ERRORS;
                if (bSound)
                {
                    api.sounds.onError();
                } // end if
                break;
            } 
            case dofus.Constants.GUILD_CHAT_COLOR:
            {
                _loc2 = dofus.managers.ChatManager.TYPE_GUILD;
                if (bSound && api.kernel.OptionsManager.getOption("GuildMessageSound"))
                {
                    api.sounds.onChatWisper();
                } // end if
                break;
            } 
            default:
            {
                ank.utils.Logger.err("[Chat] Erreur : mauvaise couleur " + sText);
                return;
            } 
        } // End of switch
        _aMessages.push({text: "<br><font color=\"#" + sColor + "\">" + sText + "</font>", type: _loc2});
        if (_aMessages.length > dofus.managers.ChatManager.MAX_LENGTH)
        {
            _aMessages.shift();
        } // end if
        this.refresh();
    } // End of the function
    function refresh()
    {
        var _loc6 = _aMessages.length;
        var _loc4 = new String();
        var _loc5 = 0;
        if (_loc6 == 0)
        {
            return;
        } // end if
        for (var _loc2 = _loc6 - 1; _loc5 < dofus.managers.ChatManager.MAX_VISIBLE && _loc2 >= 0; --_loc2)
        {
            var _loc3 = _aMessages[_loc2];
            if (_aVisibleTypes[_loc3.type] == true)
            {
                ++_loc5;
                _loc4 = _loc3.text + _loc4;
            } // end if
        } // end of for
        api.ui.getUIComponent("Banner").setChatText(_loc4);
    } // End of the function
    static var TYPE_INFOS = 0;
    static var TYPE_ERRORS = 1;
    static var TYPE_MESSAGES = 2;
    static var TYPE_WISP = 3;
    static var TYPE_GUILD = 4;
    static var MAX_LENGTH = 100;
    static var MAX_VISIBLE = 50;
    static var EMPTY_ZONE_LENGTH = 31;
    static var STOP_SCROLL_LENGTH = 6;
    var _aVisibleTypes = [true, true, true, true, true];
} // End of Class
#endinitclip
