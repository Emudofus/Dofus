package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.jerakine.data.I18n;
   
   public class ObjectItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function ObjectItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean {
         var iw:ItemWrapper = null;
         for each (iw in InventoryManager.getInstance().realInventory)
         {
            if(iw.objectGID == _criterionValue)
            {
               if(_operator.text == ItemCriterionOperator.EQUAL)
               {
                  return true;
               }
               return false;
            }
         }
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            return true;
         }
         return false;
      }
      
      override public function get text() : String {
         var objectName:String = Item.getItemById(_criterionValue).name;
         var readableCriterion:String = "";
         switch(_operator.text)
         {
            case ItemCriterionOperator.DIFFERENT:
               readableCriterion = I18n.getUiText("ui.common.doNotPossess",[objectName]);
               break;
            case ItemCriterionOperator.EQUAL:
               readableCriterion = I18n.getUiText("ui.common.doPossess",[objectName]);
               break;
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:ObjectItemCriterion = new ObjectItemCriterion(this.basicText);
         return clonedCriterion;
      }
   }
}
