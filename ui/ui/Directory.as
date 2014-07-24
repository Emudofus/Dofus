package ui
{
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.UtilApi;
   import d2api.SystemApi;
   import d2api.ChatApi;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import d2components.ButtonContainer;
   import d2components.GraphicContainer;
   import d2components.Input;
   import d2components.Grid;
   import d2components.ComboBox;
   import d2enums.ComponentHookList;
   import d2hooks.AllianceList;
   import d2hooks.GuildList;
   import d2hooks.SilentWhoIs;
   import flash.events.TimerEvent;
   import d2data.GuildWrapper;
   import d2data.EmblemSymbol;
   import d2data.AllianceWrapper;
   import d2actions.GuildListRequest;
   import d2actions.AllianceListRequest;
   import flash.events.Event;
   import d2actions.BasicWhoIsRequest;
   import d2actions.GuildFactsRequest;
   import d2actions.AllianceFactsRequest;
   import d2network.AbstractSocialGroupInfos;
   import d2network.BasicGuildInformations;
   import d2network.BasicAllianceInformations;
   
   public class Directory extends Object
   {
      
      public function Directory() {
         this._moreBtnList = new Dictionary();
         this._sortFieldAssoc = new Dictionary(true);
         this._exactMemberSearchTimer = new Timer(1000,1);
         super();
      }
      
      private static const TAB_GUILD:uint = 0;
      
      private static const TAB_ALLIANCE:uint = 1;
      
      private static const SEARCH_TAG:uint = 0;
      
      private static const SEARCH_NAME:uint = 1;
      
      private static const SEARCH_MEMBER_NAME:uint = 2;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var utilApi:UtilApi;
      
      public var sysApi:SystemApi;
      
      public var chatApi:ChatApi;
      
      private var _currentTab:uint = 1;
      
      private var _currentGuildDataProvider;
      
      private var _currentAllianceDataProvider;
      
      private var _guildSortField:String;
      
      private var _guildSortOrderAscending:Boolean = true;
      
      private var _allianceSortField:String;
      
      private var _allianceSortOrderAscending:Boolean = true;
      
      private var _moreBtnList:Dictionary;
      
      private var _sortFieldAssoc:Dictionary;
      
      private var _exactMemberSearchTimer:Timer;
      
      public var btn_guilds:ButtonContainer;
      
      public var btn_alliances:ButtonContainer;
      
      public var btn_search:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_tabGuildAbr:ButtonContainer;
      
      public var btn_tabGuildName:ButtonContainer;
      
      public var btn_tabGuildLevel:ButtonContainer;
      
      public var btn_tabGuildMembers:ButtonContainer;
      
      public var btn_tabAllianceAbr:ButtonContainer;
      
      public var btn_tabAllianceName:ButtonContainer;
      
      public var btn_tabAllianceSubarea:ButtonContainer;
      
      public var btn_tabAllianceNbMembers:ButtonContainer;
      
      public var btn_tabAllianceGuildNumber:ButtonContainer;
      
      public var ctr_guild:GraphicContainer;
      
      public var inp_guildFilter:Input;
      
      public var gd_guilds:Grid;
      
      public var ctr_alliance:GraphicContainer;
      
      public var inp_allianceFilter:Input;
      
      public var gd_alliances:Grid;
      
      public var cb_allianceSearchType:ComboBox;
      
      public var cb_guildSearchType:ComboBox;
      
      public function main(args:Object) : void {
         this.uiApi.addComponentHook(this.btn_guilds,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_alliances,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_guildFilter,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_allianceFilter,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.cb_allianceSearchType,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_guildSearchType,ComponentHookList.ON_SELECT_ITEM);
         this._sortFieldAssoc[this.btn_tabGuildAbr] = "allianceTag";
         this._sortFieldAssoc[this.btn_tabGuildName] = "guildName";
         this._sortFieldAssoc[this.btn_tabGuildLevel] = "level";
         this._sortFieldAssoc[this.btn_tabGuildMembers] = "nbMembers";
         this._sortFieldAssoc[this.btn_tabAllianceAbr] = "allianceTag";
         this._sortFieldAssoc[this.btn_tabAllianceName] = "allianceName";
         this._sortFieldAssoc[this.btn_tabAllianceSubarea] = "nbSubareas";
         this._sortFieldAssoc[this.btn_tabAllianceNbMembers] = "nbMembers";
         this._sortFieldAssoc[this.btn_tabAllianceGuildNumber] = "nbGuilds";
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_guilds,this.uiApi.me());
         this.btn_guilds.selected = true;
         this.sysApi.addHook(AllianceList,this.onAllianceList);
         this.sysApi.addHook(GuildList,this.onGuildList);
         this.sysApi.addHook(SilentWhoIs,this.onWhoisInfo);
         this.cb_allianceSearchType.dataProvider = [
            {
               "label":this.uiApi.getText("ui.common.name"),
               "type":SEARCH_NAME
            },
            {
               "label":this.uiApi.getText("ui.alliance.tag"),
               "type":SEARCH_TAG
            },
            {
               "label":this.uiApi.getText("ui.alliance.memberName"),
               "type":SEARCH_MEMBER_NAME
            }];
         this.cb_guildSearchType.dataProvider = [
            {
               "label":this.uiApi.getText("ui.common.name"),
               "type":SEARCH_NAME
            },
            {
               "label":this.uiApi.getText("ui.alliance.memberName"),
               "type":SEARCH_MEMBER_NAME
            }];
         this._exactMemberSearchTimer.addEventListener(TimerEvent.TIMER,this.onRefreshExactMemberNameFilter);
         this._currentTab = TAB_GUILD;
         this.displaySelectedTab();
      }
      
      public function unload() : void {
         this._moreBtnList = null;
         this._currentGuildDataProvider = null;
         this._currentAllianceDataProvider = null;
         this._exactMemberSearchTimer.removeEventListener(TimerEvent.TIMER,this.onRefreshExactMemberNameFilter);
      }
      
      public function updateGuildLine(data:GuildWrapper, components:*, selected:Boolean) : void {
         var icon:EmblemSymbol = null;
         if(!this._moreBtnList[components.btn_guildMore.name])
         {
            this.uiApi.addComponentHook(components.btn_guildMore,ComponentHookList.ON_RELEASE);
         }
         this._moreBtnList[components.btn_guildMore.name] = data;
         if(data)
         {
            components.lbl_guildLvl.text = data.level.toString();
            components.lbl_guildName.text = this.chatApi.getGuildLink(data,data.guildName);
            components.lbl_guildMembers.text = data.nbMembers.toString();
            components.lbl_guildAllianceTag.text = data.alliance?this.chatApi.getAllianceLink(data.alliance.allianceId,"[" + data.alliance.allianceTag + "]"):"";
            if(data.backEmblem)
            {
               components.tx_emblemBackGuild.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + "icons/back/" + data.backEmblem.idEmblem + ".png");
               components.tx_emblemUpGuild.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + "icons/up/" + data.upEmblem.idEmblem + ".png");
               this.utilApi.changeColor(components.tx_emblemBackGuild,data.backEmblem.color,1);
               icon = this.dataApi.getEmblemSymbol(data.upEmblem.idEmblem);
               if(icon.colorizable)
               {
                  this.utilApi.changeColor(components.tx_emblemUpGuild,data.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(components.tx_emblemUpGuild,data.upEmblem.color,0,true);
               }
               components.btn_guildMore.visible = true;
            }
         }
         else
         {
            components.lbl_guildLvl.text = "";
            components.lbl_guildName.text = "";
            components.lbl_guildMembers.text = "";
            components.tx_emblemBackGuild.uri = null;
            components.tx_emblemUpGuild.uri = null;
            components.btn_guildMore.visible = false;
         }
      }
      
      public function updateAllianceLine(data:AllianceWrapper, components:*, selected:Boolean) : void {
         var icon:EmblemSymbol = null;
         if(!this._moreBtnList[components.btn_allianceMore.name])
         {
            this.uiApi.addComponentHook(components.btn_allianceMore,"onRelease");
         }
         this._moreBtnList[components.btn_allianceMore.name] = data;
         if(data)
         {
            components.lbl_allianceTag.text = this.chatApi.getAllianceLink(data,data.allianceTag);
            components.lbl_allianceName.text = this.chatApi.getAllianceLink(data,data.allianceName);
            components.lbl_allianceAreas.text = data.nbSubareas;
            components.lbl_allianceGuilds.text = data.nbGuilds;
            components.lbl_allianceMembers.text = data.nbMembers;
            if(data.backEmblem)
            {
               components.tx_emblemBackAlliance.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + "icons/back/" + data.backEmblem.idEmblem + ".png");
               components.tx_emblemUpAlliance.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + "icons/up/" + data.upEmblem.idEmblem + ".png");
               this.utilApi.changeColor(components.tx_emblemBackAlliance,data.backEmblem.color,1);
               icon = this.dataApi.getEmblemSymbol(data.upEmblem.idEmblem);
               if((icon) && (icon.colorizable))
               {
                  this.utilApi.changeColor(components.tx_emblemUpAlliance,data.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(components.tx_emblemUpAlliance,data.upEmblem.color,0,true);
               }
               components.btn_allianceMore.visible = true;
            }
            else
            {
               components.tx_emblemBackAlliance.uri = null;
               components.tx_emblemUpAlliance.uri = null;
            }
            components.btn_allianceMore.visible = true;
         }
         else
         {
            components.lbl_allianceTag.text = "";
            components.lbl_allianceName.text = "";
            components.lbl_allianceAreas.text = "";
            components.lbl_allianceGuilds.text = "";
            components.lbl_allianceMembers.text = "";
            components.tx_emblemUpAlliance.uri = null;
            components.tx_emblemBackAlliance.uri = null;
            components.btn_allianceMore.visible = false;
         }
      }
      
      private function displaySelectedTab() : void {
         switch(this._currentTab)
         {
            case TAB_GUILD:
               this.ctr_guild.visible = true;
               this.ctr_alliance.visible = false;
               if((this.gd_guilds.dataProvider == null) || (this.gd_guilds.dataProvider.length == 0))
               {
                  this.sysApi.sendAction(new GuildListRequest());
               }
               break;
            case TAB_ALLIANCE:
               this.ctr_guild.visible = false;
               this.ctr_alliance.visible = true;
               if((this.gd_alliances.dataProvider == null) || (this.gd_alliances.dataProvider.length == 0))
               {
                  this.sysApi.sendAction(new AllianceListRequest());
               }
               break;
         }
      }
      
      public function onChange(target:Input) : void {
         switch(target)
         {
            case this.inp_guildFilter:
               this.updateGuildFilter();
               break;
            case this.inp_allianceFilter:
               this.updateAllianceFilter();
         }
      }
      
      private function updateGuildFilter() : void {
         switch(this.cb_guildSearchType.selectedItem.type)
         {
            case SEARCH_NAME:
               this.gd_guilds.dataProvider = this.utilApi["filter"](this._currentGuildDataProvider,this.inp_guildFilter.text,"guildName");
               break;
            case SEARCH_TAG:
               this.gd_guilds.dataProvider = this.utilApi["filter"](this._currentGuildDataProvider,this.inp_guildFilter.text,"allianceTag");
               break;
            case SEARCH_MEMBER_NAME:
               this._exactMemberSearchTimer.reset();
               this._exactMemberSearchTimer.start();
               break;
         }
      }
      
      private function updateAllianceFilter() : void {
         switch(this.cb_allianceSearchType.selectedItem.type)
         {
            case SEARCH_NAME:
               this.gd_alliances.dataProvider = this.utilApi["filter"](this._currentAllianceDataProvider,this.inp_allianceFilter.text,"allianceName");
               break;
            case SEARCH_TAG:
               this.gd_alliances.dataProvider = this.utilApi["filter"](this._currentAllianceDataProvider,this.inp_allianceFilter.text,"allianceTag");
               break;
            case SEARCH_MEMBER_NAME:
               this._exactMemberSearchTimer.reset();
               this._exactMemberSearchTimer.start();
               break;
         }
      }
      
      private function onRefreshExactMemberNameFilter(e:Event) : void {
         if((this._currentTab == TAB_GUILD) && (this.inp_guildFilter.text.length > 2))
         {
            this.sysApi.sendAction(new BasicWhoIsRequest(this.inp_guildFilter.text,false));
         }
         if((this._currentTab == TAB_ALLIANCE) && (this.inp_allianceFilter.text.length > 2))
         {
            this.sysApi.sendAction(new BasicWhoIsRequest(this.inp_allianceFilter.text,false));
         }
      }
      
      private function onGuildList(list:Object, isUpdate:Boolean, error:Boolean) : void {
         this._currentGuildDataProvider = list;
         this.gd_guilds.dataProvider = this.utilApi["sort"](this._currentGuildDataProvider,"nbMembers",false,true);
      }
      
      private function onAllianceList(list:Object, isUpdate:Boolean, error:Boolean) : void {
         this._currentAllianceDataProvider = list;
         this.gd_alliances.dataProvider = this.utilApi["sort"](this._currentAllianceDataProvider,"nbSubareas",false,true);
      }
      
      public function onRelease(target:Object) : void {
         var gw:GuildWrapper = null;
         var aw:AllianceWrapper = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_guilds:
               if(this._currentTab != TAB_GUILD)
               {
                  this._currentTab = TAB_GUILD;
                  this.displaySelectedTab();
               }
               break;
            case this.btn_alliances:
               if(this._currentTab != TAB_ALLIANCE)
               {
                  this._currentTab = TAB_ALLIANCE;
                  this.displaySelectedTab();
               }
               break;
            case this.btn_tabGuildLevel:
            case this.btn_tabGuildMembers:
            case this.btn_tabAllianceGuildNumber:
            case this.btn_tabAllianceNbMembers:
            case this.btn_tabAllianceSubarea:
               if(this._currentTab == TAB_GUILD)
               {
                  this._guildSortOrderAscending = !this._guildSortOrderAscending;
                  this.gd_guilds.dataProvider = this.utilApi["sort"](this.gd_guilds.dataProvider,this._sortFieldAssoc[target],this._guildSortOrderAscending,true);
               }
               else
               {
                  this._allianceSortOrderAscending = !this._allianceSortOrderAscending;
                  this.gd_alliances.dataProvider = this.utilApi["sort"](this.gd_alliances.dataProvider,this._sortFieldAssoc[target],this._allianceSortOrderAscending,true);
               }
               break;
            case this.btn_tabGuildAbr:
            case this.btn_tabGuildName:
            case this.btn_tabAllianceAbr:
            case this.btn_tabAllianceName:
               if(this._currentTab == TAB_GUILD)
               {
                  this._guildSortOrderAscending = !this._guildSortOrderAscending;
                  this.gd_guilds.dataProvider = this.utilApi["sort"](this.gd_guilds.dataProvider,this._sortFieldAssoc[target],this._guildSortOrderAscending,false);
               }
               else
               {
                  this._allianceSortOrderAscending = !this._allianceSortOrderAscending;
                  this.gd_alliances.dataProvider = this.utilApi["sort"](this.gd_alliances.dataProvider,this._sortFieldAssoc[target],this._allianceSortOrderAscending,false);
               }
               break;
            default:
               if(target.name.indexOf("btn_guildMore") != -1)
               {
                  gw = this._moreBtnList[target.name];
                  this.sysApi.sendAction(new GuildFactsRequest(gw.guildId));
               }
               else if(target.name.indexOf("btn_allianceMore") != -1)
               {
                  aw = this._moreBtnList[target.name];
                  this.sysApi.sendAction(new AllianceFactsRequest(aw.allianceId));
               }
               
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(this._currentTab == TAB_GUILD)
         {
            this.updateGuildFilter();
         }
         else if(this._currentTab == TAB_ALLIANCE)
         {
            this.updateAllianceFilter();
         }
         
      }
      
      private function onWhoisInfo(accountId:uint, accountNickname:String, areaId:uint, playerId:uint, playerName:String, position:uint, socialGroups:Object) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
