package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.FightApi;
   import d2api.TimeApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Texture;
   import flash.utils.Dictionary;
   import d2hooks.*;
   import d2actions.*;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import d2data.FighterInformations;
   
   public class SpectatorPanel extends Object
   {
      
      public function SpectatorPanel() {
         this._lifePoints = new Array();
         this._attackersLifeById = new Dictionary();
         this._defendersLifeById = new Dictionary();
         super();
      }
      
      private static var ATTACKER_ID:int = 0;
      
      private static var DEFENDER_ID:int = 1;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var fightApi:FightApi;
      
      public var timeApi:TimeApi;
      
      public var mainCtr:GraphicContainer;
      
      public var lbl_attackersName:Label;
      
      public var lbl_defendersName:Label;
      
      public var lbl_time:Label;
      
      public var lbl_attackersLife:Label;
      
      public var lbl_defendersLife:Label;
      
      public var tx_lifeBar:Texture;
      
      private var LIFEPOINTS_STR:String;
      
      private var _fightStartTime:Number;
      
      private var _ticker:Object;
      
      private var _attackersName:String;
      
      private var _defendersName:String;
      
      private var _lifePoints:Array;
      
      private var _attackersLifeById:Dictionary;
      
      private var _defendersLifeById:Dictionary;
      
      public function main(params:Object) : void {
         this.sysApi.addHook(FightersListUpdated,this.onGameFightTurnListUpdated);
         this.sysApi.addHook(UpdatePreFightersList,this.onUpdatePreFightersList);
         this.sysApi.addHook(SpectateUpdate,this.onSpectateUpdate);
         this.sysApi.addHook(GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(GameFightStart,this.onGameFightStart);
         this.sysApi.addHook(FightEvent,this.onFightEvent);
         this.sysApi.addHook(BuffAdd,this.onBuffAdd);
         this.sysApi.addHook(BuffDispell,this.onBuffDispell);
         this.sysApi.addHook(BuffRemove,this.onBuffRemove);
         this.sysApi.addHook(BuffUpdate,this.onBuffUpdate);
         this.LIFEPOINTS_STR = this.uiApi.getText("ui.short.lifePoints");
         this._fightStartTime = params[0];
         this._attackersName = params[1];
         this._defendersName = params[2];
         if(this._fightStartTime > 0)
         {
            this.updateClock(null);
            this._ticker = new Timer(1000);
            this._ticker.addEventListener(TimerEvent.TIMER,this.updateClock);
            this._ticker.start();
         }
         else
         {
            this.lbl_time.text = "-";
         }
         if(this._attackersName != "")
         {
            this.lbl_attackersName.text = this._attackersName;
         }
         else
         {
            this.lbl_attackersName.text = this.uiApi.getText("ui.common.attackers");
         }
         if(this._defendersName != "")
         {
            this.lbl_defendersName.text = this._defendersName;
         }
         else
         {
            this.lbl_defendersName.text = this.uiApi.getText("ui.common.defenders");
         }
         this.onGameFightTurnListUpdated();
      }
      
      public function unload() : void {
         if(this._ticker)
         {
            this._ticker.removeEventListener(TimerEvent.TIMER,this.updateClock);
            this._ticker.stop();
         }
      }
      
      private function updateClock(te:TimerEvent) : void {
         var duration:Number = new Date().getTime() - this._fightStartTime * 1000;
         this.lbl_time.text = "" + this.timeApi.getShortDuration(duration,true);
      }
      
      private function updateLifeOfOneFighter(fighterId:int) : void {
         var infos:FighterInformations = this.fightApi.getFighterInformations(fighterId);
         if((infos) && ((!infos.summoned) || (infos.fighterId > -1)))
         {
            if(infos.team == "challenger")
            {
               this._attackersLifeById[fighterId] = infos.lifePoints + infos.shieldPoints;
            }
            else if(infos.team == "defender")
            {
               this._defendersLifeById[fighterId] = infos.lifePoints + infos.shieldPoints;
            }
            else if(this._attackersLifeById[fighterId])
            {
               this._attackersLifeById[fighterId] = 0;
            }
            else if(this._defendersLifeById[fighterId])
            {
               this._defendersLifeById[fighterId] = 0;
            }
            
            
            
            this.updateLifeBalance();
         }
      }
      
      private function updateLifeBalance() : void {
         var lp:* = 0;
         var attackersPercent:* = 0;
         var defendersPercent:* = 0;
         this._lifePoints[ATTACKER_ID] = 0;
         for each(lp in this._attackersLifeById)
         {
            this._lifePoints[ATTACKER_ID] = this._lifePoints[ATTACKER_ID] + lp;
         }
         this._lifePoints[DEFENDER_ID] = 0;
         for each(lp in this._defendersLifeById)
         {
            this._lifePoints[DEFENDER_ID] = this._lifePoints[DEFENDER_ID] + lp;
         }
         this.lbl_attackersLife.text = this._lifePoints[ATTACKER_ID] + " " + this.LIFEPOINTS_STR;
         this.lbl_defendersLife.text = this._lifePoints[DEFENDER_ID] + " " + this.LIFEPOINTS_STR;
         attackersPercent = int(this._lifePoints[ATTACKER_ID] / (this._lifePoints[DEFENDER_ID] + this._lifePoints[ATTACKER_ID]) * 100);
         defendersPercent = 100 - attackersPercent;
         this.tx_lifeBar.gotoAndStop = attackersPercent;
      }
      
      private function onGameFightTurnListUpdated() : void {
         var id:* = 0;
         var infos:FighterInformations = null;
         var fightersId:Object = this.fightApi.getFighters();
         if(!fightersId)
         {
            return;
         }
         var pos:int = fightersId.length - 1;
         while(pos >= 0)
         {
            id = fightersId[pos];
            infos = this.fightApi.getFighterInformations(id);
            if((infos) && ((!infos.summoned) || (infos.fighterId > -1)))
            {
               if(infos.team == "challenger")
               {
                  this._attackersLifeById[id] = infos.lifePoints + infos.shieldPoints;
               }
               else
               {
                  this._defendersLifeById[id] = infos.lifePoints + infos.shieldPoints;
               }
            }
            pos--;
         }
         this.updateLifeBalance();
      }
      
      private function onUpdatePreFightersList(id:int = 0) : void {
         this.updateLifeOfOneFighter(id);
      }
      
      private function onGameFightStart(... params) : void {
         if(this._fightStartTime == 0)
         {
            this._fightStartTime = new Date().getTime() / 1000;
            this.updateClock(null);
            this._ticker = new Timer(1000);
            this._ticker.addEventListener(TimerEvent.TIMER,this.updateClock);
            this._ticker.start();
         }
      }
      
      private function onSpectateUpdate(fightStartTime:Number, attackersName:String = "", defendersName:String = "") : void {
         if(fightStartTime == 0)
         {
            return;
         }
         this._fightStartTime = fightStartTime;
         this.updateClock(null);
         this._ticker = new Timer(1000);
         this._ticker.addEventListener(TimerEvent.TIMER,this.updateClock);
         this._ticker.start();
      }
      
      public function onBuffAdd(buffId:uint, targetId:int) : void {
         this.updateLifeOfOneFighter(targetId);
      }
      
      public function onBuffRemove(buffId:uint, targetId:int, reason:String) : void {
         this.updateLifeOfOneFighter(targetId);
      }
      
      public function onBuffUpdate(buffId:uint, targetId:int) : void {
         this.updateLifeOfOneFighter(targetId);
      }
      
      public function onBuffDispell(targetId:int) : void {
         this.updateLifeOfOneFighter(targetId);
      }
      
      private function onFightEvent(eventName:String, params:Object, targetList:Object = null) : void {
         var targetId:* = 0;
         if(targetList == null)
         {
            targetList = new Array();
            if(params.length)
            {
               targetList[0] = params[0];
            }
         }
         var num:int = targetList.length;
         var i:int = 0;
         while(i < num)
         {
            targetId = targetList[i];
            switch(eventName)
            {
               case "fighterLifeGain":
               case "fighterLifeLoss":
               case "fighterShieldLoss":
               case "fighterGotDispelled":
               case "fighterTemporaryBoosted":
               case "fighterDeath":
               case "fighterLeave":
                  this.updateLifeOfOneFighter(targetId);
                  break;
               case "fighterSummoned":
                  break;
            }
            i++;
         }
      }
      
      private function onGameFightEnd(params:Object) : void {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
