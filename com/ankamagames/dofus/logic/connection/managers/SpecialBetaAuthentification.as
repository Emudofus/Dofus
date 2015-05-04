package com.ankamagames.dofus.logic.connection.managers
{
   import flash.events.EventDispatcher;
   import com.ankamagames.dofus.misc.utils.RpcServiceManager;
   import flash.events.Event;
   import com.ankamagames.dofus.misc.utils.RpcServiceCenter;
   import flash.utils.setTimeout;
   
   public class SpecialBetaAuthentification extends EventDispatcher
   {
      
      public function SpecialBetaAuthentification(param1:String, param2:String)
      {
         super();
         var _loc3_:Array = [];
         switch(param2)
         {
            case STREAMING:
               _loc3_.push(1210,1080,1008,1127,1508);
               break;
            case MODULES:
               _loc3_.push(1127);
               break;
         }
         this._haveAccess = false;
         if(_loc3_.length)
         {
            this._rpc = new RpcServiceManager(RpcServiceCenter.getInstance().apiDomain + "/forum/forum.json","json");
            this._rpc.addEventListener(Event.COMPLETE,this.onDataReceived);
            this._rpc.callMethod("IsAuthorized",["dofus","fr",param1,_loc3_]);
         }
         else
         {
            setTimeout(dispatchEvent,1,new Event(Event.INIT));
         }
      }
      
      public static const STREAMING:String = "streaming";
      
      public static const MODULES:String = "modules";
      
      private var _rpc:RpcServiceManager;
      
      private var _haveAccess:Boolean = false;
      
      public function get haveAccess() : Boolean
      {
         return this._haveAccess;
      }
      
      private function onDataReceived(param1:Event) : void
      {
         var _loc2_:* = false;
         var _loc3_:* = true;
         if(!_loc2_)
         {
            this._haveAccess = this._rpc.getAllResultData();
            if(_loc3_)
            {
            }
            return;
         }
         dispatchEvent(new Event(Event.INIT));
      }
   }
}
