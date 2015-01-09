package com.ankamagames.atouin.utils.map
{
    import com.ankamagames.jerakine.types.positions.WorldPoint;

    public function getWorldPointFromMapId(nMapId:uint):WorldPoint
    {
        var worldId:uint = ((nMapId & 0x3FFC0000) >> 18);
        var x:int = ((nMapId >> 9) & 511);
        var y:int = (nMapId & 511);
        if ((x & 0x0100) == 0x0100)
        {
            x = -((x & 0xFF));
        };
        if ((y & 0x0100) == 0x0100)
        {
            y = -((y & 0xFF));
        };
        return (WorldPoint.fromCoords(worldId, x, y));
    }

}//package com.ankamagames.atouin.utils.map

