// Action script...

// [Initial MovieClip Action of sprite 1073]
#initclip 43
class dofus.graphics.gapi.ui.friends.FriendsDisconnectedItem extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _oItem, _lblName, _btnRemove, addToQueue, __set__list;
    function FriendsDisconnectedItem()
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
            _lblName.__set__text(oItem.account);
            _btnRemove._visible = true;
        }
        else
        {
            _lblName.__set__text("");
            _btnRemove._visible = false;
        } // end else if
    } // End of the function
    function remove()
    {
        _oItem.owner.removeFriend(_oItem.name);
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
