package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.logic.connection.frames.ServerSelectionFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public class ConnectionApi extends Object implements IApi
   {
      
      public function ConnectionApi() {
         super();
      }
      
      private function get serverSelectionFrame() : ServerSelectionFrame {
         return Kernel.getWorker().getFrame(ServerSelectionFrame) as ServerSelectionFrame;
      }
      
      public function getUsedServers() : Vector.<GameServerInformations> {
         return this.serverSelectionFrame.usedServers;
      }
      
      public function getServers() : Vector.<GameServerInformations> {
         return this.serverSelectionFrame.servers;
      }
      
      public function isCharacterWaitingForChange(param1:int) : Boolean {
         var _loc2_:GameServerApproachFrame = Kernel.getWorker().getFrame(GameServerApproachFrame) as GameServerApproachFrame;
         if(_loc2_)
         {
            return _loc2_.isCharacterWaitingForChange(param1);
         }
         return false;
      }
      
      public function allowAutoConnectCharacter(param1:Boolean) : void {
         PlayerManager.getInstance().allowAutoConnectCharacter = param1;
         PlayerManager.getInstance().autoConnectOfASpecificCharacterId = -1;
      }
      
      public function getAutochosenServer() : GameServerInformations {
         var _loc4_:GameServerInformations = null;
         var _loc5_:Object = null;
         var _loc6_:GameServerInformations = null;
         var _loc7_:Object = null;
         var _loc8_:* = 0;
         var _loc9_:GameServerInformations = null;
         var _loc10_:Object = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         var _loc3_:int = PlayerManager.getInstance().communityId;
         for each (_loc4_ in this.serverSelectionFrame.servers)
         {
            _loc5_ = Server.getServerById(_loc4_.id);
            if(_loc5_)
            {
               if(_loc5_.communityId == _loc3_ || (_loc3_ == 1 || _loc3_ == 2) && (_loc5_.communityId == 1 || _loc5_.communityId == 2))
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         if(_loc2_.length == 0)
         {
            for each (_loc6_ in this.serverSelectionFrame.servers)
            {
               _loc7_ = Server.getServerById(_loc6_.id);
               if((_loc7_) && _loc7_.communityId == 2)
               {
                  _loc2_.push(_loc6_);
               }
            }
         }
         _loc2_.sortOn("completion",Array.NUMERIC);
         if(_loc2_.length > 0)
         {
            _loc8_ = -1;
            for each (_loc9_ in _loc2_)
            {
               _loc10_ = Server.getServerById(_loc9_.id);
               if(_loc9_.status == 3 && _loc8_ == -1)
               {
                  _loc8_ = _loc9_.completion;
               }
               if(!(_loc8_ == -1) && _loc10_.population.id == _loc8_ && _loc9_.status == 3)
               {
                  if(!(BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || _loc10_.name.indexOf("Test") == -1)
                  {
                     _loc1_.push(_loc9_);
                  }
               }
            }
            if(_loc1_.length > 0)
            {
               return _loc1_[Math.floor(Math.random() * _loc1_.length)];
            }
         }
         return null;
      }
   }
}
