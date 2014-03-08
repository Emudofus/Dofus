package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.jerakine.data.I18n;
   
   public class ObjectItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function ObjectItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get isRespected() : Boolean {
         var _loc1_:ItemWrapper = null;
         for each (_loc1_ in InventoryManager.getInstance().realInventory)
         {
            if(_loc1_.objectGID == _criterionValue)
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
         var _loc1_:String = Item.getItemById(_criterionValue).name;
         var _loc2_:* = "";
         switch(_operator.text)
         {
            case ItemCriterionOperator.DIFFERENT:
               _loc2_ = I18n.getUiText("ui.common.doNotPossess",[_loc1_]);
               break;
            case ItemCriterionOperator.EQUAL:
               _loc2_ = I18n.getUiText("ui.common.doPossess",[_loc1_]);
               break;
         }
         return _loc2_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:ObjectItemCriterion = new ObjectItemCriterion(this.basicText);
         return _loc1_;
      }
   }
}
