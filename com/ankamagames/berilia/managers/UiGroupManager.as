package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.UiGroup;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.event.UiRenderAskEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class UiGroupManager extends Object
   {
      
      public function UiGroupManager() {
         this._registeredGroup = new Array();
         this._uis = new Array();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            Berilia.getInstance().addEventListener(UiRenderAskEvent.UI_RENDER_ASK,this.onUiRenderAsk);
            return;
         }
      }
      
      protected static const _log:Logger;
      
      private static var _self:UiGroupManager;
      
      public static function getInstance() : UiGroupManager {
         if(!_self)
         {
            _self = new UiGroupManager();
         }
         return _self;
      }
      
      private var _registeredGroup:Array;
      
      private var _uis:Array;
      
      public function registerGroup(g:UiGroup) : void {
         this._registeredGroup[g.name] = g;
      }
      
      public function removeGroup(name:String) : void {
         delete this._registeredGroup[name];
      }
      
      public function getGroup(name:String) : UiGroup {
         return this._registeredGroup[name];
      }
      
      public function destroy() : void {
         Berilia.getInstance().removeEventListener(UiRenderAskEvent.UI_RENDER_ASK,this.onUiRenderAsk);
         _self = null;
      }
      
      private function onUiRenderAsk(e:UiRenderAskEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
