package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenSocialAction extends Object implements Action
   {
      
      public function OpenSocialAction() {
         super();
      }
      
      public static function create(name:String = null) : OpenSocialAction {
         var a:OpenSocialAction = new OpenSocialAction();
         a.name = name;
         return a;
      }
      
      public var name:String;
   }
}
