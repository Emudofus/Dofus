// Action script...

// [Initial MovieClip Action of sprite 848]
#initclip 60
class ank.battlefield.datacenter.Cell extends Object
{
    var y, allSpritesOn, __get__rootY, __get__spriteOnCount, __get__spriteOnID;
    function Cell()
    {
        super();
    } // End of the function
    function get rootY()
    {
        return (y - (7 - groundLevel) * ank.battlefield.Constants.LEVEL_HEIGHT);
    } // End of the function
    function addSpriteOnID(sID)
    {
        if (allSpritesOn == undefined)
        {
            allSpritesOn = new Object();
        } // end if
        if (sID == undefined)
        {
            return;
        } // end if
        if (allSpritesOn[sID])
        {
            return;
        } // end if
        allSpritesOn[sID] = true;
    } // End of the function
    function removeSpriteOnID(sID)
    {
        delete allSpritesOn[sID];
    } // End of the function
    function removeAllSpritesOnID()
    {
        delete this.allSpritesOn;
    } // End of the function
    function get spriteOnCount()
    {
        var _loc2 = 0;
        for (var _loc3 in allSpritesOn)
        {
            ++_loc2;
        } // end of for...in
        return (_loc2);
    } // End of the function
    function get spriteOnID()
    {
        if (allSpritesOn == undefined)
        {
            return;
        } // end if
        for (var _loc2 in allSpritesOn)
        {
            if (allSpritesOn[_loc2])
            {
                return (String(_loc2));
            } // end if
        } // end of for...in
        return;
    } // End of the function
    var active = true;
    var lineOfSight = true;
    var layerGroundRot = 0;
    var groundLevel = 7;
    var movement = 4;
    var layerGroundNum = 0;
    var groundSlope = 1;
    var layerGroundFlip = false;
    var layerObject1Num = 0;
    var layerObject1Rot = 0;
    var layerObject1Flip = false;
    var layerObject2Flip = false;
    var layerObject2Interactive = false;
    var layerObject2Num = 0;
} // End of Class
#endinitclip
