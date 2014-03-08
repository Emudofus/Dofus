package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class CraftSmileyItem extends Object implements IDataCenter
   {
      
      public function CraftSmileyItem(param1:uint, param2:int, param3:uint) {
         super();
         this.playerId = param1;
         this.iconId = param2;
         this.craftResult = param3;
      }
      
      public var playerId:int;
      
      public var iconId:int;
      
      public var craftResult:uint;
   }
}
