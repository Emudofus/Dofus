// Action script...

// [Initial MovieClip Action of sprite 20927]
#initclip 192
if (!dofus.managers.AdminManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.AdminManager = function ()
    {
        super();
        dofus.managers.AdminManager._sSelf = this;
    }).prototype;
    (_global.dofus.managers.AdminManager = function ()
    {
        super();
        dofus.managers.AdminManager._sSelf = this;
    }).getInstance = function ()
    {
        return (dofus.managers.AdminManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        this._nUICounter = 0;
        this.loadXML();
    };
    _loc1.showPopupMenu = function (pm)
    {
        pm.show(_root._xmouse, _root._ymouse, true);
    };
    _loc1.loadXML = function (bShow)
    {
        var _loc2 = new XML();
        _loc2.parent = this;
        _loc2.onLoad = function (bSuccess)
        {
            if (bSuccess)
            {
                this.parent.xml = this;
                this.parent.initStartup(this.firstChild.firstChild);
            }
            else
            {
                this.parent.xml = undefined;
            } // end else if
            if (bShow)
            {
                this.parent.showAdminPopupMenu();
            } // end if
        };
        _loc2.ignoreWhite = true;
        _loc2.load(dofus.Constants.XML_ADMIN_MENU_PATH);
    };
    _loc1.showAdminPopupMenu = function (sPlayerName)
    {
        var _loc3 = this.api.datacenter.Sprites.getItems();
        var _loc4 = false;
        for (var a in _loc3)
        {
            var _loc5 = _loc3[a];
            if (_loc5.name.toUpperCase() == this.api.datacenter.Player.Name.toUpperCase())
            {
                this.myPlayerObject = _loc5;
            } // end if
            if (_loc5.name.toUpperCase() == sPlayerName.toUpperCase())
            {
                this.playerObject = _loc5;
                _loc4 = true;
                break;
            } // end if
        } // end of for...in
        if (!_loc4)
        {
            this.playerObject = null;
        } // end if
        if (sPlayerName != undefined)
        {
            this.playerName = sPlayerName;
        } // end if
        if (this.xml != undefined)
        {
            this.createAndShowPopupMenu(this.xml.firstChild.firstChild);
        }
        else
        {
            var _loc6 = this.api.ui.createPopupMenu();
            _loc6.addStaticItem("XML not found");
            _loc6.addItem("Reload XML", this, this.loadXML, [true]);
            this.showPopupMenu(_loc6);
        } // end else if
    };
    _loc1.generateDateString = function ()
    {
        var _loc2 = new Date();
        var _loc3 = String(_loc2.getFullYear());
        if (_loc3.length < 2)
        {
            _loc3 = "0" + _loc3;
        } // end if
        var _loc4 = String(_loc2.getMonth());
        if (_loc4.length < 2)
        {
            _loc4 = "0" + _loc4;
        } // end if
        var _loc5 = String(_loc2.getDate());
        if (_loc5.length < 2)
        {
            _loc5 = "0" + _loc5;
        } // end if
        this.date = _loc3 + "/" + _loc4 + "/" + _loc5;
    };
    _loc1.generateHourString = function ()
    {
        var _loc2 = new Date();
        var _loc3 = String(_loc2.getHours());
        if (_loc3.length < 2)
        {
            _loc3 = "0" + _loc3;
        } // end if
        var _loc4 = String(_loc2.getMinutes());
        if (_loc4.length < 2)
        {
            _loc4 = "0" + _loc4;
        } // end if
        var _loc5 = String(_loc2.getSeconds());
        if (_loc5.length < 2)
        {
            _loc5 = "0" + _loc5;
        } // end if
        this.hour = _loc3 + ":" + _loc4 + ":" + _loc5;
    };
    _loc1.generateHourAndDate = function ()
    {
        this.generateDateString();
        this.generateHourString();
    };
    _loc1.createAndShowPopupMenu = function (node)
    {
        this.generateHourAndDate();
        var _loc3 = this.api.ui.createPopupMenu();
        while (node != null && node != undefined)
        {
            var _loc4 = this.replace(node.attributes.label);
            switch (node.attributes.type)
            {
                case "static":
                {
                    _loc3.addStaticItem(_loc4);
                    break;
                } 
                case "menu":
                {
                    _loc3.addItem(_loc4 + " >>", this, this.createAndShowPopupMenu, [node.firstChild]);
                    break;
                } 
                case "menuDebug":
                {
                    if (dofus.Constants.DEBUG)
                    {
                        _loc3.addItem(_loc4 + " >>", this, this.createAndShowPopupMenu, [node.firstChild]);
                    } // end if
                    break;
                } 
                case "loadXML":
                {
                    _loc3.addItem(_loc4, this, this.loadXML, [true]);
                    break;
                } 
                case "startup":
                {
                    break;
                } 
                default:
                {
                    _loc3.addItem(_loc4, this, this.executeFirst, [node]);
                    break;
                } 
            } // End of switch
            node = node.nextSibling;
        } // end while
        this.showPopupMenu(_loc3);
    };
    _loc1.initStartup = function (node)
    {
        while (node != null && node != undefined)
        {
            if (node.attributes.type == "startup")
            {
                this._startupNode = node;
                return;
            } // end if
            node = node.nextSibling;
        } // end while
    };
    _loc1.executeFirst = function (node)
    {
        this.removeInterval();
        this._sSaveNode = node.cloneNode(true);
        this.execute(this._sSaveNode);
    };
    _loc1.execute = function (node)
    {
        if (node.attributes.check != true)
        {
            this.generateHourAndDate();
            this._sCurrentNode = node;
            var _loc3 = node.attributes.command;
            if (_loc3 != undefined)
            {
                _loc3 = this.replaceCommand(_loc3);
                if (_loc3 == null)
                {
                    return (false);
                } // end if
            } // end if
            switch (node.attributes.type)
            {
                case "sendCommand":
                {
                    this.sendCommand(_loc3);
                    break;
                } 
                case "sendChat":
                {
                    this.sendChat(_loc3);
                    break;
                } 
                case "prepareCommand":
                {
                    this.prepareCommand(_loc3);
                    break;
                } 
                case "prepareChat":
                {
                    this.prepareChat(_loc3);
                    break;
                } 
                case "clearConsole":
                {
                    this.clearConsole();
                    break;
                } 
                case "openConsole":
                {
                    this.openConsole();
                    break;
                } 
                case "closeConsole":
                {
                    this.closeConsole();
                    break;
                } 
                case "move":
                {
                    this.move(Number(node.attributes.cell), node.attributes.dirs);
                    break;
                } 
                case "emote":
                {
                    this.emote(Number(node.attributes.num));
                    break;
                } 
                case "smiley":
                {
                    this.smiley(Number(node.attributes.num));
                    break;
                } 
                case "direction":
                {
                    this.direction(Number(node.attributes.num));
                    break;
                } 
                case "batch":
                {
                    return (this.batch(node.firstChild));
                    break;
                } 
                case "summoner":
                {
                    this.itemSummoner();
                    break;
                } 
            } // End of switch
            node.attributes.check = true;
        } // end if
        return (true);
    };
    _loc1.batch = function (node)
    {
        while (node != null && node != undefined)
        {
            var _loc3 = this.execute(node);
            if (_loc3 == false)
            {
                return (false);
            } // end if
            var _loc4 = node.nextSibling;
            var _loc5 = Number(node.attributes.delay);
            if (!_global.isNaN(_loc5) && node.attributes.delayCheck != true)
            {
                ank.utils.Timer.setTimer(this, "batch", this, this.onCommandDelay, _loc5);
                return (false);
            } // end if
            var _loc6 = node.parentNode;
            if (_loc6.attributes.repeatCheck == undefined)
            {
                _loc6.attributes.repeatCheck = 1;
            } // end if
            var _loc7 = _loc6.attributes.repeat;
            if (_loc4 == undefined && (!_global.isNaN(_loc7) && _loc6.attributes.repeatCheck < _loc7))
            {
                var _loc8 = 0;
                
                while (++_loc8, _loc8 < _loc6.childNodes.length)
                {
                    _loc6.childNodes[_loc8].attributes.check = false;
                    _loc6.childNodes[_loc8].attributes.delayCheck = false;
                } // end while
                ++_loc6.attributes.repeatCheck;
                _loc4 = _loc6.childNodes[0];
            } // end if
            node = _loc4;
        } // end while
        return (true);
    };
    _loc1.onCommandDelay = function ()
    {
        this._sCurrentNode.attributes.delayCheck = true;
        this.removeInterval();
        this.resumeExecute();
    };
    _loc1.removeInterval = function ()
    {
        ank.utils.Timer.removeTimer(this, "batch");
    };
    _loc1.resumeExecute = function ()
    {
        this.execute(this._sSaveNode);
    };
    _loc1.openConsole = function ()
    {
        this.api.ui.loadUIComponent("Debug", "Debug", undefined, {bAlwaysOnTop: true});
    };
    _loc1.closeConsole = function ()
    {
        this.api.ui.unloadUIComponent("Debug");
    };
    _loc1.prepareCommand = function (sCommand)
    {
        this.api.ui.loadUIComponent("Debug", "Debug", {command: sCommand}, {bStayIfPresent: true});
    };
    _loc1.sendCommand = function (sCommand)
    {
        this.api.kernel.DebugConsole.process(sCommand);
    };
    _loc1.prepareChat = function (sCommand)
    {
        this.api.ui.getUIComponent("Banner").txtConsole = sCommand;
    };
    _loc1.sendChat = function (sCommand)
    {
        this.api.kernel.Console.process(sCommand);
    };
    _loc1.clearConsole = function ()
    {
        this.api.ui.getUIComponent("Debug").clear();
    };
    _loc1.move = function (nCellNum, bAllDirections)
    {
        this.api.datacenter.Player.InteractionsManager.calculatePath(this.api.gfx.mapHandler, nCellNum, true, this.api.datacenter.Game.isFight, true, bAllDirections);
        if (this.api.datacenter.Basics.interactionsManager_path.length != 0)
        {
            var _loc4 = ank.battlefield.utils.Compressor.compressPath(this.api.datacenter.Basics.interactionsManager_path);
            if (_loc4 != undefined)
            {
                this.myPlayerObject.GameActionsManager.transmittingMove(1, [_loc4]);
                delete this.api.datacenter.Basics.interactionsManager_path;
            } // end if
        } // end if
    };
    _loc1.smiley = function (nIndex)
    {
        this.api.network.Chat.useSmiley(nIndex);
    };
    _loc1.emote = function (nIndex)
    {
        this.api.network.Emotes.useEmote(nIndex);
    };
    _loc1.direction = function (nIndex)
    {
        this.api.network.Emotes.setDirection(nIndex);
    };
    _loc1.itemSummoner = function ()
    {
        this.api.ui.loadUIComponent("ItemSummoner", "ItemSummoner");
    };
    _loc1.replace = function (sText)
    {
        var _loc3 = new Array();
        _loc3.push({f: "%g", t: this.playerObject.guildName});
        _loc3.push({f: "%c", t: this.playerObject.cellNum});
        _loc3.push({f: "%p", t: this.playerName});
        _loc3.push({f: "%n", t: this.api.datacenter.Player.Name});
        _loc3.push({f: "%d", t: this.date});
        _loc3.push({f: "%h", t: this.hour});
        _loc3.push({f: "%t", t: this.api.kernel.NightManager.time});
        _loc3.push({f: "%s", t: this.api.datacenter.Basics.aks_a_prompt});
        _loc3.push({f: "%m", t: this.api.datacenter.Map.id});
        _loc3.push({f: "%v", t: dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + " build " + dofus.Constants.BUILD_NUMBER});
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            sText = sText.split(_loc3[_loc4].f).join(_loc3[_loc4].t);
        } // end while
        return (sText);
    };
    _loc1.replaceCommand = function (sText)
    {
        var _loc3 = new Array();
        _loc3.push({f: "#item", ui: "ItemSelector"});
        _loc3.push({f: "#look", ui: "MonsterAndLookSelector"});
        _loc3.push({f: "#monster", ui: "MonsterAndLookSelector", p: {monster: true}});
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            if (sText.indexOf(_loc3[_loc4].f) != -1)
            {
                var _loc5 = this.api.ui.loadUIComponent(_loc3[_loc4].ui, _loc3[_loc4].ui + this._nUICounter++, _loc3[_loc4].p);
                _loc5.addEventListener("select", this);
                _loc5.addEventListener("cancel", this);
                return (null);
            } // end if
        } // end while
        return (this.replace(sText));
    };
    _loc1.replaceUI = function (sText, sToReplace, sReplacer)
    {
        var _loc5 = sText.indexOf(sToReplace);
        var _loc6 = sText.split("");
        _loc6.splice(_loc5, sToReplace.length, sReplacer);
        var _loc7 = _loc6.join("");
        return (_loc7);
    };
    _loc1.cancel = function (oEvent)
    {
    };
    _loc1.characterEnteringGame = function ()
    {
        if (this._startupNode != null && this._startupNode != undefined)
        {
            this.playerObject = this.api.datacenter.Player;
            this.playerName = (dofus.datacenter.LocalPlayer)(this.playerObject).Name;
            this.batch(this._startupNode.firstChild);
        } // end if
    };
    _loc1.select = function (oEvent)
    {
        switch (oEvent.ui)
        {
            case "ItemSelector":
            {
                this._sCurrentNode.attributes.command = this.replaceUI(this._sCurrentNode.attributes.command, "#item", oEvent.itemId + " " + oEvent.itemQuantity);
                break;
            } 
            case "LookSelector":
            {
                this._sCurrentNode.attributes.command = this.replaceUI(this._sCurrentNode.attributes.command, "#look", oEvent.lookId);
                break;
            } 
            case "MonsterSelector":
            {
                this._sCurrentNode.attributes.command = this.replaceUI(this._sCurrentNode.attributes.command, "#monster", oEvent.monsterId);
                break;
            } 
        } // End of switch
        this.resumeExecute();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.AdminManager = function ()
    {
        super();
        dofus.managers.AdminManager._sSelf = this;
    })._sSelf = null;
} // end if
#endinitclip
