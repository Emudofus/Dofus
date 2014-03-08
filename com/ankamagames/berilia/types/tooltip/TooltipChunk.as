package com.ankamagames.berilia.types.tooltip
{
   import flash.events.EventDispatcher;
   
   public class TooltipChunk extends EventDispatcher
   {
      
      public function TooltipChunk(param1:String) {
         super();
         this._content = param1;
      }
      
      private var _content:String;
      
      public function processContent(param1:Object) : String {
         var _loc3_:String = null;
         var _loc2_:String = this._content;
         for (_loc3_ in param1)
         {
            _loc2_ = _loc2_.split("#" + _loc3_).join(param1[_loc3_]);
         }
         return _loc2_;
      }
      
      public function get content() : String {
         return this._content;
      }
   }
}
