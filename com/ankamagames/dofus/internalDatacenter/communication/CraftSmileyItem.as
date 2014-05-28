package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class CraftSmileyItem extends Object implements IDataCenter
   {
      
      public function CraftSmileyItem(pPlayerId:uint, pIconId:int, pCraftResult:uint) {
         super();
         this.playerId = pPlayerId;
         this.iconId = pIconId;
         this.craftResult = pCraftResult;
      }
      
      public var playerId:int;
      
      public var iconId:int;
      
      public var craftResult:uint;
   }
}
