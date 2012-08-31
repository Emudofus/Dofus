// Action script...

// [Initial MovieClip Action of sprite 1017]
#initclip 238
class dofus.graphics.gapi.controls.SpellBoostViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _oSpell, __get__initialized, __get__spell, addToQueue, api, _lblNew, _ldrIcon, _lblName, _lblLevel1, _lblAP1, _lblRange1, _txtDamages1, _txtCritical1, _mcArrowCritical, _lblLevel2, _lblAP2, _lblRange2, _txtDamages2, _txtCritical2, __set__spell;
    function SpellBoostViewer()
    {
        super();
    } // End of the function
    function set spell(oSpell)
    {
        _oSpell = oSpell;
        if (this.__get__initialized())
        {
            this.initData();
        } // end if
        //return (this.spell());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.SpellBoostViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
    } // End of the function
    function initData()
    {
        this.updateData();
    } // End of the function
    function initTexts()
    {
        _lblNew.__set__text(api.lang.getText("NEW_CHARACTERISTICS"));
    } // End of the function
    function updateData()
    {
        if (_oSpell != undefined)
        {
            _ldrIcon.__set__contentPath(_oSpell.iconFile);
            _lblName.__set__text(_oSpell.name);
            _lblLevel1.__set__text(api.lang.getText("LEVEL") + " " + _oSpell.level);
            _lblAP1.__set__text(_oSpell.apCost + " " + api.lang.getText("AP"));
            _lblRange1.__set__text(_oSpell.rangeStr + " " + api.lang.getText("RANGE"));
            _txtDamages1.__set__text(_oSpell.descriptionNormalHit);
            _txtCritical1.__set__text(_oSpell.descriptionCriticalHit == undefined ? ("") : (_oSpell.descriptionCriticalHit));
            _mcArrowCritical._visible = _oSpell.descriptionCriticalHit != undefined;
            _oSpell.level = _oSpell.level + 1;
            _lblLevel2.__set__text(api.lang.getText("LEVEL") + " " + _oSpell.level);
            _lblAP2.__set__text(_oSpell.apCost + " " + api.lang.getText("AP"));
            _lblRange2.__set__text(_oSpell.rangeStr + " " + api.lang.getText("RANGE"));
            _txtDamages2.__set__text(_oSpell.descriptionNormalHit);
            _txtCritical2.__set__text(_oSpell.descriptionCriticalHit == undefined ? ("") : (_oSpell.descriptionCriticalHit));
            _oSpell.level = _oSpell.level - 1;
        } // end if
    } // End of the function
    static var CLASS_NAME = "SpellBoostViewer";
} // End of Class
#endinitclip
