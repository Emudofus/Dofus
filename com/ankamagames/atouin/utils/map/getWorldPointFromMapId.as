package com.ankamagames.atouin.utils.map
{
   public function getWorldPointFromMapId(param1:uint) : WorldPoint
   {
      var _loc2_:uint = (param1 & 1073479680) >> 18;
      var _loc3_:* = param1 >> 9 & 511;
      var _loc4_:* = param1 & 511;
      if((_loc3_ & 256) == 256)
      {
         _loc3_ = -(_loc3_ & 255);
      }
      if((_loc4_ & 256) == 256)
      {
         _loc4_ = -(_loc4_ & 255);
      }
      return WorldPoint.fromCoords(_loc2_,_loc3_,_loc4_);
   }
}
