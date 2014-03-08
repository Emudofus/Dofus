package com.ankamagames.jerakine.logger.targets
{
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.json.JSON;
   import com.hurlant.util.Base64;
   
   public class LimitedBufferTarget extends AbstractTarget
   {
      
      public function LimitedBufferTarget(param1:int=50) {
         super();
         this._limit = param1;
         this._buffer = new Vector.<LogEvent>();
      }
      
      private var _buffer:Vector.<LogEvent>;
      
      private var _limit:int;
      
      override public function logEvent(param1:LogEvent) : void {
         if(this._buffer.length >= this._limit)
         {
            this._buffer.shift();
         }
         this._buffer.push(param1);
      }
      
      public function getFormatedBuffer() : String {
         var _loc2_:LogEvent = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc1_:Array = new Array();
         for each (_loc2_ in this._buffer)
         {
            _loc3_ = new Object();
            _loc3_.message = _loc2_.message;
            _loc3_.level = _loc2_.level;
            _loc1_.push(_loc3_);
         }
         _loc4_ = com.ankamagames.jerakine.json.JSON.encode(_loc1_);
         return Base64.encode(_loc4_);
      }
      
      public function clearBuffer() : void {
         this._buffer = new Vector.<LogEvent>();
      }
   }
}
