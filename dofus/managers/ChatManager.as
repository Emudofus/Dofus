// Action script...

// [Initial MovieClip Action of sprite 20553]
#initclip 74
if (!dofus.managers.ChatManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).prototype;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).getInstance = function ()
    {
        return (dofus.managers.ChatManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        this._aItemsBuffer = new Array();
        this._aMessagesBuffer = new Array();
        this._nItemsBufferIDs = 0;
        this._aBlacklist = new Array();
        this.updateRigth();
        this.clear();
    };
    _loc1.updateRigth = function ()
    {
        if (this.api.datacenter.Player.isAuthorized)
        {
            dofus.managers.ChatManager.MAX_VISIBLE = dofus.managers.ChatManager.MAX_VISIBLE * dofus.managers.ChatManager.ADMIN_BUFFER_MULTIPLICATOR;
            dofus.managers.ChatManager.MAX_ALL_LENGTH = dofus.managers.ChatManager.MAX_ALL_LENGTH * dofus.managers.ChatManager.ADMIN_BUFFER_MULTIPLICATOR;
            dofus.managers.ChatManager.MAX_ITEM_BUFFER_LENGTH = dofus.managers.ChatManager.MAX_ITEM_BUFFER_LENGTH * dofus.managers.ChatManager.ADMIN_BUFFER_MULTIPLICATOR;
        } // end if
    };
    _loc1.clear = function ()
    {
        this._aMessages = new Array();
        this._nMessageCounterInfo = 0;
    };
    _loc1.setTypes = function (aTypes)
    {
        this._aVisibleTypes = aTypes;
        this.refresh(true);
    };
    _loc1.isTypeVisible = function (nType)
    {
        return (this._aVisibleTypes[nType]);
    };
    _loc1.setTypeVisible = function (nType, bVisible)
    {
        this._aVisibleTypes[nType] = bVisible;
        this.refresh(true);
    };
    _loc1.initCensorDictionnary = function ()
    {
        if (this._oCensorDictionnary == undefined)
        {
            this._oCensorDictionnary = new Object();
            var _loc2 = this.api.lang.getCensoredWords();
            for (var j in _loc2)
            {
                this._oCensorDictionnary[String(_loc2[j].c).toUpperCase()] = {weight: Number(_loc2[j].l), id: Number(j), parseWord: _loc2[j].d};
                if (_loc2[j].d)
                {
                    this._bUseInWordCensor = true;
                } // end if
            } // end of for...in
        } // end if
    };
    _loc1.applyOutputCensorship = function (sText)
    {
        if (this.api.datacenter.Player.isAuthorized)
        {
            return (true);
        } // end if
        if (!this.api.lang.getConfigText("CENSORSHIP_ENABLE_OUTPUT"))
        {
            return (true);
        } // end if
        this.initCensorDictionnary();
        var _loc3 = -1;
        var _loc4 = 0;
        var _loc5 = -1;
        var _loc6 = this.avoidPonctuation(sText.toUpperCase()).split(" ");
        for (var i in _loc6)
        {
            if (this._oCensorDictionnary[_loc6[i]] != undefined)
            {
                if (Number(this._oCensorDictionnary[_loc6[i]].weight) > _loc3)
                {
                    _loc3 = Number(this._oCensorDictionnary[_loc6[i]].weight);
                    _loc4 = Number(this._oCensorDictionnary[_loc6[i]].id);
                } // end if
                continue;
            } // end if
            if (this._bUseInWordCensor)
            {
                for (var j in this._oCensorDictionnary)
                {
                    _loc5 = _loc6[i].indexOf(j);
                    if (_loc5 != -1 && this._oCensorDictionnary[j].parseWord)
                    {
                        if (Number(this._oCensorDictionnary[j].weight) > _loc3)
                        {
                            _loc3 = Number(this._oCensorDictionnary[j].weight);
                            _loc4 = Number(this._oCensorDictionnary[j].id);
                        } // end if
                    } // end if
                } // end of for...in
            } // end if
        } // end of for...in
        if (_loc3 >= this.api.lang.getConfigText("SEND_CENSORSHIP_SINCE"))
        {
            this.api.network.Basics.sanctionMe(_loc3, _loc4);
        } // end if
        if (_loc3 > 0)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("PLEASE_RESTRAIN_TO_A_POLITE_VOCABULARY"), "ERROR_CHAT");
            return (false);
        } // end if
        return (true);
    };
    _loc1.applyInputCensorship = function (sText)
    {
        if (!this.api.kernel.OptionsManager.getOption("CensorshipFilter") || !this.api.lang.getConfigText("CENSORSHIP_ENABLE_INPUT"))
        {
            return (sText);
        } // end if
        this.initCensorDictionnary();
        var _loc3 = new Array();
        var _loc4 = sText.split(" ");
        var _loc5 = this.avoidPonctuation(sText.toUpperCase()).split(" ");
        var _loc6 = -1;
        for (var i in _loc5)
        {
            _loc6 = -1;
            if (this._oCensorDictionnary[_loc5[i]] != undefined)
            {
                _loc3.push(this.getCensoredWord(_loc5[i]));
                _loc6 = 0;
            }
            else if (this._bUseInWordCensor)
            {
                for (var j in this._oCensorDictionnary)
                {
                    _loc6 = _loc5[i].indexOf(j);
                    if (_loc6 != -1 && this._oCensorDictionnary[j].parseWord)
                    {
                        _loc3.push(this.getCensoredWord(_loc5[i]));
                        break;
                    } // end if
                    _loc6 = -1;
                } // end of for...in
            } // end else if
            if (_loc6 == -1)
            {
                _loc3.push(_loc4[i]);
            } // end if
        } // end of for...in
        _loc3.reverse();
        return (_loc3.join(" "));
    };
    _loc1.avoidPonctuation = function (sWord)
    {
        var _loc3 = new String();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < sWord.length)
        {
            var _loc5 = sWord.charCodeAt(_loc4);
            if (_loc5 > 47 && _loc5 < 58 || (_loc5 > 64 && _loc5 < 91 || _loc5 == 32))
            {
                _loc3 = _loc3 + sWord.charAt(_loc4);
            } // end if
        } // end while
        return (_loc3);
    };
    _loc1.getCensoredWord = function (sWord)
    {
        var _loc3 = new String();
        var _loc4 = new String();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < sWord.length)
        {
            var _loc6 = sWord.charCodeAt(_loc5);
            if (_loc6 > 47 && _loc6 < 58 || (_loc6 > 64 && _loc6 < 91 || _loc6 > 96 && _loc6 < 123))
            {
                var _loc7 = new String();
                
                while (_loc7 == _loc4)
                {
                    _loc7 = dofus.managers.ChatManager.CENSORSHIP_CHAR[Math.floor(Math.random() * dofus.managers.ChatManager.CENSORSHIP_CHAR.length)];
                } // end while
                _loc4 = _loc7;
                _loc3 = _loc3 + _loc7;
                continue;
            } // end if
            _loc4 = sWord.charAt(_loc5);
            _loc3 = _loc3 + sWord.charAt(_loc5);
        } // end while
        return (_loc3);
    };
    _loc1.addLinkWarning = function (sText)
    {
        var _loc3 = sText.toUpperCase();
        if (_loc3.indexOf("</A>") > -1)
        {
            _loc3 = _loc3.substr(_loc3.indexOf("</A>"));
        } // end if
        var _loc4 = _loc3.split(" ");
        var _loc5 = false;
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc4.length)
        {
            var _loc7 = false;
            var _loc8 = 0;
            
            while (++_loc8, _loc8 < dofus.managers.ChatManager.LINK_FILTERS.length)
            {
                if (_loc4[_loc6].indexOf(dofus.managers.ChatManager.LINK_FILTERS[_loc8]) > -1)
                {
                    _loc7 = true;
                    break;
                } // end if
            } // end while
            if (_loc7)
            {
                var _loc9 = 0;
                
                while (++_loc9, _loc9 < dofus.managers.ChatManager.WHITE_LIST.length)
                {
                    if (_loc4[_loc6].indexOf(dofus.managers.ChatManager.WHITE_LIST[_loc9]) > -1)
                    {
                        _loc7 = false;
                        break;
                    } // end if
                } // end while
            } // end if
            if (_loc7)
            {
                _loc5 = true;
                break;
            } // end if
        } // end while
        if (_loc5)
        {
            sText = sText + (" [<font color=\"#006699\"><u><b><a href=\'asfunction:onHref,ShowLinkWarning,CHAT_LINK_WARNING_TEXT\'>" + this.api.lang.getText("CHAT_LINK_WARNING") + "</a></b></u></font>]");
        } // end if
        return (sText);
    };
    _loc1.addText = function (sText, sColor, bSound, sUniqId)
    {
        if (bSound == undefined)
        {
            bSound = true;
        } // end if
        var _loc6 = "";
        var _loc9 = false;
        switch (sColor)
        {
            case dofus.Constants.MSG_CHAT_COLOR:
            {
                var _loc7 = dofus.managers.ChatManager.TYPE_MESSAGES;
                _loc9 = true;
                var _loc8 = true;
                break;
            } 
            case dofus.Constants.EMOTE_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_MESSAGES;
                _loc9 = true;
                _loc8 = true;
                break;
            } 
            case dofus.Constants.THINK_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_MESSAGES;
                _loc9 = true;
                _loc8 = true;
                break;
            } 
            case dofus.Constants.GROUP_CHAT_COLOR:
            case dofus.Constants.MSGCHUCHOTE_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_WISP;
                _loc9 = true;
                _loc8 = true;
                if (bSound)
                {
                    this.api.sounds.events.onChatWisper();
                } // end if
                break;
            } 
            case dofus.Constants.INFO_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_INFOS;
                ++this._nMessageCounterInfo;
                _loc8 = false;
                break;
            } 
            case dofus.Constants.ERROR_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_ERRORS;
                _loc8 = true;
                if (bSound)
                {
                    if (this._bFirstErrorCatched)
                    {
                        this.api.sounds.events.onError();
                    }
                    else
                    {
                        this._bFirstErrorCatched = true;
                    } // end if
                } // end else if
                break;
            } 
            case dofus.Constants.GUILD_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_GUILD;
                _loc9 = true;
                _loc8 = true;
                if (bSound && this.api.kernel.OptionsManager.getOption("GuildMessageSound"))
                {
                    this.api.sounds.events.onChatWisper();
                } // end if
                break;
            } 
            case dofus.Constants.PVP_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_PVP;
                _loc9 = true;
                _loc8 = true;
                break;
            } 
            case dofus.Constants.TRADE_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_TRADE;
                _loc9 = true;
                _loc8 = true;
                break;
            } 
            case dofus.Constants.RECRUITMENT_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_RECRUITMENT;
                _loc9 = true;
                _loc8 = true;
                break;
            } 
            case dofus.Constants.MEETIC_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_MEETIC;
                _loc9 = true;
                _loc8 = true;
                break;
            } 
            case dofus.Constants.ADMIN_CHAT_COLOR:
            {
                _loc7 = dofus.managers.ChatManager.TYPE_ADMIN;
                _loc8 = true;
                break;
            } 
            default:
            {
                ank.utils.Logger.err("[Chat] Erreur : mauvaise couleur " + sText);
                return;
            } 
        } // End of switch
        if (_loc9)
        {
            sText = this.addLinkWarning(sText);
            sText = this.applyInputCensorship(sText);
        } // end if
        if (_loc8 && this.api.kernel.NightManager.time.length)
        {
            _loc6 = "[" + this.api.kernel.NightManager.time + "] ";
        } // end if
        this._aMessages.push({textStyleLeft: "<font color=\"#" + sColor + "\"><br />", text: sText, textStyleRight: "</font>", type: _loc7, uniqId: sUniqId, timestamp: _loc6, lf: false});
        if (this._aMessages.length > dofus.managers.ChatManager.MAX_ALL_LENGTH)
        {
            this._aMessages.shift();
        } // end if
        this.refresh();
    };
    _loc1.refresh = function (bForceRefresh)
    {
        var _loc3 = this._aMessages.length;
        var _loc4 = new String();
        var _loc5 = 0;
        if (_loc3 == 0 && !bForceRefresh)
        {
            return;
        } // end if
        var _loc6 = _loc3 - 1;
        
        while (--_loc6, _loc5 < dofus.managers.ChatManager.MAX_VISIBLE && _loc6 >= 0)
        {
            var _loc7 = this._aMessages[_loc6];
            if (this._aVisibleTypes[_loc7.type] == true)
            {
                ++_loc5;
                if (!_loc7.htmlSyntaxChecked)
                {
                    var _loc8 = dofus.managers.ChatManager.safeHtml(_loc7.text);
                    _loc7.lf = !_loc8.v || _loc7.lf;
                    _loc7.text = _loc8.t;
                    _loc7.htmlSyntaxChecked = true;
                } // end if
                if (this.api.kernel.OptionsManager.getOption("TimestampInChat"))
                {
                    _loc4 = (_loc7.lf ? ("<br/>") : ("")) + _loc7.textStyleLeft + _loc7.timestamp + _loc7.text + _loc7.textStyleRight + _loc4;
                    continue;
                } // end if
                _loc4 = (_loc7.lf ? ("<br/>") : ("")) + _loc7.textStyleLeft + _loc7.text + _loc7.textStyleRight + _loc4;
            } // end if
        } // end while
        this.api.ui.getUIComponent("Banner").setChatText(_loc4);
    };
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).safeHtml = function (s)
    {
        var _loc3 = true;
        var _loc4 = new Array();
        var _loc5 = new Array();
        var _loc6 = s;
        var _loc7 = 0;
        var _loc8 = 0;
        
        while (++_loc8, _loc6.indexOf("<") > -1 && _loc7++ < dofus.managers.ChatManager.HTML_NB_PASS_MAX)
        {
            var _loc9 = _loc6.indexOf("<");
            var _loc10 = _loc6.indexOf(">", _loc9) + 1;
            var _loc11 = _loc6.substring(_loc9, _loc10);
            var _loc12 = _loc11.indexOf("/") == 1;
            var _loc13 = _loc11.indexOf("/") == _loc11.length - 2;
            var _loc14 = _loc12 ? (_loc11.substring(2, _loc11.length - 1)) : (_loc11.substring(1, _loc11.length - 1));
            _loc14 = _loc14.substring(0, _loc14.indexOf(" ") > -1 ? (_loc14.indexOf(" ")) : (_loc14.length));
            _loc5[_loc8] = {c: _loc12, b: _loc14};
            if (_loc13)
            {
                _loc5[++_loc8] = {c: !_loc12, b: _loc14};
            } // end if
            _loc6 = _loc6.substring(_loc10);
        } // end while
        var _loc15 = 0;
        
        while (++_loc15, _loc15 < _loc5.length)
        {
            var _loc16 = _loc5[_loc15];
            if (_loc16.c)
            {
                if (_loc4[_loc16.b] == undefined || _loc4[_loc16.b] == 0)
                {
                    _loc3 = false;
                }
                else
                {
                    _loc4[_loc16.b] = _loc4[_loc16.b] - 1;
                } // end else if
                continue;
            } // end if
            if (_loc4[_loc16.b] == undefined)
            {
                _loc4[_loc16.b] = 0;
            } // end if
            _loc4[_loc16.b] = _loc4[_loc16.b] + 1;
        } // end while
        for (var i in _loc4)
        {
            if (_loc4[i] > 0)
            {
                _loc3 = false;
            } // end if
        } // end of for...in
        if (_loc3)
        {
            return ({v: true, t: s});
        } // end if
        return ({v: false, t: s.split("<").join("&lt;").split(">").join("&gt;")});
    };
    _loc1.parseInlineItems = function (sMessage, aItems)
    {
        var _loc4 = 0;
        
        while (_loc4 = _loc4 + 2, _loc4 < aItems.length)
        {
            var _loc5 = Number(aItems[_loc4]);
            var _loc6 = aItems[_loc4 + 1];
            var _loc7 = new dofus.datacenter.Item(0, _loc5, 1, 1, _loc6, 1);
            var _loc8 = "° " + _loc4 / 2;
            var _loc9 = this.getLinkItem(_loc7);
            var _loc10 = sMessage.indexOf(_loc8);
            if (_loc10 != -1)
            {
                var _loc11 = sMessage.split("");
                _loc11.splice(_loc10, _loc8.length, _loc9);
                sMessage = _loc11.join("");
            } // end if
        } // end while
        return (sMessage);
    };
    _loc1.parseInlinePos = function (sMessage)
    {
        var _loc3 = sMessage;
        var _loc4 = 0;
        var _loc6 = 0;
        var _loc7 = 0;
        
        while (++_loc7, _loc3.indexOf("[") > -1 && (_loc4++ < dofus.managers.ChatManager.HTML_NB_PASS_MAX && _loc6 < dofus.managers.ChatManager.MAX_POS_REPLACE))
        {
            var _loc8 = _loc3.indexOf("[");
            var _loc9 = _loc3.indexOf("]", _loc8) + 1;
            if (_loc9 > 0)
            {
                var _loc10 = _loc3.substring(_loc8 + 1, _loc9 - 1).indexOf(", ") == -1 ? (",") : (", ");
                var _loc11 = _loc3.substring(_loc8 + 1, _loc9 - 1).split(_loc10);
                if (_loc11.length == 2)
                {
                    if (!_global.isNaN(_loc11[0]) && !_global.isNaN(new ank.utils.ExtendedString(_loc11[0]).trim().toString()))
                    {
                        var _loc12 = _global.parseInt(_loc11[0]);
                        var _loc13 = _global.parseInt(_loc11[1]);
                        if (Math.abs(_loc12) < 150 && Math.abs(_loc13) < 150)
                        {
                            var _loc5 = sMessage.split(_loc3.substring(_loc8, _loc9));
                            _loc6 = _loc6 + _loc5.length;
                            if (_loc6 > dofus.managers.ChatManager.MAX_POS_REPLACE)
                            {
                                break;
                            } // end if
                            sMessage = _loc5.join(this.getLinkCoord(_loc12, _loc13));
                        } // end if
                    } // end if
                } // end if
            }
            else
            {
                break;
            } // end else if
            _loc3 = _loc3.substring(_loc9);
        } // end while
        return (sMessage);
    };
    _loc1.parseSecretsEmotes = function (sMessage)
    {
        if (!this.api.lang.getConfigText("CHAT_USE_SECRETS_EMOTES"))
        {
            return (sMessage);
        } // end if
        if (sMessage.indexOf("[love]") != -1)
        {
            sMessage = sMessage.split("[love]").join("");
            if (!this.api.datacenter.Game.isFight)
            {
                this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum + ",2914,11,8,1");
            } // end if
        } // end if
        if (sMessage.indexOf("[rock]") != -1)
        {
            sMessage = sMessage.split("[rock]").join("");
            if (!this.api.datacenter.Game.isFight)
            {
                this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum + ",2069,10,1,1");
                this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + (this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum + 1) + ",2904,11,8,3");
                this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + (this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum - 1) + ",2904,11,8,3");
                this.api.network.Chat.onSmiley(this.api.datacenter.Player.ID + "|1");
                this.api.kernel.AudioManager.playSound("SPEAK_TRIGGER_LEVEL_UP");
                this.api.network.Chat.onMessage(true, this.api.datacenter.Player.ID + "|" + this.api.datacenter.Player.Name + "|" + sMessage);
            } // end if
            sMessage = "";
        } // end if
        return (sMessage);
    };
    _loc1.getLinkName = function (sName, sUniqId)
    {
        if (sUniqId != undefined && (sUniqId.length > 0 && sUniqId != ""))
        {
            return ("<b><a href=\'asfunction:onHref,ShowPlayerPopupMenu," + sName + "," + sUniqId + "\'>" + sName + "</a></b>");
        } // end if
        return ("<b><a href=\'asfunction:onHref,ShowPlayerPopupMenu," + sName + "\'>" + sName + "</a></b>");
    };
    _loc1.getLinkCoord = function (nX, nY)
    {
        return ("<b><a href=\'asfunction:onHref,updateCompass," + nX + "," + nY + "\'>[" + nX + "," + nY + "]</a></b>");
    };
    _loc1.getLinkItem = function (oItem)
    {
        var _loc3 = this.addItemToBuffer(oItem);
        return ("<b>[<a href=\'asfunction:onHref,ShowItemViewer," + String(_loc3) + "\'>" + oItem.name + "</a>]</b>");
    };
    _loc1.addItemToBuffer = function (oItem)
    {
        if (this._nItemsBufferIDs == undefined || _global.isNaN(this._nItemsBufferIDs))
        {
            this._nItemsBufferIDs = 0;
        } // end if
        ++this._nItemsBufferIDs;
        if (this._aItemsBuffer == undefined)
        {
            this._aItemsBuffer = new Array();
        } // end if
        if (this._aItemsBuffer.length > dofus.managers.ChatManager.MAX_ITEM_BUFFER_LENGTH)
        {
            this._aItemsBuffer.shift();
        } // end if
        this._aItemsBuffer.push({id: this._nItemsBufferIDs, data: oItem});
        return (this._nItemsBufferIDs);
    };
    _loc1.getItemFromBuffer = function (nItemID)
    {
        var _loc3 = this._aItemsBuffer.length;
        
        while (--_loc3, _loc3 >= 0)
        {
            if (this._aItemsBuffer[_loc3].id == nItemID)
            {
                return (this._aItemsBuffer[_loc3].data);
            } // end if
        } // end while
        return;
    };
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).isPonctuation = function (sChar)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.managers.ChatManager.PONCTUATION.length)
        {
            if (dofus.managers.ChatManager.PONCTUATION[_loc3] == sChar)
            {
                return (true);
            } // end if
        } // end while
        return (false);
    };
    _loc1.addToBlacklist = function (sName, nClass)
    {
        if (sName != this.api.datacenter.Player.Name && !this.isBlacklisted(sName))
        {
            this._aBlacklist.push({sName: sName, nClass: nClass});
        } // end if
    };
    _loc1.removeToBlacklist = function (sName)
    {
        for (var i in this._aBlacklist)
        {
            if (sName == this._aBlacklist[i].sName || sName == "*" + this._aBlacklist[i].sName)
            {
                this._aBlacklist[i] = undefined;
                this.api.ui.getUIComponent("Friends").updateIgnoreList();
                this.api.kernel.showMessage(undefined, this.api.lang.getText("TEMPORARY_NOMORE_BLACKLISTED", [sName]), "INFO_CHAT");
                return;
            } // end if
        } // end of for...in
    };
    _loc1.getBlacklist = function ()
    {
        return (this._aBlacklist);
    };
    _loc1.isBlacklisted = function (sName)
    {
        for (var i in this._aBlacklist)
        {
            if (sName.toLowerCase() == this._aBlacklist[i].sName.toLowerCase())
            {
                return (true);
            } // end if
        } // end of for...in
        return (false);
    };
    _loc1.getMessageFromId = function (sUniqId)
    {
        for (var i in this._aMessages)
        {
            if (this._aMessages[i].uniqId == sUniqId)
            {
                return (this._aMessages[i].text);
            } // end if
        } // end of for...in
        return;
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    })._sSelf = null;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).TYPE_INFOS = 0;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).TYPE_ERRORS = 1;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).TYPE_MESSAGES = 2;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).TYPE_WISP = 3;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).TYPE_GUILD = 4;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).TYPE_PVP = 5;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).TYPE_RECRUITMENT = 6;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).TYPE_TRADE = 7;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).TYPE_MEETIC = 8;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).TYPE_ADMIN = 9;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).MAX_ALL_LENGTH = 150;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).MAX_INFOS_LENGTH = 50;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).MAX_VISIBLE = 30;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).EMPTY_ZONE_LENGTH = 31;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).STOP_SCROLL_LENGTH = 6;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).MAX_ITEM_BUFFER_LENGTH = 75;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).MAX_POS_REPLACE = 6;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).ADMIN_BUFFER_MULTIPLICATOR = 5;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).HTML_NB_PASS_MAX = 50;
    _loc1._aVisibleTypes = [true, true, true, true, true, true, true, true, true, true];
    _loc1._nItemsBufferIDs = 0;
    _loc1._bFirstErrorCatched = false;
    _loc1._bUseInWordCensor = false;
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).CENSORSHIP_CHAR = ["%", "&", "§ ", "@", "?"];
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).PONCTUATION = [".", "!", "?", "~"];
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).LINK_FILTERS = ["WWW", "HTTP", "@", ".COM", ".FR", ".INFO", "HOTMAIL", "MSN", "GMAIL", "FTP"];
    (_global.dofus.managers.ChatManager = function (oAPI)
    {
        super();
        dofus.managers.ChatManager._sSelf = this;
        this.initialize(oAPI);
    }).WHITE_LIST = [".DOFUS.COM", ".ANKAMA-GAMES.COM", ".GOOGLE.COM", ".DOFUS.FR", ".DOFUS.DE", ".DOFUS.ES", ".DOFUS.CO.UK", ".WAKFU.COM", ".ANKAMA-SHOP.COM", ".ANKAMA.COM", ".ANKAMA-EDITIONS.COM", ".ANKAMA-WEB.COM", ".ANKAMA-EVENTS.COM", ".DOFUS-ARENA.COM", ".MUTAFUKAZ.COM", ".MANGA-DOFUS.COM", ".LABANDEPASSANTE.FR", "@_@", ".ANKAMA-PLAY.COM"];
} // end if
#endinitclip
