package com.ankamagames.atouin.utils.map
{
   public function getWorldPointFromMapId(nMapId:uint) : WorldPoint {
      var worldId:uint = (nMapId & 1073479680) >> 18;
      var x:int = nMapId >> 9 & 511;
      var y:int = nMapId & 511;
      if((x & 256) == 256)
      {
         x = -(x & 255);
      }
      if((y & 256) == 256)
      {
         y = -(y & 255);
      }
      return WorldPoint.fromCoords(worldId,x,y);
   }
}
