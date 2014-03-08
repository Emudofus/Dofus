package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   
   public class SoulStoneItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function SoulStoneItemCriterion(pCriterion:String) {
         super(pCriterion);
         var arrayParams:Array = String(_criterionValueText).split(",");
         if((arrayParams) && (arrayParams.length > 0))
         {
            if(arrayParams.length > 2)
            {
               trace("Les paramètres pour le critère de pierre d\'ame sont mauvais ! (" + _serverCriterionForm + ")");
            }
            else
            {
               this._monsterId = uint(arrayParams[0]);
               this._quantityMonster = int(arrayParams[1]);
            }
         }
         else
         {
            this._monsterId = uint(_criterionValue);
         }
         this._monsterName = Monster.getMonsterById(this._monsterId).name;
      }
      
      private static const ID_SOUL_STONE:Array = [7010,10417,10418];
      
      private var _quantityMonster:uint = 1;
      
      private var _monsterId:uint;
      
      private var _monsterName:String;
      
      override public function get isRespected() : Boolean {
         var iw:ItemWrapper = null;
         var soulStoneId:uint = 0;
         for each (iw in InventoryManager.getInstance().realInventory)
         {
            for each (soulStoneId in ID_SOUL_STONE)
            {
               if(iw.objectGID == soulStoneId)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function get text() : String {
         var readableCriterion:String = I18n.getUiText("ui.tooltip.possessSoulStone",[this._quantityMonster,this._monsterName]);
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:SoulStoneItemCriterion = new SoulStoneItemCriterion(this.basicText);
         return clonedCriterion;
      }
   }
}
