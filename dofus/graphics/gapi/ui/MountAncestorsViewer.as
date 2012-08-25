// Action script...

// [Initial MovieClip Action of sprite 20713]
#initclip 234
if (!dofus.graphics.gapi.ui.MountAncestorsViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.MountAncestorsViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__mount = function (oMount)
    {
        this._oMount = oMount;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.mount());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.MountAncestorsViewer.CLASS_NAME);
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
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < 15)
        {
            this["_ldr" + _loc2].addEventListener("initialization", this);
        } // end while
    };
    _loc1.initTexts = function ()
    {
    };
    _loc1.updateData = function ()
    {
        if (this._oMount != undefined)
        {
            this._lblMountName.text = this._oMount.name;
            var _loc2 = new ank.utils.ExtendedArray();
            for (var a in this._oMount.ancestors)
            {
                _loc2[a] = this._oMount.ancestors[a];
            } // end of for...in
            _loc2.push(this._oMount.modelID);
            var _loc3 = 0;
            
            while (++_loc3, _loc3 < _loc2.length)
            {
                var _loc4 = Number(_loc2[_loc3]);
                if (_loc4 != 0)
                {
                    var _loc5 = new dofus.datacenter.Mount(_loc4);
                    var _loc6 = (ank.gapi.controls.Loader)(this["_ldr" + _loc3]);
                    _loc6.forceNextLoad();
                    _loc6.contentPath = _loc5.gfxFile;
                    var _loc7 = new ank.battlefield.datacenter.Sprite("-1", undefined, "", 0, 0);
                    _loc7.mount = _loc5;
                    this.api.colors.addSprite(_loc6, _loc7);
                    var _loc8 = this.attachMovie("Rectangle", "mcButton" + _loc3, _loc3);
                    _loc8._width = 75;
                    _loc8._height = 75;
                    _loc8._alpha = 0;
                    _loc8._x = _loc6._x - 35;
                    _loc8._y = _loc6._y - 60;
                    _loc8.mount = _loc5;
                    _loc8.onRollOver = function ()
                    {
                        this._parent.gapi.showTooltip(this.mount.modelName, this, -30, {bXLimit: true, bYLimit: false});
                    };
                    _loc8.onRollOut = function ()
                    {
                        this._parent.out();
                    };
                } // end if
                this["_mcUnknown" + _loc3]._visible = _loc4 == 0;
            } // end while
        } // end if
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.target.content;
        _loc3.attachMovie("staticR_front", "anim_front", 11);
        _loc3.attachMovie("staticR_back", "anim_back", 10);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnClose:
            {
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("mount", function ()
    {
    }, _loc1.__set__mount);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.MountAncestorsViewer = function ()
    {
        super();
    }).CLASS_NAME = "MountAncestorsViewer";
} // end if
#endinitclip
