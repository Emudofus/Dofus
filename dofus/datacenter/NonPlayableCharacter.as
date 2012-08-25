// Action script...

// [Initial MovieClip Action of sprite 20800]
#initclip 65
if (!dofus.datacenter.NonPlayableCharacter)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.NonPlayableCharacter = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID, customArtwork)
    {
        super();
        this.api = _global.API;
        if (this.__proto__ == dofus.datacenter.NonPlayableCharacter.prototype)
        {
            this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID, customArtwork);
        } // end if
    }).prototype;
    _loc1.__set__unicID = function (value)
    {
        this._oNpcText = this.api.lang.getNonPlayableCharactersText(value);
        //return (this.unicID());
    };
    _loc1.__get__name = function ()
    {
        return (this.api.lang.fetchString(this._oNpcText.n));
    };
    _loc1.__get__actions = function ()
    {
        var _loc2 = new Array();
        var _loc3 = this._oNpcText.a;
        var _loc4 = _loc3.length;
        while (_loc4-- > 0)
        {
            _loc2.push({name: this.api.lang.getNonPlayableCharactersActionText(_loc3[_loc4]), action: this.getActionFunction(_loc3[_loc4])});
        } // end while
        return (_loc2);
    };
    _loc1.__get__gfxID = function ()
    {
        return (this._gfxID);
    };
    _loc1.__set__gfxID = function (value)
    {
        this._gfxID = value;
        //return (this.gfxID());
    };
    _loc1.__get__extraClipID = function ()
    {
        return (this._nExtraClipID);
    };
    _loc1.__set__extraClipID = function (nExtraClipID)
    {
        this._nExtraClipID = nExtraClipID;
        //return (this.extraClipID());
    };
    _loc1.__get__customArtwork = function ()
    {
        return (this._nCustomArtwork);
    };
    _loc1.__set__customArtwork = function (nCustomArtwork)
    {
        this._nCustomArtwork = nCustomArtwork;
        //return (this.customArtwork());
    };
    _loc1.initialize = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID, customArtwork)
    {
        super.initialize(sID, clipClass, sGfxFile, cellNum, dir);
        this._gfxID = gfxID;
        this._nCustomArtwork = customArtwork;
    };
    _loc1.getActionFunction = function (nActionID)
    {
        switch (nActionID)
        {
            case 1:
            {
                return ({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.startExchange, params: [0, this.id]});
                break;
            } 
            case 2:
            {
                return ({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.startExchange, params: [2, this.id]});
                break;
            } 
            case 3:
            {
                return ({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.startDialog, params: [this.id]});
                break;
            } 
            case 4:
            {
                return ({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.startExchange, params: [9, this.id]});
                break;
            } 
            case 5:
            {
                return ({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.startExchange, params: [10, this.id]});
                break;
            } 
            case 6:
            {
                return ({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.startExchange, params: [11, this.id]});
                break;
            } 
            case 7:
            {
                return ({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.startExchange, params: [17, this.id]});
                break;
            } 
            case 8:
            {
                return ({object: this.api.kernel.GameManager, method: this.api.kernel.GameManager.startExchange, params: [18, this.id]});
                break;
            } 
            default:
            {
                return (new Object());
            } 
        } // End of switch
    };
    _loc1.addProperty("customArtwork", _loc1.__get__customArtwork, _loc1.__set__customArtwork);
    _loc1.addProperty("extraClipID", _loc1.__get__extraClipID, _loc1.__set__extraClipID);
    _loc1.addProperty("gfxID", _loc1.__get__gfxID, _loc1.__set__gfxID);
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("unicID", function ()
    {
    }, _loc1.__set__unicID);
    _loc1.addProperty("actions", _loc1.__get__actions, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
