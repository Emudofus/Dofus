package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class WarnOnHardcoreDeathAction extends Object implements Action
   {
      
      public function WarnOnHardcoreDeathAction()
      {
         super();
      }
      
      public static function create(param1:Boolean) : WarnOnHardcoreDeathAction
      {
         var _loc2_:WarnOnHardcoreDeathAction = new WarnOnHardcoreDeathAction();
         _loc2_.enable = param1;
         return _loc2_;
      }
      
      public var enable:Boolean;
   }
}
