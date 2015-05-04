package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.RegisteringFrame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceListRequestAction;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceListMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceVersatileInfoListMessage;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildListRequestAction;
   import com.ankamagames.dofus.network.messages.game.guild.GuildListMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildVersatileInfoListMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.social.AllianceVersatileInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.social.GuildVersatileInformations;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.utils.crypto.Signature;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
   
   public class SocialDataFrame extends RegisteringFrame
   {
      
      public function SocialDataFrame()
      {
         var output:ByteArray = null;
         var signedData:ByteArray = null;
         var signature:Signature = null;
         var signatureIsValid:Boolean = false;
         this._guildList = new Vector.<GuildWrapper>();
         super();
         AllianceWrapper.clearCache();
         var serverId:int = PlayerManager.getInstance().server.id;
         var base_url:String = BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING?LOCAL_URL:ONLINE_URL;
         var configGameExport:String = XmlConfig.getInstance().getEntry("config.gameExport");
         if(configGameExport)
         {
            if(BuildInfos.BUILD_TYPE <= BuildTypeEnum.TESTING)
            {
               if(XmlConfig.getInstance().getEntry("config.gameExport.signature"))
               {
                  output = new ByteArray();
                  try
                  {
                     signedData = Base64.decodeToByteArray(XmlConfig.getInstance().getEntry("config.gameExport.signature"));
                     signedData.position = signedData.length;
                     signedData.writeUTFBytes(configGameExport);
                     signedData.position = 0;
                     signature = new Signature(SignedFileAdapter.defaultSignatureKey);
                     signatureIsValid = signature.verify(signedData,output);
                  }
                  catch(error:Error)
                  {
                     _log.error("gameExport signature has not been properly encoded in Base64.");
                  }
                  if(signatureIsValid)
                  {
                     base_url = configGameExport;
                  }
               }
               else
               {
                  _log.error("gameExport needs to be signed!");
               }
            }
            else
            {
               base_url = configGameExport;
            }
         }
         this._urlAllianceList = new Uri(base_url + "AllianceListMessage." + serverId + ".data");
         this._urlAllianceVersatileList = new Uri(base_url + "AllianceVersatileInfoListMessage." + serverId + ".data");
         this._urlGuildList = new Uri(base_url + "GuildListMessage." + serverId + ".data");
         this._urlGuildVersatileList = new Uri(base_url + "GuildVersatileInfoListMessage." + serverId + ".data");
         ConnectionsHandler.getHttpConnection().addToWhiteList(GuildVersatileInfoListMessage);
         ConnectionsHandler.getHttpConnection().addToWhiteList(GuildListMessage);
         ConnectionsHandler.getHttpConnection().addToWhiteList(AllianceVersatileInfoListMessage);
         ConnectionsHandler.getHttpConnection().addToWhiteList(AllianceListMessage);
         ConnectionsHandler.getHttpConnection().resetTime(this._urlAllianceList);
         ConnectionsHandler.getHttpConnection().resetTime(this._urlAllianceVersatileList);
         ConnectionsHandler.getHttpConnection().resetTime(this._urlGuildList);
         ConnectionsHandler.getHttpConnection().resetTime(this._urlGuildVersatileList);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialDataFrame));
      
      private static const LOCAL_URL:String = "http://gameservers-www-exports.dofus2.lan/";
      
      private static const ONLINE_URL:String = "http://dl.ak.ankama.com/games/dofus2/game-export/";
      
      private var _urlAllianceList:Uri;
      
      private var _urlAllianceVersatileList:Uri;
      
      private var _urlGuildList:Uri;
      
      private var _urlGuildVersatileList:Uri;
      
      private var _allianceList:Vector.<AllianceWrapper>;
      
      private var _guildList:Vector.<GuildWrapper>;
      
      private var _waitStaticAllianceInfo:Boolean;
      
      private var _waitVersatileAllianceInfo:Boolean;
      
      private var _waitStaticGuildInfo:Boolean;
      
      private var _waitVersatileGuildInfo:Boolean;
      
      public var versatileDataLifetime:uint = 300000.0;
      
      public var staticDataLifetime:uint = 900000.0;
      
      override public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      override protected function registerMessages() : void
      {
         register(AllianceListRequestAction,this.onAllianceListRequest);
         register(AllianceListMessage,this.onAllianceListMessage);
         register(AllianceVersatileInfoListMessage,this.onAllianceVersatileListMessage);
         register(GuildListRequestAction,this.onGuildListRequest);
         register(GuildListMessage,this.onGuildListMessage);
         register(GuildVersatileInfoListMessage,this.onGuildVersatileListMessage);
      }
      
      private function onGuildListRequest(param1:GuildListRequestAction) : Boolean
      {
         var _loc2_:Boolean = ConnectionsHandler.getHttpConnection().request(this._urlGuildList,this.onAllianceIoError,this.staticDataLifetime);
         if(_loc2_)
         {
            this._waitStaticGuildInfo = true;
         }
         var _loc3_:Boolean = ConnectionsHandler.getHttpConnection().request(this._urlGuildVersatileList,this.onGuildVersatileIoError,this.versatileDataLifetime);
         if(_loc3_)
         {
            this._waitVersatileGuildInfo = true;
         }
         if(!this._waitVersatileGuildInfo && !this._waitStaticGuildInfo)
         {
            this.dispatchGuildList();
         }
         return true;
      }
      
      private function onAllianceListRequest(param1:AllianceListRequestAction) : Boolean
      {
         var _loc2_:Boolean = ConnectionsHandler.getHttpConnection().request(this._urlAllianceList,this.onAllianceIoError,this.staticDataLifetime);
         if(_loc2_)
         {
            this._waitStaticAllianceInfo = true;
         }
         var _loc3_:Boolean = ConnectionsHandler.getHttpConnection().request(this._urlAllianceVersatileList,this.onAllianceVersatileIoError,this.versatileDataLifetime);
         if(_loc3_)
         {
            this._waitVersatileAllianceInfo = true;
         }
         if(!this._waitVersatileAllianceInfo && !this._waitStaticAllianceInfo)
         {
            this.dispatchAllianceList();
         }
         return true;
      }
      
      private function onAllianceListMessage(param1:AllianceListMessage) : Boolean
      {
         var _loc2_:uint = getTimer();
         this._allianceList = new Vector.<AllianceWrapper>();
         var _loc3_:uint = param1.alliances.length;
         var _loc4_:Vector.<AllianceFactSheetInformations> = param1.alliances;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            this._allianceList[_loc5_] = AllianceWrapper.getFromNetwork(_loc4_[_loc5_]);
            _loc5_++;
         }
         this._waitStaticAllianceInfo = false;
         this.dispatchAllianceList(true);
         return true;
      }
      
      private function onAllianceVersatileListMessage(param1:AllianceVersatileInfoListMessage) : Boolean
      {
         var _loc5_:AllianceWrapper = null;
         var _loc6_:* = 0;
         var _loc2_:uint = getTimer();
         var _loc3_:uint = param1.alliances.length;
         var _loc4_:Vector.<AllianceVersatileInformations> = param1.alliances;
         var _loc7_:AllianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
         var _loc8_:uint = 0;
         while(_loc8_ < _loc3_)
         {
            _loc6_ = -1;
            for each(_loc5_ in this._allianceList)
            {
               if(_loc5_.allianceId == _loc4_[_loc8_].allianceId)
               {
                  _loc6_ = this._allianceList.indexOf(_loc5_);
                  break;
               }
            }
            if(_loc6_ != -1)
            {
               this._allianceList[_loc6_] = AllianceWrapper.getFromNetwork(_loc4_[_loc8_]);
            }
            else if((_loc7_.hasAlliance) && _loc4_[_loc8_].allianceId == _loc7_.alliance.allianceId)
            {
               _loc5_ = _loc7_.alliance.clone();
               _loc5_.nbGuilds = _loc4_[_loc8_].nbGuilds;
               _loc5_.nbMembers = _loc4_[_loc8_].nbMembers;
               _loc5_.nbSubareas = _loc4_[_loc8_].nbSubarea;
               AllianceWrapper.updateRef(_loc5_.allianceId,_loc5_);
               this._allianceList.push(_loc5_);
            }
            
            _loc8_++;
         }
         this._waitVersatileAllianceInfo = false;
         this.dispatchAllianceList(true);
         return true;
      }
      
      private function onGuildListMessage(param1:GuildListMessage) : Boolean
      {
         var _loc2_:uint = getTimer();
         this._guildList = new Vector.<GuildWrapper>();
         var _loc3_:uint = param1.guilds.length;
         var _loc4_:Vector.<GuildInformations> = param1.guilds;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            this._guildList[_loc5_] = GuildWrapper.getFromNetwork(_loc4_[_loc5_]);
            _loc5_++;
         }
         this._waitStaticGuildInfo = false;
         this.dispatchGuildList(true);
         return true;
      }
      
      private function onGuildVersatileListMessage(param1:GuildVersatileInfoListMessage) : Boolean
      {
         var _loc5_:GuildWrapper = null;
         var _loc6_:* = 0;
         var _loc2_:uint = getTimer();
         var _loc3_:uint = param1.guilds.length;
         var _loc4_:Vector.<GuildVersatileInformations> = param1.guilds;
         var _loc7_:SocialFrame = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
         var _loc8_:uint = 0;
         while(_loc8_ < _loc3_)
         {
            _loc6_ = -1;
            for each(_loc5_ in this._guildList)
            {
               if(_loc5_.guildId == _loc4_[_loc8_].guildId)
               {
                  _loc6_ = this._guildList.indexOf(_loc5_);
                  break;
               }
            }
            if(_loc6_ != -1)
            {
               this._guildList[_loc6_] = GuildWrapper.getFromNetwork(_loc4_[_loc8_]);
            }
            else if((_loc7_.hasGuild) && _loc4_[_loc8_].guildId == _loc7_.guild.guildId)
            {
               _loc5_ = _loc7_.guild.clone();
               _loc5_.level = _loc4_[_loc8_].guildLevel;
               _loc5_.leaderId = _loc4_[_loc8_].leaderId;
               _loc5_.nbMembers = _loc4_[_loc8_].nbMembers;
               GuildWrapper.updateRef(_loc5_.guildId,_loc5_);
               this._guildList.push(_loc5_);
            }
            
            _loc8_++;
         }
         this._waitVersatileGuildInfo = false;
         this.dispatchGuildList(true);
         return true;
      }
      
      private function dispatchGuildList(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:GuildWrapper = null;
         if((this._waitStaticGuildInfo) || (this._waitVersatileGuildInfo))
         {
            return;
         }
         for each(_loc3_ in this._guildList)
         {
            GuildWrapper.updateRef(_loc3_.guildId,_loc3_);
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.GuildList,this._guildList,param1,this._guildList == null || param2);
      }
      
      private function dispatchAllianceList(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:AllianceWrapper = null;
         if((this._waitStaticAllianceInfo) || (this._waitVersatileAllianceInfo))
         {
            return;
         }
         for each(_loc3_ in this._allianceList)
         {
            AllianceWrapper.updateRef(_loc3_.allianceId,_loc3_);
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceList,this._allianceList,param1,this._allianceList == null || param2);
      }
      
      private function onAllianceIoError() : void
      {
         _log.error("Impossible d\'accéder aux données static de liste d\'alliance");
         this._waitStaticAllianceInfo = false;
         this.dispatchAllianceList(false,true);
      }
      
      private function onAllianceVersatileIoError() : void
      {
         _log.error("Impossible d\'accéder aux données versatile de liste d\'alliance");
         this._waitVersatileAllianceInfo = false;
         this.dispatchAllianceList(false,true);
      }
      
      private function onGuildIoError() : void
      {
         _log.error("Impossible d\'accéder aux données static de liste de guilde");
         this._waitStaticGuildInfo = false;
         this.dispatchGuildList(false,true);
      }
      
      private function onGuildVersatileIoError() : void
      {
         _log.error("Impossible d\'accéder aux données versatile de liste de guilde");
         this._waitVersatileGuildInfo = false;
         this.dispatchGuildList(false,true);
      }
   }
}
