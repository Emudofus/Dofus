// Action script...

// [Initial MovieClip Action of sprite 1015]
#initclip 236
class dofus.graphics.gapi.controls.SpellInfosViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _oSpell, __get__initialized, __get__spell, addToQueue, api, _lblEffectsTitle, _lblCriticalHitTitle, _lblHelp, _lblName, _lblLevel, _lblRange, _lblAP, _txtDescription, _txtEffects, _txtCriticalHit, _ldrIcon, __set__spell;
    function SpellInfosViewer()
    {
        super();
    } // End of the function
    function set spell(oSpell)
    {
        if (oSpell == _oSpell)
        {
            return;
        } // end if
        _oSpell = oSpell;
        if (this.__get__initialized())
        {
            this.updateData();
        } // end if
        //return (this.spell());
        null;
    } // End of the function
    function get spell()
    {
        return (_oSpell);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.SpellInfosViewer.CLASS_NAME);
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
        _lblEffectsTitle.__set__text(api.lang.getText("EFFECTS") + " :");
        _lblCriticalHitTitle.__set__text(api.lang.getText("CRITICAL_HIT") + " :");
        _lblHelp.__set__text(api.lang.getText("HOW_GET_DETAILS"));
    } // End of the function
    function updateData()
    {
        if (_oSpell != undefined)
        {
            _lblCriticalHitTitle._visible = _oSpell.descriptionCriticalHit != undefined;
            _lblName.__set__text(_oSpell.name);
            _lblLevel.__set__text(api.lang.getText("LEVEL") + " " + _oSpell.level);
            _lblRange.__set__text((_oSpell.rangeMin != 0 ? (_oSpell.rangeMin + "-") : ("")) + _oSpell.rangeMax + " " + api.lang.getText("RANGE"));
            _lblAP.__set__text(_oSpell.apCost + " " + api.lang.getText("AP"));
            _txtDescription.__set__text(_oSpell.description);
            _txtEffects.__set__text(_oSpell.descriptionNormalHit);
            _txtCriticalHit.__set__text(_oSpell.descriptionCriticalHit != undefined ? (_oSpell.descriptionCriticalHit) : (""));
            _ldrIcon.__set__contentPath(_oSpell.iconFile);
        }
        else
        {
            _lblCriticalHitTitle._visible = false;
            _lblName.__set__text("");
            _lblLevel.__set__text("");
            _lblRange.__set__text("");
            _lblAP.__set__text("");
            _txtDescription.__set__text("");
            _txtEffects.__set__text("");
            _txtCriticalHit.__set__text("");
            _ldrIcon.__set__contentPath("");
        } // end else if
    } // End of the function
    static var CLASS_NAME = "SpellInfosViewer";
} // End of Class
#endinitclip
