package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.UtilApi;
   import d2api.ChatApi;
   import d2api.SocialApi;
   import d2api.DataApi;
   import d2api.PlayedCharacterApi;
   import d2data.GuildWrapper;
   import d2data.AllianceWrapper;
   import flash.utils.Dictionary;
   import d2components.Grid;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.AggressableStatusEnum;
   import d2data.EmblemSymbol;
   
   public class AllianceMembers extends Object
   {
      
      public function AllianceMembers() {
         this._compsLblName = new Dictionary(true);
         this._compsBtnLeader = new Dictionary(true);
         this._compsBtnKick = new Dictionary(true);
         this._compsTxEmblem = new Dictionary(true);
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var utilApi:UtilApi;
      
      public var chatApi:ChatApi;
      
      public var modCommon:Object;
      
      public var socialApi:SocialApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      private var _guildsList:Array;
      
      private var _emblemsPath:String;
      
      private var _myGuild:GuildWrapper;
      
      private var _myAlliance:AllianceWrapper;
      
      private var _bDescendingSort:Boolean = false;
      
      private var _compsLblName:Dictionary;
      
      private var _compsBtnLeader:Dictionary;
      
      private var _compsBtnKick:Dictionary;
      
      private var _compsTxEmblem:Dictionary;
      
      private var _guildIdWaitingForKick:int;
      
      private var _guildIdWaitingForLeader:int;
      
      private var _avaEnabled:Boolean = false;
      
      public var gd_guilds:Grid;
      
      public var btn_lbl_btn_ava:Label;
      
      public var btn_ava:ButtonContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var btn_tabMembers:ButtonContainer;
      
      public function main(... params) : void {
         var g:Object = null;
         var playerAlignment:Object = null;
         this.sysApi.addHook(AllianceUpdateInformations,this.onAllianceUpdateInformations);
         this.sysApi.addHook(PvpAvaStateChange,this.onPvpAvaStateChange);
         this.uiApi.addComponentHook(this.btn_ava,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_ava,ComponentHookList.ON_ROLL_OUT);
         this._emblemsPath = this.uiApi.me().getConstant("emblems_uri");
         this._myGuild = this.socialApi.getGuild();
         this._myAlliance = this.socialApi.getAlliance();
         this._avaEnabled = false;
         if(this.playerApi.getPlayedCharacterInfo().level >= 50)
         {
            playerAlignment = this.playerApi.characteristics().alignmentInfos;
            if((playerAlignment.aggressable == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE) || (playerAlignment.aggressable == AggressableStatusEnum.AvA_ENABLED_NON_AGGRESSABLE) || (playerAlignment.aggressable == AggressableStatusEnum.AvA_DISQUALIFIED) || (playerAlignment.aggressable == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE))
            {
               this._avaEnabled = true;
            }
         }
         else
         {
            this.btn_ava.softDisabled = true;
         }
         if(this._avaEnabled)
         {
            this.btn_lbl_btn_ava.text = this.uiApi.getText("ui.alliance.disableAvA");
         }
         else
         {
            this.btn_lbl_btn_ava.text = this.uiApi.getText("ui.alliance.enableAvA");
         }
         var tempGuilds:Object = this.socialApi.getAllianceGuilds();
         this._guildsList = new Array();
         for each(g in tempGuilds)
         {
            this._guildsList.push(g);
         }
         this.gd_guilds.dataProvider = this._guildsList;
      }
      
      public function unload() : void {
      }
      
      public function updateGuildLine(data:*, components:*, selected:Boolean) : void {
         var icon:EmblemSymbol = null;
         if(!this._compsBtnKick[components.btn_kick.name])
         {
            this.uiApi.addComponentHook(components.btn_kick,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_kick,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_kick,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsBtnKick[components.btn_kick.name] = data;
         if(!this._compsBtnLeader[components.btn_giveLeadership.name])
         {
            this.uiApi.addComponentHook(components.btn_giveLeadership,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_giveLeadership,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_giveLeadership,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsBtnLeader[components.btn_giveLeadership.name] = data;
         if(!this._compsLblName[components.lbl_guildName.name])
         {
            this.uiApi.addComponentHook(components.lbl_guildName,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.lbl_guildName,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsLblName[components.lbl_guildName.name] = data;
         if(!this._compsLblName[components.lbl_members.name])
         {
            this.uiApi.addComponentHook(components.lbl_members,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.lbl_members,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsLblName[components.lbl_members.name] = data;
         if(!this._compsLblName[components.tx_disabledGuild.name])
         {
            this.uiApi.addComponentHook(components.tx_disabledGuild,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_disabledGuild,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsLblName[components.tx_disabledGuild.name] = true;
         if(!this._compsLblName[components.tx_leader.name])
         {
            this.uiApi.addComponentHook(components.tx_leader,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_leader,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsLblName[components.tx_leader.name] = true;
         this._compsTxEmblem[components.tx_emblemBack.name] = data;
         this._compsTxEmblem[components.tx_emblemUp.name] = data;
         if(data != null)
         {
            components.lbl_guildName.text = this.chatApi.getGuildLink(data,data.guildName);
            components.lbl_leaderName.text = this.uiApi.getText("ui.guild.leadBy","{player," + data.leaderName + "," + data.leaderId + "::" + data.leaderName + "}");
            components.lbl_lvl.text = data.guildLevel;
            components.lbl_perco.text = data.nbTaxCollectors + " " + this.uiApi.getText("ui.social.guildTaxCollectors").toLowerCase();
            components.lbl_members.text = this.uiApi.getText("ui.guild.onlineMembers",data.nbConnectedMembers,data.nbMembers);
            components.tx_emblemBack.uri = this.uiApi.createUri(this._emblemsPath + "icons/back/" + data.backEmblem.idEmblem + ".png");
            components.tx_emblemUp.uri = this.uiApi.createUri(this._emblemsPath + "icons/up/" + data.upEmblem.idEmblem + ".png");
            this.utilApi.changeColor(components.tx_emblemBack,data.backEmblem.color,1);
            icon = this.dataApi.getEmblemSymbol(data.upEmblem.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(components.tx_emblemUp,data.upEmblem.color,0);
            }
            else
            {
               this.utilApi.changeColor(components.tx_emblemUp,data.upEmblem.color,0,true);
            }
            if(data.enabled)
            {
               components.tx_disabledGuild.visible = false;
            }
            else
            {
               components.tx_disabledGuild.visible = true;
            }
            if(data.allianceLeader)
            {
               components.tx_leader.visible = true;
            }
            else
            {
               components.tx_leader.visible = false;
            }
            if((this._myGuild.guildId == this._myAlliance.leaderGuildId) && (this.socialApi.hasGuildRight(this.playerApi.id(),"isBoss")))
            {
               components.btn_kick.visible = true;
               if(this._myGuild.guildId == data.guildId)
               {
                  components.btn_giveLeadership.visible = false;
               }
               else
               {
                  components.btn_giveLeadership.visible = true;
               }
            }
            else
            {
               components.btn_giveLeadership.visible = false;
               if((this._myGuild.guildId == data.guildId) && (this.socialApi.hasGuildRight(this.playerApi.id(),"isBoss")))
               {
                  components.btn_kick.visible = true;
               }
               else
               {
                  components.btn_kick.visible = false;
               }
            }
         }
         else
         {
            components.lbl_guildName.text = "";
            components.lbl_leaderName.text = "";
            components.lbl_lvl.text = "";
            components.lbl_perco.text = "";
            components.lbl_members.text = "";
            components.tx_emblemBack.uri = null;
            components.tx_emblemUp.uri = null;
            components.tx_leader.visible = false;
            components.tx_disabledGuild.visible = false;
            components.btn_giveLeadership.visible = false;
            components.btn_kick.visible = false;
         }
      }
      
      private function popupDeleteGuild(data:Object) : void {
         var text:String = null;
         if((data.guildId == this._myAlliance.leaderGuildId) && (this._guildsList.length > 1))
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.alliance.guildLeaderCantBeBanned"),[this.uiApi.getText("ui.common.ok")]);
         }
         else
         {
            if(this._myGuild.guildId == data.guildId)
            {
               text = this.uiApi.getText("ui.alliance.quitConfirm");
            }
            else
            {
               text = this.uiApi.getText("ui.alliance.kickConfirm",data.guildName);
            }
            this._guildIdWaitingForKick = data.guildId;
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),text,[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmDeleteGuild,this.onCancelDeleteGuild],this.onConfirmDeleteGuild,this.onCancelDeleteGuild);
         }
      }
      
      private function onConfirmDeleteGuild() : void {
         this.sysApi.sendAction(new AllianceKickRequest(this._guildIdWaitingForKick));
         this._guildIdWaitingForKick = 0;
      }
      
      private function onCancelDeleteGuild() : void {
         this._guildIdWaitingForKick = 0;
      }
      
      private function popupLeaderGuild(data:Object) : void {
         var text:String = this.uiApi.getText("ui.alliance.giveLeadershipConfirm",data.guildName);
         this._guildIdWaitingForLeader = data.guildId;
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),text,[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmLeaderGuild,this.onCancelLeaderGuild],this.onConfirmLeaderGuild,this.onCancelLeaderGuild);
      }
      
      private function onConfirmLeaderGuild() : void {
         this.sysApi.sendAction(new AllianceChangeGuildRights(this._guildIdWaitingForLeader,1));
         this._guildIdWaitingForLeader = 0;
      }
      
      private function onCancelLeaderGuild() : void {
         this._guildIdWaitingForLeader = 0;
      }
      
      private function onAllianceUpdateInformations() : void {
         var g:Object = null;
         var tempGuilds:Object = this.socialApi.getAllianceGuilds();
         this._guildsList = new Array();
         for each(g in tempGuilds)
         {
            this._guildsList.push(g);
         }
         this.gd_guilds.dataProvider = this._guildsList;
      }
      
      private function onPvpAvaStateChange(status:int, probationTime:uint) : void {
         if((status == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE) || (status == AggressableStatusEnum.AvA_ENABLED_NON_AGGRESSABLE) || (status == AggressableStatusEnum.AvA_DISQUALIFIED) || (status == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE))
         {
            this._avaEnabled = true;
            this.btn_lbl_btn_ava.text = this.uiApi.getText("ui.alliance.disableAvA");
         }
         else
         {
            this._avaEnabled = false;
            this.btn_lbl_btn_ava.text = this.uiApi.getText("ui.alliance.enableAvA");
         }
      }
      
      public function onRelease(target:Object) : void {
         var data:Object = null;
         var data2:Object = null;
         if((target == this.btn_ava) && (this.btn_ava.softDisabled == false))
         {
            this.sysApi.sendAction(new SetEnableAVARequest(!this._avaEnabled));
         }
         if(target == this.btn_tabName)
         {
            if(this._bDescendingSort)
            {
               this.gd_guilds.sortOn("guildName",Array.CASEINSENSITIVE);
            }
            else
            {
               this.gd_guilds.sortOn("guildName",Array.CASEINSENSITIVE | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target == this.btn_tabLevel)
         {
            if(this._bDescendingSort)
            {
               this.gd_guilds.sortOn("guildLevel",Array.NUMERIC);
            }
            else
            {
               this.gd_guilds.sortOn("guildLevel",Array.NUMERIC | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target == this.btn_tabMembers)
         {
            if(this._bDescendingSort)
            {
               this.gd_guilds.sortOn("nbConnectedMembers",Array.NUMERIC);
            }
            else
            {
               this.gd_guilds.sortOn("nbConnectedMembers",Array.NUMERIC | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target.name.indexOf("btn_giveLeadership") != -1)
         {
            data = this._compsBtnLeader[target.name];
            this.popupLeaderGuild(data);
         }
         else if(target.name.indexOf("btn_kick") != -1)
         {
            data2 = this._compsBtnKick[target.name];
            this.popupDeleteGuild(data2);
         }
         
         
         
         
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var data:Object = null;
         var months:* = 0;
         var days:* = 0;
         var hours:* = 0;
         var argText:String = null;
         var point:uint = 6;
         var relPoint:uint = 0;
         if(target.name.indexOf("btn_giveLeadership") != -1)
         {
            tooltipText = this.uiApi.getText("ui.alliance.giveLeadership");
         }
         else if(target.name.indexOf("btn_kick") != -1)
         {
            tooltipText = this.uiApi.getText("ui.alliance.kickGuild");
         }
         else if(target.name.indexOf("btn_ava") != -1)
         {
            tooltipText = this.uiApi.getText("ui.alliance.enableAvATooltip");
            if(this.playerApi.getPlayedCharacterInfo().level < 50)
            {
               tooltipText = tooltipText + ("\n" + this.uiApi.getText("ui.spell.requiredLevel") + " 50");
            }
         }
         else if(target.name.indexOf("tx_disabledGuild") != -1)
         {
            tooltipText = this.uiApi.getText("ui.guild.disabled");
         }
         else if(target.name.indexOf("tx_leader") != -1)
         {
            tooltipText = this.uiApi.getText("ui.guild.right.leader");
         }
         else if(target.name.indexOf("lbl_members") != -1)
         {
            data = this._compsLblName[target.name];
            if(!data)
            {
               return;
            }
            this.sysApi.log(2,"guild " + data.guildName + "    hoursSinceLastConnection " + data.hoursSinceLastConnection);
            if((data.nbConnectedMembers == 0) && (data.hoursSinceLastConnection > 0))
            {
               months = Math.floor(data.hoursSinceLastConnection / 720);
               days = (data.hoursSinceLastConnection - months * 720) / 24;
               hours = data.hoursSinceLastConnection - days * 24 - months * 720;
               if(months > 0)
               {
                  if(days > 0)
                  {
                     argText = this.uiApi.processText(this.uiApi.getText("ui.social.monthsAndDaysSinceLastConnection",months,days),"m",days <= 1);
                  }
                  else
                  {
                     argText = this.uiApi.processText(this.uiApi.getText("ui.social.monthsSinceLastConnection",months),"m",months <= 1);
                  }
               }
               else if(days > 0)
               {
                  argText = this.uiApi.processText(this.uiApi.getText("ui.social.daysSinceLastConnection",days),"m",days <= 1);
               }
               else
               {
                  argText = this.uiApi.getText("ui.social.lessThanADay");
               }
               
               tooltipText = this.uiApi.getText("ui.social.lastConnection",argText);
            }
         }
         
         
         
         
         
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onTextureReady(target:Object) : void {
         var icon:EmblemSymbol = null;
         if(target.name.indexOf("tx_emblemBack") != -1)
         {
            this.utilApi.changeColor(target.getChildByName("back"),this._compsTxEmblem[target.name].backEmblem.color,1);
         }
         else if(target.name.indexOf("tx_emblemUp") != -1)
         {
            icon = this.dataApi.getEmblemSymbol(this._compsTxEmblem[target.name].upEmblem.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(target.getChildByName("up"),this._compsTxEmblem[target.name].upEmblem.color,0);
            }
            else
            {
               this.utilApi.changeColor(target.getChildByName("up"),this._compsTxEmblem[target.name].upEmblem.color,0,true);
            }
         }
         
      }
   }
}
