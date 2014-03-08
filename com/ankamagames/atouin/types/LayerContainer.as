package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class LayerContainer extends Sprite
   {
      
      public function LayerContainer(param1:int) {
         super();
         this._nLayerId = param1;
         name = "layer" + param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LayerContainer));
      
      private var _nLayerId:int;
      
      private var _lastIndexCell:uint;
      
      public function get layerId() : int {
         return this._nLayerId;
      }
      
      public function addCell(param1:CellContainer) : void {
         var _loc2_:CellContainer = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = _loc3_;
         while(_loc4_ < numChildren)
         {
            _loc2_ = getChildAt(_loc4_) as CellContainer;
            if(_loc2_)
            {
               if(param1.depth < _loc2_.depth)
               {
                  this._lastIndexCell = _loc4_;
                  addChildAt(param1,_loc4_);
                  return;
               }
            }
            _loc4_++;
         }
         this._lastIndexCell = numChildren;
         addChild(param1);
      }
   }
}
