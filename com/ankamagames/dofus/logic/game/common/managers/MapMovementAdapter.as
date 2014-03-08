package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class MapMovementAdapter extends Object
   {
      
      public function MapMovementAdapter() {
         super();
      }
      
      private static const DEBUG_ADAPTER:Boolean = false;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapMovementAdapter));
      
      public static function getServerMovement(param1:MovementPath) : Vector.<uint> {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function getClientMovement(param1:Vector.<uint>) : MovementPath {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
