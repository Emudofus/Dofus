// Action script...

// [Initial MovieClip Action of sprite 20659]
#initclip 180
if (!ank.battlefield.datacenter.Cell)
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
    var _loc1 = (_global.ank.battlefield.datacenter.Cell = function ()
    {
        super();
    }).prototype;
    _loc1.__get__rootY = function ()
    {
        return (this.y - (7 - this.groundLevel) * ank.battlefield.Constants.LEVEL_HEIGHT);
    };
    _loc1.addSpriteOnID = function (sID)
    {
        if (this.allSpritesOn == undefined)
        {
            this.allSpritesOn = new Object();
        } // end if
        if (sID == undefined)
        {
            return;
        } // end if
        if (this.allSpritesOn[sID])
        {
            return;
        } // end if
        this.allSpritesOn[sID] = true;
    };
    _loc1.removeSpriteOnID = function (sID)
    {
        this.allSpritesOn[sID] = undefined;
        delete this.allSpritesOn[sID];
    };
    _loc1.removeAllSpritesOnID = function ()
    {
        for (var k in this.allSpritesOn)
        {
            this.allSpritesOn[k] = undefined;
            delete this.allSpritesOn[k];
        } // end of for...in
        delete this.allSpritesOn;
    };
    _loc1.__get__spriteOnCount = function ()
    {
        var _loc2 = 0;
        for (var k in this.allSpritesOn)
        {
            ++_loc2;
        } // end of for...in
        return (_loc2);
    };
    _loc1.__get__spriteOnID = function ()
    {
        if (this.allSpritesOn == undefined)
        {
            return;
        } // end if
        for (var k in this.allSpritesOn)
        {
            if (this.allSpritesOn[k])
            {
                return (String(k));
            } // end if
        } // end of for...in
        return;
    };
    _loc1.__get__carriedSpriteOnId = function ()
    {
        if (this.allSpritesOn == undefined)
        {
            return (false);
        } // end if
        for (var k in this.allSpritesOn)
        {
            if (this.allSpritesOn[k].hasCarriedChild())
            {
                return (true);
            } // end if
        } // end of for...in
        return (false);
    };
    _loc1.addProperty("spriteOnCount", _loc1.__get__spriteOnCount, function ()
    {
    });
    _loc1.addProperty("spriteOnID", _loc1.__get__spriteOnID, function ()
    {
    });
    _loc1.addProperty("carriedSpriteOnId", _loc1.__get__carriedSpriteOnId, function ()
    {
    });
    _loc1.addProperty("rootY", _loc1.__get__rootY, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1.active = true;
    _loc1.lineOfSight = true;
    _loc1.layerGroundRot = 0;
    _loc1.groundLevel = 7;
    _loc1.movement = 4;
    _loc1.layerGroundNum = 0;
    _loc1.groundSlope = 1;
    _loc1.layerGroundFlip = false;
    _loc1.layerObject1Num = 0;
    _loc1.layerObject1Rot = 0;
    _loc1.layerObject1Flip = false;
    _loc1.layerObject2Flip = false;
    _loc1.layerObject2Interactive = false;
    _loc1.layerObject2Num = 0;
} // end if
#endinitclip
