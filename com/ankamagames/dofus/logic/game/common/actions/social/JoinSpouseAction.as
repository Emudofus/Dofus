package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinSpouseAction extends Object implements Action
   {
      
      public function JoinSpouseAction() {
         super();
      }
      
      public static function create() : JoinSpouseAction {
         var _loc1_:JoinSpouseAction = new JoinSpouseAction();
         return _loc1_;
      }
   }
}
