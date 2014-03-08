package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class NameItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function NameItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:String = I18n.getUiText("ui.common.name");
         return _loc1_ + " " + this.getReadableOperator();
      }
      
      override public function get isRespected() : Boolean {
         var _loc1_:String = PlayedCharacterManager.getInstance().infos.name;
         var _loc2_:* = false;
         var _loc3_:String = _criterionValue.toString();
         switch(_operator.text)
         {
            case "=":
               _loc2_ = _loc1_ == _loc3_;
               break;
            case "!":
               _loc2_ = !(_loc1_ == _loc3_);
               break;
            case "~":
               _loc2_ = _loc1_.toLowerCase() == _loc3_.toLowerCase();
               break;
            case "S":
               _loc2_ = _loc1_.toLowerCase().indexOf(_loc3_.toLowerCase()) == 0;
               break;
            case "s":
               _loc2_ = _loc1_.indexOf(_loc3_) == 0;
               break;
            case "E":
               _loc2_ = _loc1_.toLowerCase().indexOf(_loc3_.toLowerCase()) == _loc1_.length - _loc3_.length;
               break;
            case "e":
               _loc2_ = _loc1_.indexOf(_loc3_) == _loc1_.length - _loc3_.length;
               break;
            case "v":
               break;
            case "i":
               break;
         }
         return _loc2_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:NameItemCriterion = new NameItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
      
      private function getReadableOperator() : String {
         var _loc1_:* = "";
         _log.debug("operator : " + _operator);
         switch(_operator.text)
         {
            case "!":
            case "=":
               _loc1_ = _operator.text + " " + _criterionValueText;
               break;
            case "~":
               _loc1_ = "= " + _criterionValueText;
               break;
            case "S":
            case "s":
               _loc1_ = I18n.getUiText("ui.criterion.startWith",[_criterionValueText]);
               break;
            case "E":
            case "e":
               _loc1_ = I18n.getUiText("ui.criterion.endWith",[_criterionValueText]);
               break;
            case "v":
               _loc1_ = I18n.getUiText("ui.criterion.valid");
               break;
            case "i":
               _loc1_ = I18n.getUiText("ui.criterion.invalid");
               break;
         }
         return _loc1_;
      }
   }
}
