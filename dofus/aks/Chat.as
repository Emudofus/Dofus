// Action script...

// [Initial MovieClip Action of sprite 20815]
#initclip 80
if (!dofus.aks.Chat)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Chat = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.send = function (sMessage, sDest, oParams)
    {
        if (sDest.toLowerCase() == this.api.datacenter.Player.Name.toLowerCase())
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_WISP_YOURSELF"), "ERROR_CHAT");
            return;
        }
        else if (this.api.kernel.ChatManager.isBlacklisted(sDest))
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_WISP_BLACKLISTED"), "ERROR_CHAT");
            return;
        } // end else if
        sMessage = new ank.utils.ExtendedString(sMessage).replace(["<", ">", "|"], ["&lt;", "&gt;", ""]);
        var _loc5 = this.api.kernel.ChatManager.applyOutputCensorship(sMessage);
        if (!_loc5)
        {
            return;
        } // end if
        if (sMessage.indexOf(this.api.datacenter.Player.login) > -1 || sMessage.indexOf(this.api.datacenter.Player.password) > -1)
        {
            if (sMessage != undefined && (this.api.datacenter.Player.login != undefined && this.api.datacenter.Player.password != undefined))
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_SAY_YOUR_PASSWORD"), "ERROR_CHAT");
                return;
            } // end if
        } // end if
        if (sMessage.length == 0)
        {
            return;
        } // end if
        var _loc6 = new String();
        var _loc7 = oParams.items;
        if (_loc7.length > 0)
        {
            var _loc8 = 0;
            var _loc9 = 0;
            
            while (++_loc9, _loc9 < _loc7.length)
            {
                var _loc10 = _loc7[_loc9];
                var _loc11 = "[" + _loc10.name + "]";
                var _loc12 = sMessage.indexOf(_loc11);
                if (_loc12 != -1)
                {
                    var _loc13 = "° " + _loc8;
                    ++_loc8;
                    var _loc14 = sMessage.split("");
                    _loc14.splice(_loc12, _loc11.length, _loc13);
                    sMessage = _loc14.join("");
                    if (_loc6.length > 0)
                    {
                        _loc6 = _loc6 + "!";
                    } // end if
                    var _loc15 = _loc10.compressedEffects;
                    _loc6 = _loc6 + (_loc10.unicID + "!" + (_loc15 != undefined ? (_loc15) : (".")));
                } // end if
            } // end while
        } // end if
        var _loc16 = _loc6;
        if (_loc16.length > dofus.Constants.MAX_DATA_LENGTH)
        {
            _loc16 = _loc16.substring(0, dofus.Constants.MAX_DATA_LENGTH - 1);
        } // end if
        if (sMessage.length > dofus.Constants.MAX_MESSAGE_LENGTH)
        {
            sMessage = sMessage.substring(0, dofus.Constants.MAX_MESSAGE_LENGTH - 1);
        } // end if
        this.aks.send("BM" + sDest + "|" + sMessage + "|" + _loc16, true, undefined, true);
    };
    _loc1.reportMessage = function (sCharacterID, sMessageUniqId, sMessage, nReason)
    {
        this.aks.send("BR" + sCharacterID + "|" + sMessage + "|" + sMessageUniqId + "|" + nReason, false);
    };
    _loc1.subscribeChannels = function (nChannel, bSubscribe)
    {
        var _loc4 = "";
        switch (nChannel)
        {
            case 0:
            {
                _loc4 = "i";
                break;
            } 
            case 2:
            {
                _loc4 = "*";
                break;
            } 
            case 3:
            {
                _loc4 = "#$p";
                break;
            } 
            case 4:
            {
                _loc4 = "%";
                break;
            } 
            case 5:
            {
                _loc4 = "!";
                break;
            } 
            case 6:
            {
                _loc4 = "?";
                break;
            } 
            case 7:
            {
                _loc4 = ":";
                break;
            } 
            case 8:
            {
                _loc4 = "^";
                break;
            } 
        } // End of switch
        this.aks.send("cC" + (bSubscribe ? ("+") : ("-")) + _loc4, true);
    };
    _loc1.useSmiley = function (nSmileyID)
    {
        if (getTimer() - this.api.datacenter.Basics.aks_chat_lastActionTime < dofus.Constants.CLICK_MIN_DELAY)
        {
            return;
        } // end if
        this.api.datacenter.Basics.aks_chat_lastActionTime = getTimer();
        this.aks.send("BS" + nSmileyID, true);
    };
    _loc1.onSubscribeChannel = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("");
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc4.length)
        {
            var _loc6 = 0;
            switch (_loc4[_loc5])
            {
                case "i":
                {
                    _loc6 = 0;
                    break;
                } 
                case "*":
                {
                    _loc6 = 2;
                    break;
                } 
                case "#":
                {
                    _loc6 = 3;
                    break;
                } 
                case "$":
                {
                    _loc6 = 3;
                    break;
                } 
                case "p":
                {
                    _loc6 = 3;
                    break;
                } 
                case "%":
                {
                    _loc6 = 4;
                    break;
                } 
                case "!":
                {
                    _loc6 = 5;
                    break;
                } 
                case "?":
                {
                    _loc6 = 6;
                    break;
                } 
                case ":":
                {
                    _loc6 = 7;
                    break;
                } 
                case "^":
                {
                    _loc6 = 8;
                    break;
                } 
                case "@":
                {
                    _loc6 = 9;
                    break;
                } 
                default:
                {
                    continue;
                } 
            } // End of switch
            this.api.ui.getUIComponent("Banner").chat.selectFilter(_loc6, _loc3);
            this.api.kernel.ChatManager.setTypeVisible(_loc6, _loc3);
            this.api.datacenter.Basics.chat_type_visible[_loc6] = _loc3;
        } // end while
    };
    _loc1.onMessage = function (bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            switch (sExtraData.charAt(0))
            {
                case "S":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("SYNTAX_ERROR", [" /w <" + this.api.lang.getText("NAME") + "> <" + this.api.lang.getText("MSG") + ">"]), "ERROR_CHAT");
                    break;
                } 
                case "f":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("USER_NOT_CONNECTED", [sExtraData.substr(1)]), "ERROR_CHAT");
                    break;
                } 
                case "e":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("USER_NOT_CONNECTED_BUT_TRY_SEND_EXTERNAL", [sExtraData.substr(1)]), "ERROR_CHAT");
                    break;
                } 
                case "n":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("USER_NOT_CONNECTED_EXTERNAL_NACK", [sExtraData.substr(1)]), "ERROR_CHAT");
                    break;
                } 
            } // End of switch
            return;
        } // end if
        var _loc4 = sExtraData.charAt(0);
        sExtraData = _loc4 == "|" ? (sExtraData.substr(1)) : (sExtraData.substr(2));
        var _loc5 = sExtraData.split("|");
        var _loc6 = _loc5[2];
        var _loc7 = _loc5[1];
        var _loc8 = _loc5[0];
        var _loc9 = _loc5[3];
        var _loc10 = _loc5[4] != undefined && (_loc5[4].length > 0 && _loc5[4] != "") ? (_loc5[4]) : (null);
        if (this.api.kernel.ChatManager.isBlacklisted(_loc7))
        {
            return;
        } // end if
        if (_loc9.length > 0)
        {
            var _loc11 = _loc9.split("!");
            _loc6 = this.api.kernel.ChatManager.parseInlineItems(_loc6, _loc11);
        } // end if
        _loc6 = this.api.kernel.ChatManager.parseInlinePos(_loc6);
        switch (_loc4)
        {
            case "F":
            {
                var _loc12 = "WHISP_CHAT";
                _loc6 = this.api.kernel.ChatManager.parseSecretsEmotes(_loc6);
                if (!_loc6.length)
                {
                    return;
                } // end if
                _loc6 = this.api.lang.getText("FROM") + " <i>" + this.getLinkName(_loc7, _loc10) + "</i> : " + _loc6;
                this.api.kernel.Console.pushWhisper("/w " + _loc7 + " ");
                break;
            } 
            case "T":
            {
                _loc12 = "WHISP_CHAT";
                _loc6 = this.api.lang.getText("TO_DESTINATION") + " " + this.getLinkName(_loc7, _loc10) + " : " + _loc6;
                break;
            } 
            case "#":
            {
                if (this.api.datacenter.Game.isFight)
                {
                    _loc12 = "WHISP_CHAT";
                    if (this.api.datacenter.Game.isSpectator)
                    {
                        var _loc13 = "(" + this.api.lang.getText("SPECTATOR") + ")";
                    }
                    else
                    {
                        _loc13 = "(" + this.api.lang.getText("TEAM") + ")";
                    } // end else if
                    _loc6 = _loc13 + " " + this.getLinkName(_loc7, _loc10) + " : " + _loc6;
                } // end if
                break;
            } 
            case "%":
            {
                _loc12 = "GUILD_CHAT_SOUND";
                _loc6 = "(" + this.api.lang.getText("GUILD") + ") " + this.getLinkName(_loc7, _loc10) + " : " + _loc6;
                break;
            } 
            case "$":
            {
                _loc12 = "PARTY_CHAT";
                _loc6 = "(" + this.api.lang.getText("PARTY") + ") " + this.getLinkName(_loc7, _loc10) + " : " + _loc6;
                break;
            } 
            case "!":
            {
                _loc12 = "PVP_CHAT";
                _loc6 = "(" + this.api.lang.getText("ALIGNMENT") + ") " + this.getLinkName(_loc7, _loc10) + " : " + _loc6;
                break;
            } 
            case "?":
            {
                _loc12 = "RECRUITMENT_CHAT";
                _loc6 = "(" + this.api.lang.getText("RECRUITMENT") + ") " + this.getLinkName(_loc7, _loc10) + " : " + _loc6;
                break;
            } 
            case ":":
            {
                _loc12 = "TRADE_CHAT";
                _loc6 = "(" + this.api.lang.getText("TRADE") + ") " + this.getLinkName(_loc7, _loc10) + " : " + _loc6;
                break;
            } 
            case "^":
            {
                _loc12 = "MEETIC_CHAT";
                _loc6 = "(" + this.api.lang.getText("MEETIC") + ") " + this.getLinkName(_loc7, _loc10) + " : " + _loc6;
                break;
            } 
            case "@":
            {
                _loc12 = "ADMIN_CHAT";
                _loc6 = "(" + this.api.lang.getText("PRIVATE_CHANNEL") + ") " + this.getLinkName(_loc7, _loc10) + " : " + _loc6;
                break;
            } 
            default:
            {
                var _loc14 = _loc6.charAt(0) == dofus.Constants.EMOTE_CHAR && (_loc6.charAt(1) == dofus.Constants.EMOTE_CHAR && (_loc6.charAt(_loc6.length - 1) == dofus.Constants.EMOTE_CHAR && _loc6.charAt(_loc6.length - 2) == dofus.Constants.EMOTE_CHAR));
                if (this.api.lang.getConfigText("EMOTES_ENABLED") && (!_loc14 && (_loc6.charAt(0) == dofus.Constants.EMOTE_CHAR && _loc6.charAt(_loc6.length - 1) == dofus.Constants.EMOTE_CHAR)))
                {
                    if (!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
                    {
                        var _loc15 = _loc6.charAt(_loc6.length - 2) == "." && _loc6.charAt(_loc6.length - 3) != "." ? (_loc6.substr(0, _loc6.length - 2) + dofus.Constants.EMOTE_CHAR) : (_loc6);
                        _loc15 = dofus.Constants.EMOTE_CHAR + _loc15.charAt(1).toUpperCase() + _loc15.substr(2);
                        this.api.gfx.addSpriteBubble(_loc8, this.api.kernel.ChatManager.applyInputCensorship(_loc15));
                    } // end if
                    _loc12 = "EMOTE_CHAT";
                    _loc6 = _loc6.substr(1, _loc6.length - 2);
                    if (!dofus.managers.ChatManager.isPonctuation(_loc6.charAt(_loc6.length - 1)))
                    {
                        _loc6 = _loc6 + ".";
                    } // end if
                    _loc6 = "<i>" + this.getLinkName(_loc7, _loc10) + " " + _loc6.charAt(0).toLowerCase() + _loc6.substr(1) + "</i>";
                }
                else if (_loc6.substr(0, 7) == "!THINK!")
                {
                    _loc6 = _loc6.substr(7);
                    if (!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
                    {
                        this.api.gfx.addSpriteBubble(_loc8, this.api.kernel.ChatManager.applyInputCensorship(_loc6), ank.battlefield.TextHandler.BUBBLE_TYPE_THINK);
                    } // end if
                    _loc12 = "THINK_CHAT";
                    _loc6 = "<i>" + this.getLinkName(_loc7, _loc10) + " " + this.api.lang.getText("THINKS_WORD") + " : " + _loc6 + "</i>";
                }
                else if (_loc14 && !_global.isNaN(_loc6.substr(2, _loc6.length - 4)))
                {
                    if (!this.api.kernel.OptionsManager.getOption("UseSpeakingItems"))
                    {
                        return;
                    } // end if
                    var _loc16 = _global.parseInt(_loc6.substr(2, _loc6.length - 4));
                    var _loc17 = this.api.lang.getSpeakingItemsText(_loc16 - Number(_loc8));
                    if (_loc17.m)
                    {
                        _loc12 = "MESSAGE_CHAT";
                        _loc6 = _loc17.m;
                        if (!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
                        {
                            this.api.gfx.addSpriteBubble(_loc8, this.api.kernel.ChatManager.applyInputCensorship(_loc6));
                        } // end if
                        _loc6 = this.getLinkName(_loc7, _loc10, true) + " : " + _loc6;
                    }
                    else
                    {
                        return;
                    } // end else if
                }
                else
                {
                    if (!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
                    {
                        this.api.gfx.addSpriteBubble(_loc8, this.api.kernel.ChatManager.applyInputCensorship(_loc6));
                    } // end if
                    _loc12 = "MESSAGE_CHAT";
                    _loc6 = this.getLinkName(_loc7, _loc10) + " : " + _loc6;
                } // end else if
                break;
            } 
        } // End of switch
        this.api.kernel.showMessage(undefined, _loc6, _loc12, undefined, _loc10);
    };
    _loc1.getLinkName = function (sName, sUniqId, bNoBold)
    {
        var _loc5 = "<b>";
        var _loc6 = "</b>";
        if (bNoBold)
        {
            _loc5 = "";
            _loc6 = "";
        } // end if
        if (sUniqId != undefined && (sUniqId.length > 0 && sUniqId != ""))
        {
            return (_loc5 + "<a href=\'asfunction:onHref,ShowPlayerPopupMenu," + sName + "," + sUniqId + "\'>" + sName + "</a>" + _loc6);
        } // end if
        return (_loc5 + "<a href=\'asfunction:onHref,ShowPlayerPopupMenu," + sName + "\'>" + sName + "</a>" + _loc6);
    };
    _loc1.onServerMessage = function (sExtraData)
    {
        if (sExtraData != undefined)
        {
            this.api.kernel.showMessage(undefined, sExtraData, "INFO_CHAT");
        } // end if
    };
    _loc1.onSmiley = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = Number(_loc3[1]);
        this.api.gfx.addSpriteOverHeadItem(_loc4, "smiley", dofus.graphics.battlefield.SmileyOverHead, [_loc5], dofus.Constants.SMILEY_DELAY);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
