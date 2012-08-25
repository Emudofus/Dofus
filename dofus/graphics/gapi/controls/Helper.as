// Action script...

// [Initial MovieClip Action of sprite 20778]
#initclip 43
if (!dofus.graphics.gapi.controls.Helper)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.Helper = function ()
    {
        super();
    }).prototype;
    (_global.dofus.graphics.gapi.controls.Helper = function ()
    {
        super();
    }).getCurrentHelper = function ()
    {
        if (dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE == null || !(dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE instanceof dofus.graphics.gapi.controls.Helper))
        {
            var _loc2 = _global.API.ui.getUIComponent("Banner");
            if (_loc2 == undefined)
            {
                return (null);
            } // end if
            var _loc3 = _loc2.showCircleXtra("helper", true);
            return (_loc3.content);
        }
        else
        {
            return (dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE);
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.Helper.CLASS_NAME);
        dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE = this;
        this._aAnimationQueue = new Array();
        this.addAnimationToQueue("show");
    };
    _loc1.createChildren = function ()
    {
        this.hideAllStars();
    };
    _loc1.hideAllStars = function ()
    {
        this.showStars(0);
    };
    _loc1.showStars = function (nCount)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.graphics.gapi.controls.Helper.MAX_STARS_DISPLAYED)
        {
            this.getStar(_loc3 + 1)._visible = nCount > _loc3;
        } // end while
        this._nStarsDisplayed = nCount;
    };
    _loc1.getStar = function (nID)
    {
        return (this["_mcStar" + nID]);
    };
    _loc1.addStar = function ()
    {
        if (this._nStarsDisplayed < dofus.graphics.gapi.controls.Helper.MAX_STARS_DISPLAYED)
        {
            this.showStars(this._nStarsDisplayed + 1);
        } // end if
    };
    _loc1.removeStar = function ()
    {
        if (this._nStarsDisplayed > 0)
        {
            this.showStars(this._nStarsDisplayed - 1);
        } // end if
    };
    _loc1.addAnimationToQueue = function (sAnimation)
    {
        this._aAnimationQueue.push(sAnimation);
        if (!this._bIsPlaying)
        {
            this.playNextAnimation();
        } // end if
    };
    _loc1.playNextAnimation = function ()
    {
        if (this._aAnimationQueue.length > 0)
        {
            var _loc2 = String(this._aAnimationQueue.shift());
            this._sLastAnimation = _loc2;
            this._mcBoon.gotoAndPlay(_loc2);
        }
        else
        {
            switch (this._sLastAnimation)
            {
                case "hide":
                {
                    var _loc3 = _global.API.ui.getUIComponent("Banner");
                    _loc3.showCircleXtra("artwork", true, {bMask: true});
                } 
            } // End of switch
            this._mcBoon.gotoAndStop("static");
            
        } // end else if
    };
    _loc1.onNewTip = function ()
    {
        this.addStar();
        this.addAnimationToQueue("wave");
    };
    _loc1.onRemoveTip = function ()
    {
        this.removeStar();
        if (this._nStarsDisplayed <= 0)
        {
            this._nStarsDisplayed = 0;
            this.addAnimationToQueue("hide");
        } // end if
    };
    _loc1.onAnimationEnd = function ()
    {
        this.playNextAnimation();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.Helper = function ()
    {
        super();
    }).CLASS_NAME = "Helper";
    (_global.dofus.graphics.gapi.controls.Helper = function ()
    {
        super();
    }).SINGLETON_INSTANCE = null;
    (_global.dofus.graphics.gapi.controls.Helper = function ()
    {
        super();
    }).MAX_STARS_DISPLAYED = 5;
} // end if
#endinitclip
