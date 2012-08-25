// Action script...

// [Initial MovieClip Action of sprite 20870]
#initclip 135
if (!dofus.graphics.gapi.ui.KnownledgeBase)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.KnownledgeBase = function ()
    {
        super();
        this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES, true);
        this._btnMaximize._visible = false;
    }).prototype;
    _loc1.__set__article = function (nArticleID)
    {
        this.addToQueue({object: this, method: this.displayArticle, params: [nArticleID]});
        //return (this.article());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.KnownledgeBase.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initText});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.recoverLastState});
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.initText = function ()
    {
        this._winBackground.title = this.api.lang.getText("KB_TITLE");
        this._lblSearch.text = this.api.lang.getText("KB_SEARCH");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnMaximize.addEventListener("click", this);
        this._btnMaximize.addEventListener("over", this);
        this._btnMaximize.addEventListener("out", this);
        this._btnMinimize.addEventListener("click", this);
        this._btnMinimize.addEventListener("over", this);
        this._btnMinimize.addEventListener("out", this);
        this._lstCategories.addEventListener("itemSelected", this);
        this._lstArticles.addEventListener("itemSelected", this);
        this._lstSearch.addEventListener("itemSelected", this);
        this._taArticle.addEventListener("href", this);
        this._mcBtnCategory.onRelease = function ()
        {
            this._parent.click({target: this});
        };
        this._mcBtnArticle.onRelease = function ()
        {
            this._parent.click({target: this});
        };
        this._tiSearch.addEventListener("change", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.initData = function ()
    {
        var _loc2 = this.api.lang.getKnownledgeBaseCategories();
        _loc2.sortOn("o", Array.NUMERIC | Array.DESCENDING);
        this._eaCategories = new ank.utils.ExtendedArray();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2.length)
        {
            if (_loc2[_loc3] != undefined && (this.api.datacenter.Basics.aks_current_regional_version != undefined && _loc2[_loc3].ep <= this.api.datacenter.Basics.aks_current_regional_version))
            {
                this._eaCategories.push(_loc2[_loc3]);
            } // end if
        } // end while
        this._lstCategories.dataProvider = this._eaCategories;
        var _loc4 = this.api.lang.getKnownledgeBaseArticles();
        _loc4.sortOn("o", Array.NUMERIC | Array.DESCENDING);
        this._eaArticles = new ank.utils.ExtendedArray();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc4.length)
        {
            if (_loc4[_loc5] != undefined && (this.api.datacenter.Basics.aks_current_regional_version != undefined && _loc4[_loc5].ep <= this.api.datacenter.Basics.aks_current_regional_version))
            {
                this._eaArticles.push(_loc4[_loc5]);
            } // end if
        } // end while
        this.generateIndexes();
    };
    _loc1.recoverLastState = function ()
    {
        switch (this.api.datacenter.Basics.kbDisplayType)
        {
            case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES:
            {
                this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES);
                break;
            } 
            case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES:
            {
                this.displayArticles(this.api.datacenter.Basics.kbCategory);
                break;
            } 
            case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE:
            {
                this.displayArticle(this.api.datacenter.Basics.kbArticle);
                break;
            } 
            case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH:
            {
                this._tiSearch.text = this.api.datacenter.Basics.kbSearch;
                break;
            } 
        } // End of switch
    };
    _loc1.switchToState = function (nStateID)
    {
        if (this._nCurrentState == nStateID)
        {
            return;
        } // end if
        var _loc3 = this.api.ui.getUIComponent("KnownledgeBase");
        switch (nStateID)
        {
            case dofus.graphics.gapi.ui.KnownledgeBase.STATE_MINIMIZED:
            {
                this._btnMaximize._visible = true;
                this._btnMinimize._visible = false;
                _loc3._y = 352;
                break;
            } 
            case dofus.graphics.gapi.ui.KnownledgeBase.STATE_MAXIMIZED:
            {
                this._btnMaximize._visible = false;
                this._btnMinimize._visible = true;
                _loc3._y = 0;
                break;
            } 
        } // End of switch
        this._nCurrentState = nStateID;
    };
    _loc1.switchToDisplay = function (nDisplayID, bDontSave)
    {
        if (this._nCurrentDisplay == nDisplayID)
        {
            return;
        } // end if
        switch (nDisplayID)
        {
            case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES:
            {
                this._lstCategories._visible = true;
                this._lstArticles._visible = false;
                this._lblCategory._visible = false;
                this._mcCategory._visible = false;
                this._mcArrowUp._visible = false;
                this._mcBgCategory._visible = false;
                this._mcBtnCategory._visible = false;
                this._lblArticle._visible = false;
                this._mcArticle._visible = false;
                this._mcBgArticle._visible = false;
                this._mcBtnArticle._visible = false;
                this._taArticle._visible = false;
                this._lstSearch._visible = false;
                this._mcBookComplete._visible = false;
                this._mcArrowUp2._visible = false;
                break;
            } 
            case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES:
            {
                this._lstCategories._visible = false;
                this._lstArticles._visible = true;
                this._lblCategory._visible = true;
                this._mcCategory._visible = true;
                this._mcArrowUp._visible = true;
                this._mcBgCategory._visible = true;
                this._mcBtnCategory._visible = true;
                this._lblArticle._visible = false;
                this._mcArticle._visible = false;
                this._mcBgArticle._visible = false;
                this._mcBtnArticle._visible = false;
                this._taArticle._visible = false;
                this._lstSearch._visible = false;
                this._mcBookComplete._visible = false;
                this._mcArrowUp2._visible = false;
                break;
            } 
            case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH:
            {
                this._lstCategories._visible = false;
                this._lstArticles._visible = false;
                this._lblCategory._visible = false;
                this._mcCategory._visible = false;
                this._mcArrowUp._visible = false;
                this._mcBgCategory._visible = false;
                this._mcBtnCategory._visible = false;
                this._lblArticle._visible = false;
                this._mcArticle._visible = false;
                this._mcBgArticle._visible = false;
                this._mcBtnArticle._visible = false;
                this._taArticle._visible = false;
                this._lstSearch._visible = true;
                this._mcBookComplete._visible = false;
                this._mcArrowUp2._visible = false;
                break;
            } 
            case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE:
            {
                this._lstCategories._visible = false;
                this._lstArticles._visible = false;
                this._lblCategory._visible = true;
                this._mcCategory._visible = true;
                this._mcArrowUp._visible = false;
                this._mcBgCategory._visible = true;
                this._mcBtnCategory._visible = false;
                this._lblArticle._visible = true;
                this._mcArticle._visible = true;
                this._mcBgArticle._visible = true;
                this._mcBtnArticle._visible = true;
                this._taArticle._visible = true;
                this._lstSearch._visible = false;
                this._mcBookComplete._visible = true;
                this._mcArrowUp2._visible = true;
                break;
            } 
        } // End of switch
        this._nCurrentDisplay = nDisplayID;
        if (bDontSave !== true)
        {
            this.api.datacenter.Basics.kbDisplayType = nDisplayID;
        } // end if
    };
    _loc1.generateIndexes = function ()
    {
        this._eaIndexes = new ank.utils.ExtendedArray();
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this._eaArticles.length)
        {
            var _loc3 = 0;
            
            while (++_loc3, _loc3 < this._eaArticles[_loc2].k.length)
            {
                this._eaIndexes.push({name: this._eaArticles[_loc2].k[_loc3].toUpperCase(), i: this._eaArticles[_loc2].i});
            } // end while
        } // end while
    };
    _loc1.searchTopic = function (sTopic)
    {
        var _loc3 = sTopic.split(" ");
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = new ank.utils.ExtendedArray();
        var _loc6 = new Array();
        var _loc7 = 0;
        var _loc8 = new Array();
        var _loc9 = -1;
        var _loc10 = 0;
        
        while (++_loc10, _loc10 < this._eaIndexes.length)
        {
            var _loc11 = this._eaIndexes[_loc10];
            var _loc12 = this.searchWordsInName(_loc3, _loc11.name, _loc7);
            if (_loc12 != 0)
            {
                _loc6.push({i: _loc11.i, w: _loc12});
                _loc7 = _loc12;
            } // end if
        } // end while
        var _loc13 = 0;
        
        while (++_loc13, _loc13 < _loc6.length)
        {
            if (!_loc8[_loc6[_loc13].i] && _loc6[_loc13].w >= _loc7)
            {
                var _loc14 = this._eaArticles.findFirstItem("i", _loc6[_loc13].i).item;
                _loc4.push(_loc14);
                _loc8[_loc6[_loc13].i] = true;
            } // end if
        } // end while
        _loc4.sortOn("c", Array.NUMERIC | Array.DESCENDING);
        var _loc15 = 0;
        
        while (++_loc15, _loc15 < _loc4.length)
        {
            if (_loc4[_loc15].n != "" && _loc4[_loc15].n != undefined)
            {
                if (_loc9 != _loc4[_loc15].c)
                {
                    _loc5.push(this.api.lang.getKnownledgeBaseCategory(_loc4[_loc15].c));
                    _loc9 = _loc4[_loc15].c;
                } // end if
                _loc5.push(_loc4[_loc15]);
            } // end if
        } // end while
        this._lstSearch.dataProvider = _loc5;
    };
    _loc1.searchWordsInName = function (aWords, sName, nMaxWordsCount)
    {
        var _loc5 = 0;
        var _loc6 = aWords.length;
        
        while (--_loc6, _loc6 >= 0)
        {
            var _loc7 = aWords[_loc6];
            if (sName.indexOf(_loc7) != -1)
            {
                ++_loc5;
                continue;
            } // end if
            if (_loc5 + _loc6 < nMaxWordsCount)
            {
                return (0);
            } // end if
        } // end while
        return (_loc5);
    };
    _loc1.displayArticles = function (nCatID, bDoNotDisplay)
    {
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this._eaArticles.length)
        {
            if (this._eaArticles[_loc5].c == nCatID)
            {
                _loc4.push(this._eaArticles[_loc5]);
            } // end if
        } // end while
        this._lstArticles.dataProvider = _loc4;
        this._lblCategory.text = this._eaCategories.findFirstItem("i", nCatID).item.n;
        if (bDoNotDisplay !== true)
        {
            this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
        } // end if
        this.api.datacenter.Basics.kbCategory = nCatID;
    };
    _loc1.displayArticle = function (nArticleID)
    {
        var _loc3 = this._eaArticles.findFirstItem("i", nArticleID).item;
        this._lblArticle.text = _loc3.n;
        this.displayArticles(_loc3.c, true);
        this._taArticle.text = "<p class=\'body\'>" + _loc3.a + "</p>";
        this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE);
        this.api.datacenter.Basics.kbArticle = nArticleID;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_mcBtnCategory":
            {
                this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES);
                break;
            } 
            case "_mcBtnArticle":
            {
                this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
                break;
            } 
            case "_btnMaximize":
            {
                this.switchToState(dofus.graphics.gapi.ui.KnownledgeBase.STATE_MAXIMIZED);
                break;
            } 
            case "_btnMinimize":
            {
                this.switchToState(dofus.graphics.gapi.ui.KnownledgeBase.STATE_MINIMIZED);
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnMinimize":
            {
                this.gapi.showTooltip(this.api.lang.getText("WINDOW_MINIMIZE"), oEvent.target, 20);
                break;
            } 
            case "_btnMaximize":
            {
                this.gapi.showTooltip(this.api.lang.getText("WINDOW_MAXIMIZE"), oEvent.target, 20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_lstCategories":
            {
                this.displayArticles(Number(oEvent.row.item.i));
                break;
            } 
            case "_lstArticles":
            {
                this.displayArticle(Number(oEvent.row.item.i));
                break;
            } 
            case "_lstSearch":
            {
                var _loc3 = oEvent.row.item;
                if (_loc3.c > 0)
                {
                    this._lblArticle.text = _loc3.n;
                    this._lblCategory.text = this._eaCategories.findFirstItem("i", _loc3.c).item.n;
                    this._taArticle.text = _loc3.a;
                    this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE);
                }
                else
                {
                    this._lblCategory.text = _loc3.n;
                    var _loc4 = _loc3.i;
                    var _loc5 = new ank.utils.ExtendedArray();
                    var _loc6 = 0;
                    
                    while (++_loc6, _loc6 < this._eaArticles.length)
                    {
                        if (this._eaArticles[_loc6].c == _loc4)
                        {
                            _loc5.push(this._eaArticles[_loc6]);
                        } // end if
                    } // end while
                    this._lstArticles.dataProvider = _loc5;
                    this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.change = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_tiSearch":
            {
                var _loc3 = this._tiSearch.text;
                if (_loc3.length > 0)
                {
                    this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH);
                    this.searchTopic(_loc3.toUpperCase());
                }
                else
                {
                    this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES);
                } // end else if
                this.api.datacenter.Basics.kbSearch = this._tiSearch.text;
                break;
            } 
        } // End of switch
    };
    _loc1.href = function (oEvent)
    {
        this.api.kernel.TipsManager.onLink(oEvent);
    };
    _loc1.onShortcut = function (sShortcut)
    {
        switch (sShortcut)
        {
            case "ACCEPT_CURRENT_DIALOG":
            {
                if (this._tiSearch.focused)
                {
                    this.change({target: this._tiSearch});
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("article", function ()
    {
    }, _loc1.__set__article);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.KnownledgeBase = function ()
    {
        super();
        this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES, true);
        this._btnMaximize._visible = false;
    }).CLASS_NAME = "KnownledgeBase";
    (_global.dofus.graphics.gapi.ui.KnownledgeBase = function ()
    {
        super();
        this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES, true);
        this._btnMaximize._visible = false;
    }).DISPLAY_CATEGORIES = 1;
    (_global.dofus.graphics.gapi.ui.KnownledgeBase = function ()
    {
        super();
        this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES, true);
        this._btnMaximize._visible = false;
    }).DISPLAY_ARTICLES = 2;
    (_global.dofus.graphics.gapi.ui.KnownledgeBase = function ()
    {
        super();
        this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES, true);
        this._btnMaximize._visible = false;
    }).DISPLAY_SEARCH = 3;
    (_global.dofus.graphics.gapi.ui.KnownledgeBase = function ()
    {
        super();
        this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES, true);
        this._btnMaximize._visible = false;
    }).DISPLAY_ARTICLE = 4;
    (_global.dofus.graphics.gapi.ui.KnownledgeBase = function ()
    {
        super();
        this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES, true);
        this._btnMaximize._visible = false;
    }).STATE_MINIMIZED = 1;
    (_global.dofus.graphics.gapi.ui.KnownledgeBase = function ()
    {
        super();
        this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES, true);
        this._btnMaximize._visible = false;
    }).STATE_MAXIMIZED = 2;
} // end if
#endinitclip
