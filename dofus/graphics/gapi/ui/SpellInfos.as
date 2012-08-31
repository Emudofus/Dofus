// Action script...

// [Initial MovieClip Action of sprite 1034]
#initclip 256
class dofus.graphics.gapi.ui.SpellInfos extends ank.gapi.core.UIAdvancedComponent
{
    var _oSpell, __get__initialized, __get__spell, unloadThis, addToQueue, _bghBackground, _sfivSpellFullInfosViewer, __set__spell;
    function SpellInfos()
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
            this.initData();
        } // end if
        //return (this.spell());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.SpellInfos.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
    } // End of the function
    function addListeners()
    {
        _bghBackground.addEventListener("click", this);
        _sfivSpellFullInfosViewer.addEventListener("close", this);
    } // End of the function
    function initData()
    {
        if (_oSpell != undefined)
        {
            _sfivSpellFullInfosViewer.__set__spell(_oSpell);
        } // end if
    } // End of the function
    function click(oEvent)
    {
        this.unloadThis();
    } // End of the function
    function close(oEvent)
    {
        this.unloadThis();
    } // End of the function
    static var CLASS_NAME = "SpellInfos";
} // End of Class
#endinitclip
