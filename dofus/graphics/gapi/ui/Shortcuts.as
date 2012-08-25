// Action script...

// [Initial MovieClip Action of sprite 20983]
#initclip 248
if (!dofus.graphics.gapi.ui.Shortcuts)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.Shortcuts = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Shortcuts.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._winBg.title = this.api.lang.getText("KEYBORD_SHORTCUT");
        this._btnClose2.label = this.api.lang.getText("CLOSE");
        this._lblDescription.text = this.api.lang.getText("SHORTCUTS_DESCRIPTION");
        this._lblKeys.text = this.api.lang.getText("SHORTCUTS_KEYS");
        this._lblDefaultSet.text = this.api.lang.getText("SHORTCUTS_SET_CHOICE");
        this._btnApplyDefault.label = this.api.lang.getText("SHORTCUTS_APPLY_DEFAULT");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose2.addEventListener("click", this);
        this._cbSetList.addEventListener("itemSelected", this);
        this._btnApplyDefault.addEventListener("click", this);
    };
    _loc1.initData = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = this.api.lang.getKeyboardShortcutsSets();
        _loc3.sortOn("d");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            if (_loc3[_loc4] == undefined)
            {
                continue;
            } // end if
            _loc2.push({label: _loc3[_loc4].d, id: _loc3[_loc4].i});
            if (_loc3[_loc4].i == this.api.kernel.OptionsManager.getOption("ShortcutSetDefault"))
            {
                this._cbSetList.selectedIndex = _loc4;
            } // end if
        } // end while
        var _loc5 = this.api.lang.getKeyboardShortcutsCategories();
        _loc5.sortOn("o", Array.NUMERIC);
        var _loc6 = this.api.lang.getKeyboardShortcuts();
        var _loc7 = new ank.utils.ExtendedArray();
        var _loc8 = 0;
        
        while (++_loc8, _loc8 < _loc5.length)
        {
            if (_loc5[_loc8] == undefined)
            {
                continue;
            } // end if
            _loc7.push({c: true, d: _loc5[_loc8].d});
            for (var k in _loc6)
            {
                if (_loc6[k] == undefined)
                {
                    continue;
                } // end if
                if (k == "CONSOLE" && !this.api.datacenter.Player.isAuthorized)
                {
                    continue;
                } // end if
                if (_loc6[k].c == _loc5[_loc8].i)
                {
                    _loc7.push({c: false, d: _loc6[k].d, s: this.api.kernel.KeyManager.getCurrentShortcut(k), k: k, l: _loc6[k].s});
                } // end if
            } // end of for...in
        } // end while
        this._lstShortcuts.dataProvider = _loc7;
        this._cbSetList.dataProvider = _loc2;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            case "_btnClose2":
            {
                this.callClose();
                break;
            } 
            case "_btnApplyDefault":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("SHORTCUTS_RESET_TO_DEFAULT"), "CAUTION_YESNO", {listener: this});
                break;
            } 
        } // End of switch
    };
    _loc1.itemSelected = function (oEvent)
    {
        this.api.kernel.OptionsManager.setOption("ShortcutSetDefault", this._cbSetList.selectedItem.id);
    };
    _loc1.yes = function (oEvent)
    {
        this.api.kernel.KeyManager.clearCustomShortcuts();
        this.api.kernel.OptionsManager.setOption("ShortcutSet", this._cbSetList.selectedItem.id);
        this.initData();
    };
    _loc1.refresh = function ()
    {
        this.initData();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Shortcuts = function ()
    {
        super();
    }).CLASS_NAME = "Shortcuts";
} // end if
#endinitclip
