package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SocialApi;
   import d2api.DataApi;
   import flash.utils.Dictionary;
   import d2components.ButtonContainer;
   import d2components.Input;
   import d2components.Grid;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.*;
   import d2actions.*;
   import d2data.Smiley;
   import d2enums.ComponentHookList;
   import d2enums.PlayerStatusEnum;
   import d2enums.PlayerStateEnum;
   
   public class Friends extends Object
   {
      
      public function Friends() {
         this._interactiveComponentsList = new Dictionary(true);
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var modCommon:Object;
      
      public var socialApi:SocialApi;
      
      public var dataApi:DataApi;
      
      private var _friendsList:Object;
      
      private var _enemiesList:Object;
      
      private var _ignoredList:Object;
      
      private var _nCurrentTab:uint = 0;
      
      private var _bShowOfflineGuys:Boolean = false;
      
      private var _bDescendingSort:Boolean = false;
      
      private var _interactiveComponentsList:Dictionary;
      
      private var _iconsPath:String;
      
      public var btn_friend:ButtonContainer;
      
      public var btn_enemy:ButtonContainer;
      
      public var btn_ignored:ButtonContainer;
      
      public var inp_add:Input;
      
      public var btn_add:ButtonContainer;
      
      public var gd_list:Grid;
      
      public var btn_showOfflineFriends:ButtonContainer;
      
      public var btn_warnWhenFriendIsOnline:ButtonContainer;
      
      public var btn_tabAli1:ButtonContainer;
      
      public var btn_tabBreed:ButtonContainer;
      
      public var btn_tabAli2:ButtonContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var btn_tabGuild:ButtonContainer;
      
      public var btn_tabAchievement:ButtonContainer;
      
      public var btn_tabState:ButtonContainer;
      
      public function main(... params) : void {
         this.btn_add.soundId = SoundEnum.SPEC_BUTTON;
         this.btn_friend.soundId = SoundEnum.TAB;
         this.btn_enemy.soundId = SoundEnum.TAB;
         this.btn_ignored.soundId = SoundEnum.TAB;
         this.sysApi.addHook(FriendsListUpdated,this.onFriendsUpdated);
         this.sysApi.addHook(EnemiesListUpdated,this.onEnemiesUpdated);
         this.sysApi.addHook(FriendAdded,this.onFriendAdded);
         this.sysApi.addHook(EnemyAdded,this.onEnemyAdded);
         this.sysApi.addHook(FriendRemoved,this.onFriendRemoved);
         this.sysApi.addHook(EnemyRemoved,this.onEnemyRemoved);
         this.sysApi.addHook(FriendWarningState,this.onFriendWarningState);
         this.sysApi.addHook(IgnoredAdded,this.onIgnoredAdded);
         this.sysApi.addHook(IgnoredRemoved,this.onIgnoredRemoved);
         this.uiApi.addComponentHook(this.btn_add,"onRelease");
         this.uiApi.addComponentHook(this.btn_showOfflineFriends,"onRelease");
         this.uiApi.addComponentHook(this.btn_warnWhenFriendIsOnline,"onRelease");
         this.uiApi.addComponentHook(this.btn_friend,"onRelease");
         this.uiApi.addComponentHook(this.btn_enemy,"onRelease");
         this.uiApi.addComponentHook(this.btn_ignored,"onRelease");
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this._iconsPath = this.uiApi.me().getConstant("icons_uri");
         this._friendsList = this.socialApi.getFriendsList();
         this._enemiesList = this.socialApi.getEnemiesList();
         this._ignoredList = this.socialApi.getIgnoredList();
         var lang:String = this.sysApi.getCurrentLanguage();
         var hasRights:Boolean = this.sysApi.getPlayerManager().hasRights;
         if(!hasRights)
         {
            switch(lang)
            {
               case "ru":
                  this.inp_add.restrict = "^ ";
                  break;
               case "ja":
                  this.inp_add.restrict = "[ァ-ヾぁ-ゞA-Za-z\\-]+";
                  break;
               case "fr":
               case "en":
               case "es":
               case "de":
               case "it":
               case "nl":
               case "pt":
               default:
                  this.inp_add.restrict = "A-Z\\-a-z";
            }
         }
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_friend,this.uiApi.me());
         this.btn_friend.selected = true;
         this.btn_showOfflineFriends.selected = false;
         this.btn_warnWhenFriendIsOnline.selected = this.socialApi.getWarnOnFriendConnec();
         this.displaySelectedTab(this._nCurrentTab);
      }
      
      public function unload() : void {
      }
      
      public function updateFriendLine(data:*, components:*, selected:Boolean) : void {
         var playerLink:String = null;
         var smiley:Smiley = null;
         if(!this._interactiveComponentsList[components.btn_delete.name])
         {
            this.uiApi.addComponentHook(components.btn_delete,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_delete,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_delete,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.btn_delete.name] = data;
         if(!this._interactiveComponentsList[components.lbl_name.name])
         {
            this.uiApi.addComponentHook(components.lbl_name,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.lbl_name,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.lbl_name.name] = data;
         if(!this._interactiveComponentsList[components.tx_status.name])
         {
            this.uiApi.addComponentHook(components.tx_status,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_status,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.tx_status.name] = data;
         if(!this._interactiveComponentsList[components.tx_state.name])
         {
            this.uiApi.addComponentHook(components.tx_state,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_state,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.tx_state,ComponentHookList.ON_RELEASE);
         }
         this._interactiveComponentsList[components.tx_state.name] = data;
         if(!this._interactiveComponentsList[components.tx_mood.name])
         {
            this.uiApi.addComponentHook(components.tx_mood,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_mood,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.tx_mood,ComponentHookList.ON_RELEASE);
         }
         this._interactiveComponentsList[components.tx_mood.name] = data;
         if(!this._interactiveComponentsList[components.tx_fight.name])
         {
            this.uiApi.addComponentHook(components.tx_fight,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_fight,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.tx_fight,ComponentHookList.ON_RELEASE);
         }
         this._interactiveComponentsList[components.tx_fight.name] = data;
         if(data)
         {
            components.lbl_name.text = "{account," + data.name + "," + data.accountId + "::" + data.name + "}";
            components.btn_delete.visible = true;
            if(data.achievementPoints == -1)
            {
               components.lbl_achievement.text = "-";
            }
            else
            {
               components.lbl_achievement.text = data.achievementPoints;
            }
            components.tx_mood.uri = null;
            components.tx_fight.uri = null;
            components.tx_status.uri = null;
            if(data.type == "Ignored")
            {
               components.lbl_level.text = "";
               components.lbl_guild.text = "";
               components.tx_alignment.uri = null;
               components.tx_state.uri = null;
               components.tx_head.uri = null;
            }
            else if(!data.online)
            {
               components.lbl_level.text = "-";
               components.lbl_guild.text = "-";
               components.tx_state.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "Social_tx_offlineState");
               components.tx_alignment.uri = null;
               components.tx_head.uri = null;
            }
            else
            {
               if(data.playerId)
               {
                  playerLink = "{player," + data.playerName + "," + data.playerId + "::" + data.name + " ( " + data.playerName + " )}";
               }
               else
               {
                  playerLink = "{player," + data.playerName + "::" + data.name + " ( " + data.playerName + " )}";
               }
               if(data.type == "Enemy")
               {
                  components.lbl_name.text = playerLink;
                  components.lbl_level.text = "?";
                  components.lbl_guild.text = "?";
                  components.tx_state.uri = null;
                  components.tx_alignment.uri = null;
                  components.tx_head.uri = this.uiApi.createUri(this.uiApi.me().getConstant("heads") + data.breed + "" + data.sex + ".png");
               }
               else
               {
                  components.lbl_name.text = playerLink;
                  if(data.level == 0)
                  {
                     components.lbl_level.text = "?";
                  }
                  else
                  {
                     components.lbl_level.text = data.level;
                  }
                  if(data.realGuildName == "")
                  {
                     components.lbl_guild.text = "";
                  }
                  else
                  {
                     components.lbl_guild.text = data.guildName;
                  }
                  if(data.statusId)
                  {
                     switch(data.statusId)
                     {
                        case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                           components.tx_status.uri = this.uiApi.createUri(this._iconsPath + "|available");
                           break;
                        case PlayerStatusEnum.PLAYER_STATUS_AFK:
                        case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                           components.tx_status.uri = this.uiApi.createUri(this._iconsPath + "|away");
                           break;
                        case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                           components.tx_status.uri = this.uiApi.createUri(this._iconsPath + "|private");
                           break;
                        case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                           components.tx_status.uri = this.uiApi.createUri(this._iconsPath + "|solo");
                           break;
                     }
                  }
                  if(data.moodSmileyId != -1)
                  {
                     smiley = this.dataApi.getSmiley(data.moodSmileyId);
                     if(smiley)
                     {
                        components.tx_mood.uri = this.uiApi.createUri(this.uiApi.me().getConstant("smilies_uri") + smiley.gfxId);
                     }
                  }
                  if(data.state == PlayerStateEnum.GAME_TYPE_FIGHT)
                  {
                     if(data.moodSmileyId == -1)
                     {
                        components.tx_state.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "Social_tx_fightState");
                     }
                     else
                     {
                        components.tx_state.uri = null;
                        components.tx_fight.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "Social_tx_fightState_small");
                     }
                  }
                  else
                  {
                     components.tx_state.uri = null;
                  }
                  if(data.alignmentSide > 0)
                  {
                     components.tx_alignment.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "" + data.alignmentSide);
                  }
                  else
                  {
                     components.tx_alignment.uri = null;
                  }
                  components.tx_head.uri = this.uiApi.createUri(this.uiApi.me().getConstant("heads") + data.breed + "" + data.sex + ".png");
               }
            }
            
         }
         else
         {
            components.lbl_name.text = "";
            components.lbl_level.text = "";
            components.lbl_guild.text = "";
            components.lbl_achievement.text = "";
            components.tx_alignment.uri = null;
            components.tx_state.uri = null;
            components.tx_fight.uri = null;
            components.tx_mood.uri = null;
            components.tx_head.uri = null;
            components.btn_delete.visible = false;
            components.tx_status.uri = null;
         }
      }
      
      private function displaySelectedTab(tab:uint) : void {
         switch(tab)
         {
            case 0:
               if(!this.btn_warnWhenFriendIsOnline.visible)
               {
                  this.btn_warnWhenFriendIsOnline.visible = true;
               }
               if(!this.btn_showOfflineFriends.visible)
               {
                  this.btn_showOfflineFriends.visible = true;
               }
               break;
            case 1:
               if(this.btn_warnWhenFriendIsOnline.visible)
               {
                  this.btn_warnWhenFriendIsOnline.visible = false;
               }
               if(!this.btn_showOfflineFriends.visible)
               {
                  this.btn_showOfflineFriends.visible = true;
               }
               break;
            case 2:
               if(this.btn_warnWhenFriendIsOnline.visible)
               {
                  this.btn_warnWhenFriendIsOnline.visible = false;
               }
               this.btn_showOfflineFriends.visible = false;
               break;
         }
         this.refreshGrid(tab);
      }
      
      private function refreshGrid(tabToRefresh:int = -1) : void {
         var datas:Object = null;
         var onlyOnlinePeople:Array = null;
         var guy:* = undefined;
         if(tabToRefresh == -1)
         {
            tabToRefresh = this._nCurrentTab;
         }
         if(tabToRefresh == this._nCurrentTab)
         {
            datas = new Object();
            switch(this._nCurrentTab)
            {
               case 0:
                  datas = this._friendsList;
                  break;
               case 1:
                  datas = this._enemiesList;
                  break;
               case 2:
                  datas = this._ignoredList;
                  break;
            }
            if(!this._bShowOfflineGuys)
            {
               onlyOnlinePeople = new Array();
               for each(guy in datas)
               {
                  if(guy.online)
                  {
                     onlyOnlinePeople.push(guy);
                  }
               }
               this.gd_list.dataProvider = onlyOnlinePeople;
            }
            else
            {
               this.gd_list.dataProvider = datas;
            }
         }
      }
      
      private function onFriendsUpdated() : void {
         this._friendsList = this.socialApi.getFriendsList();
         this.refreshGrid(0);
      }
      
      private function onEnemiesUpdated() : void {
         this._enemiesList = this.socialApi.getEnemiesList();
         this.refreshGrid(1);
      }
      
      private function onFriendAdded(result:Boolean) : void {
         this._friendsList = this.socialApi.getFriendsList();
         if(result)
         {
            this.refreshGrid(0);
         }
      }
      
      private function onEnemyAdded(result:Boolean) : void {
         this._enemiesList = this.socialApi.getEnemiesList();
         if(result)
         {
            this.refreshGrid(1);
         }
      }
      
      private function onFriendRemoved(result:Boolean) : void {
         this._friendsList = this.socialApi.getFriendsList();
         if(result)
         {
            this.refreshGrid(0);
         }
      }
      
      private function onEnemyRemoved(result:Boolean) : void {
         this._enemiesList = this.socialApi.getEnemiesList();
         if(result)
         {
            this.refreshGrid(1);
         }
      }
      
      private function onFriendWarningState(enable:Boolean) : void {
         if(this.btn_warnWhenFriendIsOnline.selected != enable)
         {
            this.btn_warnWhenFriendIsOnline.selected = enable;
         }
      }
      
      private function onIgnoredAdded() : void {
         this._ignoredList = this.socialApi.getIgnoredList();
         this.refreshGrid(2);
      }
      
      private function onIgnoredRemoved() : void {
         this._ignoredList = this.socialApi.getIgnoredList();
         this.refreshGrid(2);
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               if((this.inp_add.haveFocus) && (!(this.inp_add.text == "")))
               {
                  switch(this._nCurrentTab)
                  {
                     case 0:
                        this.sysApi.sendAction(new AddFriend(this.inp_add.text));
                        break;
                     case 1:
                        this.sysApi.sendAction(new AddEnemy(this.inp_add.text));
                        break;
                     case 2:
                        this.sysApi.sendAction(new AddIgnored(this.inp_add.text));
                        break;
                  }
                  this.inp_add.text = "";
                  return true;
               }
               break;
         }
         return false;
      }
      
      public function onRelease(target:Object) : void {
         var data:Object = null;
         switch(target)
         {
            case this.btn_add:
               switch(this._nCurrentTab)
               {
                  case 0:
                     if(this.inp_add.text)
                     {
                        this.sysApi.sendAction(new AddFriend(this.inp_add.text));
                     }
                     break;
                  case 1:
                     if(this.inp_add.text)
                     {
                        this.sysApi.sendAction(new AddEnemy(this.inp_add.text));
                     }
                     break;
                  case 2:
                     if(this.inp_add.text)
                     {
                        this.sysApi.sendAction(new AddIgnored(this.inp_add.text));
                     }
                     break;
               }
               this.inp_add.text = "";
               break;
            case this.btn_friend:
               if(this._nCurrentTab != 0)
               {
                  this._nCurrentTab = 0;
                  this.displaySelectedTab(this._nCurrentTab);
               }
               break;
            case this.btn_enemy:
               if(this._nCurrentTab != 1)
               {
                  this._nCurrentTab = 1;
                  this.displaySelectedTab(this._nCurrentTab);
               }
               break;
            case this.btn_ignored:
               if(this._nCurrentTab != 2)
               {
                  this._nCurrentTab = 2;
                  this.displaySelectedTab(this._nCurrentTab);
               }
               break;
            case this.btn_showOfflineFriends:
               this._bShowOfflineGuys = this.btn_showOfflineFriends.selected;
               this.refreshGrid(this._nCurrentTab);
               break;
            case this.btn_warnWhenFriendIsOnline:
               this.sysApi.sendAction(new FriendWarningSet(this.btn_warnWhenFriendIsOnline.selected));
               break;
            case this.btn_tabAli1:
            case this.btn_tabAli2:
               if(this._bDescendingSort)
               {
                  this.gd_list.sortOn("alignmentSide",Array.NUMERIC);
               }
               else
               {
                  this.gd_list.sortOn("alignmentSide",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_tabGuild:
               if(this._bDescendingSort)
               {
                  this.gd_list.sortOn("guildName",Array.CASEINSENSITIVE);
               }
               else
               {
                  this.gd_list.sortOn("guildName",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_tabName:
               if(this._bDescendingSort)
               {
                  this.gd_list.sortOn("name",Array.CASEINSENSITIVE);
               }
               else
               {
                  this.gd_list.sortOn("name",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_tabLevel:
               if(this._bDescendingSort)
               {
                  this.gd_list.sortOn("level",Array.NUMERIC);
               }
               else
               {
                  this.gd_list.sortOn("level",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_tabBreed:
               if(this._bDescendingSort)
               {
                  this.gd_list.sortOn("breed",Array.NUMERIC);
               }
               else
               {
                  this.gd_list.sortOn("breed",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_tabAchievement:
               if(this._bDescendingSort)
               {
                  this.gd_list.sortOn("achievementPoints",Array.NUMERIC);
               }
               else
               {
                  this.gd_list.sortOn("achievementPoints",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_tabState:
               if(this._bDescendingSort)
               {
                  this.gd_list.sortOn("state",Array.NUMERIC);
               }
               else
               {
                  this.gd_list.sortOn("state",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            default:
               if(target.name.indexOf("btn_delete") != -1)
               {
                  data = this._interactiveComponentsList[target.name];
                  if(data.type == "Friend")
                  {
                     this.sysApi.sendAction(new RemoveFriend(data.accountId));
                  }
                  else if(data.type == "Enemy")
                  {
                     this.sysApi.sendAction(new RemoveEnemy(data.accountId));
                  }
                  else if(data.type == "Ignored")
                  {
                     this.sysApi.sendAction(new RemoveIgnored(data.accountId));
                  }
                  
                  
               }
               else if((!(target.name.indexOf("tx_state") == -1)) || (!(target.name.indexOf("tx_mood") == -1)) || (!(target.name.indexOf("tx_fight") == -1)))
               {
                  data = this._interactiveComponentsList[target.name];
                  if(data.state == PlayerStateEnum.GAME_TYPE_FIGHT)
                  {
                     this.sysApi.sendAction(new GameFightSpectatePlayerRequest(data.playerId));
                  }
               }
               
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var data:Object = null;
         var months:* = 0;
         var days:* = 0;
         var hours:* = 0;
         var argText:String = null;
         var sdata:Object = null;
         var point:uint = 6;
         var relPoint:uint = 2;
         if(target.name.indexOf("btn_delete") != -1)
         {
            text = this.uiApi.getText("ui.charsel.characterDelete");
         }
         else if((!(target.name.indexOf("tx_state") == -1)) || (!(target.name.indexOf("tx_mood") == -1)) || (!(target.name.indexOf("tx_fight") == -1)))
         {
            data = this._interactiveComponentsList[target.name];
            if(data.state == PlayerStateEnum.GAME_TYPE_FIGHT)
            {
               text = this.uiApi.getText("ui.spectator.clicToJoin");
            }
         }
         else if(target.name.indexOf("lbl_name") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if((data) && (!data.online))
            {
               if(data.lastConnection > -1)
               {
                  months = Math.floor(data.lastConnection / 720);
                  days = (data.lastConnection - months * 720) / 24;
                  hours = data.lastConnection - days * 24 - months * 720;
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
                  
                  text = this.uiApi.getText("ui.social.lastConnection",argText);
                  relPoint = 0;
               }
            }
         }
         else if(target.name.indexOf("tx_status") != -1)
         {
            sdata = this._interactiveComponentsList[target.name];
            if((sdata) && (sdata.online))
            {
               switch(sdata.statusId)
               {
                  case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                     text = this.uiApi.getText("ui.chat.status.availiable");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_AFK:
                     text = this.uiApi.getText("ui.chat.status.away");
                     if(sdata.awayMessage != "")
                     {
                        text = text + (this.uiApi.getText("ui.common.colon") + sdata.awayMessage);
                     }
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                     text = this.uiApi.getText("ui.chat.status.idle");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                     text = this.uiApi.getText("ui.chat.status.private");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                     text = this.uiApi.getText("ui.chat.status.solo");
                     break;
               }
            }
         }
         
         
         
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
   }
}
