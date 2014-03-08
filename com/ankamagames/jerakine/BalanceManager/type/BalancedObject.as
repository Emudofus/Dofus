package com.ankamagames.jerakine.BalanceManager.type
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.BalanceManager.events.BalanceEvent;
   
   public class BalancedObject extends EventDispatcher
   {
      
      public function BalancedObject(param1:Object) {
         super();
         this.item = param1;
         this.nbCall = 0;
      }
      
      public var item:Object;
      
      private var _nbCall:uint;
      
      public var chanceToBeNonCall:Number;
      
      public var chanceToBeCall:Number;
      
      public function increment() : uint {
         this.nbCall = this._nbCall + 1;
         return this._nbCall;
      }
      
      public function set nbCall(param1:uint) : void {
         var _loc2_:uint = this._nbCall;
         this._nbCall = param1;
         var _loc3_:BalanceEvent = new BalanceEvent(BalanceEvent.BALANCE_UPDATE);
         _loc3_.previousBalance = _loc2_;
         _loc3_.newBalance = this._nbCall;
         _loc3_.item = this.item;
         dispatchEvent(_loc3_);
      }
      
      public function get nbCall() : uint {
         return this._nbCall;
      }
   }
}
