package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.jerakine.data.I18n;
   
   public class SubareaItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function SubareaItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get isRespected() : Boolean {
         var _loc1_:uint = PlayedCharacterManager.getInstance().currentSubArea.id;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
            case ItemCriterionOperator.DIFFERENT:
               return super.isRespected;
            default:
               return false;
         }
      }
      
      override public function get text() : String {
         var _loc1_:String = null;
         var _loc2_:SubArea = SubArea.getSubAreaById(_criterionValue);
         if(!_loc2_)
         {
            return "error on subareaItemCriterion";
         }
         var _loc3_:String = _loc2_.name;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               _loc1_ = I18n.getUiText("ui.tooltip.beInSubarea",[_loc3_]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               _loc1_ = I18n.getUiText("ui.tooltip.dontBeInSubarea",[_loc3_]);
               break;
         }
         return _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:SubareaItemCriterion = new SubareaItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().currentSubArea.id;
      }
   }
}
