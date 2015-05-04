package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.internalDatacenter.connection.BasicCharacterWrapper;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class PlayerManager extends Object implements IDestroyable
   {
      
      public function PlayerManager()
      {
         super();
         if(!this._connexionTime)
         {
            this._connexionTime = new Date().getTime();
         }
         if(_self != null)
         {
            throw new SingletonError("PlayerManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            return;
         }
      }
      
      private static var _self:PlayerManager;
      
      public static function getInstance() : PlayerManager
      {
         if(_self == null)
         {
            _self = new PlayerManager();
         }
         return _self;
      }
      
      public var accountId:uint;
      
      public var communityId:uint;
      
      public var hasRights:Boolean;
      
      public var nickname:String;
      
      public var subscriptionEndDate:Number;
      
      public var secretQuestion:String;
      
      public var adminStatus:int;
      
      public var passkey:String;
      
      public var accountCreation:Number;
      
      private var _server:Server;
      
      public var serverCommunityId:int = -1;
      
      public var serverLang:String;
      
      public var serverGameType:int = -1;
      
      public var serversList:Vector.<int>;
      
      public var charactersList:Vector.<BasicCharacterWrapper>;
      
      public var allowAutoConnectCharacter:Boolean = false;
      
      public var autoConnectOfASpecificCharacterId:int = -1;
      
      private var _subscriptionDurationElapsed:Number;
      
      private var _connexionTime:Number;
      
      public function set server(param1:Server) : void
      {
         this._server = param1;
      }
      
      public function get server() : Server
      {
         if(this._server)
         {
            if(this.serverCommunityId > -1)
            {
               this._server.communityId = this.serverCommunityId;
            }
            if(this.serverGameType > -1)
            {
               this._server.gameTypeId = this.serverGameType;
            }
            if(this.serverLang != "")
            {
               this._server.language = this.serverLang;
            }
         }
         return this._server;
      }
      
      public function get subscriptionDurationElapsed() : Number
      {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         if(this.subscriptionEndDate > this._connexionTime)
         {
            _loc1_ = new Date().getTime();
            _loc2_ = Math.min(this.subscriptionEndDate,_loc1_) - this._connexionTime;
            if(_loc2_ > 0)
            {
               return this._subscriptionDurationElapsed + Math.floor(_loc2_ / 1000);
            }
         }
         return this._subscriptionDurationElapsed;
      }
      
      public function set subscriptionDurationElapsed(param1:Number) : void
      {
         this._subscriptionDurationElapsed = param1;
      }
      
      public function destroy() : void
      {
         _self = null;
      }
   }
}
