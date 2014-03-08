package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenMapAction extends Object implements Action
   {
      
      public function OpenMapAction() {
         super();
      }
      
      public static function create(conquest:Boolean=false) : OpenMapAction {
         var a:OpenMapAction = new OpenMapAction();
         a.conquest = conquest;
         return a;
      }
      
      public var conquest:Boolean;
   }
}
