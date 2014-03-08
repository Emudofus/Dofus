package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class PlayerInventory extends Inventory
   {
      
      public function PlayerInventory() {
         super();
      }
      
      override public function set kamas(param1:int) : void {
         if(PlayedCharacterManager.getInstance().characteristics)
         {
            PlayedCharacterManager.getInstance().characteristics.kamas = param1;
         }
         super.kamas = param1;
      }
   }
}
