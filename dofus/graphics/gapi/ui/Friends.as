// Action script...

// [Initial MovieClip Action of sprite 20915]
#initclip 180
if (!dofus.graphics.gapi.ui.Friends)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Friends = function ()
    {
        super();
    }).prototype;
    _loc1.__set__enemiesList = function (aEnemies)
    {
        if (this._sCurrentTab != "Enemies")
        {
            return;
        } // end if
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < aEnemies.length)
        {
            var _loc6 = aEnemies[_loc5];
            if (_loc6.account.length == 0)
            {
                continue;
            } // end if
            if (_loc6.state != "DISCONNECT")
            {
                _loc3.push(_loc6);
                continue;
            } // end if
            _loc4.push(_loc6);
        } // end while
        this._dgOnLine.dataProvider = _loc3;
        this._dgOffLine.dataProvider = _loc4;
        //return (this.enemiesList());
    };
    _loc1.__set__friendsList = function (aFriends)
    {
        if (this._sCurrentTab != "Friends")
        {
            return;
        } // end if
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < aFriends.length)
        {
            var _loc6 = aFriends[_loc5];
            if (_loc6.account.length == 0)
            {
                continue;
            } // end if
            if (_loc6.state != "DISCONNECT")
            {
                _loc3.push(_loc6);
                continue;
            } // end if
            _loc4.push(_loc6);
        } // end while
        this._dgOnLine.dataProvider = _loc3;
        if (!this.api.config.isStreaming)
        {
            this._dgOffLine.dataProvider = _loc4;
        } // end if
        //return (this.friendsList());
    };
    _loc1.__set__spouse = function (oSpouse)
    {
        if (this._svSpouse != undefined)
        {
            this._svSpouse.swapDepths(this._mcSpousePlacer);
            this._svSpouse.removeMovieClip();
        } // end if
        this.attachMovie("SpouseViewer", "_svSpouse", 10, {_x: this._mcSpousePlacer._x, _y: this._mcSpousePlacer._y, spouse: oSpouse});
        this._svSpouse.swapDepths(this._mcSpousePlacer);
        //return (this.spouse());
    };
    _loc1.removeFriend = function (sName)
    {
        switch (this._sCurrentTab)
        {
            case "Enemies":
            {
                this.api.network.Enemies.removeEnemy(sName);
                break;
            } 
            case "Friends":
            {
                this.api.network.Friends.removeFriend(sName);
                break;
            } 
            case "Ignore":
            {
                this.api.kernel.ChatManager.removeToBlacklist(sName);
                this.updateIgnoreList();
                break;
            } 
        } // End of switch
    };
    _loc1.updateIgnoreList = function ()
    {
        if (this._sCurrentTab != "Ignore")
        {
            return;
        } // end if
        var _loc2 = this.api.kernel.ChatManager.getBlacklist();
        var _loc3 = new ank.utils.ExtendedArray();
        for (var i in _loc2)
        {
            if (_loc2[i] == undefined)
            {
                continue;
            } // end if
            var _loc4 = new Object();
            _loc4.name = _loc2[i].sName;
            _loc4.gfxID = _loc2[i].nClass;
            _loc3.push(_loc4);
        } // end of for...in
        this._dgOffLine.dataProvider = new ank.utils.ExtendedArray();
        this._dgOnLine.dataProvider = _loc3;
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Friends.CLASS_NAME);
        this.gapi.getUIComponent("Banner").chatAutoFocus = false;
    };
    _loc1.destroy = function ()
    {
        this.gapi.getUIComponent("Banner").chatAutoFocus = true;
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
        this.addToQueue({object: this, method: this.setTextFocus});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.setCurrentTab, params: [this._sCurrentTab]});
        this.api.network.Friends.getFriendsList();
        this._mcSpousePlacer._visible = false;
    };
    _loc1.initTexts = function ()
    {
        switch (this._sCurrentTab)
        {
            case "Enemies":
            {
                this._winBg.title = this.api.lang.getText("ENEMIES");
                this._lblAddFriend.text = this.api.lang.getText("ADD_AN_ENEMY");
                this._lblInfo.text = this.api.lang.getText("FRIENDS_INFO_ENEMIES");
                this._dgOnLine.columnsNames = ["", this.api.lang.getText("ACCOUNT") + " (" + this.api.lang.getText("NAME") + ")", this.api.lang.getText("LEVEL"), "", ""];
                this._dgOffLine._visible = true;
                this._lblOffLine._visible = this._dgOffLine._visible;
                this._lblOnLine._visible = this._dgOffLine._visible;
                break;
            } 
            case "Friends":
            {
                this._winBg.title = this.api.lang.getText("FRIENDS");
                this._lblAddFriend.text = this.api.lang.getText("ADD_A_FRIEND");
                this._lblInfo.text = this.api.lang.getText("FRIENDS_INFO_FRIENDS");
                this._dgOnLine.columnsNames = ["", this.api.lang.getText("ACCOUNT") + " (" + this.api.lang.getText("NAME") + ")", this.api.lang.getText("LEVEL"), "", ""];
                this._dgOffLine._visible = true;
                this._lblOffLine._visible = this._dgOffLine._visible;
                this._lblOnLine._visible = this._dgOffLine._visible;
                break;
            } 
            case "Ignore":
            {
                this._winBg.title = this.api.lang.getText("IGNORED");
                this._lblAddFriend.text = this.api.lang.getText("ADD_A_IGNORED");
                this._lblInfo.text = this.api.lang.getText("FRIENDS_INFO_IGNORE");
                this._dgOnLine.columnsNames = ["", this.api.lang.getText("NAME").substr(0, 1).toUpperCase() + this.api.lang.getText("NAME").substr(1), "", ""];
                this._dgOffLine._visible = false;
                this._lblOffLine._visible = this._dgOffLine._visible;
                this._lblOnLine._visible = this._dgOffLine._visible;
                break;
            } 
        } // End of switch
        this._btnTabFriends.label = this.api.lang.getText("FRIENDS");
        this._btnTabEnemies.label = this.api.lang.getText("ENEMIES");
        this._btnTabIgnore.label = this.api.lang.getText("IGNORED");
        this._lblHelp.text = this.api.lang.getText("IGNORED_DESC");
        this._lblTitleInfo.text = this.api.lang.getText("INFORMATIONS");
        this._dgOffLine.columnsNames = [this.api.lang.getText("ACCOUNT")];
        this._lblOnLine.text = this.api.lang.getText("ONLINE");
        this._lblOffLine.text = this.api.lang.getText("OFFLINE");
        this._btnAdd.label = this.api.lang.getText("ADD");
        this._lblShowFriendsWarning.text = this.api.lang.getText("WARNING_WHEN_FRIENDS_COME_ONLINE");
        if (!this.api.lang.getConfigText("ENABLE_IGNORE_LIST"))
        {
            this._btnSwapMode._visible = false;
        } // end if
    };
    _loc1.addListeners = function ()
    {
        this._btnAdd.addEventListener("click", this);
        this._btnClose.addEventListener("click", this);
        this._btnTabFriends.addEventListener("click", this);
        this._btnTabEnemies.addEventListener("click", this);
        this._btnTabIgnore.addEventListener("click", this);
        this._btnShowFriendsWarning.addEventListener("click", this);
        this._btnShowFriendsWarning.addEventListener("over", this);
        this._btnShowFriendsWarning.addEventListener("out", this);
        this._dgOnLine.addEventListener("itemSelected", this);
        this._dgOnLine.addEventListener("itemdblClick", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.initData = function ()
    {
        this._btnShowFriendsWarning.selected = this.api.datacenter.Basics.aks_notify_on_friend_connexion;
    };
    _loc1.setTextFocus = function ()
    {
        this._itAddFriend.setFocus();
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
    _loc1.updateCurrentTabInformations = function ()
    {
        switch (this._sCurrentTab)
        {
            case "Enemies":
            {
                this.api.network.Enemies.getEnemiesList();
                break;
            } 
            case "Friends":
            {
                this.api.network.Friends.getFriendsList();
                break;
            } 
            case "Ignore":
            {
                this.updateIgnoreList();
                break;
            } 
        } // End of switch
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG" && this._itAddFriend.focused)
        {
            this.click({target: this._btnAdd});
            return (false);
        } // end if
        return (true);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnAdd:
            {
                if (this._itAddFriend.text.length != 0)
                {
                    switch (this._sCurrentTab)
                    {
                        case "Enemies":
                        {
                            this.api.network.Enemies.addEnemy("%" + this._itAddFriend.text);
                            if (this._itAddFriend.text != undefined)
                            {
                                this._itAddFriend.text = "";
                            } // end if
                            this.api.network.Enemies.getEnemiesList();
                            break;
                        } 
                        case "Friends":
                        {
                            this.api.network.Friends.addFriend("%" + this._itAddFriend.text);
                            if (this._itAddFriend.text != undefined)
                            {
                                this._itAddFriend.text = "";
                            } // end if
                            this.api.network.Friends.getFriendsList();
                            break;
                        } 
                        case "Ignore":
                        {
                            this.api.kernel.ChatManager.addToBlacklist(this._itAddFriend.text);
                            if (this._itAddFriend.text != undefined)
                            {
                                this._itAddFriend.text = "";
                            } // end if
                            this.updateIgnoreList();
                            break;
                        } 
                    } // End of switch
                } // end if
                break;
            } 
            case this._btnClose:
            {
                this.callClose();
                break;
            } 
            case this._btnTabFriends:
            {
                this.setCurrentTab("Friends");
                break;
            } 
            case this._btnTabEnemies:
            {
                this.setCurrentTab("Enemies");
                break;
            } 
            case this._btnTabIgnore:
            {
                this.setCurrentTab("Ignore");
                break;
            } 
            case this._btnShowFriendsWarning:
            {
                this.api.network.Friends.setNotifyWhenConnect(this._btnShowFriendsWarning.selected);
                this.api.datacenter.Basics.aks_notify_on_friend_connexion = this._btnShowFriendsWarning.selected;
                break;
            } 
        } // End of switch
    };
    _loc1.notifyStateChanged = function (bNotify)
    {
        this._btnShowFriendsWarning.selected = bNotify;
    };
    _loc1.itemSelected = function (oEvent)
    {
        this.api.kernel.GameManager.showPlayerPopupMenu(undefined, oEvent.row.item.name, undefined, true, undefined, undefined, true);
    };
    _loc1.itemdblClick = function (oEvent)
    {
        this.api.kernel.GameManager.askPrivateMessage(oEvent.row.item.name);
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnShowFriendsWarning:
            {
                this.gapi.showTooltip(this.api.lang.getText("WARNING_WHEN_FRIENDS_COME_ONLINE_TOOLTIP"), oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("friendsList", function ()
    {
    }, _loc1.__set__friendsList);
    _loc1.addProperty("spouse", function ()
    {
    }, _loc1.__set__spouse);
    _loc1.addProperty("enemiesList", function ()
    {
    }, _loc1.__set__enemiesList);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Friends = function ()
    {
        super();
    }).CLASS_NAME = "Friends";
    _loc1._sCurrentTab = "Friends";
} // end if
#endinitclip
