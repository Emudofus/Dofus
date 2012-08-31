// Action script...

// [Initial MovieClip Action of sprite 1074]
#initclip 44
class dofus.graphics.gapi.ui.friends.FriendsConnectedItem extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _oItem, _lblName, _lblLevel, _mcFight, _ldrGuild, _btnRemove, addToQueue, __set__list;
    function FriendsConnectedItem()
    {
        super();
    } // End of the function
    function set list(mcList)
    {
        _mcList = mcList;
        //return (this.list());
        null;
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            _oItem = oItem;
            _lblName.__set__text(oItem.account + " (" + oItem.name + ")");
            _lblLevel.__set__text(oItem.level);
            _mcFight._visible = oItem.state == "IN_MULTI";
            _ldrGuild.__set__contentPath(dofus.Constants.GUILDS_MINI_PATH + oItem.gfxID + ".swf");
            _btnRemove._visible = true;
        }
        else
        {
            _lblName.__set__text("");
            _lblLevel.__set__text("");
            _mcFight._visible = false;
            _ldrGuild.__set__contentPath("");
            _btnRemove._visible = false;
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
        _btnRemove.addEventListener("click", this);
    } // End of the function
    function click(oEvent)
    {
        _mcList._parent._parent.removeFriend("*" + _oItem.account);
    } // End of the function
} // End of Class
#endinitclip
