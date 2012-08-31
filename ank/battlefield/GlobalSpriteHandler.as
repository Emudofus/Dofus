// Action script...

// [Initial MovieClip Action of sprite 870]
#initclip 82
class ank.battlefield.GlobalSpriteHandler
{
    var _oSprites;
    function GlobalSpriteHandler()
    {
        this.initialize();
    } // End of the function
    function initialize()
    {
        _oSprites = new Object();
    } // End of the function
    function addSprite(mcSprite, oSpriteData)
    {
        _oSprites[mcSprite._target] = {mc: mcSprite, data: oSpriteData};
        this.garbageCollector();
    } // End of the function
    function setColors(mc, color1, color2, color3)
    {
        var _loc2 = _oSprites[mc._target].data;
        if (color1 != -1)
        {
            _loc2.color1 = color1;
        } // end if
        if (color2 != -1)
        {
            _loc2.color2 = color2;
        } // end if
        if (color3 != -1)
        {
            _loc2.color3 = color3;
        } // end if
    } // End of the function
    function setAccessories(mc, aAccessories)
    {
        var _loc2 = _oSprites[mc._target].data;
        if (aAccessories != undefined)
        {
            _loc2.accessories = aAccessories;
        } // end if
    } // End of the function
    function applyColor(mc, nZone)
    {
        var _loc4 = this.getSpriteData(mc);
        if (_loc4 != undefined)
        {
            var _loc2 = _loc4["color" + nZone];
            if (_loc2 != undefined && _loc2 != -1)
            {
                var _loc8 = (_loc2 & 16711680) >> 16;
                var _loc5 = (_loc2 & 65280) >> 8;
                var _loc7 = _loc2 & 255;
                var _loc6 = new Color(mc);
                var _loc3 = new Object();
                _loc3 = {ra: "0", rb: _loc8, ga: "0", gb: _loc5, ba: "0", bb: _loc7, aa: "100", ab: "0"};
                _loc6.setTransform(_loc3);
            } // end if
        } // end if
    } // End of the function
    function applyAccessory(mc, accessoryID, side, mcToHide, bFix)
    {
        if (bFix == undefined)
        {
            bFix = false;
        } // end if
        var _loc3 = this.getSpriteData(mc);
        if (_loc3 != undefined)
        {
            var _loc2;
            mc.clip.removeMovieClip();
            switch (accessoryID)
            {
                case 0:
                {
                    _loc2 = _loc3.accessories[0].gfx;
                    break;
                } 
                case 1:
                {
                    _loc2 = _loc3.accessories[1].gfx;
                    break;
                } 
                case 2:
                {
                    _loc2 = _loc3.accessories[2].gfx;
                    break;
                } 
                case 3:
                {
                    _loc2 = _loc3.accessories[3].gfx;
                    break;
                } 
            } // End of switch
            if (bFix)
            {
                switch (_loc3.direction)
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
            if (_loc2 != undefined)
            {
                if (mcToHide != undefined)
                {
                    mcToHide.gotoAndStop(_loc2.length == 0 || _loc2 == "_" ? (1) : (2));
                } // end if
                mc.attachMovie(_loc2, "clip", 10);
                mc.clip.gotoAndStop(side);
            } // end if
        } // end if
    } // End of the function
    function applyAnim(mc, sAnim)
    {
        var _loc2 = this.getSpriteData(mc);
        if (_loc2 != undefined)
        {
            if (_loc2.bAnimLoop)
            {
                _loc2.mc.animationClip.lastAnimation = _loc2.animation;
            }
            else
            {
                _loc2.mc.setAnim(sAnim);
            } // end if
        } // end else if
    } // End of the function
    function applyEnd(mc)
    {
        var _loc2 = this.getSpriteData(mc);
        if (_loc2 != undefined)
        {
            if (!_loc2.bAnimLoop)
            {
                _loc2.sequencer.onActionEnd();
            } // end if
        } // end if
    } // End of the function
    function applySprite(mc)
    {
        var _loc2 = this.getSpriteData(mc);
        switch (_loc2.direction)
        {
            case 0:
            case 4:
            {
                mc.attachMovie(_loc2.animation + "S", "clip", 1);
                break;
            } 
            case 1:
            case 3:
            {
                mc.attachMovie(_loc2.animation + "R", "clip", 1);
                break;
            } 
            case 2:
            {
                mc.attachMovie(_loc2.animation + "F", "clip", 1);
                break;
            } 
            case 5:
            case 7:
            {
                mc.attachMovie(_loc2.animation + "L", "clip", 1);
                break;
            } 
            case 6:
            {
                mc.attachMovie(_loc2.animation + "B", "clip", 1);
                break;
            } 
        } // End of switch
    } // End of the function
    function getSpriteData(mc)
    {
        var _loc2 = mc._target;
        for (var _loc3 in _oSprites)
        {
            if (_loc2.substring(0, _loc3.length) == _loc3)
            {
                if (_loc2.charAt(_loc3.length) != "/")
                {
                    continue;
                } // end if
                if (_oSprites[_loc3] != undefined)
                {
                    return (_oSprites[_loc3].data);
                    break;
                } // end if
            } // end if
        } // end of for...in
    } // End of the function
    function garbageCollector(Void)
    {
        for (var _loc2 in _oSprites)
        {
            if (_oSprites[_loc2].mc._target == undefined)
            {
                delete _oSprites[_loc2];
            } // end if
        } // end of for...in
    } // End of the function
} // End of Class
#endinitclip
