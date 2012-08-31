// Action script...

// [Initial MovieClip Action of sprite 815]
#initclip 22
class dofus.graphics.gapi.controls.ItemViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _btnUseItem, __get__useButton, _btnDestroyItem, __get__destroyButton, _btnTargetItem, __get__targetButton, _bPrice, _lblPrice, _mcKamaSymbol, __get__displayPrice, _oItem, addToQueue, __get__itemData, _btnTabCharacteristics, _pbEthereal, api, _btnTabEffects, _btnTabConditions, _lblName, _lblLevel, _txtDescription, _ldrIcon, _parent, _lblWeight, _lstInfos, dispatchEvent, gapi, __set__destroyButton, __set__displayPrice, __set__itemData, __set__targetButton, __set__useButton;
    function ItemViewer()
    {
        super();
    } // End of the function
    function set useButton(bUseButton)
    {
        _bUseButton = bUseButton;
        _btnUseItem._visible = bUseButton;
        //return (this.useButton());
        null;
    } // End of the function
    function get useButton()
    {
        return (_bUseButton);
    } // End of the function
    function set destroyButton(bDestroyButton)
    {
        _bDestroyButton = bDestroyButton;
        _btnDestroyItem._visible = bDestroyButton;
        //return (this.destroyButton());
        null;
    } // End of the function
    function get destroyButton()
    {
        return (_bDestroyButton);
    } // End of the function
    function set targetButton(bTargetButton)
    {
        _bTargetButton = bTargetButton;
        _btnTargetItem._visible = bTargetButton;
        //return (this.targetButton());
        null;
    } // End of the function
    function get targetButton()
    {
        return (_bTargetButton);
    } // End of the function
    function set displayPrice(bDisplayPrice)
    {
        _bPrice = bDisplayPrice;
        _lblPrice._visible = bDisplayPrice;
        _mcKamaSymbol._visible = bDisplayPrice;
        //return (this.displayPrice());
        null;
    } // End of the function
    function get displayPrice()
    {
        return (_bPrice);
    } // End of the function
    function set itemData(oItem)
    {
        _oItem = oItem;
        this.addToQueue({object: this, method: showItemData, params: [oItem]});
        //return (this.itemData());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.ItemViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _btnUseItem._visible = false;
        _btnDestroyItem._visible = false;
        _btnTargetItem._visible = false;
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        _btnTabCharacteristics._visible = false;
        _pbEthereal._visible = false;
    } // End of the function
    function initTexts()
    {
        _btnTabEffects.__set__label(api.lang.getText("EFFECTS"));
        _btnTabConditions.__set__label(api.lang.getText("CONDITIONS"));
        _btnTabCharacteristics.__set__label(api.lang.getText("CHARACTERISTICS"));
    } // End of the function
    function addListeners()
    {
        _btnUseItem.addEventListener("click", this);
        _btnUseItem.addEventListener("over", this);
        _btnUseItem.addEventListener("out", this);
        _btnDestroyItem.addEventListener("click", this);
        _btnDestroyItem.addEventListener("over", this);
        _btnDestroyItem.addEventListener("out", this);
        _btnTargetItem.addEventListener("click", this);
        _btnTargetItem.addEventListener("over", this);
        _btnTargetItem.addEventListener("out", this);
        _btnTabEffects.addEventListener("click", this);
        _btnTabCharacteristics.addEventListener("click", this);
        _btnTabConditions.addEventListener("click", this);
        _pbEthereal.addEventListener("over", this);
        _pbEthereal.addEventListener("out", this);
    } // End of the function
    function showItemData(oItem)
    {
        if (oItem != undefined)
        {
            _lblName.__set__text(oItem.name);
            if (oItem.style == "")
            {
                _lblName.__set__styleName("WhiteLeftMediumBoldLabel");
            }
            else
            {
                _lblName.__set__styleName(oItem.style + "LeftMediumBoldLabel");
            } // end else if
            _lblLevel.__set__text(api.lang.getText("LEVEL_SMALL") + oItem.level);
            _txtDescription.__set__text(oItem.description);
            _ldrIcon.__set__contentPath(oItem.iconFile);
            this.updateCurrentTabInformations();
            if (oItem.superType == 2)
            {
                _btnTabCharacteristics._visible = true;
            }
            else
            {
                if (_sCurrentTab == "Characteristics")
                {
                    this.setCurrentTab("Effects");
                } // end if
                _btnTabCharacteristics._visible = false;
            } // end else if
            _lblPrice.__set__text(oItem.price == undefined ? ("") : (String(oItem.price).addMiddleChar(api.lang.getConfigText("THOUSAND_SEPARATOR"), 3)));
            _lblWeight.__set__text(oItem.weight + " " + ank.utils.PatternDecoder.combine(_parent.api.lang.getText("PODS"), "m", oItem.weight < 2));
            _btnUseItem._visible = _bUseButton && oItem.canUse;
            _btnDestroyItem._visible = _bDestroyButton && oItem.canDestroy;
            _btnTargetItem._visible = _bTargetButton && oItem.canTarget;
            if (oItem.isEthereal)
            {
                var _loc3 = oItem.etherealResistance;
                _pbEthereal.__set__maximum(_loc3.param3);
                _pbEthereal.__set__value(_loc3.param2);
                _pbEthereal._visible = true;
                if (_loc3.param2 < 4)
                {
                    _pbEthereal.__set__styleName("EtherealCriticalProgressBar");
                }
                else
                {
                    _pbEthereal.__set__styleName("EtherealNormalProgressBar");
                } // end else if
            }
            else
            {
                _pbEthereal._visible = false;
            } // end else if
        }
        else
        {
            _lblName.__set__text("");
            _lblLevel.__set__text("");
            _txtDescription.__set__text("");
            _ldrIcon.__set__contentPath("");
            _lstInfos.removeAll();
            _lblPrice.__set__text("");
            _lblWeight.__set__text("");
            _btnUseItem._visible = false;
            _btnDestroyItem._visible = false;
            _btnTargetItem._visible = false;
            _pbEthereal._visible = false;
        } // end else if
    } // End of the function
    function updateCurrentTabInformations()
    {
        switch (_sCurrentTab)
        {
            case "Effects":
            {
                _lstInfos.__set__dataProvider(_oItem.effects);
                break;
            } 
            case "Characteristics":
            {
                _lstInfos.__set__dataProvider(_oItem.characteristics);
                break;
            } 
            case "Conditions":
            {
                _lstInfos.__set__dataProvider(_oItem.conditions);
                break;
            } 
        } // End of switch
    } // End of the function
    function setCurrentTab(sNewTab)
    {
        var _loc2 = this["_btnTab" + _sCurrentTab];
        var _loc3 = this["_btnTab" + sNewTab];
        _loc2.__set__selected(true);
        _loc2.__set__enabled(true);
        _loc3.__set__selected(false);
        _loc3.__set__enabled(false);
        _sCurrentTab = sNewTab;
        this.updateCurrentTabInformations();
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnUseItem":
            {
                this.dispatchEvent({type: "useItem", item: _oItem});
                break;
            } 
            case "_btnDestroyItem":
            {
                this.dispatchEvent({type: "destroyItem", item: _oItem});
                break;
            } 
            case "_btnTargetItem":
            {
                this.dispatchEvent({type: "targetItem", item: _oItem});
                break;
            } 
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
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnUseItem":
            {
                gapi.showTooltip(_parent.api.lang.getText("CLICK_TO_USE"), _btnUseItem, -20);
                break;
            } 
            case "_btnDestroyItem":
            {
                gapi.showTooltip(_parent.api.lang.getText("CLICK_TO_DESTROY"), _btnDestroyItem, -20);
                break;
            } 
            case "_btnTargetItem":
            {
                gapi.showTooltip(_parent.api.lang.getText("CLICK_TO_TARGET"), _btnTargetItem, -20);
                break;
            } 
            case "_pbEthereal":
            {
                var _loc2 = _oItem.etherealResistance;
                gapi.showTooltip(_loc2.description, _btnTargetItem, -20);
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    static var CLASS_NAME = "ItemViewer";
    var _bUseButton = false;
    var _bDestroyButton = false;
    var _bTargetButton = false;
    var _sCurrentTab = "Effects";
} // End of Class
#endinitclip
