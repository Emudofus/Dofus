// Action script...

// [Initial MovieClip Action of sprite 20754]
#initclip 19
if (!dofus.managers.KeyManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.KeyManager = function (oAPI)
    {
        super();
        dofus.managers.KeyManager._sSelf = this;
        this.initialize(oAPI);
    }).prototype;
    _loc1.__get__Broadcasting = function ()
    {
        return (this._bIsBroadcasting);
    };
    _loc1.__set__Broadcasting = function (bIsBroadcasting)
    {
        this._bIsBroadcasting = bIsBroadcasting;
        //return (this.Broadcasting());
    };
    (_global.dofus.managers.KeyManager = function (oAPI)
    {
        super();
        dofus.managers.KeyManager._sSelf = this;
        this.initialize(oAPI);
    }).getInstance = function ()
    {
        return (dofus.managers.KeyManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        Key.addListener(this);
        this._aAnyTimeShortcuts = new Array();
        this._aNoChatShortcuts = new Array();
        this._so = SharedObject.getLocal(this.api.datacenter.Player.login + dofus.Constants.GLOBAL_SO_SHORTCUTS_NAME);
        this._nCurrentSet = this.api.kernel.OptionsManager.getOption("ShortcutSet");
        this.loadShortcuts();
    };
    _loc1.addShortcutsListener = function (sMethod, oListener)
    {
        if (this._aListening == undefined)
        {
            this._aListening = new Array();
        } // end if
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._aListening.length)
        {
            if (String(this._aListening[_loc4].o) == String(oListener) && this._aListening[_loc4].m == sMethod)
            {
                this.removeShortcutsListener(this._aListening[_loc4].o);
            } // end if
        } // end while
        this._aListening.push({o: oListener, m: sMethod});
    };
    _loc1.removeShortcutsListener = function (oListener)
    {
        if (this._aListening == undefined)
        {
            return;
        } // end if
        var _loc3 = new Array();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._aListening.length)
        {
            if (this._aListening[_loc4].o == oListener)
            {
                _loc3.push(_loc4);
            } // end if
        } // end while
        _loc3.sort(Array.DESCENDING);
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            this._aListening.splice(_loc3[_loc5], 1);
        } // end while
    };
    _loc1.addKeysListener = function (sMethod, oListener)
    {
        if (this._aKeysListening == undefined)
        {
            this._aKeysListening = new Array();
        } // end if
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._aKeysListening.length)
        {
            if (String(this._aKeysListening[_loc4].o) == String(oListener) && this._aKeysListening[_loc4].m == sMethod)
            {
                this._aKeysListening[_loc4] = undefined;
            } // end if
        } // end while
        this._aKeysListening.push({o: oListener, m: sMethod});
    };
    _loc1.removeKeysListener = function (oListener)
    {
        if (this._aKeysListening == undefined)
        {
            return;
        } // end if
        var _loc3 = new Array();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._aKeysListening.length)
        {
            if (this._aKeysListening[_loc4].o == oListener)
            {
                _loc3.push(_loc4);
            } // end if
        } // end while
        _loc3.sort(Array.DESCENDING);
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            this._aKeysListening.splice(_loc3[_loc5], 1);
        } // end while
    };
    _loc1.getDefaultShortcut = function (sShortcut)
    {
        return (this.api.lang.getKeyboardShortcutsKeys(this._nCurrentSet, sShortcut));
    };
    _loc1.getCurrentShortcut = function (sShortcut)
    {
        var _loc3 = new Array();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._aAnyTimeShortcuts.length)
        {
            if (this._aAnyTimeShortcuts[_loc4].d == sShortcut)
            {
                _loc3.push({k: this._aAnyTimeShortcuts[_loc4].k, c: this._aAnyTimeShortcuts[_loc4].c, d: this._aAnyTimeShortcuts[_loc4].l});
            } // end if
        } // end while
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this._aNoChatShortcuts.length)
        {
            if (this._aNoChatShortcuts[_loc5].d == sShortcut)
            {
                _loc3.push({k: this._aNoChatShortcuts[_loc5].k, c: this._aNoChatShortcuts[_loc5].c, d: this._aNoChatShortcuts[_loc5].l});
            } // end if
        } // end while
        if (_loc3.length == 1)
        {
            return (_loc3[0]);
        }
        else if (_loc3.length == 2)
        {
            return ({k: _loc3[0].k, c: _loc3[0].c, d: _loc3[0].d, k2: _loc3[1].k, c2: _loc3[1].c, d2: _loc3[1].d});
        } // end else if
        return;
    };
    _loc1.clearCustomShortcuts = function ()
    {
        this._so.clear();
        this.loadShortcuts();
    };
    _loc1.askCustomShortcut = function (sShortcut, bIsAlternative)
    {
        this.api.ui.loadUIComponent("AskCustomShortcut", "AskCustomShortcut", {title: this.api.lang.getText("SHORTCUTS_CUSTOM"), ShortcutCode: sShortcut, IsAlt: bIsAlternative, Description: this.api.lang.getKeyboardShortcuts()[sShortcut].d});
    };
    _loc1.setCustomShortcut = function (sShortcut, bIsAlternative, nKeyCode, nCtrlCode, sAscii)
    {
        if (sShortcut == undefined || bIsAlternative == undefined)
        {
            return;
        } // end if
        var _loc7 = sShortcut + (bIsAlternative ? ("_ALT") : ("_MAIN"));
        if (nKeyCode == undefined)
        {
            this._so.data[_loc7] = undefined;
        }
        else
        {
            if (nCtrlCode == undefined)
            {
                nCtrlCode = 0;
            } // end if
            if (sAscii == undefined || sAscii == "")
            {
                sAscii = this.api.lang.getKeyStringFromKeyCode(nKeyCode);
                sAscii = this.api.lang.getControlKeyString(nCtrlCode) + sAscii;
            } // end if
            this._so.data[_loc7] = {s: sShortcut, a: bIsAlternative, k: nKeyCode, c: nCtrlCode, i: sAscii};
        } // end else if
        this.loadShortcuts();
    };
    _loc1.getCustomShortcut = function (sShortcut, bIsAlternative)
    {
        var _loc4 = sShortcut + (bIsAlternative ? ("_ALT") : ("_MAIN"));
        return (this._so.data[_loc4]);
    };
    _loc1.isCustomShortcut = function (sShortcut, bIsAlternative)
    {
        return (this.getCustomShortcut(sShortcut, bIsAlternative) != undefined);
    };
    _loc1.deleteCustomShortcut = function (sShortcut, bIsAlternative)
    {
        this.setCustomShortcut(sShortcut, bIsAlternative);
    };
    _loc1.getCurrentDefaultSet = function ()
    {
        var _loc2 = Number(this.api.lang.getText("SHORTCUTS_DEFAULT_SET"));
        if (_loc2 < 1)
        {
            _loc2 = 1;
        } // end if
        return (_loc2);
    };
    _loc1.dispatchCtrlState = function (bNewCtrlState)
    {
        this.dispatchShortcut(bNewCtrlState ? ("CTRL_STATE_CHANGED_ON") : ("CTRL_STATE_CHANGED_OFF"));
    };
    _loc1.dispatchShortcut = function (sShortcut)
    {
        if (!this._bIsBroadcasting)
        {
            return (false);
        } // end if
        if (this._aListening == undefined)
        {
            return (true);
        } // end if
        var _loc3 = new Array();
        var _loc4 = true;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this._aListening.length)
        {
            if (this._aListening[_loc5] == undefined || this._aListening[_loc5].o == undefined)
            {
                _loc3.push(_loc5);
                continue;
            } // end if
            var _loc6 = eval(String(this._aListening[_loc5].o) + "." + this._aListening[_loc5].m).call(this._aListening[_loc5].o, sShortcut);
            if (_loc6 != undefined && _loc6 == false)
            {
                _loc4 = false;
                break;
            } // end if
        } // end while
        _loc3.sort(Array.DESCENDING);
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < _loc3.length)
        {
            this._aListening.splice(_loc3[_loc7], 1);
        } // end while
        if (_loc4)
        {
            _loc4 = this.onShortcut(sShortcut);
        } // end if
        return (_loc4);
    };
    _loc1.dispatchKey = function (sKey)
    {
        if (!this._bIsBroadcasting)
        {
            return;
        } // end if
        if (this._aKeysListening == undefined)
        {
            return;
        } // end if
        sKey = new ank.utils.ExtendedString(sKey).trim().toString();
        if (sKey.length == 0)
        {
            return;
        } // end if
        var _loc3 = new Array();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._aKeysListening.length)
        {
            if (this._aKeysListening[_loc4] == undefined || this._aKeysListening[_loc4].o == undefined)
            {
                _loc3.push(_loc4);
                continue;
            } // end if
            eval(String(this._aKeysListening[_loc4].o) + "." + this._aKeysListening[_loc4].m).call(this._aKeysListening[_loc4].o, sKey);
        } // end while
        _loc3.sort(Array.DESCENDING);
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            this._aKeysListening.splice(_loc3[_loc5], 1);
        } // end while
    };
    _loc1.loadShortcuts = function ()
    {
        var _loc2 = this.api.lang.getKeyboardShortcuts();
        this._aNoChatShortcuts = new Array();
        this._aAnyTimeShortcuts = new Array();
        for (var k in _loc2)
        {
            var _loc3 = this.api.lang.getKeyboardShortcutsKeys(this._nCurrentSet, k);
            var _loc4 = this.getCustomShortcut(k, false);
            if (_loc4 != undefined && !_loc2[k].s)
            {
                if (_loc3.o)
                {
                    this._aNoChatShortcuts.push({k: _loc4.k, c: _loc4.c, o: _loc3.o, d: k, l: _loc4.i, s: _loc2[k].s});
                }
                else
                {
                    this._aAnyTimeShortcuts.push({k: _loc4.k, c: _loc4.c, o: _loc3.o, d: k, l: _loc4.i, s: _loc2[k].s});
                } // end else if
            }
            else if (_loc3.o)
            {
                this._aNoChatShortcuts.push({k: _loc3.k, c: _loc3.c, o: _loc3.o, d: k, l: _loc3.s, s: _loc2[k].s});
            }
            else if (_loc3.k != undefined)
            {
                this._aAnyTimeShortcuts.push({k: _loc3.k, c: _loc3.c, o: _loc3.o, d: k, l: _loc3.s, s: _loc2[k].s});
            } // end else if
            var _loc5 = this.getCustomShortcut(k, true);
            if (_loc5 != undefined && !_loc2[k].s)
            {
                if (_loc3.o)
                {
                    this._aNoChatShortcuts.push({k: _loc5.k, c: _loc5.c, o: _loc3.o, d: k, l: _loc5.i, s: _loc2[k].s});
                }
                else
                {
                    this._aAnyTimeShortcuts.push({k: _loc5.k, c: _loc5.c, o: _loc3.o, d: k, l: _loc5.i, s: _loc2[k].s});
                } // end else if
                continue;
            } // end if
            if (!_global.isNaN(_loc3.k2) && _loc3.k2 != undefined)
            {
                if (_loc3.o)
                {
                    this._aNoChatShortcuts.push({k: _loc3.k2, c: _loc3.c2, o: _loc3.o, d: k, l: _loc3.s2, s: _loc2[k].s});
                    continue;
                } // end if
                this._aAnyTimeShortcuts.push({k: _loc3.k2, c: _loc3.c2, o: _loc3.o, d: k, l: _loc3.s2, s: _loc2[k].s});
            } // end if
        } // end of for...in
        if (this._aNoChatShortcuts.length == 0 && this._aAnyTimeShortcuts.length == 0)
        {
            this._aAnyTimeShortcuts.push({k: 38, c: 0, o: true, d: "HISTORY_UP"});
            this._aAnyTimeShortcuts.push({k: 40, c: 0, o: true, d: "HISTORY_DOWN"});
            this._aAnyTimeShortcuts.push({k: 13, c: 1, o: true, d: "GUILD_MESSAGE"});
            this._aAnyTimeShortcuts.push({k: 13, c: 0, o: true, d: "ACCEPT_CURRENT_DIALOG"});
            this._aAnyTimeShortcuts.push({k: 70, c: 1, o: true, d: "FULLSCREEN"});
            var _loc6 = this.api.lang.getDefaultConsoleShortcuts();
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < _loc6.length)
            {
                this._aAnyTimeShortcuts.push({k: _loc6[_loc7].k, c: _loc6[_loc7].c, o: true, d: "CONSOLE"});
            } // end while
        } // end if
    };
    _loc1.processShortcuts = function (aShortcuts, nKeyCode, bCtrl, bShift)
    {
        var _loc6 = true;
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < aShortcuts.length)
        {
            if (Number(aShortcuts[_loc7].k) == nKeyCode)
            {
                var _loc8 = false;
                switch (aShortcuts[_loc7].c)
                {
                    case 1:
                    {
                        if (bCtrl && !bShift)
                        {
                            _loc8 = true;
                        } // end if
                        break;
                    } 
                    case 2:
                    {
                        if (!bCtrl && bShift)
                        {
                            _loc8 = true;
                        } // end if
                        break;
                    } 
                    case 3:
                    {
                        if (bCtrl && bShift)
                        {
                            _loc8 = true;
                        } // end if
                        break;
                    } 
                    default:
                    {
                        if (!bCtrl && !bShift)
                        {
                            _loc8 = true;
                        } // end if
                        break;
                    } 
                } // End of switch
                if (_loc8)
                {
                    _loc6 = this.dispatchShortcut(aShortcuts[_loc7].d);
                } // end if
            } // end if
        } // end while
        return (_loc6);
    };
    _loc1.onSetChange = function (nSetID)
    {
        this._nCurrentSet = nSetID;
        this.loadShortcuts();
    };
    _loc1.onKeyDown = function ()
    {
        var _loc2 = Key.getCode();
        var _loc3 = Key.getAscii();
        var _loc4 = Key.isDown(Key.CONTROL);
        var _loc5 = Key.isDown(Key.SHIFT);
        if (this._lastCtrlState != _loc4)
        {
            this._lastCtrlState = _loc4;
            this.dispatchCtrlState(_loc4);
        } // end if
        if (this._bPressedKeys[_loc2] != undefined)
        {
            return;
        } // end if
        this._bPressedKeys[_loc2] = true;
        if (!this.processShortcuts(this._aAnyTimeShortcuts, _loc2, _loc4, _loc5))
        {
            return;
        } // end if
        if (Selection.getFocus() != undefined)
        {
            return;
        } // end if
        if (!this.processShortcuts(this._aNoChatShortcuts, _loc2, _loc4, _loc5))
        {
            return;
        } // end if
        if (_loc3 > 0)
        {
            this.dispatchKey(String.fromCharCode(_loc3));
        } // end if
    };
    _loc1.onKeyUp = function ()
    {
        var _loc2 = Key.getCode();
        delete this._bPressedKeys[_loc2];
    };
    _loc1.onShortcut = function (sShortcut)
    {
        var _loc3 = true;
        switch (sShortcut)
        {
            case "TOGGLE_FIGHT_INFOS":
            {
                this.api.kernel.OptionsManager.setOption("ChatEffects", !this.api.kernel.OptionsManager.getOption("ChatEffects"));
                _loc3 = false;
                break;
            } 
            case "ESCAPE":
            {
                this.api.datacenter.Basics.gfx_canLaunch = false;
                if (!this.api.ui.removeCursor(true))
                {
                    if (this.api.ui.callCloseOnLastUI() == false)
                    {
                        this.api.ui.loadUIComponent("AskMainMenu", "AskMainMenu");
                    } // end if
                } // end if
                break;
            } 
            case "CONSOLE":
            {
                if (this.api.datacenter.Player.isAuthorized)
                {
                    this.api.ui.loadUIComponent("Debug", "Debug", undefined, {bAlwaysOnTop: true});
                    _loc3 = false;
                } // end if
                break;
            } 
            case "GRID":
            {
                this.api.kernel.OptionsManager.setOption("Grid");
                _loc3 = false;
                break;
            } 
            case "TRANSPARENCY":
            {
                this.api.kernel.OptionsManager.setOption("Transparency", !this.api.gfx.bGhostView);
                _loc3 = false;
                break;
            } 
            case "SPRITEINFOS":
            {
                this.api.kernel.OptionsManager.setOption("SpriteInfos");
                _loc3 = false;
                break;
            } 
            case "COORDS":
            {
                this.api.kernel.OptionsManager.setOption("MapInfos");
                _loc3 = false;
                break;
            } 
            case "STRINGCOURSE":
            {
                this.api.kernel.OptionsManager.setOption("StringCourse");
                _loc3 = false;
                break;
            } 
            case "BUFF":
            {
                this.api.kernel.OptionsManager.setOption("Buff");
                _loc3 = false;
                break;
            } 
            case "MOVABLEBAR":
            {
                this.api.kernel.OptionsManager.setOption("MovableBar", !this.api.kernel.OptionsManager.getOption("MovableBar"));
                _loc3 = false;
                break;
            } 
            case "MOUNTING":
            {
                this.api.network.Mount.ride();
                _loc3 = false;
                break;
            } 
            case "FULLSCREEN":
            {
                getURL("FSCommand:" add "fullscreen", this.api.kernel.GameManager.isFullScreen = !this.api.kernel.GameManager.isFullScreen);
                _loc3 = false;
                break;
            } 
            case "ALLOWSCALE":
            {
                getURL("FSCommand:" add "allowscale", this.api.kernel.GameManager.isAllowingScale = !this.api.kernel.GameManager.isAllowingScale);
                _loc3 = false;
                break;
            } 
        } // End of switch
        return (_loc3);
    };
    _loc1.addProperty("Broadcasting", _loc1.__get__Broadcasting, _loc1.__set__Broadcasting);
    ASSetPropFlags(_loc1, null, 1);
    _loc1._bIsBroadcasting = true;
    _loc1._bPressedKeys = new Array();
    _loc1._bCtrlDown = false;
    _loc1._bShiftDown = true;
    (_global.dofus.managers.KeyManager = function (oAPI)
    {
        super();
        dofus.managers.KeyManager._sSelf = this;
        this.initialize(oAPI);
    })._sSelf = null;
} // end if
#endinitclip
