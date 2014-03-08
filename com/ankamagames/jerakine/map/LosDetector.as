package com.ankamagames.jerakine.map
{
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.Dofus1Line;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class LosDetector extends Object
   {
      
      public function LosDetector() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LosDetector));
      
      public static function getCell(param1:IDataMapProvider, param2:Vector.<uint>, param3:MapPoint) : Vector.<uint> {
         var _loc5_:uint = 0;
         var _loc8_:Array = null;
         var _loc9_:* = false;
         var _loc10_:String = null;
         var _loc11_:MapPoint = null;
         var _loc13_:* = 0;
         var _loc4_:Array = new Array();
         var _loc6_:MapPoint = null;
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc6_ = MapPoint.fromCellId(param2[_loc5_]);
            _loc4_.push(
               {
                  "p":_loc6_,
                  "dist":param3.distanceToCell(_loc6_)
               });
            _loc5_++;
         }
         _loc4_.sortOn("dist",Array.DESCENDING | Array.NUMERIC);
         var _loc7_:Object = new Object();
         var _loc12_:Vector.<uint> = new Vector.<uint>();
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc11_ = MapPoint(_loc4_[_loc5_].p);
            if(!(!(_loc7_[_loc11_.x + "_" + _loc11_.y] == null) && !(param3.x + param3.y == _loc11_.x + _loc11_.y) && !(param3.x - param3.y == _loc11_.x - _loc11_.y)))
            {
               _loc8_ = Dofus1Line.getLine(param3.x,param3.y,0,_loc11_.x,_loc11_.y,0);
               if(_loc8_.length == 0)
               {
                  _loc12_.push(_loc11_.cellId);
               }
               else
               {
                  _loc9_ = true;
                  _loc13_ = 0;
                  while(_loc13_ < _loc8_.length)
                  {
                     _loc10_ = Math.floor(_loc8_[_loc13_].x) + "_" + Math.floor(_loc8_[_loc13_].y);
                     if(MapPoint.isInMap(_loc8_[_loc13_].x,_loc8_[_loc13_].y))
                     {
                        if(_loc13_ > 0 && (param1.hasEntity(Math.floor(_loc8_[_loc13_-1].x),Math.floor(_loc8_[_loc13_-1].y))))
                        {
                           _loc9_ = false;
                        }
                        else
                        {
                           if(_loc8_[_loc13_].x + _loc8_[_loc13_].y == param3.x + param3.y || _loc8_[_loc13_].x - _loc8_[_loc13_].y == param3.x - param3.y)
                           {
                              _loc9_ = (_loc9_) && (param1.pointLos(Math.floor(_loc8_[_loc13_].x),Math.floor(_loc8_[_loc13_].y),true));
                           }
                           else
                           {
                              if(_loc7_[_loc10_] == null)
                              {
                                 _loc9_ = (_loc9_) && (param1.pointLos(Math.floor(_loc8_[_loc13_].x),Math.floor(_loc8_[_loc13_].y),true));
                              }
                              else
                              {
                                 _loc9_ = (_loc9_) && (_loc7_[_loc10_]);
                              }
                           }
                        }
                     }
                     _loc13_++;
                  }
                  _loc7_[_loc10_] = _loc9_;
               }
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc6_ = MapPoint.fromCellId(param2[_loc5_]);
            if(_loc7_[_loc6_.x + "_" + _loc6_.y])
            {
               _loc12_.push(_loc6_.cellId);
            }
            _loc5_++;
         }
         return _loc12_;
      }
   }
}
