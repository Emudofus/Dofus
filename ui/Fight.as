package 
{
   import flash.display.Sprite;
   import ui.Timeline;
   import ui.Buffs;
   import ui.FightResult;
   import ui.TurnStart;
   import ui.FighterInfo;
   import ui.ChallengeDisplay;
   import ui.SpectatorPanel;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.FightApi;
   import d2api.DataApi;
   import d2api.ConfigApi;
   import d2api.ChatApi;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import d2hooks.*;
   import d2enums.StrataEnum;
   import flash.utils.Dictionary;
   
   public class Fight extends Sprite
   {
      
      public function Fight() {
         this._fightEventsTimer = new Timer(1000);
         super();
      }
      
      private static var _newLevel:int;
      
      public static function get newLevel() : int {
         return _newLevel;
      }
      
      protected var timeline:Timeline;
      
      protected var buffs:Buffs;
      
      protected var fightResult:FightResult;
      
      protected var turnStart:TurnStart;
      
      protected var fighterInfo:FighterInfo;
      
      protected var challengeDisplay:ChallengeDisplay;
      
      protected var spectatorPanel:SpectatorPanel;
      
      public var modCommon:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var fightApi:FightApi;
      
      public var dataApi:DataApi;
      
      public var configApi:ConfigApi;
      
      public var chatApi:ChatApi;
      
      private var _currentBuffsOwnerId:int;
      
      private var _fightEndParams:Object;
      
      private var _fightEventsTimer:Timer;
      
      private var _currentFightStartDate:Number = 0;
      
      private var _currentFightAttackersName:String = "";
      
      private var _currentFightDefendersName:String = "";
      
      private var _afkPopup:String;
      
      public function main() : void {
         Api.sysApi = this.sysApi;
         Api.uiApi = this.uiApi;
         Api.fightApi = this.fightApi;
         Api.dataApi = this.dataApi;
         Api.configApi = this.configApi;
         Api.chatApi = this.chatApi;
         _newLevel = -1;
         this._fightEventsTimer.addEventListener(TimerEvent.TIMER,this.onFightEventsTimer);
         this.sysApi.addHook(GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(GameFightStarting,this.onGameFightStarting);
         this.sysApi.addHook(GameFightStart,this.onGameFightStart);
         this.sysApi.addHook(SpectateUpdate,this.onSpectateUpdate);
         this.sysApi.addHook(FightersListUpdated,this.onFightersListUpdated);
         this.sysApi.addHook(FightText,this.onFightText);
         this.sysApi.addHook(FighterSelected,this.onOpenBuffs);
         this.sysApi.addHook(GameFightTurnStart,this.onTurnStart);
         this.sysApi.addHook(CharacterLevelUp,this.onCharacterLevelUp);
         this.sysApi.addHook(LevelUiClosed,this.onLevelUiClosed);
         this.sysApi.addHook(SpectatorWantLeave,this.onSpectatorWantLeave);
         this.sysApi.addHook(AfkModeChanged,this.onAfkModeChanged);
         this.sysApi.addHook(ChallengeInfoUpdate,this.onChallengeInfoUpdate);
      }
      
      public function unload() : void {
         if(this._fightEventsTimer)
         {
            this._fightEventsTimer.reset();
            this._fightEventsTimer.removeEventListener(TimerEvent.TIMER,this.onFightEventsTimer);
            this._fightEventsTimer = null;
         }
      }
      
      private var _preparationPhase:Boolean;
      
      private function onTurnStart(fighterId:int, waitingTime:uint, picture:Boolean) : void {
         var turnStartUi:Object = null;
         this._killCount = 0;
         if(picture)
         {
            turnStartUi = this.uiApi.getUi("turnStart");
            if(turnStartUi)
            {
               turnStartUi.uiClass.restart(fighterId,waitingTime);
            }
            else
            {
               this.uiApi.loadUi("turnStart","turnStart",
                  {
                     "fighterId":fighterId,
                     "waitingTime":waitingTime
                  });
            }
         }
         else if(this.uiApi.getUi("turnStart"))
         {
            this.uiApi.unloadUi("turnStart");
         }
         
      }
      
      private function onFightersListUpdated() : void {
         if(!this.uiApi.getUi("timeline"))
         {
            this.uiApi.loadUi("timeline","timeline");
         }
      }
      
      private function onGameFightEnd(params:Object) : void {
         this._fightEventsTimer.reset();
         this.uiApi.unloadUi("timeline");
         this.uiApi.unloadUi("fighterInfo");
         if(this.uiApi.getUi("buffs"))
         {
            this.uiApi.unloadUi("buffs");
         }
         if((!this._preparationPhase) && (params.results.length > 0))
         {
            this.uiApi.loadUi("fightResult","fightResult",params);
         }
         if(this.uiApi.getUi("turnStart"))
         {
            this.uiApi.unloadUi("turnStart");
         }
         if(this.uiApi.getUi("challengeDisplay"))
         {
            this.uiApi.unloadUi("challengeDisplay");
         }
         if(this._afkPopup)
         {
            this.uiApi.unloadUi(this._afkPopup);
            this._afkPopup = null;
         }
         this._preparationPhase = false;
         this._currentFightStartDate = 0;
         this._currentFightAttackersName = "";
         this._currentFightDefendersName = "";
      }
      
      private var _killCount:uint = 0;
      
      private function onFightText(pEvtName:String, pParams:Object, pTargets:Object, pTargetsTeam:String = "") : void {
         try
         {
            FightTexts.event(pEvtName,pParams,pTargets,pTargetsTeam);
         }
         catch(e:Error)
         {
            trace("Exception sur onFightText : " + e.getStackTrace());
         }
      }
      
      private function onOpenBuffs(targetId:int) : void {
         var timelineUi:Object = this.uiApi.getUi("timeline");
         if(!this.uiApi.getUi("buffs"))
         {
            this._currentBuffsOwnerId = targetId;
            this.uiApi.loadUiInside("buffs",timelineUi.uiClass.ctr_buffs,"buffs",targetId);
         }
         else if(this._currentBuffsOwnerId == targetId)
         {
            this.uiApi.unloadUi("buffs");
         }
         else
         {
            this._currentBuffsOwnerId = targetId;
            this.uiApi.unloadUi("buffs");
            this.uiApi.loadUiInside("buffs",timelineUi.uiClass.ctr_buffs,"buffs",targetId);
         }
         
      }
      
      private function onCharacterLevelUp(pNewLevel:uint, pSpellPointEarned:uint, pCaracPointEarned:uint, pHealPointEarned:uint, pNewSpell:Object, pSpellObtained:Boolean, pLevelSpellObtention:int) : void {
         _newLevel = pNewLevel;
      }
      
      private function onLevelUiClosed() : void {
         this.uiApi.loadUi("fightResult","fightResult",this._fightEndParams);
      }
      
      private function onSpectatorWantLeave() : void {
         this.uiApi.unloadUi("timeline");
         this.uiApi.unloadUi("fighterInfo");
         if(this.uiApi.getUi("buffs"))
         {
            this.uiApi.unloadUi("buffs");
         }
         if(this.uiApi.getUi("turnStart"))
         {
            this.uiApi.unloadUi("turnStart");
         }
         if(this.uiApi.getUi("challengeDisplay"))
         {
            this.uiApi.unloadUi("challengeDisplay");
         }
         if(this.uiApi.getUi("spectatorPanel"))
         {
            this.uiApi.unloadUi("spectatorPanel");
         }
         this._currentFightStartDate = 0;
         this._currentFightAttackersName = "";
         this._currentFightDefendersName = "";
      }
      
      private function onSpectateUpdate(fightStartTime:Number, attackersName:String = "", defendersName:String = "") : void {
         if(fightStartTime > 0)
         {
            this._currentFightStartDate = fightStartTime;
         }
         if(attackersName != "")
         {
            this._currentFightAttackersName = attackersName;
         }
         if(defendersName != "")
         {
            this._currentFightDefendersName = defendersName;
         }
         if(!this.uiApi.getUi("spectatorPanel"))
         {
            this.uiApi.loadUi("spectatorPanel","spectatorPanel",[this._currentFightStartDate,this._currentFightAttackersName,this._currentFightDefendersName],StrataEnum.STRATA_HIGH);
         }
      }
      
      private function onGameFightStarting(... params) : void {
         FightTexts.cacheFighterName = new Dictionary();
         this._preparationPhase = true;
         this.uiApi.unloadUi("fightResult");
         if(!this.uiApi.getUi("timeline"))
         {
            this.uiApi.loadUi("timeline","timeline");
         }
         if(!this.uiApi.getUi("fighterInfo"))
         {
            this.uiApi.loadUi("fighterInfo","fighterInfo",null,StrataEnum.STRATA_TOP);
         }
      }
      
      private function onGameFightStart(... params) : void {
         this._preparationPhase = false;
      }
      
      private function onAfkModeChanged(enabled:Boolean) : void {
         if((enabled) && (!this._afkPopup))
         {
            this._afkPopup = this.modCommon.openPopup(this.uiApi.getText("ui.fight.inactivityTitle"),this.uiApi.getText("ui.fight.inactivityMessage"),[this.uiApi.getText("ui.common.ok")],[this.onQuitAfk],this.onQuitAfk,this.onQuitAfk);
         }
      }
      
      private function onQuitAfk() : void {
         this._afkPopup = null;
      }
      
      private function onFightEventsTimer(e:TimerEvent) : void {
         FightTexts.writeLog();
      }
      
      public function onChallengeInfoUpdate(challenges:Object) : void {
         if(!this.uiApi.getUi("challengeDisplay"))
         {
            this.uiApi.loadUi("challengeDisplay","challengeDisplay",{"challenges":challenges});
         }
      }
   }
}
