package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenMapAction extends Object implements Action
   {
      
      public function OpenMapAction()
      {
         super();
      }
      
      public static function create(param1:Boolean = false, param2:Boolean = true, param3:Boolean = false) : OpenMapAction
      {
         var _loc4_:OpenMapAction = new OpenMapAction();
         _loc4_.ignoreSetting = param1;
         _loc4_.pocket = param2;
         _loc4_.conquest = param3;
         return _loc4_;
      }
      
      public var conquest:Boolean;
      
      public var pocket:Boolean;
      
      public var ignoreSetting:Boolean;
   }
}
