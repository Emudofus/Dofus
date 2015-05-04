package com.ankamagames.jerakine.BalanceManager.events
{
   import flash.events.Event;
   
   public class BalanceEvent extends Event
   {
      
      public function BalanceEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public static const BALANCE_UPDATE:String = "balance_update";
      
      public var item:Object;
      
      public var newBalance:uint;
      
      public var previousBalance:uint;
   }
}
