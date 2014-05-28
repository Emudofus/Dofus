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
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public class SocialDataFrame extends RegisteringFrame
   {
      
      public function SocialDataFrame() {
         super();
         AllianceWrapper.clearCache();
         var serverId:int = PlayerManager.getInstance().server.id;
         var base_url:String = BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING?LOCAL_URL:ONLINE_URL;
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
      
      protected static const _log:Logger;
      
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
      
      override public function get priority() : int {
         return Priority.NORMAL;
      }
      
      override protected function registerMessages() : void {
         register(AllianceListRequestAction,this.onAllianceListRequest);
         register(AllianceListMessage,this.onAllianceListMessage);
         register(AllianceVersatileInfoListMessage,this.onAllianceVersatileListMessage);
         register(GuildListRequestAction,this.onGuildListRequest);
         register(GuildListMessage,this.onGuildListMessage);
         register(GuildVersatileInfoListMessage,this.onGuildVersatileListMessage);
      }
      
      private function onGuildListRequest(a:GuildListRequestAction) : Boolean {
         var newStaticRequest:Boolean = ConnectionsHandler.getHttpConnection().request(this._urlGuildList,this.onAllianceIoError,this.staticDataLifetime);
         if(newStaticRequest)
         {
            this._waitStaticGuildInfo = true;
         }
         var newVersatileRequest:Boolean = ConnectionsHandler.getHttpConnection().request(this._urlGuildVersatileList,this.onGuildVersatileIoError,this.versatileDataLifetime);
         if(newVersatileRequest)
         {
            this._waitVersatileGuildInfo = true;
         }
         if((!this._waitVersatileGuildInfo) && (!this._waitStaticGuildInfo))
         {
            this.dispatchGuildList();
         }
         return true;
      }
      
      private function onAllianceListRequest(a:AllianceListRequestAction) : Boolean {
         var newStaticRequest:Boolean = ConnectionsHandler.getHttpConnection().request(this._urlAllianceList,this.onAllianceIoError,this.staticDataLifetime);
         if(newStaticRequest)
         {
            this._waitStaticAllianceInfo = true;
         }
         var newVersatileRequest:Boolean = ConnectionsHandler.getHttpConnection().request(this._urlAllianceVersatileList,this.onAllianceVersatileIoError,this.versatileDataLifetime);
         if(newVersatileRequest)
         {
            this._waitVersatileAllianceInfo = true;
         }
         if((!this._waitVersatileAllianceInfo) && (!this._waitStaticAllianceInfo))
         {
            this.dispatchAllianceList();
         }
         return true;
      }
      
      private function onAllianceListMessage(m:AllianceListMessage) : Boolean {
         var ts:uint = getTimer();
         this._allianceList = new Vector.<AllianceWrapper>();
         var len:uint = m.alliances.length;
         var list:Vector.<AllianceFactSheetInformations> = m.alliances;
         var i:uint = 0;
         while(i < len)
         {
            this._allianceList[i] = AllianceWrapper.getFromNetwork(list[i]);
            i++;
         }
         this._waitStaticAllianceInfo = false;
         this.dispatchAllianceList(true);
         return true;
      }
      
      private function onAllianceVersatileListMessage(m:AllianceVersatileInfoListMessage) : Boolean {
         var alliance:AllianceWrapper = null;
         var allianceIndex:* = 0;
         var ts:uint = getTimer();
         var len:uint = m.alliances.length;
         var list:Vector.<AllianceVersatileInformations> = m.alliances;
         var allianceFrame:AllianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
         var i:uint = 0;
         while(i < len)
         {
            allianceIndex = -1;
            for each(alliance in this._allianceList)
            {
               if(alliance.allianceId == list[i].allianceId)
               {
                  allianceIndex = this._allianceList.indexOf(alliance);
                  break;
               }
            }
            if(allianceIndex != -1)
            {
               this._allianceList[allianceIndex] = AllianceWrapper.getFromNetwork(list[i]);
            }
            else if((allianceFrame.hasAlliance) && (list[i].allianceId == allianceFrame.alliance.allianceId))
            {
               alliance = allianceFrame.alliance.clone();
               alliance.nbGuilds = list[i].nbGuilds;
               alliance.nbMembers = list[i].nbMembers;
               alliance.nbSubareas = list[i].nbSubarea;
               AllianceWrapper.updateRef(alliance.allianceId,alliance);
               this._allianceList.push(alliance);
            }
            
            i++;
         }
         this._waitVersatileAllianceInfo = false;
         this.dispatchAllianceList(true);
         return true;
      }
      
      private function onGuildListMessage(m:GuildListMessage) : Boolean {
         var ts:uint = getTimer();
         this._guildList = new Vector.<GuildWrapper>();
         var len:uint = m.guilds.length;
         var list:Vector.<GuildInformations> = m.guilds;
         var i:uint = 0;
         while(i < len)
         {
            this._guildList[i] = GuildWrapper.getFromNetwork(list[i]);
            i++;
         }
         this._waitStaticGuildInfo = false;
         this.dispatchGuildList(true);
         return true;
      }
      
      private function onGuildVersatileListMessage(m:GuildVersatileInfoListMessage) : Boolean {
         var guild:GuildWrapper = null;
         var guildIndex:* = 0;
         var ts:uint = getTimer();
         var len:uint = m.guilds.length;
         var list:Vector.<GuildVersatileInformations> = m.guilds;
         var socialFrame:SocialFrame = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
         var i:uint = 0;
         while(i < len)
         {
            guildIndex = -1;
            for each(guild in this._guildList)
            {
               if(guild.guildId == list[i].guildId)
               {
                  guildIndex = this._guildList.indexOf(guild);
                  break;
               }
            }
            if(guildIndex != -1)
            {
               this._guildList[guildIndex] = GuildWrapper.getFromNetwork(list[i]);
            }
            else if((socialFrame.hasGuild) && (list[i].guildId == socialFrame.guild.guildId))
            {
               guild = socialFrame.guild.clone();
               guild.level = list[i].guildLevel;
               guild.leaderId = list[i].leaderId;
               guild.nbMembers = list[i].nbMembers;
               GuildWrapper.updateRef(guild.guildId,guild);
               this._guildList.push(guild);
            }
            
            i++;
         }
         this._waitVersatileGuildInfo = false;
         this.dispatchGuildList(true);
         return true;
      }
      
      private function dispatchGuildList(isUpdate:Boolean = false, isError:Boolean = false) : void {
         if((this._waitStaticGuildInfo) || (this._waitVersatileGuildInfo))
         {
            return;
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.GuildList,this._guildList,isUpdate,this._guildList == null || isError);
      }
      
      private function dispatchAllianceList(isUpdate:Boolean = false, isError:Boolean = false) : void {
         if((this._waitStaticAllianceInfo) || (this._waitVersatileAllianceInfo))
         {
            return;
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceList,this._allianceList,isUpdate,this._allianceList == null || isError);
      }
      
      private function onAllianceIoError() : void {
         _log.error("Impossible d\'accéder aux données static de liste d\'alliance");
         this._waitStaticAllianceInfo = false;
         this.dispatchAllianceList(false,true);
      }
      
      private function onAllianceVersatileIoError() : void {
         _log.error("Impossible d\'accéder aux données versatile de liste d\'alliance");
         this._waitVersatileAllianceInfo = false;
         this.dispatchAllianceList(false,true);
      }
      
      private function onGuildIoError() : void {
         _log.error("Impossible d\'accéder aux données static de liste de guilde");
         this._waitStaticGuildInfo = false;
         this.dispatchGuildList(false,true);
      }
      
      private function onGuildVersatileIoError() : void {
         _log.error("Impossible d\'accéder aux données versatile de liste de guilde");
         this._waitVersatileGuildInfo = false;
         this.dispatchGuildList(false,true);
      }
   }
}
