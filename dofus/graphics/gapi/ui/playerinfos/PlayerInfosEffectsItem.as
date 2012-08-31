// Action script...

// [Initial MovieClip Action of sprite 1078]
#initclip 48
class dofus.graphics.gapi.ui.playerinfos.PlayerInfosEffectsItem extends ank.gapi.core.UIBasicComponent
{
    var _ldrIcon, _lblDescription, _lblRemainingTurn, _lblSpell, _oItem, addToQueue;
    function PlayerInfosEffectsItem()
    {
        super();
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            _ldrIcon.forceNextLoad();
            _ldrIcon.__set__contentPath(dofus.Constants.EFFECTSICON_FILE);
            _lblDescription.__set__text(oItem.description);
            _lblRemainingTurn.__set__text(oItem.remainingTurnStr);
            _lblSpell.__set__text(oItem.spellName);
            _oItem = oItem;
        }
        else
        {
            _ldrIcon.__set__contentPath("");
            _lblDescription.__set__text("");
            _lblRemainingTurn.__set__text("");
            _lblSpell.__set__text("");
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function addListeners()
    {
        _ldrIcon.addEventListener("initialization", this);
    } // End of the function
    function initialization(oEvent)
    {
        _ldrIcon.content.attachMovie("Icon_" + _oItem.characteristic, "_mcIcon", 10, {operator: _oItem.operator});
    } // End of the function
} // End of Class
#endinitclip
