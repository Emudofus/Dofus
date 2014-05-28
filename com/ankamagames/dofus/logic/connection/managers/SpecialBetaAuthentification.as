package com.ankamagames.dofus.logic.connection.managers
{
   import flash.events.EventDispatcher;
   import com.ankamagames.dofus.misc.utils.RpcServiceManager;
   import flash.events.Event;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import flash.utils.setTimeout;
   
   public class SpecialBetaAuthentification extends EventDispatcher
   {
      
      public function SpecialBetaAuthentification(login:String, type:String) {
         super();
         var url:String = BASE_URL;
         if((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.ALPHA))
         {
            url = url + "com";
         }
         else
         {
            url = url + "lan";
         }
         var forumId:Array = [];
         switch(type)
         {
            case STREAMING:
               forumId.push(1210,1080,1008,1127);
               break;
            case MODULES:
               forumId.push(1127);
               break;
         }
         this._haveAccess = false;
         if(forumId.length)
         {
            this._rpc = new RpcServiceManager(url + "/forum/forum.json","json");
            this._rpc.addEventListener(Event.COMPLETE,this.onDataReceived);
            this._rpc.callMethod("IsAuthorized",["dofus","fr",login,forumId]);
         }
         else
         {
            setTimeout(dispatchEvent,1,new Event(Event.INIT));
         }
      }
      
      private static var BASE_URL:String = "http://api.ankama.";
      
      public static const STREAMING:String = "streaming";
      
      public static const MODULES:String = "modules";
      
      private var _rpc:RpcServiceManager;
      
      private var _haveAccess:Boolean = false;
      
      public function get haveAccess() : Boolean {
         return this._haveAccess;
      }
      
      private function onDataReceived(e:Event) : void {
         var _loc2_:* = true;
         var _loc3_:* = false;
         this._haveAccess = this._rpc.getAllResultData();
         dispatchEvent(new Event(Event.INIT));
      }
   }
}
