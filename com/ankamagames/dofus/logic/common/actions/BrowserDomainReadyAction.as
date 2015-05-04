package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.berilia.components.WebBrowser;
   
   public class BrowserDomainReadyAction extends Object implements Action
   {
      
      public function BrowserDomainReadyAction()
      {
         super();
      }
      
      public static function create(param1:WebBrowser) : BrowserDomainReadyAction
      {
         var _loc2_:BrowserDomainReadyAction = new BrowserDomainReadyAction();
         _loc2_.browser = param1;
         return _loc2_;
      }
      
      public var browser:WebBrowser;
   }
}
