package com.ankamagames.arena.dofusmodule.adapter
{
   import flash.events.EventDispatcher;
   import flash.events.TextEvent;
   import flash.events.Event;
   import d2api.SystemApi;
   import d2api.TimeApi;
   import d2hooks.PlayerAggression;
   
   public class GeneralDofusCommunicator extends EventDispatcher implements IGeneralCommunicator
   {
      
      public function GeneralDofusCommunicator(sysApi:SystemApi, timeApi:TimeApi) {
         super();
         this._sysApi = sysApi;
         this._timeApi = timeApi;
         this._texts = new Array();
         this._sysApi.addHook(PlayerAggression,this.onAggro);
      }
      
      public static const EVT_DESTROY_FROM_DOFUS:String = "com.ankamagames.arena.dofusmodule.adapter.GeneralDofusCommunicator.EVT_DESTROY_FROM_DOFUS";
      
      public static const EVT_CLOSE_ARENA_IN_DOFUS_REQUEST:String = "com.ankamagames.arena.dofusmodule.adapter.GeneralDofusCommunicator.EVT_CLOSE_ARENA_IN_DOFUS_REQUEST";
      
      public static const EVT_AGGRO_IN_DOFUS:String = "com.ankamagames.arena.dofusmodule.adapter.GeneralDofusCommunicator.EVT_AGGRO_IN_DOFUS";
      
      public static const EVT_GET_TEXT_REQUEST:String = "com.ankamagames.arena.dofusmodule.adapter.GeneralDofusCommunicator.EVT_GET_TEXT_REQUEST";
      
      public static const EVT_DOFUS_CLOSE_BUTTON_CLICKED:String = "com.ankamagames.arena.dofusmodule.adapter.GeneralDofusCommunicator.EVT_DOFUS_CLOSE_BUTTON_CLICKED";
      
      public static const CLOSE_ARENA_KEY:String = "dofus_close_arena";
      
      public static const REDUCE_ARENA_KEY:String = "dofus_reduce_arena";
      
      public static const RESTORE_ARENA_KEY:String = "dofus_restore_arena";
      
      public function onAggro(attackerId:int, name:String) : void {
         dispatchEvent(new TextEvent(EVT_AGGRO_IN_DOFUS,false,false,name));
      }
      
      public function destroy() : void {
         dispatchEvent(new Event(EVT_DESTROY_FROM_DOFUS));
      }
      
      public function closeArenaRequest() : void {
         dispatchEvent(new Event(EVT_CLOSE_ARENA_IN_DOFUS_REQUEST));
      }
      
      public function setText(key:String, value:String) : void {
         this._texts[key] = value;
      }
      
      public function getText(key:String) : String {
         if(this._texts[key] == null)
         {
            dispatchEvent(new TextEvent(EVT_GET_TEXT_REQUEST,false,false,key));
         }
         return this._texts[key] == null?"":this._texts[key];
      }
      
      private var _sysApi:SystemApi;
      
      private var _texts:Array;
      
      private var _timeApi:TimeApi;
   }
}
