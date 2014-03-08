package com.ankamagames.dofus.scripts
{
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class ScriptsUtil extends Object
   {
      
      public function ScriptsUtil() {
         super();
      }
      
      public static function getMapPoint(param1:Array) : MapPoint {
         var _loc2_:MapPoint = null;
         var _loc3_:ScriptEntity = null;
         if(param1)
         {
            switch(param1.length)
            {
               case 1:
                  if(param1[0] is ScriptEntity)
                  {
                     _loc3_ = param1[0] as ScriptEntity;
                     _loc2_ = MapPoint.fromCoords(_loc3_.x,_loc3_.y);
                  }
                  else
                  {
                     _loc2_ = MapPoint.fromCellId(param1[0]);
                  }
                  break;
               case 2:
                  _loc2_ = MapPoint.fromCoords(param1[0],param1[1]);
                  break;
            }
         }
         return _loc2_;
      }
   }
}
