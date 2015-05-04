package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class MapMovementAdapter extends Object
   {
      
      public function MapMovementAdapter()
      {
         super();
      }
      
      private static const DEBUG_ADAPTER:Boolean = false;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapMovementAdapter));
      
      public static function getServerMovement(param1:MovementPath) : Vector.<uint>
      {
         var _loc5_:PathElement = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         param1.compress();
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         for each(_loc5_ in param1.path)
         {
            _loc3_ = _loc5_.orientation;
            _loc7_ = (_loc3_ & 7) << 12 | _loc5_.step.cellId & 4095;
            _loc2_.push(_loc7_);
            _loc4_++;
         }
         _loc6_ = (_loc3_ & 7) << 12 | param1.end.cellId & 4095;
         _loc2_.push(_loc6_);
         if(DEBUG_ADAPTER)
         {
            _loc8_ = "";
            for each(_loc9_ in _loc2_)
            {
               _loc8_ = _loc8_ + ((_loc9_ & 4095) + " > ");
            }
            _log.debug("Sending path : " + _loc8_);
         }
         return _loc2_;
      }
      
      public static function getClientMovement(param1:Vector.<uint>) : MovementPath
      {
         var _loc4_:PathElement = null;
         var _loc5_:* = 0;
         var _loc6_:MapPoint = null;
         var _loc7_:PathElement = null;
         var _loc8_:String = null;
         var _loc9_:PathElement = null;
         var _loc2_:MovementPath = new MovementPath();
         var _loc3_:uint = 0;
         for each(_loc5_ in param1)
         {
            _loc6_ = MapPoint.fromCellId(_loc5_ & 4095);
            _loc7_ = new PathElement();
            _loc7_.step = _loc6_;
            if(_loc3_ == 0)
            {
               _loc2_.start = _loc6_;
            }
            else
            {
               _loc4_.orientation = _loc4_.step.orientationTo(_loc7_.step);
            }
            if(_loc3_ == param1.length - 1)
            {
               _loc2_.end = _loc6_;
               break;
            }
            _loc2_.addPoint(_loc7_);
            _loc4_ = _loc7_;
            _loc3_++;
         }
         _loc2_.fill();
         if(DEBUG_ADAPTER)
         {
            _loc8_ = "Start : " + _loc2_.start.cellId + " | ";
            for each(_loc9_ in _loc2_.path)
            {
               _loc8_ = _loc8_ + (_loc9_.step.cellId + " > ");
            }
            _log.debug("Received path : " + _loc8_ + " | End : " + _loc2_.end.cellId);
         }
         return _loc2_;
      }
   }
}
