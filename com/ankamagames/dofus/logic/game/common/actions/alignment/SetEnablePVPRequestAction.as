package com.ankamagames.dofus.logic.game.common.actions.alignment
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SetEnablePVPRequestAction extends Object implements Action
   {
      
      public function SetEnablePVPRequestAction() {
         super();
      }
      
      public static function create(param1:Boolean) : SetEnablePVPRequestAction {
         var _loc2_:SetEnablePVPRequestAction = new SetEnablePVPRequestAction();
         _loc2_.enable = param1;
         return _loc2_;
      }
      
      public var enable:Boolean;
   }
}
