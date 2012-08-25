// Action script...

// [Initial MovieClip Action of sprite 20488]
#initclip 9
if (!ank.battlefield.datacenter.Sprite)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.datacenter)
    {
        _global.ank.battlefield.datacenter = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.datacenter.Sprite = function (nID, fClipClass, sGfxFile, nCellNum, nDir)
    {
        super();
        this.initialize(nID, fClipClass, sGfxFile, nCellNum, nDir);
    }).prototype;
    _loc1.initialize = function (sID, fClipClass, sGfxFile, nCellNum, nDir)
    {
        this.id = sID;
        this.clipClass = fClipClass;
        this._sGfxFile = sGfxFile;
        this._nCellNum = Number(nCellNum);
        this._nDirection = nDir == undefined ? (1) : (Number(nDir));
        this._oSequencer = new ank.utils.Sequencer(1000);
        this._bInMove = false;
        this._bVisible = true;
        this._bClear = false;
        this._eoLinkedChilds = new ank.utils.ExtendedObject();
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.__get__hasChilds = function ()
    {
        return (this._eoLinkedChilds.getLength() != 0);
    };
    _loc1.__get__hasParent = function ()
    {
        return (this.linkedParent != undefined);
    };
    _loc1.__get__childIndex = function ()
    {
        return (this._nChildIndex);
    };
    _loc1.__set__childIndex = function (nChildIndex)
    {
        this._nChildIndex = nChildIndex;
        //return (this.childIndex());
    };
    _loc1.__get__linkedChilds = function ()
    {
        return (this._eoLinkedChilds);
    };
    _loc1.__get__linkedParent = function ()
    {
        return (this._oLinkedParent);
    };
    _loc1.__set__linkedParent = function (oLinkedParent)
    {
        this._oLinkedParent = oLinkedParent;
        //return (this.linkedParent());
    };
    _loc1.hasCarriedChild = function ()
    {
        return (this._oCarriedChild != undefined);
    };
    _loc1.hasCarriedParent = function ()
    {
        return (this._oCarriedParent != undefined);
    };
    _loc1.__get__carriedChild = function ()
    {
        return (this._oCarriedChild);
    };
    _loc1.__set__carriedChild = function (o)
    {
        this._oCarriedChild = o;
        //return (this.carriedChild());
    };
    _loc1.__get__carriedParent = function ()
    {
        return (this._oCarriedParent);
    };
    _loc1.__set__carriedParent = function (o)
    {
        this._oCarriedParent = o;
        //return (this.carriedParent());
    };
    _loc1.__get__gfxFile = function ()
    {
        return (this._sGfxFile);
    };
    _loc1.__set__gfxFile = function (sGfxFile)
    {
        this.dispatchEvent({type: "gfxFileChanged", value: sGfxFile});
        this._sGfxFile = sGfxFile;
        //return (this.gfxFile());
    };
    _loc1.__get__defaultAnimation = function ()
    {
        return (this._sDefaultAnimation);
    };
    _loc1.__set__defaultAnimation = function (value)
    {
        this._sDefaultAnimation = value;
        //return (this.defaultAnimation());
    };
    _loc1.__get__startAnimation = function ()
    {
        return (this._sStartAnimation);
    };
    _loc1.__set__startAnimation = function (value)
    {
        this._sStartAnimation = value;
        //return (this.startAnimation());
    };
    _loc1.__get__startAnimationTimer = function ()
    {
        return (this._nStartAnimationTimer);
    };
    _loc1.__set__startAnimationTimer = function (value)
    {
        this._nStartAnimationTimer = value;
        //return (this.startAnimationTimer());
    };
    _loc1.__get__speedModerator = function ()
    {
        return (this._nSpeedModerator);
    };
    _loc1.__set__speedModerator = function (value)
    {
        this._nSpeedModerator = Number(value);
        //return (this.speedModerator());
    };
    _loc1.__get__isVisible = function ()
    {
        return (this._bVisible);
    };
    _loc1.__set__isVisible = function (value)
    {
        this._bVisible = value;
        //return (this.isVisible());
    };
    _loc1.__get__isHidden = function (Void)
    {
        return (this._bHidden);
    };
    _loc1.__set__isHidden = function (value)
    {
        this.mc.isHidden = this._bHidden = value;
        //return (this.isHidden());
    };
    _loc1.__get__isInMove = function ()
    {
        return (this._bInMove);
    };
    _loc1.__set__isInMove = function (value)
    {
        this._bInMove = value;
        if (this.hasCarriedChild())
        {
            this.carriedChild.isInMove = value;
        } // end if
        //return (this.isInMove());
    };
    _loc1.__get__isClear = function ()
    {
        return (this._bClear);
    };
    _loc1.__set__isClear = function (value)
    {
        this._bClear = value;
        //return (this.isClear());
    };
    _loc1.__get__cellNum = function ()
    {
        return (this._nCellNum);
    };
    _loc1.__set__cellNum = function (value)
    {
        this._nCellNum = Number(value);
        //return (this.cellNum());
    };
    _loc1.__get__direction = function ()
    {
        return (this._nDirection);
    };
    _loc1.__set__direction = function (value)
    {
        this._nDirection = Number(value);
        //return (this.direction());
    };
    _loc1.__get__color1 = function ()
    {
        return (this._nColor1);
    };
    _loc1.__set__color1 = function (value)
    {
        this._nColor1 = Number(value);
        //return (this.color1());
    };
    _loc1.__get__color2 = function ()
    {
        return (this._nColor2);
    };
    _loc1.__set__color2 = function (value)
    {
        this._nColor2 = Number(value);
        //return (this.color2());
    };
    _loc1.__get__color3 = function ()
    {
        return (this._nColor3);
    };
    _loc1.__set__color3 = function (value)
    {
        this._nColor3 = Number(value);
        //return (this.color3());
    };
    _loc1.__get__accessories = function ()
    {
        return (this._aAccessories);
    };
    _loc1.__set__accessories = function (value)
    {
        this.dispatchEvent({type: "accessoriesChanged", value: value});
        this._aAccessories = value;
        //return (this.accessories());
    };
    _loc1.__get__sequencer = function ()
    {
        return (this._oSequencer);
    };
    _loc1.__set__sequencer = function (value)
    {
        this._oSequencer = value;
        //return (this.sequencer());
    };
    _loc1.__get__allDirections = function ()
    {
        return (this._bAllDirections);
    };
    _loc1.__set__allDirections = function (bAllDirections)
    {
        this._bAllDirections = bAllDirections;
        //return (this.allDirections());
    };
    _loc1.__get__forceWalk = function ()
    {
        return (this._bForceWalk);
    };
    _loc1.__set__forceWalk = function (bForceWalk)
    {
        this._bForceWalk = bForceWalk;
        //return (this.forceWalk());
    };
    _loc1.__get__forceRun = function ()
    {
        return (this._bForceRun);
    };
    _loc1.__set__forceRun = function (bForceRun)
    {
        this._bForceRun = bForceRun;
        //return (this.forceRun());
    };
    _loc1.__get__noFlip = function ()
    {
        return (this._bNoFlip);
    };
    _loc1.__set__noFlip = function (bNoFlip)
    {
        this._bNoFlip = bNoFlip;
        //return (this.noFlip());
    };
    _loc1.__get__mount = function ()
    {
        return (this._oMount);
    };
    _loc1.__set__mount = function (v)
    {
        this._oMount = v;
        //return (this.mount());
    };
    _loc1.__get__isMounting = function ()
    {
        return (this._oMount != undefined);
    };
    _loc1.addProperty("gfxFile", _loc1.__get__gfxFile, _loc1.__set__gfxFile);
    _loc1.addProperty("linkedChilds", _loc1.__get__linkedChilds, function ()
    {
    });
    _loc1.addProperty("startAnimation", _loc1.__get__startAnimation, _loc1.__set__startAnimation);
    _loc1.addProperty("hasChilds", _loc1.__get__hasChilds, function ()
    {
    });
    _loc1.addProperty("linkedParent", _loc1.__get__linkedParent, _loc1.__set__linkedParent);
    _loc1.addProperty("mount", _loc1.__get__mount, _loc1.__set__mount);
    _loc1.addProperty("isClear", _loc1.__get__isClear, _loc1.__set__isClear);
    _loc1.addProperty("carriedChild", _loc1.__get__carriedChild, _loc1.__set__carriedChild);
    _loc1.addProperty("forceRun", _loc1.__get__forceRun, _loc1.__set__forceRun);
    _loc1.addProperty("isInMove", _loc1.__get__isInMove, _loc1.__set__isInMove);
    _loc1.addProperty("speedModerator", _loc1.__get__speedModerator, _loc1.__set__speedModerator);
    _loc1.addProperty("isHidden", _loc1.__get__isHidden, _loc1.__set__isHidden);
    _loc1.addProperty("childIndex", _loc1.__get__childIndex, _loc1.__set__childIndex);
    _loc1.addProperty("color1", _loc1.__get__color1, _loc1.__set__color1);
    _loc1.addProperty("accessories", _loc1.__get__accessories, _loc1.__set__accessories);
    _loc1.addProperty("color2", _loc1.__get__color2, _loc1.__set__color2);
    _loc1.addProperty("color3", _loc1.__get__color3, _loc1.__set__color3);
    _loc1.addProperty("forceWalk", _loc1.__get__forceWalk, _loc1.__set__forceWalk);
    _loc1.addProperty("carriedParent", _loc1.__get__carriedParent, _loc1.__set__carriedParent);
    _loc1.addProperty("allDirections", _loc1.__get__allDirections, _loc1.__set__allDirections);
    _loc1.addProperty("startAnimationTimer", _loc1.__get__startAnimationTimer, _loc1.__set__startAnimationTimer);
    _loc1.addProperty("isVisible", _loc1.__get__isVisible, _loc1.__set__isVisible);
    _loc1.addProperty("defaultAnimation", _loc1.__get__defaultAnimation, _loc1.__set__defaultAnimation);
    _loc1.addProperty("sequencer", _loc1.__get__sequencer, _loc1.__set__sequencer);
    _loc1.addProperty("isMounting", _loc1.__get__isMounting, function ()
    {
    });
    _loc1.addProperty("direction", _loc1.__get__direction, _loc1.__set__direction);
    _loc1.addProperty("cellNum", _loc1.__get__cellNum, _loc1.__set__cellNum);
    _loc1.addProperty("noFlip", _loc1.__get__noFlip, _loc1.__set__noFlip);
    _loc1.addProperty("hasParent", _loc1.__get__hasParent, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1.allowGhostMode = true;
    _loc1.bAnimLoop = false;
    _loc1._nChildIndex = -1;
    _loc1._sDefaultAnimation = "static";
    _loc1._sStartAnimation = "static";
    _loc1._nSpeedModerator = 1;
    _loc1._bHidden = false;
    _loc1._bAllDirections = true;
    _loc1._bForceWalk = false;
    _loc1._bForceRun = false;
    _loc1._bNoFlip = false;
} // end if
#endinitclip
