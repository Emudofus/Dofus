package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PresetSetPositionAction extends Object implements Action
   {
      
      public function PresetSetPositionAction() {
         super();
      }
      
      public static function create(presetId:uint, position:uint) : PresetSetPositionAction {
         var a:PresetSetPositionAction = new PresetSetPositionAction();
         a.presetId = presetId;
         a.position = position;
         return a;
      }
      
      public var presetId:uint;
      
      public var position:uint;
   }
}
