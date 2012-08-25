// Action script...

// [Initial MovieClip Action of sprite 20532]
#initclip 53
if (!dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls.artworkrotation)
    {
        _global.dofus.graphics.gapi.controls.artworkrotation = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem = function ()
    {
        super();
        this._mcAlphaMask._visible = false;
    }).prototype;
    _loc1.__set__sex = function (nSex)
    {
        this._nSex = Number(nSex);
        //return (this.sex());
    };
    _loc1.__set__scale = function (nScale)
    {
        this._nScale = Number(nScale);
        //return (this.scale());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.CLASS_NAME);
    };
    _loc1.loadArtwork = function (nClassID)
    {
        var _loc3 = dofus.Constants.GUILDS_BIG_PATH + nClassID + this._nSex + ".swf";
        this._ldrArtwork.addEventListener("initialization", this);
        this._ldrArtwork.contentPath = _loc3;
        this._mcAlphaMask.cacheAsBitmap = true;
        this._mcAlphaMask._xscale = this._mcAlphaMask._yscale = 85;
        this._ldrArtwork.setMask(this._mcAlphaMask);
    };
    _loc1.colorize = function (bNoTransform, bAnimation)
    {
        if (bAnimation == undefined)
        {
            bAnimation = false;
        } // end if
        var nLen = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.RED.length;
        var cTmp = new Color(this._ldrArtwork);
        var oTmp = new Object();
        var nI = bNoTransform ? (nLen - 1) : (0);
        if (!bAnimation)
        {
            oTmp.ra = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
            oTmp.rb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.RED[nI];
            oTmp.ga = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
            oTmp.gb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.GREEN[nI];
            oTmp.ba = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
            oTmp.bb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.BLUE[nI];
            cTmp.setTransform(oTmp);
        }
        else
        {
            var nInc = bNoTransform ? (-1) : (1);
            this.onEnterFrame = function ()
            {
                oTmp.ra = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
                oTmp.rb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.RED[nI];
                oTmp.ga = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
                oTmp.gb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.GREEN[nI];
                oTmp.ba = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
                oTmp.bb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.BLUE[nI];
                cTmp.setTransform(oTmp);
                nI = nI + nInc;
                if (nI >= nLen || nI < 0)
                {
                    this._oLastTransform = oTmp;
                    delete this.onEnterFrame;
                } // end if
            };
        } // end else if
    };
    _loc1.initialization = function (oEvent)
    {
        oEvent.clip._xscale = oEvent.clip._yscale = this._nScale;
    };
    _loc1.addProperty("scale", function ()
    {
    }, _loc1.__set__scale);
    _loc1.addProperty("sex", function ()
    {
    }, _loc1.__set__sex);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem = function ()
    {
        super();
        this._mcAlphaMask._visible = false;
    }).CLASS_NAME = "ArtworkRotationItem";
    (_global.dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem = function ()
    {
        super();
        this._mcAlphaMask._visible = false;
    }).RED = [0, 45, 89, 134, 178];
    (_global.dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem = function ()
    {
        super();
        this._mcAlphaMask._visible = false;
    }).GREEN = [0, 35, 70, 106, 141];
    (_global.dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem = function ()
    {
        super();
        this._mcAlphaMask._visible = false;
    }).BLUE = [0, 25, 50, 75, 100];
    (_global.dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem = function ()
    {
        super();
        this._mcAlphaMask._visible = false;
    }).PERCENT = [100, 75, 50, 25, 0];
} // end if
#endinitclip
