package com.ankamagames.atouin.utils.map
{
    public function getMapIdFromCoord(worldId:int, x:int, y:int):int
    {
        var worldIdMax:int = (2 << 12);
        var mapCoordMax:int = (2 << 8);
        if ((((((x > mapCoordMax)) || ((y > mapCoordMax)))) || ((worldId > worldIdMax))))
        {
            return (-1);
        };
        var newWorldId:int = (worldId & 4095);
        var newX:int = (Math.abs(x) & 0xFF);
        if (x < 0)
        {
            newX = (newX | 0x0100);
        };
        var newY:int = (Math.abs(y) & 0xFF);
        if (y < 0)
        {
            newY = (newY | 0x0100);
        };
        return (((newWorldId << 18) | ((newX << 9) | newY)));
    }

}//package com.ankamagames.atouin.utils.map

