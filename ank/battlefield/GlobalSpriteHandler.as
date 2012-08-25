// Action script...

// [Initial MovieClip Action of sprite 20714]
#initclip 235
if (!ank.battlefield.GlobalSpriteHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.GlobalSpriteHandler = function ()
    {
        this.initialize();
    }).prototype;
    _loc1.initialize = function ()
    {
        this._oSprites = new Object();
        this._mclLoader = new MovieClipLoader();
        this._mclLoader.addListener(this);
        this._aFrameToGo = new Array();
    };
    _loc1.setAccessoriesRoot = function (path)
    {
        this._sAccessoriesPath = path;
    };
    _loc1.addSprite = function (mcSprite, oSpriteData)
    {
        this._oSprites[mcSprite._target] = {mc: mcSprite, data: oSpriteData};
        this.garbageCollector();
    };
    _loc1.setColors = function (mc, color1, color2, color3)
    {
        var _loc6 = this._oSprites[mc._target].data;
        if (color1 != -1)
        {
            _loc6.color1 = color1;
        } // end if
        if (color2 != -1)
        {
            _loc6.color2 = color2;
        } // end if
        if (color3 != -1)
        {
            _loc6.color3 = color3;
        } // end if
    };
    _loc1.setAccessories = function (mc, aAccessories)
    {
        var _loc4 = this._oSprites[mc._target].data;
        if (aAccessories != undefined)
        {
            _loc4.accessories = aAccessories;
        } // end if
    };
    _loc1.applyColor = function (mc, nZone, isMount)
    {
        var _loc5 = this.getSpriteData(mc);
        if (_loc5 != undefined)
        {
            var _loc6 = isMount && _loc5.mount != undefined ? (_loc5.mount["color" + nZone]) : (_loc5["color" + nZone]);
            if (_loc6 != undefined && _loc6 != -1)
            {
                var _loc7 = (_loc6 & 16711680) >> 16;
                var _loc8 = (_loc6 & 65280) >> 8;
                var _loc9 = _loc6 & 255;
                var _loc10 = new Color(mc);
                var _loc11 = new Object();
                _loc11 = {ra: "0", rb: _loc7, ga: "0", gb: _loc8, ba: "0", bb: _loc9, aa: "100", ab: "0"};
                _loc10.setTransform(_loc11);
                
            } // end if
        } // end if
    };
    _loc1.applyAccessory = function (mc, accessoryID, side, mcToHide, bFix)
    {
        if (bFix == undefined)
        {
            bFix = false;
        } // end if
        var _loc7 = this.getSpriteData(mc);
        if (_loc7 != undefined)
        {
            var _loc8 = _loc7.accessories[accessoryID].gfx;
            mc.clip.removeMovieClip();
            if (bFix)
            {
                switch (_loc7.direction)
                {
                    case 3:
                    case 4:
                    case 7:
                    {
                        mc._x = -mc._x;
                        break;
                    } 
                } // End of switch
            } // end if
            if (_loc8 != undefined)
            {
                if (mcToHide != undefined)
                {
                    mcToHide.gotoAndStop(_loc8.length == 0 || _loc8 == "_" ? (1) : (2));
                } // end if
                if (!ank.battlefield.Constants.USE_STREAMING_FILES || ank.battlefield.Constants.STREAMING_METHOD == "compact")
                {
                    mc.attachMovie(_loc8, "clip", 10);
                    if (_loc7.accessories[accessoryID].frame != undefined)
                    {
                        mc.clip.gotoAndStop(side + _loc7.accessories[accessoryID].frame);
                    }
                    else
                    {
                        mc.clip.gotoAndStop(side);
                    } // end else if
                }
                else
                {
                    var _loc9 = _loc8.split("_");
                    if (_loc9[0] == undefined || (_global.isNaN(Number(_loc9[0])) || (_loc9[1] == undefined || _global.isNaN(Number(_loc9[1])))))
                    {
                        return;
                    } // end if
                    var _loc10 = mc.createEmptyMovieClip("clip", 10);
                    if (_loc7.skin !== undefined)
                    {
                        this._aFrameToGo[_loc10] = side + _loc7.skin;
                    }
                    else
                    {
                        this._aFrameToGo[_loc10] = side;
                    } // end else if
                    this._mclLoader.loadClip(this._sAccessoriesPath + _loc9.join("/") + ".swf", _loc10);
                } // end if
            } // end if
        } // end else if
    };
    _loc1.applyAnim = function (mc, sAnim)
    {
        var _loc4 = this.getSpriteData(mc);
        if (_loc4 != undefined)
        {
            if (_loc4.bAnimLoop)
            {
                _loc4.mc.saveLastAnimation(_loc4.animation);
            }
            else
            {
                _loc4.mc.setAnim(sAnim);
            } // end if
        } // end else if
    };
    _loc1.applyEnd = function (mc)
    {
        var _loc3 = this.getSpriteData(mc);
        if (_loc3 != undefined)
        {
            if (!_loc3.bAnimLoop)
            {
                _loc3.sequencer.onActionEnd();
            } // end if
        } // end if
    };
    _loc1.applySprite = function (mc)
    {
        var _loc3 = this.getSpriteData(mc);
        switch (_loc3.direction)
        {
            case 0:
            case 4:
            {
                mc.attachMovie(_loc3.animation + "S", "clip", 1);
                break;
            } 
            case 1:
            case 3:
            {
                mc.attachMovie(_loc3.animation + "R", "clip", 1);
                break;
            } 
            case 2:
            {
                mc.attachMovie(_loc3.animation + "F", "clip", 1);
                break;
            } 
            case 5:
            case 7:
            {
                mc.attachMovie(_loc3.animation + "L", "clip", 1);
                break;
            } 
            case 6:
            {
                mc.attachMovie(_loc3.animation + "B", "clip", 1);
                break;
            } 
        } // End of switch
    };
    _loc1.registerCarried = function (mc)
    {
        var _loc3 = this.getSpriteData(mc);
        _loc3.mc.mcCarried = mc;
    };
    _loc1.registerChevauchor = function (mc)
    {
        var _loc3 = this.getSpriteData(mc);
        _loc3.mc.mcChevauchorPos = mc;
        _loc3.mc.updateChevauchorPosition();
    };
    _loc1.getSpriteData = function (mc)
    {
        var _loc3 = mc._target;
        for (var name in this._oSprites)
        {
            if (_loc3.substring(0, name.length) == name)
            {
                if (_loc3.charAt(name.length) != "/")
                {
                    continue;
                } // end if
                if (this._oSprites[name] != undefined)
                {
                    return (this._oSprites[name].data);
                    break;
                } // end if
            } // end if
        } // end of for...in
    };
    _loc1.garbageCollector = function (Void)
    {
        for (var o in this._oSprites)
        {
            if (this._oSprites[o].mc._target == undefined)
            {
                delete this._oSprites[o];
            } // end if
        } // end of for...in
    };
    _loc1.recursiveGotoAndStop = function (mc, frame)
    {
        mc.stop();
        mc.gotoAndStop(frame);
        for (var i in mc)
        {
            if (mc[i] instanceof MovieClip)
            {
                this.recursiveGotoAndStop(mc[i], frame);
            } // end if
        } // end of for...in
    };
    _loc1.onLoadInit = function (mc)
    {
        this.recursiveGotoAndStop(mc, this._aFrameToGo[mc]);
        delete this._aFrameToGo[mc];
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
