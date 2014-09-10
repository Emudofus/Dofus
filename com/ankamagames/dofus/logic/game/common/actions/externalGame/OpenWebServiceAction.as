package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenWebServiceAction extends Object implements Action
   {
      
      public function OpenWebServiceAction() {
         super();
      }
      
      public static function create(uiName:String = "", uiParams:Object = null) : OpenWebServiceAction {
         var action:OpenWebServiceAction = new OpenWebServiceAction();
         action.uiName = uiName;
         action.uiParams = uiParams;
         return action;
      }
      
      public var uiName:String;
      
      public var uiParams:Object;
   }
}
