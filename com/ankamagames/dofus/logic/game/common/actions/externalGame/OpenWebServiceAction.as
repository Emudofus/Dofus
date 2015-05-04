package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenWebServiceAction extends Object implements Action
   {
      
      public function OpenWebServiceAction()
      {
         super();
      }
      
      public static function create(param1:String = "", param2:Object = null) : OpenWebServiceAction
      {
         var _loc3_:OpenWebServiceAction = new OpenWebServiceAction();
         _loc3_.uiName = param1;
         _loc3_.uiParams = param2;
         return _loc3_;
      }
      
      public var uiName:String;
      
      public var uiParams:Object;
   }
}
