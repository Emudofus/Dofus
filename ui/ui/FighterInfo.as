package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.FightApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.EntityDisplayer;
   import d2components.Label;
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import flash.events.TimerEvent;
   import d2hooks.*;
   import d2actions.*;
   import d2network.GameFightCharacterInformations;
   import d2network.GameFightCompanionInformations;
   import d2data.FighterInformations;
   
   public class FighterInfo extends Object
   {
      
      public function FighterInfo() {
         this._stats = new Dictionary();
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var fightApi:FightApi;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_entity:GraphicContainer;
      
      public var btn_spectatorPanel:ButtonContainer;
      
      public var entityDisplayer:EntityDisplayer;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var lbl_lifePoints:Label;
      
      public var lbl_shieldPoints:Label;
      
      public var lbl_actionPoints:Label;
      
      public var lbl_movementPoints:Label;
      
      public var lbl_action:Label;
      
      public var lbl_movement:Label;
      
      public var lbl_tackle:Label;
      
      public var lbl_criticalDmgReduction:Label;
      
      public var lbl_pushDmgReduction:Label;
      
      public var lbl_neutralPercent:Label;
      
      public var lbl_strengthPercent:Label;
      
      public var lbl_intelligencePercent:Label;
      
      public var lbl_chancePercent:Label;
      
      public var lbl_agilityPercent:Label;
      
      public var lbl_neutral:Label;
      
      public var lbl_strength:Label;
      
      public var lbl_intelligence:Label;
      
      public var lbl_chance:Label;
      
      public var lbl_agility:Label;
      
      private var _timerEntityDisplayer:Timer;
      
      private var _fighterId:int;
      
      private var _lastFighterId:int;
      
      private var _stats:Dictionary;
      
      public function main(params:Object) : void {
         this.sysApi.addHook(FighterInfoUpdate,this.onFighterInfoUpdate);
         this.sysApi.addHook(FightEvent,this.onFightEvent);
         this.sysApi.addHook(SpectateUpdate,this.onSpectateUpdate);
         this.sysApi.addHook(GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(SpectatorWantLeave,this.onGameFightEnd);
         this.mainCtr.visible = false;
         this.ctr_entity.scaleX = -1;
         this.entityDisplayer.useFade = false;
         this.entityDisplayer.view = "timeline";
         this._timerEntityDisplayer = new Timer(10,1);
         this._timerEntityDisplayer.addEventListener(TimerEvent.TIMER,this.showEntityDisplayer);
         if(this.fightApi.isSpectator())
         {
            if(this.uiApi.getUi("spectatorPanel"))
            {
               this.btn_spectatorPanel.selected = true;
            }
            else
            {
               this.btn_spectatorPanel.selected = false;
            }
            this.btn_spectatorPanel.visible = true;
         }
         else
         {
            this.btn_spectatorPanel.visible = false;
         }
      }
      
      public function unload() : void {
         if(this._timerEntityDisplayer)
         {
            this._timerEntityDisplayer.removeEventListener(TimerEvent.TIMER,this.showEntityDisplayer);
            this._timerEntityDisplayer.reset();
            this._timerEntityDisplayer = null;
         }
         var bannerUi:Object = this.uiApi.getUi("banner").uiClass;
         bannerUi.gd_btnUis.mouseChildren = true;
         bannerUi.btn_moreBtn.mouseEnabled = true;
      }
      
      private function showEntityDisplayer(event:TimerEvent) : void {
         this._timerEntityDisplayer.reset();
         this.entityDisplayer.look = this.fightApi.getFighterInformations(this._fighterId).look;
         this.entityDisplayer.setAnimationAndDirection("AnimArtwork",1);
         this.entityDisplayer.visible = true;
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.btn_spectatorPanel)
         {
            if(!this.uiApi.getUi("spectatorPanel"))
            {
               this.sysApi.dispatchHook(SpectateUpdate,0,"","");
               this.btn_spectatorPanel.selected = true;
            }
            else
            {
               this.uiApi.unloadUi("spectatorPanel");
               this.btn_spectatorPanel.selected = false;
            }
         }
      }
      
      public function onFighterInfoUpdate(infos:Object = null) : void {
         var bannerUi:Object = this.uiApi.getUi("banner").uiClass;
         if((infos) && (!this.fightApi.preFightIsActive()))
         {
            bannerUi.gd_btnUis.mouseChildren = false;
            bannerUi.btn_moreBtn.mouseEnabled = false;
            if((this.fightApi.isSpectator()) && (this.sysApi.getOption("spectatorAutoShowCurrentFighterInfo","dofus")))
            {
               this.btn_spectatorPanel.visible = false;
            }
            this.entityDisplayer.disabled = infos.stats.lifePoints <= 0;
            this.lbl_name.text = this.fightApi.getFighterName(infos.contextualId);
            this.lbl_level.text = this.uiApi.getText("ui.common.short.level") + " " + this.fightApi.getFighterLevel(infos.contextualId);
            this._lastFighterId = this._fighterId;
            this._fighterId = infos.contextualId;
            if((!(this._stats["lifePoints"] == infos.stats.lifePoints)) || (!(this._stats["maxLifePoints"] == infos.stats.maxLifePoints)))
            {
               this._stats["lifePoints"] = infos.stats.lifePoints;
               this._stats["maxLifePoints"] = infos.stats.maxLifePoints;
               this.updateLifePoints();
            }
            if(this._stats["shieldPoints"] != infos.stats.shieldPoints)
            {
               this._stats["shieldPoints"] = infos.stats.shieldPoints;
               this.updateShieldPoints();
            }
            if(this._stats["fighterUsedAP"] != infos.stats.actionPoints)
            {
               this._stats["fighterUsedAP"] = infos.stats.actionPoints;
               this.lbl_actionPoints.text = this._stats["fighterUsedAP"];
            }
            if(this._stats["movementPoints"] != infos.stats.movementPoints)
            {
               this._stats["movementPoints"] = infos.stats.movementPoints;
               this.lbl_movementPoints.text = this._stats["movementPoints"];
            }
            if(this._stats["dodgePALostProbability"] != infos.stats.dodgePALostProbability)
            {
               this._stats["dodgePALostProbability"] = infos.stats.dodgePALostProbability;
               this.lbl_action.text = infos.stats.dodgePALostProbability;
            }
            if(this._stats["dodgePMLostProbability"] != infos.stats.dodgePMLostProbability)
            {
               this._stats["dodgePMLostProbability"] = infos.stats.dodgePMLostProbability;
               this.lbl_movement.text = this._stats["dodgePMLostProbability"];
            }
            if(this._stats["tackleBlock"] != infos.stats.tackleBlock)
            {
               this._stats["tackleBlock"] = infos.stats.tackleBlock;
               this.lbl_tackle.text = this._stats["tackleBlock"] > 0?this._stats["tackleBlock"].toString():"0";
            }
            if(this._stats["criticalDamageReduction"] != infos.stats.criticalDamageFixedResist)
            {
               this._stats["criticalDamageReduction"] = infos.stats.criticalDamageFixedResist;
               this.lbl_criticalDmgReduction.text = this._stats["criticalDamageReduction"];
            }
            if(this._stats["pushDamageReduction"] != infos.stats.pushDamageFixedResist)
            {
               this._stats["pushDamageReduction"] = infos.stats.pushDamageFixedResist;
               this.lbl_pushDmgReduction.text = this._stats["pushDamageReduction"];
            }
            if((infos is GameFightCharacterInformations) || (infos is GameFightCompanionInformations))
            {
               this._stats["neutralPercent"] = infos.stats.neutralElementResistPercent > 50?50:infos.stats.neutralElementResistPercent;
               this._stats["strengthPercent"] = infos.stats.earthElementResistPercent > 50?50:infos.stats.earthElementResistPercent;
               this._stats["intelligencePercent"] = infos.stats.fireElementResistPercent > 50?50:infos.stats.fireElementResistPercent;
               this._stats["chancePercent"] = infos.stats.waterElementResistPercent > 50?50:infos.stats.waterElementResistPercent;
               this._stats["agilityPercent"] = infos.stats.airElementResistPercent > 50?50:infos.stats.airElementResistPercent;
               this._stats["neutral"] = infos.stats.neutralElementReduction;
               this._stats["strength"] = infos.stats.earthElementReduction;
               this._stats["intelligence"] = infos.stats.fireElementReduction;
               this._stats["chance"] = infos.stats.waterElementReduction;
               this._stats["agility"] = infos.stats.airElementReduction;
            }
            else
            {
               this._stats["neutralPercent"] = infos.stats.neutralElementResistPercent;
               this._stats["strengthPercent"] = infos.stats.earthElementResistPercent;
               this._stats["intelligencePercent"] = infos.stats.fireElementResistPercent;
               this._stats["chancePercent"] = infos.stats.waterElementResistPercent;
               this._stats["agilityPercent"] = infos.stats.airElementResistPercent;
               this._stats["neutral"] = infos.stats.neutralElementReduction;
               this._stats["strength"] = infos.stats.earthElementReduction;
               this._stats["intelligence"] = infos.stats.fireElementReduction;
               this._stats["chance"] = infos.stats.waterElementReduction;
               this._stats["agility"] = infos.stats.airElementReduction;
            }
            this.updateResistance();
            this.mainCtr.visible = true;
            if(this.entityDisplayer.look != this.fightApi.getFighterInformations(this._fighterId).look)
            {
               this._timerEntityDisplayer.start();
               this.entityDisplayer.visible = false;
            }
            else
            {
               this._timerEntityDisplayer.reset();
            }
         }
         else
         {
            bannerUi.gd_btnUis.mouseChildren = true;
            bannerUi.btn_moreBtn.mouseEnabled = true;
            if(this.fightApi.isSpectator())
            {
               this.btn_spectatorPanel.visible = true;
            }
            this.mainCtr.visible = false;
            this._timerEntityDisplayer.reset();
         }
      }
      
      private function updateLifePoints() : void {
         this.lbl_lifePoints.text = this._stats["lifePoints"] + " / " + this._stats["maxLifePoints"];
      }
      
      private function updateShieldPoints() : void {
         this.lbl_shieldPoints.text = this._stats["shieldPoints"];
      }
      
      private function updateResistance() : void {
         this.lbl_neutralPercent.text = this._stats["neutralPercent"] + "%";
         this.lbl_strengthPercent.text = this._stats["strengthPercent"] + "%";
         this.lbl_intelligencePercent.text = this._stats["intelligencePercent"] + "%";
         this.lbl_chancePercent.text = this._stats["chancePercent"] + "%";
         this.lbl_agilityPercent.text = this._stats["agilityPercent"] + "%";
         this.lbl_neutral.text = this._stats["neutral"];
         this.lbl_strength.text = this._stats["strength"];
         this.lbl_intelligence.text = this._stats["intelligence"];
         this.lbl_chance.text = this._stats["chance"];
         this.lbl_agility.text = this._stats["agility"];
      }
      
      private function onFightEvent(eventName:String, params:Object, targetList:Object = null) : void {
         var targetId:* = 0;
         var infos:FighterInformations = null;
         if(!this._fighterId)
         {
            return;
         }
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
            if(this._fighterId != targetId)
            {
               i++;
               continue;
            }
            switch(eventName)
            {
               case "fighterUsedMP":
               case "fighterLostMP":
                  this._stats["movementPoints"] = this._stats["movementPoints"] - params[1];
                  this.lbl_movementPoints.text = this._stats["movementPoints"];
                  break;
               case "fighterGainedMP":
                  this._stats["movementPoints"] = this._stats["movementPoints"] + params[1];
                  this.lbl_movementPoints.text = this._stats["movementPoints"];
                  break;
               case "fighterUsedAP":
               case "fighterLostAP":
                  this._stats["fighterUsedAP"] = this._stats["fighterUsedAP"] - params[1];
                  this.lbl_actionPoints.text = this._stats["fighterUsedAP"];
                  break;
               case "fighterGainedAP":
                  this._stats["fighterUsedAP"] = this._stats["fighterUsedAP"] + params[1];
                  this.lbl_actionPoints.text = this._stats["fighterUsedAP"];
                  break;
               case "fighterLifeGain":
                  this._stats["lifePoints"] = this._stats["lifePoints"] + params[1];
                  this.updateLifePoints();
                  break;
               case "fighterLifeLoss":
                  this._stats["lifePoints"] = this._stats["lifePoints"] - params[1];
                  this.updateLifePoints();
                  break;
               case "fighterShieldLoss":
                  this._stats["shieldPoints"] = this._stats["shieldPoints"] - params[1];
                  this.updateShieldPoints();
                  break;
               case "fighterShieldGain":
                  this._stats["shieldPoints"] = this._stats["shieldPoints"] + params[1];
                  this.updateShieldPoints();
                  break;
               case "fighterGotDispelled":
               case "fighterTemporaryBoosted":
                  infos = this.fightApi.getFighterInformations(targetId);
                  this._stats["shieldPoints"] = infos.shieldPoints;
                  this._stats["lifePoints"] = infos.lifePoints;
                  this.updateLifePoints();
                  this.updateShieldPoints();
                  if(this._stats["movementPoints"] != infos.movementPoints)
                  {
                     this._stats["movementPoints"] = infos.movementPoints;
                     this.lbl_movementPoints.text = this._stats["movementPoints"];
                  }
                  if(this._stats["fighterUsedAP"] != infos.actionPoints)
                  {
                     this._stats["fighterUsedAP"] = infos.actionPoints;
                     this.lbl_actionPoints.text = this._stats["fighterUsedAP"];
                  }
                  this._stats["neutral"] = infos.neutralFixedResist;
                  this._stats["strength"] = infos.earthFixedResist;
                  this._stats["intelligence"] = infos.fireFixedResist;
                  this._stats["chance"] = infos.waterFixedResist;
                  this._stats["agility"] = infos.airFixedResist;
                  this._stats["neutralPercent"] = infos.neutralResist > 50?50:infos.neutralResist;
                  this._stats["strengthPercent"] = infos.earthResist > 50?50:infos.earthResist;
                  this._stats["intelligencePercent"] = infos.fireResist > 50?50:infos.fireResist;
                  this._stats["chancePercent"] = infos.waterResist > 50?50:infos.waterResist;
                  this._stats["agilityPercent"] = infos.airResist > 50?50:infos.airResist;
                  this.updateResistance();
                  break;
               case "fighterGotTackled":
                  this._stats["fighterUsedAP"] = this._stats["fighterUsedAP"] - params[1];
                  this._stats["movementPoints"] = this._stats["movementPoints"] - params[2];
                  this.lbl_actionPoints.text = this._stats["fighterUsedAP"];
                  this.lbl_movementPoints.text = this._stats["movementPoints"];
                  break;
               case "fighterDeath":
               case "fighterLeave":
                  this._stats["lifePoints"] = 0;
                  this.updateLifePoints();
                  break;
            }
            return;
         }
      }
      
      public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int) : void {
         if(isSpectator)
         {
            if(this.uiApi.getUi("spectatorPanel"))
            {
               this.btn_spectatorPanel.selected = true;
            }
            else
            {
               this.btn_spectatorPanel.selected = false;
            }
            this.btn_spectatorPanel.visible = true;
         }
         else
         {
            this.btn_spectatorPanel.visible = false;
         }
      }
      
      private function onSpectateUpdate(fightStartTime:Number, attackersName:String = "", defendersName:String = "") : void {
         this.btn_spectatorPanel.selected = true;
      }
      
      private function onGameFightEnd(params:Object) : void {
         this.btn_spectatorPanel.visible = false;
      }
   }
}
