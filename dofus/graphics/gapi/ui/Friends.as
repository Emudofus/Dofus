// Action script...

// [Initial MovieClip Action of sprite 982]
#initclip 197
class dofus.graphics.gapi.ui.Friends extends ank.gapi.core.UIAdvancedComponent
{
    var _dgOnLine, _dgOffLine, __get__friendsList, _svSpouse, _mcSpousePlacer, attachMovie, __get__spouse, api, gapi, unloadThis, addToQueue, _winBg, _lblOnLine, _lblOffLine, _btnAdd, _lblAddFriend, _btnClose, _itAddFriend, __set__friendsList, __set__spouse;
    function Friends()
    {
        super();
    } // End of the function
    function set friendsList(aFriends)
    {
        var _loc5 = new ank.utils.ExtendedArray();
        var _loc6 = new ank.utils.ExtendedArray();
        for (var _loc3 = 0; _loc3 < aFriends.length; ++_loc3)
        {
            var _loc2 = aFriends[_loc3];
            if (_loc2.account.length == 0)
            {
                continue;
            } // end if
            if (_loc2.state != "DISCONNECT")
            {
                _loc5.push(_loc2);
                continue;
            } // end if
            _loc6.push(_loc2);
        } // end of for
        _dgOnLine.__set__dataProvider(_loc5);
        _dgOffLine.__set__dataProvider(_loc6);
        //return (this.friendsList());
        null;
    } // End of the function
    function set spouse(oSpouse)
    {
        if (_svSpouse != undefined)
        {
            _svSpouse.swapDepths(_mcSpousePlacer);
            _svSpouse.removeMovieClip();
        } // end if
        this.attachMovie("SpouseViewer", "_svSpouse", 10, {_x: _mcSpousePlacer._x, _y: _mcSpousePlacer._y, spouse: oSpouse});
        _svSpouse.swapDepths(_mcSpousePlacer);
        //return (this.spouse());
        null;
    } // End of the function
    function removeFriend(sName)
    {
        api.network.Friends.removeFriend(sName);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Friends.CLASS_NAME);
        gapi.getUIComponent("Banner").chatAutoFocus = false;
    } // End of the function
    function destroy()
    {
        gapi.getUIComponent("Banner").chatAutoFocus = true;
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: setTextFocus});
        api.network.Friends.getFriendsList();
        _mcSpousePlacer._visible = false;
    } // End of the function
    function initTexts()
    {
        _winBg.__set__title(api.lang.getText("FRIENDS"));
        _dgOnLine.__set__columnsNames(["", api.lang.getText("ACCOUNT") + " (" + api.lang.getText("NAME") + ")", api.lang.getText("LEVEL")]);
        _dgOffLine.__set__columnsNames([api.lang.getText("ACCOUNT")]);
        _lblOnLine.__set__text(api.lang.getText("ONLINE"));
        _lblOffLine.__set__text(api.lang.getText("OFFLINE"));
        _btnAdd.__set__label(api.lang.getText("ADD"));
        _lblAddFriend.__set__text(api.lang.getText("ADD_A_FRIEND"));
    } // End of the function
    function addListeners()
    {
        _btnAdd.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
        _dgOnLine.addEventListener("itemSelected", this);
        Key.addListener(this);
    } // End of the function
    function setTextFocus()
    {
        _itAddFriend.setFocus();
    } // End of the function
    function onKeyDown()
    {
        if (Key.getCode() == 13 && _itAddFriend.__get__focused())
        {
            this.click({target: _btnAdd});
        } // end if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnAdd":
            {
                if (_itAddFriend.text.length != 0)
                {
                    api.network.Friends.addFriend("%" + _itAddFriend.__get__text());
                    _itAddFriend.__set__text("");
                    api.network.Friends.getFriendsList();
                } // end if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    } // End of the function
    function itemSelected(oEvent)
    {
        api.kernel.GameManager.askPrivateMessage(oEvent.target.item.name);
    } // End of the function
    static var CLASS_NAME = "Friends";
} // End of Class
#endinitclip
