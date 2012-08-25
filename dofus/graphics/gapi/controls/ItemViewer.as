// Action script...

// [Initial MovieClip Action of sprite 20980]
#initclip 245
if (!dofus.graphics.gapi.controls.ItemViewer)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.ItemViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__useButton = function (bUseButton)
    {
        this._bUseButton = bUseButton;
        //return (this.useButton());
    };
    _loc1.__get__useButton = function ()
    {
        return (this._bUseButton);
    };
    _loc1.__set__destroyButton = function (bDestroyButton)
    {
        this._bDestroyButton = bDestroyButton;
        //return (this.destroyButton());
    };
    _loc1.__get__destroyButton = function ()
    {
        return (this._bDestroyButton);
    };
    _loc1.__set__targetButton = function (bTargetButton)
    {
        this._bTargetButton = bTargetButton;
        //return (this.targetButton());
    };
    _loc1.__get__targetButton = function ()
    {
        return (this._bTargetButton);
    };
    _loc1.__set__displayPrice = function (bDisplayPrice)
    {
        this._bPrice = bDisplayPrice;
        this._lblPrice._visible = bDisplayPrice;
        this._mcKamaSymbol._visible = bDisplayPrice;
        //return (this.displayPrice());
    };
    _loc1.__get__displayPrice = function ()
    {
        return (this._bPrice);
    };
    _loc1.__set__hideDesc = function (bDisplayDesc)
    {
        this._bDesc = !bDisplayDesc;
        this._txtDescription._visible = this._bDesc;
        this._txtDescription.scrollBarRight = this._bDesc;
        //return (this.hideDesc());
    };
    _loc1.__get__hideDesc = function ()
    {
        return (this._bDesc);
    };
    _loc1.__set__itemData = function (oItem)
    {
        this._oItem = oItem;
        this.addToQueue({object: this, method: this.showItemData, params: [oItem]});
        //return (this.itemData());
    };
    _loc1.__get__itemData = function ()
    {
        return (this._oItem);
    };
    _loc1.__set__displayWidth = function (nDisplayWidth)
    {
        this._nDisplayWidth = Math.max(316, nDisplayWidth + 2);
        //return (this.displayWidth());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ItemViewer.CLASS_NAME);
    };
    _loc1.arrange = function ()
    {
        this._lstInfos._width = this._nDisplayWidth - this._lstInfos._x;
        this._txtDescription._width = this._nDisplayWidth - this._txtDescription._x - 1;
        this._mcTitle._width = this._nDisplayWidth - this._mcTitle._x;
        this._lblLevel._x = this._nDisplayWidth - (316 - this._lblLevel._x);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this._btnTabCharacteristics._visible = false;
        this._pbEthereal._visible = false;
        this._ldrTwoHanded._visible = false;
    };
    _loc1.initTexts = function ()
    {
        this._btnTabEffects.label = this.api.lang.getText("EFFECTS");
        this._btnTabConditions.label = this.api.lang.getText("CONDITIONS");
        this._btnTabCharacteristics.label = this.api.lang.getText("CHARACTERISTICS");
    };
    _loc1.addListeners = function ()
    {
        this._btnAction.addEventListener("click", this);
        this._btnAction.addEventListener("over", this);
        this._btnAction.addEventListener("out", this);
        this._btnTabEffects.addEventListener("click", this);
        this._btnTabCharacteristics.addEventListener("click", this);
        this._btnTabConditions.addEventListener("click", this);
        this._pbEthereal.addEventListener("over", this);
        this._pbEthereal.addEventListener("out", this);
        this._ldrTwoHanded.onRollOver = function ()
        {
            this._parent.over({target: this});
        };
        this._ldrTwoHanded.onRollOut = function ()
        {
            this._parent.out({target: this});
        };
    };
    _loc1.showItemData = function (oItem)
    {
        if (oItem != undefined)
        {
            this._lblName.text = oItem.name;
            if (dofus.Constants.DEBUG)
            {
                this._lblName.text = this._lblName.text + (" (" + oItem.unicID + ")");
            } // end if
            if (oItem.style == "")
            {
                this._lblName.styleName = "WhiteLeftMediumBoldLabel";
            }
            else
            {
                this._lblName.styleName = oItem.style + "LeftMediumBoldLabel";
            } // end else if
            this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL") + oItem.level;
            this._txtDescription.text = oItem.description;
            this._ldrIcon.contentParams = oItem.params;
            this._ldrIcon.contentPath = oItem.iconFile;
            this.updateCurrentTabInformations();
            if (oItem.superType == 2)
            {
                this._btnTabCharacteristics._visible = true;
            }
            else
            {
                if (this._sCurrentTab == "Characteristics")
                {
                    this.setCurrentTab("Effects");
                } // end if
                this._btnTabCharacteristics._visible = false;
            } // end else if
            this._lblPrice.text = oItem.price == undefined ? ("") : (new ank.utils.ExtendedString(oItem.price).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3));
            this._lblWeight.text = oItem.weight + " " + ank.utils.PatternDecoder.combine(this._parent.api.lang.getText("PODS"), "m", oItem.weight < 2);
            if (oItem.isEthereal)
            {
                var _loc3 = oItem.etherealResistance;
                this._pbEthereal.maximum = _loc3.param3;
                this._pbEthereal.value = _loc3.param2;
                this._pbEthereal._visible = true;
                if (_loc3.param2 < 4)
                {
                    this._pbEthereal.styleName = "EtherealCriticalProgressBar";
                }
                else
                {
                    this._pbEthereal.styleName = "EtherealNormalProgressBar";
                } // end else if
            }
            else
            {
                this._pbEthereal._visible = false;
            } // end else if
            this._ldrTwoHanded._visible = oItem.needTwoHands;
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblLevel.text = "";
            this._txtDescription.text = "";
            this._ldrIcon.contentPath = "";
            this._lstInfos.removeAll();
            this._lblPrice.text = "";
            this._lblWeight.text = "";
            this._pbEthereal._visible = false;
            this._ldrTwoHanded._visible = false;
        } // end else if
    };
    _loc1.updateCurrentTabInformations = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        switch (this._sCurrentTab)
        {
            case "Effects":
            {
                for (var s in this._oItem.effects)
                {
                    if (this._oItem.effects[s].description.length > 0)
                    {
                        _loc2.push(this._oItem.effects[s]);
                    } // end if
                } // end of for...in
                break;
            } 
            case "Characteristics":
            {
                for (var s in this._oItem.characteristics)
                {
                    if (this._oItem.characteristics[s].length > 0)
                    {
                        _loc2.push(this._oItem.characteristics[s]);
                    } // end if
                } // end of for...in
                break;
            } 
            case "Conditions":
            {
                for (var s in this._oItem.conditions)
                {
                    if (this._oItem.conditions[s].length > 0)
                    {
                        _loc2.push(this._oItem.conditions[s]);
                    } // end if
                } // end of for...in
                break;
            } 
        } // End of switch
        _loc2.reverse();
        this._lstInfos.dataProvider = _loc2;
    };
    _loc1.setCurrentTab = function (sNewTab)
    {
        var _loc3 = this["_btnTab" + this._sCurrentTab];
        var _loc4 = this["_btnTab" + sNewTab];
        _loc3.selected = true;
        _loc3.enabled = true;
        _loc4.selected = false;
        _loc4.enabled = false;
        this._sCurrentTab = sNewTab;
        this.updateCurrentTabInformations();
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnTabEffects":
            {
                this.setCurrentTab("Effects");
                break;
            } 
            case "_btnTabCharacteristics":
            {
                this.setCurrentTab("Characteristics");
                break;
            } 
            case "_btnTabConditions":
            {
                this.setCurrentTab("Conditions");
                break;
            } 
            case "_btnAction":
            {
                var _loc3 = this.api.ui.createPopupMenu();
                _loc3.addStaticItem(this._oItem.name);
                if (this._bUseButton && this._oItem.canUse)
                {
                    _loc3.addItem(this._parent.api.lang.getText("CLICK_TO_USE"), this, this.dispatchEvent, [{type: "useItem", item: this._oItem}]);
                } // end if
                _loc3.addItem(this._parent.api.lang.getText("CLICK_TO_INSERT"), this.api.kernel.GameManager, this.api.kernel.GameManager.insertItemInChat, [this._oItem]);
                if (this._bTargetButton && this._oItem.canTarget)
                {
                    _loc3.addItem(this._parent.api.lang.getText("CLICK_TO_TARGET"), this, this.dispatchEvent, [{type: "targetItem", item: this._oItem}]);
                } // end if
                _loc3.addItem(this._parent.api.lang.getText("ASSOCIATE_RECEIPTS"), this.api.ui, this.api.ui.loadUIComponent, ["ItemUtility", "ItemUtility", {item: this._oItem}]);
                if (this._bDestroyButton && this._oItem.canDestroy)
                {
                    _loc3.addItem(this._parent.api.lang.getText("CLICK_TO_DESTROY"), this, this.dispatchEvent, [{type: "destroyItem", item: this._oItem}]);
                } // end if
                _loc3.show(_root._xmouse, _root._ymouse);
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_pbEthereal":
            {
                var _loc3 = this._oItem.etherealResistance;
                this.gapi.showTooltip(_loc3.description, oEvent.target, -20);
                break;
            } 
            case "_ldrTwoHanded":
            {
                this.gapi.showTooltip(this.api.lang.getText("TWO_HANDS_WEAPON"), this._ldrTwoHanded, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("targetButton", _loc1.__get__targetButton, _loc1.__set__targetButton);
    _loc1.addProperty("useButton", _loc1.__get__useButton, _loc1.__set__useButton);
    _loc1.addProperty("displayPrice", _loc1.__get__displayPrice, _loc1.__set__displayPrice);
    _loc1.addProperty("displayWidth", function ()
    {
    }, _loc1.__set__displayWidth);
    _loc1.addProperty("itemData", _loc1.__get__itemData, _loc1.__set__itemData);
    _loc1.addProperty("hideDesc", _loc1.__get__hideDesc, _loc1.__set__hideDesc);
    _loc1.addProperty("destroyButton", _loc1.__get__destroyButton, _loc1.__set__destroyButton);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ItemViewer = function ()
    {
        super();
    }).CLASS_NAME = "ItemViewer";
    _loc1._nDisplayWidth = 316;
    _loc1._bUseButton = false;
    _loc1._bDestroyButton = false;
    _loc1._bTargetButton = false;
    _loc1._sCurrentTab = "Effects";
} // end if
#endinitclip
