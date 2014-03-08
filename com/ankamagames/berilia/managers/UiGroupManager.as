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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiGroupManager));
      
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
      
      public function registerGroup(param1:UiGroup) : void {
         this._registeredGroup[param1.name] = param1;
      }
      
      public function removeGroup(param1:String) : void {
         delete this._registeredGroup[[param1]];
      }
      
      public function getGroup(param1:String) : UiGroup {
         return this._registeredGroup[param1];
      }
      
      public function destroy() : void {
         Berilia.getInstance().removeEventListener(UiRenderAskEvent.UI_RENDER_ASK,this.onUiRenderAsk);
         _self = null;
      }
      
      private function onUiRenderAsk(param1:UiRenderAskEvent) : void {
         var _loc3_:UiGroup = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:* = false;
         var _loc7_:String = null;
         if(!param1.uiData.uiGroupName || !this._registeredGroup[param1.uiData.uiGroupName])
         {
            return;
         }
         if(!this._uis[param1.uiData.uiGroupName])
         {
            this._uis[param1.uiData.uiGroupName] = new Array();
         }
         var _loc2_:UiGroup = this.getGroup(param1.uiData.uiGroupName);
         if(!_loc2_)
         {
            return;
         }
         for each (_loc3_ in this._registeredGroup)
         {
            if((_loc2_.exclusive) && !_loc3_.permanent && !(_loc3_.name == _loc2_.name))
            {
               if(this._uis[_loc3_.name] != null)
               {
                  _loc4_ = this._registeredGroup[_loc3_.name].uis;
                  for each (_loc5_ in _loc4_)
                  {
                     _loc6_ = true;
                     for each (_loc7_ in _loc2_.uis)
                     {
                        if(_loc5_ == _loc7_)
                        {
                           _loc6_ = false;
                        }
                     }
                     if((_loc6_) && !(_loc7_ == null))
                     {
                        Berilia.getInstance().unloadUi(_loc5_);
                     }
                     delete this._uis[_loc3_.name][[_loc5_]];
                  }
               }
            }
         }
         this._uis[param1.uiData.uiGroupName][param1.name] = param1.uiData;
      }
   }
}
