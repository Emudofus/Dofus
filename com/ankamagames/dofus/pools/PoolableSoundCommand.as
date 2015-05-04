package com.ankamagames.dofus.pools
{
   import com.ankamagames.jerakine.pools.Poolable;
   import flash.utils.getTimer;
   
   public class PoolableSoundCommand extends Object implements Poolable
   {
      
      public function PoolableSoundCommand()
      {
         super();
      }
      
      private static const COMMAND_LIFETIME:uint = 240000;
      
      public var method:String;
      
      public var params:Array;
      
      public var creationTime:int;
      
      public function get hasExpired() : Boolean
      {
         return getTimer() - this.creationTime > COMMAND_LIFETIME;
      }
      
      public function init(param1:String, param2:Array) : void
      {
         this.method = param1;
         this.params = param2;
         this.creationTime = getTimer();
      }
      
      public function free() : void
      {
         this.method = null;
         this.params = null;
         this.creationTime = 0;
      }
   }
}
