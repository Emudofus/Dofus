package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.FightApi;
   import ui.timeline.Fighter;
   import flash.display.Sprite;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2hooks.GameFightTurnEnd;
   import d2hooks.FightersListUpdated;
   import d2hooks.UpdatePreFightersList;
   import d2hooks.GameFightTurnStart;
   import d2hooks.FightEvent;
   import d2hooks.FoldAll;
   import d2hooks.FighterSelected;
   import d2hooks.BuffAdd;
   import d2hooks.BuffDispell;
   import d2hooks.BuffRemove;
   import d2hooks.BuffUpdate;
   import d2hooks.TurnCountUpdated;
   import d2hooks.OrderFightersSwitched;
   import d2hooks.HideDeadFighters;
   import d2hooks.HideSummonedFighters;
   import d2hooks.WaveUpdated;
   import d2hooks.FighterInfoUpdate;
   import d2actions.*;
   import d2data.FighterInformations;
   import flash.utils.Dictionary;
   import d2enums.TeamEnum;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   
   public class Timeline extends Object
   {
      
      public function Timeline() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var fightApi:FightApi;
      
      private var _fighters:Array;
      
      private var _hiddenFighters:Array;
      
      private var _fightersId:Object;
      
      private var _foldAllStatus:Boolean = false;
      
      private var _hideDeadGuys:Boolean = false;
      
      private var _hideSummonedStuff:Boolean = false;
      
      private var _selectedFighter:Fighter = null;
      
      private var _turnOf:Fighter = null;
      
      private var _timelineMask:Sprite;
      
      private var _screenWidth:int;
      
      private var _charCtrOffset:int;
      
      private var _turnCount:uint = 1;
      
      private var _waveCountAttackers:uint = 0;
      
      private var _turnCountBeforeNextWaveAttackers:int = -1;
      
      private var _waveCountDefenders:uint = 0;
      
      private var _turnCountBeforeNextWaveDefenders:int = -1;
      
      private var _topDisplayMode:Boolean;
      
      private var _rollOverMe:Boolean = false;
      
      public var timelineCtr:GraphicContainer;
      
      public var charCtr:GraphicContainer;
      
      public var charFrames:GraphicContainer;
      
      public var ctr_timeline:GraphicContainer;
      
      public var ctr_buffs:GraphicContainer;
      
      public var lbl_turnCount:Label;
      
      public var btn_minimArrow:ButtonContainer;
      
      public var btn_rightArrow:ButtonContainer;
      
      public var btn_leftArrow:ButtonContainer;
      
      public var btn_up:ButtonContainer;
      
      public var btn_down:ButtonContainer;
      
      public var tx_currentArrow:Texture;
      
      public var tx_background:Texture;
      
      public var tx_wave:Texture;
      
      public function main(turnList:Object) : void {
         this.sysApi.addHook(GameFightTurnEnd,this.onGameFightTurnEnd);
         this.sysApi.addHook(FightersListUpdated,this.onGameFightTurnListUpdated);
         this.sysApi.addHook(UpdatePreFightersList,this.onUpdatePreFightersList);
         this.sysApi.addHook(GameFightTurnStart,this.onGameFightTurnStart);
         this.sysApi.addHook(FightEvent,this.onFightEvent);
         this.sysApi.addHook(FoldAll,this.onFoldAll);
         this.sysApi.addHook(FighterSelected,this.onFighterSelected);
         this.sysApi.addHook(BuffAdd,this.onBuffAdd);
         this.sysApi.addHook(BuffDispell,this.onBuffDispell);
         this.sysApi.addHook(BuffRemove,this.onBuffRemove);
         this.sysApi.addHook(BuffUpdate,this.onBuffUpdate);
         this.sysApi.addHook(TurnCountUpdated,this.onTurnCountUpdated);
         this.sysApi.addHook(OrderFightersSwitched,this.onOrderFightersSwitched);
         this.sysApi.addHook(HideDeadFighters,this.onHideDeadFighters);
         this.sysApi.addHook(HideSummonedFighters,this.onHideSummonedFighters);
         this.sysApi.addHook(WaveUpdated,this.onWaveUpdated);
         this.sysApi.addHook(FighterInfoUpdate,this.onFighterMouseAction);
         this.uiApi.addComponentHook(this.lbl_turnCount,"onRollOver");
         this.uiApi.addComponentHook(this.lbl_turnCount,"onRollOut");
         this.uiApi.addComponentHook(this.tx_wave,"onRollOver");
         this.uiApi.addComponentHook(this.tx_wave,"onRollOut");
         this._fighters = new Array();
         this._hiddenFighters = new Array();
         this.tx_background.autoGrid = true;
         this.tx_currentArrow.visible = false;
         this._screenWidth = this.uiApi.getStageWidth();
         this._charCtrOffset = int(this.uiApi.me().getConstant("char_ctr_offset"));
         this._topDisplayMode = this.sysApi.getData("topDisplayTimeline");
         this._hideDeadGuys = this.sysApi.getOption("hideDeadFighters","dofus");
         this._hideSummonedStuff = this.sysApi.getOption("hideSummonedFighters","dofus");
         this._timelineMask = new Sprite();
         this._timelineMask.graphics.beginFill(16733440);
         this._timelineMask.graphics.drawRect(-this._screenWidth + 170,0,this._screenWidth - 110,this.timelineCtr.height);
         this._timelineMask.graphics.endFill();
         this.timelineCtr.addChild(this._timelineMask);
         this._timelineMask.visible = false;
         this.replaceTimeline();
      }
      
      public function unload() : void {
         var fighter:Fighter = null;
         Fighter.cleanFramesPool();
         var i:int = 0;
         while(i < this._fighters.length)
         {
            fighter = this._fighters[i];
            fighter.destroy();
            i++;
         }
         this._fighters = null;
         this._hiddenFighters = null;
      }
      
      public function set folded(value:Boolean) : void {
         var te:Boolean = this.isTimelineExtended();
         this.btn_leftArrow.visible = (!value) && (te);
         this.btn_rightArrow.visible = (!value) && (te);
         this.charFrames.visible = !value;
         this.tx_currentArrow.visible = !value;
         this.tx_background.visible = !value;
         this.lbl_turnCount.visible = !value;
         this.tx_wave.visible = (!value) && ((this._waveCountAttackers > 0) || (this._waveCountDefenders > 0));
      }
      
      public function get folded() : Boolean {
         return !this.charFrames.visible;
      }
      
      public function moveLeft() : void {
         var offset:int = this.charCtr.contentWidth - this._timelineMask.width - this._charCtrOffset;
         if(this.charFrames.x + this._charCtrOffset + 300 < this._timelineMask.x + offset)
         {
            this.charFrames.x = this.charFrames.x + 300;
         }
         else
         {
            this.charFrames.x = this._timelineMask.x + offset;
         }
         this.updateTurnOfArrow();
      }
      
      public function moveRight() : void {
         if(this.charFrames.x + this._charCtrOffset > this._timelineMask.x + 300)
         {
            this.charFrames.x = this.charFrames.x - 300;
         }
         else
         {
            this.charFrames.x = this._timelineMask.x;
         }
         this.updateTurnOfArrow();
      }
      
      public function refreshMoveOffset() : void {
         if(this.charCtr.contentWidth <= this._timelineMask.width)
         {
            this.charFrames.x = -this.charFrames.width;
         }
         else if(this.charFrames.x + this._charCtrOffset < this._timelineMask.x)
         {
            this.charFrames.x = this._timelineMask.x;
         }
         else if(this.charFrames.x + this._charCtrOffset - this.charCtr.contentWidth > this._timelineMask.x - this._timelineMask.width)
         {
            this.charFrames.x = this._timelineMask.x - this._timelineMask.width + this.charCtr.contentWidth;
         }
         
         
      }
      
      private function createFighter(id:int, num:uint) : Fighter {
         var f:Fighter = new Fighter(id,this.uiApi.me(),num);
         this.uiApi.addComponentHook(f.frame,"onRelease");
         this.uiApi.addComponentHook(f.frame,"onRollOver");
         this.uiApi.addComponentHook(f.frame,"onRollOut");
         this.charCtr.addChild(f.frame);
         return f;
      }
      
      private function refreshTimeline() : void {
         var fighter:Fighter = null;
         var oldfighter:Fighter = null;
         var id:* = 0;
         var infos:FighterInformations = null;
         var alive:* = false;
         var deadId:* = 0;
         var oldFighters:Dictionary = new Dictionary();
         for each(oldFighters[oldfighter.id] in this._fighters)
         {
         }
         this._fightersId = this.fightApi.getFighters();
         if(!this._fightersId)
         {
            this._fightersId = new Array();
         }
         var deadFightersId:Object = this.fightApi.getDeadFighters();
         if(!deadFightersId)
         {
            deadFightersId = new Array();
         }
         this._fighters = new Array();
         this._hiddenFighters = new Array();
         var numFighter:uint = this._fightersId.length - deadFightersId.length;
         var pos:int = this._fightersId.length - 1;
         while(pos >= 0)
         {
            id = this._fightersId[pos];
            infos = Api.fightApi.getFighterInformations(id);
            alive = true;
            for each(deadId in deadFightersId)
            {
               if(deadId == id)
               {
                  alive = false;
                  break;
               }
            }
            if(oldFighters[id])
            {
               if(((!this._hideDeadGuys) || (alive)) && ((!this._hideSummonedStuff) || (!oldFighters[id].summoned)))
               {
                  fighter = oldFighters[id];
                  fighter.alive = alive;
                  fighter.updateNumber(numFighter);
                  if(!fighter.alive)
                  {
                     numFighter++;
                  }
                  oldFighters[id] = null;
                  this._fighters.push(fighter);
               }
               else
               {
                  this._hiddenFighters[id] = 
                     {
                        "id":id,
                        "alive":alive,
                        "summoned":oldFighters[id].summoned
                     };
                  this.charCtr.removeChild(oldFighters[id].frame);
                  oldFighters[id].destroy(true);
                  fighter = null;
                  if(!alive)
                  {
                     numFighter++;
                  }
               }
            }
            else
            {
               infos = Api.fightApi.getFighterInformations(id);
               if((infos) && (!this._hideDeadGuys || alive) && ((!this._hideSummonedStuff) || (!infos.summoned)))
               {
                  fighter = this.createFighter(id,numFighter);
                  fighter.alive = alive;
                  if(!fighter.alive)
                  {
                     numFighter++;
                  }
                  this.charCtr.addChild(fighter.frame);
                  this._fighters.push(fighter);
               }
               else
               {
                  if(!alive)
                  {
                     numFighter++;
                  }
                  if(infos)
                  {
                     this._hiddenFighters[id] = 
                        {
                           "id":id,
                           "alive":alive,
                           "summoned":infos.summoned
                        };
                  }
               }
            }
            numFighter--;
            pos--;
         }
         for each(fighter in oldFighters)
         {
            if(fighter)
            {
               fighter.frame.removeFromParent();
               if(deadFightersId.length > 0)
               {
                  fighter.destroy();
               }
               else
               {
                  fighter.destroy(true);
               }
            }
         }
         this.resizeTimeline();
      }
      
      private function selectFighter(fighter:Fighter) : void {
         if(this._selectedFighter)
         {
            this._selectedFighter.selected = false;
         }
         if(this._selectedFighter != fighter)
         {
            this._selectedFighter = fighter;
            fighter.selected = true;
         }
         else
         {
            this._selectedFighter = null;
         }
      }
      
      private function setTurnOf(fighter:Fighter, waitTime:int) : void {
         this._turnOf = fighter;
         if(!fighter.highlight)
         {
            fighter.highlight = true;
         }
         fighter.startCountDown(waitTime);
         this.updateTurnOfArrow();
      }
      
      private function updateTurnOfArrow() : void {
         if(this._turnOf)
         {
            if(!this.tx_currentArrow.visible)
            {
               this.tx_currentArrow.visible = true;
            }
            this.tx_currentArrow.x = this._turnOf.frame.x + int(this._turnOf.frame.width / 2) - this.tx_currentArrow.width / 2 - 7;
         }
      }
      
      private function unsetTurnOf(fighter:Fighter) : void {
         if(this._turnOf == fighter)
         {
            this._turnOf = null;
         }
         fighter.highlight = false;
         fighter.stopCountDown();
      }
      
      private function getFighterByFrame(frame:Object) : Fighter {
         var fighter:Fighter = null;
         for each(fighter in this._fighters)
         {
            if(fighter.frame == frame)
            {
               return fighter;
            }
         }
         return null;
      }
      
      private function getFighterById(id:int) : Fighter {
         var fighter:Fighter = null;
         for each(fighter in this._fighters)
         {
            if(fighter.id == id)
            {
               return fighter;
            }
         }
         return null;
      }
      
      private function resizeTimeline() : void {
         var fighter:Fighter = null;
         var pos:* = 0;
         var frameOffsetHorizontal:int = this.uiApi.me().getConstant("frame_offset_horizontal");
         var currentX:int = 0;
         var timelineSize:int = 0;
         pos = 0;
         while(pos < this._fighters.length)
         {
            fighter = this._fighters[pos];
            if(fighter)
            {
               if(pos != 0)
               {
                  currentX = currentX + (fighter.frame.width + frameOffsetHorizontal);
               }
               timelineSize = timelineSize + (fighter.frame.width + frameOffsetHorizontal);
               fighter.frame.x = -currentX;
            }
            pos++;
         }
         var marginRight:int = this.uiApi.me().getConstant("bg_margin_right");
         var marginLeft:int = this.uiApi.me().getConstant("bg_margin_left");
         this.tx_background.width = timelineSize + marginRight + marginLeft;
         if(this.tx_background.width > this._screenWidth - 20)
         {
            this.tx_background.width = this._screenWidth - 20;
         }
         this.refreshMoveOffset();
         if(this.isTimelineExtended())
         {
            this.btn_leftArrow.x = -this.tx_background.width + int(this.uiApi.me().getConstant("bg_margin_left_to_arrow"));
            this.btn_leftArrow.visible = true;
            this.btn_rightArrow.visible = true;
            this._timelineMask.visible = true;
            this.charFrames.mask = this._timelineMask;
         }
         else
         {
            this.btn_leftArrow.visible = false;
            this.btn_rightArrow.visible = false;
            this._timelineMask.visible = false;
            this.charFrames.mask = null;
         }
         this.uiApi.me().render();
         this.updateTurnOfArrow();
      }
      
      private function isTimelineExtended() : Boolean {
         var fighter:Fighter = null;
         var extended:* = false;
         var timelineSize:int = 0;
         var frameOffsetHorizontal:int = this.uiApi.me().getConstant("frame_offset_horizontal");
         var marginRight:int = this.uiApi.me().getConstant("bg_margin_right");
         var marginLeft:int = this.uiApi.me().getConstant("bg_margin_left");
         for each(fighter in this._fighters)
         {
            timelineSize = timelineSize + (fighter.frame.width + frameOffsetHorizontal);
         }
         extended = timelineSize > this._screenWidth - marginRight - this.btn_minimArrow.width - marginLeft;
         return extended;
      }
      
      private function updateBuff(buffId:uint, targetId:int) : void {
         var fighter:Fighter = this.getFighterById(targetId);
         if(fighter)
         {
            fighter.refreshPdv();
            fighter.refreshShield();
         }
      }
      
      private function updateFightersSprite(id:int) : void {
         var fighter:Fighter = null;
         for each(fighter in this._fighters)
         {
            if(fighter.id == id)
            {
               fighter.updateSprite();
               fighter.refreshPdv();
            }
         }
      }
      
      private function replaceTimeline() : void {
         this.btn_down.visible = this._topDisplayMode;
         this.btn_up.visible = !this._topDisplayMode;
         if(!this._topDisplayMode)
         {
            this.timelineCtr.y = 740;
            this.ctr_buffs.y = 0;
            this.ctr_timeline.y = 50;
         }
         else
         {
            this.timelineCtr.y = 33;
            this.ctr_buffs.y = 85;
            this.ctr_timeline.y = 0;
         }
         this.refreshTimeline();
      }
      
      private function onGameFightTurnListUpdated() : void {
         this.refreshTimeline();
      }
      
      private function onUpdatePreFightersList(id:int = 0) : void {
         this.refreshTimeline();
         this.updateFightersSprite(id);
      }
      
      private function onGameFightTurnStart(id:int, waitTime:int, picture:Boolean) : void {
         var pos:* = 0;
         var fighter:Fighter = this.getFighterById(id);
         if(fighter)
         {
            if(fighter.alive)
            {
               this.setTurnOf(fighter,waitTime);
            }
         }
         else
         {
            pos = this._fightersId.indexOf(id) - 1;
            while(pos > 0)
            {
               fighter = this.getFighterById(this._fightersId[pos]);
               if(fighter)
               {
                  this.setTurnOf(fighter,waitTime);
                  break;
               }
               pos--;
            }
         }
      }
      
      private function onGameFightTurnEnd(id:int) : void {
         var fighter:Fighter = this.getFighterById(id);
         if((fighter) && (fighter.alive))
         {
            this.unsetTurnOf(fighter);
         }
      }
      
      private function onFightEvent(eventName:String, params:Object, targetList:Object = null) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onFoldAll(fold:Boolean) : void {
         if(fold)
         {
            this._foldAllStatus = this.folded;
            this.folded = true;
         }
         else
         {
            this.folded = this._foldAllStatus;
         }
      }
      
      public function onRelease(target:Object) : void {
         var fighter:Fighter = null;
         switch(target)
         {
            case this.btn_minimArrow:
               this.folded = !this.folded;
               break;
            case this.btn_leftArrow:
               this.moveLeft();
               break;
            case this.btn_rightArrow:
               this.moveRight();
               break;
            case this.btn_down:
               this._topDisplayMode = false;
               this.sysApi.setData("topDisplayTimeline",this._topDisplayMode);
               this.replaceTimeline();
               break;
            case this.btn_up:
               this._topDisplayMode = true;
               this.sysApi.setData("topDisplayTimeline",this._topDisplayMode);
               this.replaceTimeline();
               break;
            default:
               fighter = this.getFighterByFrame(target);
               if(!fighter)
               {
                  break;
               }
               if(this.fightApi.isCastingSpell())
               {
                  if(fighter.alive)
                  {
                     Api.sysApi.sendAction(new TimelineEntityClick(fighter.id));
                  }
               }
               else
               {
                  this.sysApi.dispatchHook(FighterSelected,fighter.id);
               }
               break;
         }
      }
      
      public function onFighterSelected(id:int) : void {
         var fighter:Fighter = this.getFighterById(id);
         this.selectFighter(fighter);
      }
      
      public function onBuffAdd(buffId:uint, targetId:int) : void {
         this.updateBuff(buffId,targetId);
      }
      
      public function onBuffRemove(buffId:uint, targetId:int, reason:String) : void {
         this.updateBuff(buffId,targetId);
      }
      
      public function onBuffUpdate(buffId:uint, targetId:int) : void {
         this.updateBuff(buffId,targetId);
      }
      
      public function onBuffDispell(targetId:int) : void {
         var fighter:Fighter = this.getFighterById(targetId);
         if(fighter)
         {
            fighter.refreshPdv();
            fighter.refreshShield();
         }
      }
      
      public function onOrderFightersSwitched(selected:Boolean) : void {
         var fighter:Fighter = null;
         var id:* = 0;
         var hiddenf:Object = null;
         var fightersId:Object = this.fightApi.getFighters();
         var num:uint = 0;
         var fighterExists:Boolean = false;
         var pos:int = 0;
         while(pos < fightersId.length)
         {
            id = fightersId[pos];
            num = num + 1;
            fighterExists = false;
            for each(fighter in this._fighters)
            {
               if(id == fighter.id)
               {
                  if(!fighter.alive)
                  {
                     num--;
                  }
                  fighter.updateNumber(num);
                  fighterExists = true;
               }
            }
            if(!fighterExists)
            {
               hiddenf = this._hiddenFighters[id];
               if((hiddenf) && (!hiddenf.alive) && (!hiddenf.summoned))
               {
                  num--;
               }
            }
            pos++;
         }
      }
      
      public function onHideDeadFighters(selected:Boolean) : void {
         if(this._hideDeadGuys != selected)
         {
            this._hideDeadGuys = selected;
            this.refreshTimeline();
         }
      }
      
      public function onHideSummonedFighters(selected:Boolean) : void {
         if(this._hideSummonedStuff != selected)
         {
            this._hideSummonedStuff = selected;
            this.refreshTimeline();
            this.onOrderFightersSwitched(true);
         }
      }
      
      public function onTurnCountUpdated(turnCount:uint) : void {
         this._turnCount = turnCount;
         this.lbl_turnCount.text = this._turnCount.toString();
         if(this._turnCountBeforeNextWaveAttackers > -1)
         {
            this._turnCountBeforeNextWaveAttackers--;
         }
         if(this._turnCountBeforeNextWaveDefenders > -1)
         {
            this._turnCountBeforeNextWaveDefenders--;
         }
      }
      
      public function onWaveUpdated(teamId:int, wave:int, nbTurnBeforeNext:int) : void {
         if(wave == 1)
         {
            nbTurnBeforeNext--;
         }
         if(teamId == TeamEnum.TEAM_CHALLENGER)
         {
            this._waveCountAttackers = wave;
            this._turnCountBeforeNextWaveAttackers = nbTurnBeforeNext;
         }
         else if(teamId == TeamEnum.TEAM_DEFENDER)
         {
            this._waveCountDefenders = wave;
            this._turnCountBeforeNextWaveDefenders = nbTurnBeforeNext;
         }
         
         this.tx_wave.visible = true;
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var text2:String = null;
         var fighter:Fighter = null;
         this._rollOverMe = true;
         if(target == this.lbl_turnCount)
         {
            text = this.uiApi.getText("ui.fight.turnNumber",this._turnCount);
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,0,null,null,null,"TextInfo");
         }
         else if((target == this.tx_wave) && ((this._waveCountAttackers > 0) || (this._waveCountDefenders > 0)))
         {
            text2 = "";
            if(this._waveCountAttackers > 0)
            {
               text2 = text2 + (this.uiApi.getText("ui.common.attackers") + "\n   " + this.uiApi.getText("ui.common.wave") + " " + this._waveCountAttackers);
               if(this._turnCountBeforeNextWaveAttackers == 0)
               {
                  text2 = text2 + ("\n   " + this.uiApi.getText("ui.fight.newWaveIncoming"));
               }
               else if(this._turnCountBeforeNextWaveAttackers > 0)
               {
                  text2 = text2 + ("\n   " + this.uiApi.processText(this.uiApi.getText("ui.fight.turnsBeforeNextWave",this._turnCountBeforeNextWaveAttackers),"",this._turnCountBeforeNextWaveAttackers == 1));
               }
               
            }
            if(this._waveCountDefenders > 0)
            {
               text2 = text2 + (this.uiApi.getText("ui.common.defenders") + "\n   " + this.uiApi.getText("ui.common.wave") + " " + this._waveCountDefenders);
               if(this._turnCountBeforeNextWaveDefenders == 0)
               {
                  text2 = text2 + ("\n   " + this.uiApi.getText("ui.fight.newWaveIncoming"));
               }
               else if(this._turnCountBeforeNextWaveDefenders > 0)
               {
                  text2 = text2 + ("\n   " + this.uiApi.processText(this.uiApi.getText("ui.fight.turnsBeforeNextWave",this._turnCountBeforeNextWaveDefenders),"",this._turnCountBeforeNextWaveDefenders == 1));
               }
               
            }
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text2),target,false,"standard",7,1,0,null,null,null,"TextInfo");
         }
         else
         {
            fighter = this.getFighterByFrame(target);
            if(fighter)
            {
               this.sysApi.sendAction(new TimelineEntityOver(fighter.id,true));
            }
         }
         
      }
      
      public function onRollOut(target:Object) : void {
         var fighter:Fighter = null;
         this._rollOverMe = false;
         if((target == this.lbl_turnCount) || (target == this.tx_wave))
         {
            this.uiApi.hideTooltip();
         }
         else
         {
            fighter = this.getFighterByFrame(target);
            if(fighter)
            {
               this.sysApi.sendAction(new TimelineEntityOut(fighter.id));
            }
         }
      }
      
      private function onFighterMouseAction(infos:Object = null) : void {
         var fighter:Fighter = null;
         var glow:GlowFilter = null;
         if(infos)
         {
            fighter = this.getFighterById(infos.contextualId);
            if((!(fighter == null)) && (fighter.alive))
            {
               glow = new GlowFilter(16777215,1,6,6,2,BitmapFilterQuality.HIGH);
               fighter.frame.filters = [glow];
               if(!this._rollOverMe)
               {
                  fighter.highlight = true;
               }
            }
         }
         else
         {
            for each(fighter in this._fighters)
            {
               if(!fighter.isCurrentPlayer)
               {
                  fighter.highlight = false;
               }
               fighter.frame.filters = new Array();
            }
         }
      }
   }
}
