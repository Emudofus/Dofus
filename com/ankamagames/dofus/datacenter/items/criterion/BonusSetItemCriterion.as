package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   
   public class BonusSetItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function BonusSetItemCriterion(param1:String)
      {
         super(param1);
      }
      
      override public function get text() : String
      {
         var _loc1_:String = I18n.getUiText("ui.criterion.setBonus");
         return _loc1_ + " " + _operator.text + " " + _criterionValue;
      }
      
      override public function get isRespected() : Boolean
      {
         return _operator.compare(uint(this.getCriterion()),_criterionValue);
      }
      
      override public function clone() : IItemCriterion
      {
         var _loc1_:BonusSetItemCriterion = new BonusSetItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int
      {
         var _loc3_:ItemWrapper = null;
         var _loc4_:* = 0;
         var _loc1_:* = 0;
         var _loc2_:Dictionary = new Dictionary();
         for each(_loc3_ in InventoryManager.getInstance().inventory.getView("equipment").content)
         {
            if(_loc3_)
            {
               if(_loc3_.itemSetId > 0)
               {
                  if(_loc2_[_loc3_.itemSetId] > 0)
                  {
                     _loc2_[_loc3_.itemSetId] = _loc2_[_loc3_.itemSetId] + 1;
                  }
                  if(_loc2_[_loc3_.itemSetId] == -1)
                  {
                     _loc2_[_loc3_.itemSetId] = 1;
                  }
                  if(!_loc2_[_loc3_.itemSetId])
                  {
                     _loc2_[_loc3_.itemSetId] = -1;
                  }
               }
            }
         }
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_ > 0)
            {
               _loc1_ = _loc1_ + _loc4_;
            }
         }
         return _loc1_;
      }
   }
}
