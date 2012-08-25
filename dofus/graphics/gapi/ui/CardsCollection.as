// Action script...

// [Initial MovieClip Action of sprite 20811]
#initclip 76
if (!dofus.graphics.gapi.ui.CardsCollection)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.CardsCollection = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.CardsCollection.CLASS_NAME);
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
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
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        var _loc2 = 1;
        
        while (++_loc2, _loc2 <= 9)
        {
            var _loc3 = this["_ctr" + _loc2];
            _loc3.addEventListener("click", this);
            _loc3.addEventListener("over", this);
            _loc3.addEventListener("out", this);
        } // end while
    };
    _loc1.initData = function ()
    {
        this._ctr1.contentData = {iconFile: "Card", params: {name: "La carte", background: 0, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
        this._ctr2.contentData = {iconFile: "Card", params: {name: "Une autre carte", background: 1, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
        this._ctr3.contentData = {iconFile: "Card", params: {name: "Le monstre", background: 2, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
        this._ctr4.contentData = {iconFile: "Card", params: {name: "Lee", background: 3, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
        this._ctr5.contentData = {iconFile: "Card", params: {name: "Gross", background: 4, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
        this._ctr6.contentData = {iconFile: "Card", params: {name: "Monster", background: 5, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
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
            case "_ctr1":
            case "_ctr2":
            case "_ctr3":
            case "_ctr4":
            case "_ctr5":
            case "_ctr6":
            case "_ctr7":
            case "_ctr8":
            case "_ctr9":
            {
                var _loc3 = oEvent.target.contentData;
                if (_loc3 != undefined)
                {
                    this._ctrMain.forceNextLoad();
                    this._ctrMain.contentData = _loc3;
                } // end if
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.CardsCollection = function ()
    {
        super();
    }).CLASS_NAME = "CardsCollection";
} // end if
#endinitclip
