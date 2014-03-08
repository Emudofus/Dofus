package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PresetSetPositionAction extends Object implements Action
   {
      
      public function PresetSetPositionAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : PresetSetPositionAction {
         var _loc3_:PresetSetPositionAction = new PresetSetPositionAction();
         _loc3_.presetId = param1;
         _loc3_.position = param2;
         return _loc3_;
      }
      
      public var presetId:uint;
      
      public var position:uint;
   }
}
