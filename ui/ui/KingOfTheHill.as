package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.AlignmentApi;
   import d2api.PlayedCharacterApi;
   import d2api.UtilApi;
   import d2api.SocialApi;
   import d2api.TimeApi;
   import d2api.ConfigApi;
   import d2api.ChatApi;
   import flash.utils.Dictionary;
   import d2data.AllianceOnTheHillWrapper;
   import flash.utils.Timer;
   import d2components.ButtonContainer;
   import d2components.GraphicContainer;
   import d2components.Texture;
   import d2components.Label;
   import d2components.Grid;
   import d2actions.*;
   import d2hooks.*;
   import d2data.PrismSubAreaWrapper;
   import d2enums.ComponentHookList;
   import flash.events.TimerEvent;
   import flash.utils.getTimer;
   import d2data.EmblemSymbol;
   import flash.events.Event;
   import d2enums.AggressableStatusEnum;
   import d2network.BasicAllianceInformations;
   import d2data.WorldPointWrapper;
   import d2enums.PrismStateEnum;
   
   public class KingOfTheHill extends Object
   {
      
      public function KingOfTheHill() {
         this._compHookData = new Dictionary(true);
         this._alliances = new Array();
         this._bar = new Dictionary();
         this._barCtr = new Dictionary();
         this._closeTimer = new Timer(TIME_UNLOAD_AFTER_END);
         super();
      }
      
      private static const MAX_ALLIANCE:uint = 5;
      
      private static const TIME_UNLOAD_AFTER_END:uint = 60000.0;
      
      private static const SERVER_CONST_KOH_DURATION:int = 2;
      
      private static const SERVER_CONST_KOH_WINNING_SCORE:int = 3;
      
      private static const SERVER_CONST_MINIMAL_TIME_BEFORE_KOH:int = 4;
      
      private static const SERVER_CONST_TIME_BEFORE_WEIGH_IN_KOH:int = 5;
      
      private static const TEAM_PLAYER_COLOR:uint = 10802701;
      
      private static const TEAM_PLAYER_BG_COLOR:uint = 6453255;
      
      private static const TEAM_DEFENDER_COLOR:uint = 52479;
      
      private static const TEAM_DEFENDER_BG_COLOR:uint = 3431610;
      
      private static const TEAM_ATTACKER_COLOR:uint = 16711680;
      
      private static const TEAM_ATTACKER_BG_COLOR:uint = 10751759;
      
      private static var _self:KingOfTheHill;
      
      public static var SERVER_KOH_DURATION:int;
      
      public static var SERVER_KOH_WINNING_SCORE:int;
      
      public static var SERVER_TIME_BEFORE_WEIGH_IN_KOH:int;
      
      private static var _lastViewType:int;
      
      public static function get instance() : KingOfTheHill {
         return _self;
      }
      
      private const VIEW_NONE:int = 0;
      
      private const VIEW_SMALL:int = 1;
      
      private const VIEW_FULL:int = 2;
      
      public var currentSubArea:uint;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var alignApi:AlignmentApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var utilApi:UtilApi;
      
      public var socialApi:SocialApi;
      
      public var timeApi:TimeApi;
      
      public var configApi:ConfigApi;
      
      public var chatApi:ChatApi;
      
      private var _kohRealDuration:uint;
      
      private var _kohStartTime:uint;
      
      private var _endOfPrequalifiedTime:uint;
      
      private var _mapScoreUpdateTime:uint;
      
      private var _compHookData:Dictionary;
      
      private var _alliances:Array;
      
      private var _currentWinnerAlliance:AllianceOnTheHillWrapper;
      
      private var _unexpectedWinnerAllianceName:String;
      
      private var _bDescendingSort:Boolean = false;
      
      private var _currentView:int;
      
      private var _iconPath:String;
      
      private var _emblemsPath:String;
      
      private var _barWidth:uint;
      
      private var _barHeight:uint;
      
      private var _bar:Dictionary;
      
      private var _barCtr:Dictionary;
      
      private var _closeTimer:Timer;
      
      private var _end:Boolean;
      
      private var _playerWeighInKoh:Boolean;
      
      private var _myAllianceId:uint;
      
      private var _prismAllianceId:uint;
      
      private var _kohPlayerStatus:uint = 4.294967295E9;
      
      public var btn_smallView:ButtonContainer;
      
      public var btn_fullView:ButtonContainer;
      
      public var btn_whoswhoTab:ButtonContainer;
      
      public var btn_allianceTab:ButtonContainer;
      
      public var btn_playersTab:ButtonContainer;
      
      public var btn_mapsTab:ButtonContainer;
      
      public var btn_scoreTab:ButtonContainer;
      
      public var ctr_progressBar:GraphicContainer;
      
      public var ctr_details:GraphicContainer;
      
      public var ctr_bar:GraphicContainer;
      
      public var ctr_prequalified:GraphicContainer;
      
      public var tx_bg:Texture;
      
      public var tx_swords:Texture;
      
      public var lbl_remainingTime:Label;
      
      public var lbl_empty:Label;
      
      public var lbl_prequalifiedTime:Label;
      
      public var lbl_mapConquest:Label;
      
      public var lbl_mapConquestMyPov:Label;
      
      public var gd_alliances:Grid;
      
      public function main(param:Object) : void {
         _self = this;
         var prismInfo:PrismSubAreaWrapper = param.prism;
         this.currentSubArea = prismInfo.subAreaId;
         this.sysApi.addHook(KohUpdate,this.onKohUpdate);
         this.sysApi.addHook(PvpAvaStateChange,this.onPvpAvaStateChange);
         this.sysApi.addHook(PrismsListUpdate,this.onPrismsListUpdate);
         this.uiApi.addComponentHook(this.tx_swords,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_swords,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_empty,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_empty,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_mapConquest,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_mapConquest,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_mapConquestMyPov,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_mapConquestMyPov,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_playersTab,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_playersTab,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_mapsTab,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_mapsTab,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_scoreTab,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_scoreTab,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_smallView,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_fullView,ComponentHookList.ON_RELEASE);
         this.ctr_progressBar.visible = false;
         this.ctr_details.visible = false;
         this._closeTimer.addEventListener(TimerEvent.TIMER,this.unloadUi);
         this._emblemsPath = this.uiApi.me().getConstant("emblems_uri");
         this._iconPath = this.uiApi.me().getConstant("icons_uri");
         this._barWidth = this.uiApi.me().getConstant("bar_width");
         this._barHeight = this.uiApi.me().getConstant("bar_height");
         SERVER_KOH_DURATION = int(this.configApi.getServerConstant(SERVER_CONST_KOH_DURATION));
         SERVER_KOH_WINNING_SCORE = int(this.configApi.getServerConstant(SERVER_CONST_KOH_WINNING_SCORE));
         SERVER_TIME_BEFORE_WEIGH_IN_KOH = int(this.configApi.getServerConstant(SERVER_CONST_TIME_BEFORE_WEIGH_IN_KOH));
         this._kohStartTime = getTimer();
         var date:Date = new Date();
         this._kohRealDuration = prismInfo.nextVulnerabilityDate * 1000 + SERVER_KOH_DURATION - date.time;
         this.updateKohStatus(param.probationTime);
         this.switchView(_lastViewType);
         this.sysApi.addEventListener(this.onEnterFrame,"kohTimers");
      }
      
      public function unload() : void {
         _self = null;
         this.sysApi.removeEventListener(this.onEnterFrame);
         if(this._closeTimer)
         {
            this._closeTimer.removeEventListener(TimerEvent.TIMER,this.unloadUi);
            this._closeTimer.stop();
         }
      }
      
      public function get barHeight() : int {
         return this._barHeight;
      }
      
      public function updateAllianceLine(data:*, components:*, selected:Boolean) : void {
         var icon:EmblemSymbol = null;
         if(!this._compHookData[components.tx_emblemBack.name])
         {
            this.uiApi.addComponentHook(components.tx_emblemBack,ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(components.tx_emblemBack,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_emblemBack,ComponentHookList.ON_ROLL_OUT);
         }
         this._compHookData[components.tx_emblemBack.name] = data;
         if(!this._compHookData[components.tx_type.name])
         {
            this.uiApi.addComponentHook(components.tx_type,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_type,ComponentHookList.ON_ROLL_OUT);
         }
         this._compHookData[components.tx_type.name] = data;
         if(data != null)
         {
            components.lbl_tag.text = this.chatApi.getAllianceLink(data,data.allianceTag);
            components.lbl_players.text = data.nbMembers;
            components.lbl_points.text = data.roundWeigth;
            components.lbl_score.text = data.matchScore + "/" + SERVER_KOH_WINNING_SCORE;
            components.tx_type.uri = this.uiApi.createUri(this._iconPath + (this._myAllianceId == data.allianceId?"ownTeam":this._prismAllianceId == data.allianceId?"defender":"forward"));
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
         }
         else
         {
            components.lbl_tag.text = "";
            components.lbl_players.text = "";
            components.lbl_points.text = "";
            components.lbl_score.text = "";
            components.tx_type.uri = null;
            components.tx_emblemBack.uri = null;
            components.tx_emblemUp.uri = null;
         }
      }
      
      public function onEnterFrame() : void {
         this.updateTime();
         if(this._endOfPrequalifiedTime != 0)
         {
            this.updatePrequalifiedTime();
         }
         if(this._mapScoreUpdateTime != 0)
         {
            this.updateMapScoreUpdateTime();
         }
      }
      
      private function updateTheHill() : void {
         var alliance:AllianceOnTheHillWrapper = null;
         var color:uint = 0;
         var bar:Bar = null;
         var width:* = 0;
         var allianceId:* = undefined;
         var b:Bar = null;
         var totalWeight:int = 0;
         var totalPlayersNumber:int = 0;
         var currentX:uint = 1;
         var i:uint = 0;
         for each(alliance in this._alliances)
         {
            if(i++ == MAX_ALLIANCE)
            {
               break;
            }
            totalWeight = totalWeight + alliance.roundWeigth;
            totalPlayersNumber = totalPlayersNumber + alliance.nbMembers;
         }
         if(!this.socialApi.hasAlliance())
         {
            this._myAllianceId = 0;
         }
         else
         {
            this._myAllianceId = this.socialApi.getAlliance().allianceId;
         }
         var prism:PrismSubAreaWrapper = this.socialApi.getPrismSubAreaById(this.playerApi.currentSubArea().id);
         if(!prism)
         {
            return;
         }
         if(prism.alliance)
         {
            this._prismAllianceId = this.socialApi.getPrismSubAreaById(this.playerApi.currentSubArea().id).alliance.allianceId;
         }
         else
         {
            this._prismAllianceId = this._myAllianceId;
         }
         this._currentWinnerAlliance = this._alliances[0];
         var updated:Dictionary = new Dictionary();
         var emptyConquest:Boolean = totalPlayersNumber == 0;
         this.lbl_empty.visible = emptyConquest;
         i = 0;
         for each(alliance in this._alliances)
         {
            if(i++ == MAX_ALLIANCE)
            {
               break;
            }
            updated[alliance.allianceId] = true;
            if(!emptyConquest)
            {
               width = Math.max(1,Math.floor((this._barWidth - this._alliances.length + 1) / totalWeight * alliance.roundWeigth));
            }
            else
            {
               width = Math.max(1,Math.floor((this._barWidth - this._alliances.length + 1) / this._alliances.length));
            }
            bar = this._bar[alliance.allianceId];
            if(!bar)
            {
               bar = new Bar(this.uiApi);
               bar.container.y = 1;
               this._bar[alliance.allianceId] = bar;
               if(alliance.allianceId == this._myAllianceId)
               {
                  bar.colorBackground = TEAM_PLAYER_BG_COLOR;
                  bar.colorScore = TEAM_PLAYER_COLOR;
               }
               else if(alliance.allianceId == this._prismAllianceId)
               {
                  bar.colorBackground = TEAM_DEFENDER_BG_COLOR;
                  bar.colorScore = TEAM_DEFENDER_COLOR;
               }
               else
               {
                  bar.colorBackground = TEAM_ATTACKER_BG_COLOR;
                  bar.colorScore = TEAM_ATTACKER_COLOR;
               }
               
               this.uiApi.addComponentHook(bar.container,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(bar.container,ComponentHookList.ON_ROLL_OUT);
               this.ctr_bar.addChild(bar.container);
            }
            bar.score = alliance.matchScore;
            bar.update();
            bar.container.visible = true;
            this._barCtr[bar.container] = alliance;
            bar.width = width;
            bar.container.x = currentX;
            currentX = currentX + (width + 1);
         }
         for(allianceId in this._bar)
         {
            if(!updated[allianceId])
            {
               b = this._bar[allianceId];
               b.container.visible = false;
            }
         }
         if((this._currentWinnerAlliance) && (this._currentWinnerAlliance.matchScore >= SERVER_KOH_WINNING_SCORE))
         {
            this.kohOver();
         }
         if(this._currentView == this.VIEW_FULL)
         {
            this.gd_alliances.dataProvider = this._alliances;
         }
      }
      
      private function kohOver() : void {
         if(this._unexpectedWinnerAllianceName)
         {
            this.lbl_remainingTime.text = this.uiApi.getText("ui.koh.win",this._unexpectedWinnerAllianceName);
            this._unexpectedWinnerAllianceName = null;
         }
         else
         {
            this.lbl_remainingTime.text = this.uiApi.getText("ui.koh.win",this._currentWinnerAlliance.allianceName);
         }
         this._end = true;
         this.sysApi.removeEventListener(this.onEnterFrame);
         this._closeTimer.start();
      }
      
      private function unloadUi(e:Event = null) : void {
         if((this.uiApi) && (this.uiApi.me()))
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function switchView(viewType:int) : void {
         if(this._currentView == viewType)
         {
            return;
         }
         switch(viewType)
         {
            case this.VIEW_NONE:
               this.ctr_progressBar.visible = false;
               this.ctr_details.visible = false;
               this.btn_smallView.selected = this.btn_fullView.selected = false;
               break;
            case this.VIEW_SMALL:
               this.ctr_progressBar.visible = true;
               this.ctr_details.visible = false;
               this.tx_bg.gotoAndStop = 1;
               this.btn_smallView.selected = true;
               this.btn_fullView.selected = false;
               break;
            case this.VIEW_FULL:
               this.ctr_progressBar.visible = true;
               this.ctr_details.visible = true;
               this.tx_bg.gotoAndStop = 2;
               this.gd_alliances.dataProvider = this._alliances;
               this.btn_smallView.selected = false;
               this.btn_fullView.selected = true;
               this.updateTheHill();
               break;
         }
         this._currentView = viewType;
         _lastViewType = this._currentView;
      }
      
      private function updateKohStatus(pProbationTime:uint) : void {
         var prequalifiedTime:* = NaN;
         var currentStatus:uint = this.playerApi.characteristics().alignmentInfos.aggressable;
         if((this._kohPlayerStatus == currentStatus) || (currentStatus == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE) && (pProbationTime == 0))
         {
            return;
         }
         this._kohPlayerStatus = currentStatus;
         this._playerWeighInKoh = currentStatus == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE;
         if(currentStatus == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE)
         {
            this._mapScoreUpdateTime = 0;
            this.ctr_prequalified.visible = true;
            prequalifiedTime = (pProbationTime + 1) * 1000 - new Date().time;
            this._endOfPrequalifiedTime = prequalifiedTime + getTimer();
            this.updatePrequalifiedTime();
         }
         else
         {
            this.ctr_prequalified.visible = false;
         }
      }
      
      private function onKohUpdate(alliances:Object, allianceMapWinner:BasicAllianceInformations, allianceMapWinnerScore:uint, allianceMapMyAllianceScore:uint, nextTickTime:Number) : void {
         var alliance:AllianceOnTheHillWrapper = null;
         var mapInfos:WorldPointWrapper = null;
         var winnerTagText:String = null;
         var winnerScoreText:String = null;
         var myTagAndScoreText:String = null;
         var ts:* = NaN;
         if((allianceMapMyAllianceScore == 0) && (this.playerApi.characteristics().alignmentInfos.aggressable == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE))
         {
            ts = new Date().time;
            if(nextTickTime > ts)
            {
               this._mapScoreUpdateTime = nextTickTime - ts + getTimer();
               this.ctr_prequalified.visible = true;
            }
         }
         this._alliances = new Array();
         for each(alliance in alliances)
         {
            this._alliances.push(alliance);
         }
         this._alliances.sortOn("roundWeigth",Array.NUMERIC | Array.DESCENDING);
         this.updateTheHill();
         mapInfos = this.playerApi.currentMap();
         winnerScoreText = "";
         myTagAndScoreText = "";
         if(allianceMapWinnerScore == 0)
         {
            winnerTagText = this.uiApi.getText("ui.common.neutral");
         }
         else if(allianceMapWinner.allianceTag == "")
         {
            winnerTagText = "";
            winnerScoreText = this.uiApi.getText("ui.koh.draw",allianceMapWinnerScore.toString());
         }
         else
         {
            winnerTagText = this.chatApi.getAllianceLink(allianceMapWinner,allianceMapWinner.allianceTag);
            winnerScoreText = allianceMapWinnerScore.toString() + " " + this.uiApi.getText("ui.short.points");
         }
         
         if((!(allianceMapWinner.allianceId == this._myAllianceId)) && (allianceMapWinnerScore > 0))
         {
            myTagAndScoreText = this.chatApi.getAllianceLink(this.socialApi.getAlliance(),this.socialApi.getAlliance().allianceTag);
            this.lbl_mapConquestMyPov.text = myTagAndScoreText;
         }
         else
         {
            this.lbl_mapConquestMyPov.text = "";
         }
         this.lbl_mapConquest.text = this.uiApi.getText("ui.option.worldOption") + " [" + mapInfos.outdoorX + "," + mapInfos.outdoorY + "]" + this.uiApi.getText("ui.common.colon") + winnerTagText;
         if(allianceMapWinnerScore > 0)
         {
            this.lbl_mapConquest.appendText(" " + winnerScoreText);
         }
      }
      
      private function onPvpAvaStateChange(state:uint, probationTime:uint) : void {
         this.updateKohStatus(probationTime);
      }
      
      public function onPrismsListUpdate(pPrismSubAreas:Object) : void {
         var subAreaId:* = 0;
         var prismSubAreaInfo:PrismSubAreaWrapper = null;
         var currentSubAreaId:int = this.playerApi.currentSubArea().id;
         for each(subAreaId in pPrismSubAreas)
         {
            if(currentSubAreaId == subAreaId)
            {
               prismSubAreaInfo = this.socialApi.getPrismSubAreaById(subAreaId);
               if(prismSubAreaInfo.state != PrismStateEnum.PRISM_STATE_VULNERABLE)
               {
                  this._unexpectedWinnerAllianceName = prismSubAreaInfo.alliance.allianceName;
                  this.kohOver();
               }
            }
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_smallView:
               if(this._currentView == this.VIEW_SMALL)
               {
                  this.switchView(this.VIEW_NONE);
               }
               else
               {
                  this.switchView(this.VIEW_SMALL);
               }
               break;
            case this.btn_fullView:
               if(this._currentView == this.VIEW_FULL)
               {
                  this.switchView(this.VIEW_NONE);
               }
               else
               {
                  this.switchView(this.VIEW_FULL);
               }
               break;
            case this.btn_whoswhoTab:
               if(this._bDescendingSort)
               {
                  this.gd_alliances.sortOn("side",Array.NUMERIC);
               }
               else
               {
                  this.gd_alliances.sortOn("side",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_allianceTab:
               if(this._bDescendingSort)
               {
                  this.gd_alliances.sortOn("allianceTag",Array.CASEINSENSITIVE);
               }
               else
               {
                  this.gd_alliances.sortOn("allianceTag",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_playersTab:
               if(this._bDescendingSort)
               {
                  this.gd_alliances.sortOn("nbMembers",Array.NUMERIC);
               }
               else
               {
                  this.gd_alliances.sortOn("nbMembers",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_mapsTab:
               if(this._bDescendingSort)
               {
                  this.gd_alliances.sortOn("roundWeigth",Array.NUMERIC);
               }
               else
               {
                  this.gd_alliances.sortOn("roundWeigth",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_scoreTab:
               if(this._bDescendingSort)
               {
                  this.gd_alliances.sortOn("matchScore",Array.NUMERIC);
               }
               else
               {
                  this.gd_alliances.sortOn("matchScore",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var data:AllianceOnTheHillWrapper = null;
         var point:uint = 6;
         var relPoint:uint = 0;
         switch(true)
         {
            case !(target.name.indexOf("tx_type") == -1):
               data = this._compHookData[target.name];
               if(!data)
               {
                  return;
               }
               tooltipText = tooltipText = this.uiApi.getText(this._myAllianceId == data.allianceId?"ui.alliance.myAlliance":this._prismAllianceId == data.allianceId?"ui.alliance.allianceInDefense":"ui.alliance.allianceInAttack");
               break;
            case !(target.name.indexOf("tx_emblemBack") == -1):
               data = this._compHookData[target.name];
               if(!data)
               {
                  return;
               }
               tooltipText = data.allianceName + " [" + data.allianceTag + "]";
               break;
            case target == this.lbl_empty:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.emptyConquest");
               break;
            case !(this._barCtr[target] == null):
               data = this._barCtr[target];
               if(!data)
               {
                  return;
               }
               tooltipText = data.allianceName + " [" + data.allianceTag + "] " + "(" + data.roundWeigth + ") : " + data.matchScore + " / " + SERVER_KOH_WINNING_SCORE + "\n" + this.uiApi.getText(this._myAllianceId == data.allianceId?"ui.alliance.myAlliance":this._prismAllianceId == data.allianceId?"ui.alliance.allianceInDefense":"ui.alliance.allianceInAttack");
               break;
            case target == this.tx_swords:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.rules",SERVER_KOH_WINNING_SCORE,this.timeApi.getShortDuration(SERVER_KOH_DURATION));
               break;
            case target == this.btn_playersTab:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.members");
               break;
            case target == this.btn_mapsTab:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.maps");
               break;
            case target == this.btn_scoreTab:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.time");
               break;
            case target == this.lbl_mapConquest:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.mapConquest");
               break;
            case target == this.lbl_mapConquestMyPov:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.mapConquestForMyAlliance");
               break;
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      private function updateTime() : void {
         var remainingTime:int = this._kohStartTime + this._kohRealDuration - getTimer();
         if(remainingTime <= 0)
         {
            if(!this._end)
            {
               this.lbl_remainingTime.text = "-";
            }
            return;
         }
         this.lbl_remainingTime.text = this.timeApi.getShortDuration(remainingTime,true);
      }
      
      private function updatePrequalifiedTime() : void {
         var remainingTime:int = this._endOfPrequalifiedTime - getTimer();
         if(remainingTime <= 0)
         {
            this.ctr_prequalified.visible = false;
            this._endOfPrequalifiedTime = 0;
            return;
         }
         this.lbl_prequalifiedTime.text = this.timeApi.getShortDuration(remainingTime,true);
      }
      
      private function updateMapScoreUpdateTime() : void {
         var remainingTime:int = this._mapScoreUpdateTime - getTimer();
         if(remainingTime <= 0)
         {
            this.ctr_prequalified.visible = false;
            this._mapScoreUpdateTime = 0;
            return;
         }
         this.lbl_prequalifiedTime.text = this.timeApi.getShortDuration(remainingTime,true);
      }
   }
}
import d2components.GraphicContainer;
import ui.KingOfTheHill;
import d2api.UiApi;

class Bar extends Object
{
   
   function Bar(uiApi:UiApi) {
      super();
      this.container = uiApi.createContainer("GraphicContainer");
      this.ctr_score = uiApi.createContainer("GraphicContainer");
      this.bg = uiApi.createContainer("GraphicContainer");
      this.ctr_score.x = this.ctr_score.y = this.ctr_score.width = this.ctr_score.height = 0;
      this.container.addChild(this.bg);
      this.container.addChild(this.ctr_score);
      this.bg.mouseEnabled = true;
      this.ctr_score.mouseEnabled = true;
   }
   
   public var colorBackground:uint;
   
   public var colorScore:uint;
   
   public var score:uint;
   
   public var container:GraphicContainer;
   
   private var bg:GraphicContainer;
   
   private var ctr_score:GraphicContainer;
   
   public function set width(v:int) : void {
      this.ctr_score.width = v;
      this.bg.width = v;
   }
   
   public function update() : void {
      var prc:Number = (KingOfTheHill.SERVER_KOH_WINNING_SCORE - this.score) / KingOfTheHill.SERVER_KOH_WINNING_SCORE;
      var size:uint = 20;
      this.bg.bgColor = this.colorBackground;
      this.bg.width = 5;
      this.bg.height = Math.round(size * prc);
      this.ctr_score.bgColor = this.colorScore;
      this.ctr_score.y = this.bg.height;
      this.ctr_score.height = Math.round(size - size * prc);
   }
}
