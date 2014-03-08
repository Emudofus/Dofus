package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AllianceAvAItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function AllianceAvAItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get isRespected() : Boolean {
         var _loc1_:* = 0;
         var _loc2_:SubArea = null;
         var _loc3_:PrismSubAreaWrapper = null;
         if(_operator.text == ItemCriterionOperator.EQUAL)
         {
            _loc1_ = PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable;
            if(!(_loc1_ == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE) && !(_loc1_ == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE))
            {
               return false;
            }
            _loc2_ = PlayedCharacterManager.getInstance().currentSubArea;
            _loc3_ = AllianceFrame.getInstance().getPrismSubAreaById(_loc2_.id);
            if(!_loc3_ || _loc3_.mapId == -1)
            {
               return false;
            }
            if(_loc3_.state != PrismStateEnum.PRISM_STATE_VULNERABLE)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      override public function get text() : String {
         var _loc1_:String = null;
         if(_operator.text == ItemCriterionOperator.EQUAL)
         {
            _loc1_ = I18n.getUiText("ui.criterion.allianceAvA");
         }
         return _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:AllianceAvAItemCriterion = new AllianceAvAItemCriterion(this.basicText);
         return _loc1_;
      }
   }
}
