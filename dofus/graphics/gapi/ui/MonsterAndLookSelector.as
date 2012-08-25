// Action script...

// [Initial MovieClip Action of sprite 20734]
#initclip 255
if (!dofus.graphics.gapi.ui.MonsterAndLookSelector)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.MonsterAndLookSelector = function ()
    {
        super();
    }).prototype;
    _loc1.__set__monster = function (bMonster)
    {
        this._bMonster = bMonster;
        //return (this.monster());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.MonsterAndLookSelector.CLASS_NAME);
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
        this.addToQueue({object: this, method: this.initAnimList});
        if (this._bMonster)
        {
            this.addToQueue({object: this, method: this.loadMonsters});
        }
        else
        {
            this.addToQueue({object: this, method: this.loadLooks});
        } // end else if
    };
    _loc1.initTexts = function ()
    {
        if (this._bMonster)
        {
            this._winBg.title = "Liste des monstres";
        }
        else
        {
            this._winBg.title = "Liste des look";
        } // end else if
        this._lblType.text = this.api.lang.getText("TYPE");
        this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
        this._btnSelect.label = this.api.lang.getText("SELECT");
        this._btnSearch.label = this.api.lang.getText("OK");
        this._tiSearch.text = this._tiSearch.text.length ? (this._tiSearch.text) : ("Recherche...");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnCancel.addEventListener("click", this);
        this._btnSelect.addEventListener("click", this);
        this._cbType.addEventListener("itemSelected", this);
        this._cbAnim.addEventListener("itemSelected", this);
        this._cg.addEventListener("selectItem", this);
        this._cg.addEventListener("overItem", this);
        this._cg.addEventListener("outItem", this);
        this._cg.addEventListener("dblClickItem", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
        this._btnSearch.addEventListener("click", this);
        var ref = this;
        var _loc2 = new Object();
        _loc2.onSetFocus = function (oldFocus_txt, newFocus_txt)
        {
            if (Selection.getFocus()._parent == ref._tiSearch)
            {
                if (ref._tiSearch.text == "Recherche...")
                {
                    ref._tiSearch.text = "";
                } // end if
            }
            else if (ref._tiSearch.text == "")
            {
                ref._tiSearch.text = "Recherche...";
            } // end else if
        };
        Selection.addListener(_loc2);
    };
    _loc1.initAnimList = function (eaTypes)
    {
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < dofus.graphics.gapi.ui.MonsterAndLookSelector.ANIM_LIST.length)
        {
            _loc3.push({label: dofus.graphics.gapi.ui.MonsterAndLookSelector.ANIM_LIST[_loc4]});
        } // end while
        this._cbAnim.dataProvider = _loc3;
    };
    _loc1.initData = function (eaTypes)
    {
        this._cciSprite.deleteButton = false;
        this._eaTypes = eaTypes;
        eaTypes.sortOn("label");
        this._cbType.dataProvider = eaTypes;
    };
    _loc1.loadLooks = function ()
    {
        var ui = this;
        var _loc2 = new XML();
        _loc2.ignoreWhite = true;
        _loc2.onLoad = function ()
        {
            var _loc2 = dofus.Constants.ARTWORKS_BIG_PATH;
            var _loc3 = new ank.utils.ExtendedArray();
            var _loc4 = new ank.utils.ExtendedArray();
            for (var _loc5 = this.firstChild.firstChild; _loc5 != undefined; _loc5 = _loc5.nextSibling)
            {
                var _loc6 = _loc5.attributes.name;
                var _loc7 = new ank.utils.ExtendedArray();
                for (var _loc8 = _loc5.firstChild; _loc8 != undefined; _loc8 = _loc8.nextSibling)
                {
                    var _loc9 = _loc8.attributes.id;
                    var _loc10 = _loc8.attributes.name;
                    var _loc11 = {iconFile: _loc2 + _loc9 + ".swf", name: _loc10, id: _loc9, gfxId: _loc9};
                    _loc7.push(_loc11);
                    _loc4.push(_loc11);
                } // end of for
                _loc3.push({label: _loc6, data: _loc7});
            } // end of for
            _loc3.push({label: "-- ALL --", data: _loc4});
            ui.initData(_loc3);
        };
        _loc2.load(dofus.Constants.XML_SPRITE_LIST);
    };
    _loc1.loadMonsters = function (sFilter)
    {
        if (sFilter == undefined)
        {
            sFilter = "";
        } // end if
        var _loc3 = this.api.lang.getMonsters();
        var _loc4 = dofus.Constants.ARTWORKS_BIG_PATH;
        var _loc5 = new ank.utils.ExtendedArray();
        var _loc6 = new ank.utils.ExtendedArray();
        var _loc7 = new Object();
        for (var a in _loc3)
        {
            var _loc8 = _loc3[a];
            var _loc9 = _loc8.b;
            var _loc10 = _loc7[_loc9];
            if (_loc10 == undefined)
            {
                _loc10 = {label: this.api.lang.getMonstersRaceText(_loc9).n, data: new ank.utils.ExtendedArray()};
                _loc7[_loc9] = _loc10;
                _loc5.push(_loc10);
            } // end if
            var _loc11 = a;
            var _loc12 = _loc8.n;
            var _loc13 = _loc8.g;
            var _loc14 = {iconFile: _loc4 + _loc13 + ".swf", name: _loc12, id: _loc11, gfxId: _loc13};
            _loc6.push(_loc14);
            _loc10.data.push(_loc14);
        } // end of for...in
        _loc5.push({label: "-- ALL --", data: _loc6});
        this.initData(_loc5);
    };
    _loc1.select = function (oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        if (_loc3 != undefined)
        {
            if (this._bMonster)
            {
                this.dispatchEvent({type: "select", ui: "MonsterSelector", monsterId: _loc3.id});
            }
            else
            {
                this.dispatchEvent({type: "select", ui: "LookSelector", lookId: _loc3.id});
            } // end else if
            this.callClose();
        } // end if
    };
    _loc1.filterResult = function (sFilter)
    {
        var _loc3 = this._cbType.selectedItem.data;
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            var _loc6 = _loc3[_loc5].name;
            if (sFilter.length && (sFilter != "Recherche..." && (sFilter.length && _loc6.toUpperCase().indexOf(sFilter.toUpperCase()) == -1)))
            {
                continue;
            } // end if
            _loc4.push(_loc3[_loc5]);
        } // end while
        this._cg.dataProvider = _loc4;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            case "_btnCancel":
            {
                this.dispatchEvent({type: "cancel"});
                this.callClose();
            } 
            case "_btnSelect":
            {
                this.select({target: this._cg.selectedItem});
                break;
            } 
            case "_btnSearch":
            {
                this._cbType.selectedIndex = 0;
                this.filterResult(this._tiSearch.text);
                break;
            } 
        } // End of switch
    };
    _loc1.dblClickItem = function (oEvent)
    {
        this.select(oEvent);
    };
    _loc1.selectItem = function (oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        if (_loc3 != undefined)
        {
            this._cciSprite.data = {name: _loc3.name, gfxFile: dofus.Constants.CLIPS_PERSOS_PATH + _loc3.gfxId + ".swf", title: _loc3.id};
            this._cciSprite.enabled = true;
        }
        else
        {
            this._cciSprite.data = undefined;
            this._cciSprite.enabled = false;
        } // end else if
    };
    _loc1.overItem = function (oEvent)
    {
        if (oEvent.target.contentData != undefined)
        {
            this.gapi.showTooltip(oEvent.target.contentData.name + " (" + oEvent.target.contentData.id + ", GFX: " + oEvent.target.contentData.gfxId + ")", oEvent.target, -20);
        } // end if
    };
    _loc1.outItem = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._cbType:
            {
                var _loc3 = this._cbType.selectedItem.data;
                this._cg.dataProvider = _loc3;
                this._lblNumber.text = _loc3.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText(this._bMonster ? ("MONSTER") : ("LOOK")), "m", _loc3.length < 2);
                break;
            } 
            case this._cbAnim:
            {
                this._cciSprite.setAnim(this._cbAnim.selectedItem.label, true);
                break;
            } 
        } // End of switch
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG" && this._tiSearch.focused)
        {
            this.click({target: this._btnSearch});
            return (false);
        } // end if
        return (true);
    };
    _loc1.addProperty("monster", function ()
    {
    }, _loc1.__set__monster);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.MonsterAndLookSelector = function ()
    {
        super();
    }).CLASS_NAME = "MonsterAndLookSelector";
    (_global.dofus.graphics.gapi.ui.MonsterAndLookSelector = function ()
    {
        super();
    }).ANIM_LIST = ["static", "walk", "run", "hit", "bonus", "anim0", "anim1", "anim2", "anim3", "anim4", "anim5", "anim6", "anim7", "anim8", "anim9", "anim10", "anim11", "anim12", "anim12", "anim13", "anim14", "anim15", "anim16", "anim17", "anim18", "anim111", "anim112", "anim113", "anim114", "anim115", "anim116", "anim117", "emote1", "emote2", "emote3", "emote4", "emote5", "emote6", "emote7", "emote8", "emote9", "emote10", "emote11", "emote12", "emote13", "emote14", "emote15", "emote16", "emote17", "emote18", "emote19", "emote20", "emote21", "emoteStatic1", "emoteStatic14", "emoteStatic15", "emoteStatic16", "emoteStatic19", "emoteStatic20", "emoteStatic21", "die"];
} // end if
#endinitclip
