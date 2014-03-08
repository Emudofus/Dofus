package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenSocialAction extends Object implements Action
   {
      
      public function OpenSocialAction() {
         super();
      }
      
      public static function create(param1:String=null) : OpenSocialAction {
         var _loc2_:OpenSocialAction = new OpenSocialAction();
         _loc2_.name = param1;
         return _loc2_;
      }
      
      public var name:String;
   }
}
