package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Timer;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityClickAction;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.BannerEmptySlotClickAction;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.*;
   import com.ankamagames.atouin.renderers.*;
   import com.ankamagames.atouin.types.*;
   import com.ankamagames.jerakine.map.*;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
   import com.ankamagames.berilia.managers.TooltipManager;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCastOnTargetRequestMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCastRequestMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import flash.geom.Point;
   
   public class FightSpellCastFrame extends Object implements Frame
   {
      
      public function FightSpellCastFrame(spellId:uint) {
         var i:SpellWrapper = null;
         var weapon:* = undefined;
         super();
         this._spellId = spellId;
         this._cursorData = new LinkedCursorData();
         this._cursorData.sprite = new FORBIDDEN_CURSOR();
         this._cursorData.sprite.cacheAsBitmap = true;
         this._cursorData.offset = new Point(14,14);
         this._cancelTimer = new Timer(50);
         this._cancelTimer.addEventListener(TimerEvent.TIMER,this.cancelCast);
         if((spellId) || (!PlayedCharacterManager.getInstance().currentWeapon))
         {
            for each(i in PlayedCharacterManager.getInstance().spellsInventory)
            {
               if(i.spellId == this._spellId)
               {
                  this._spellLevel = i;
               }
            }
         }
         else
         {
            weapon = PlayedCharacterManager.getInstance().currentWeapon;
            this._spellLevel = 
               {
                  "effects":weapon.effects,
                  "castTestLos":weapon.castTestLos,
                  "castInLine":weapon.castInLine,
                  "castInDiagonal":weapon.castInDiagonal,
                  "minRange":weapon.minRange,
                  "range":weapon.range,
                  "apCost":weapon.apCost,
                  "needFreeCell":false,
                  "needTakenCell":false,
                  "needFreeTrapCell":false
               };
         }
         this._clearTargetTimer = new Timer(50,1);
         this._clearTargetTimer.addEventListener(TimerEvent.TIMER,this.onClearTarget);
      }
      
      private static const FORBIDDEN_CURSOR:Class;
      
      protected static const _log:Logger;
      
      private static const RANGE_COLOR:Color;
      
      private static const LOS_COLOR:Color;
      
      private static const TARGET_COLOR:Color;
      
      private static const SELECTION_RANGE:String = "SpellCastRange";
      
      private static const SELECTION_LOS:String = "SpellCastLos";
      
      private static const SELECTION_TARGET:String = "SpellCastTarget";
      
      private static const FORBIDDEN_CURSOR_NAME:String = "SpellCastForbiddenCusror";
      
      private static var _currentTargetIsTargetable:Boolean;
      
      public static function isCurrentTargetTargetable() : Boolean {
         return _currentTargetIsTargetable;
      }
      
      public static function updateRangeAndTarget() : void {
         var castFrame:FightSpellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         if(castFrame)
         {
            castFrame.removeRange();
            castFrame.drawRange();
            castFrame.refreshTarget(true);
         }
      }
      
      private var _spellLevel:Object;
      
      private var _spellId:uint;
      
      private var _rangeSelection:Selection;
      
      private var _losSelection:Selection;
      
      private var _targetSelection:Selection;
      
      private var _currentCell:int = -1;
      
      private var _virtualCast:Boolean;
      
      private var _cancelTimer:Timer;
      
      private var _cursorData:LinkedCursorData;
      
      private var _lastTargetStatus:Boolean = true;
      
      private var _isInfiniteTarget:Boolean;
      
      private var _usedWrapper;
      
      private var _clearTargetTimer:Timer;
      
      private var _spellmaximumRange:uint;
      
      public function get priority() : int {
         return Priority.HIGHEST;
      }
      
      public function get currentSpell() : Object {
         return this._spellLevel;
      }
      
      public function pushed() : Boolean {
         var fef:FightEntitiesFrame = null;
         var fighters:Dictionary = null;
         var actorInfos:GameContextActorInformations = null;
         var fighterInfos:GameFightFighterInformations = null;
         var char:AnimatedCharacter = null;
         var fbf:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(fbf.playingSlaveEntity)
         {
            fef = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            fighters = fef.getEntitiesDictionnary();
            for each(actorInfos in fighters)
            {
               fighterInfos = actorInfos as GameFightFighterInformations;
               char = DofusEntities.getEntity(fighterInfos.contextualId) as AnimatedCharacter;
               if((char) && (!(fighterInfos.contextualId == CurrentPlayedFighterManager.getInstance().currentFighterId)) && (fighterInfos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED))
               {
                  char.setCanSeeThrough(true);
               }
            }
         }
         this._cancelTimer.reset();
         this._lastTargetStatus = true;
         if(this._spellId == 0)
         {
            if(PlayedCharacterManager.getInstance().currentWeapon)
            {
               this._usedWrapper = PlayedCharacterManager.getInstance().currentWeapon;
            }
            else
            {
               this._usedWrapper = SpellWrapper.create(-1,0,1,false,PlayedCharacterManager.getInstance().id);
            }
         }
         else
         {
            this._usedWrapper = SpellWrapper.getFirstSpellWrapperById(this._spellId,CurrentPlayedFighterManager.getInstance().currentFighterId);
         }
         KernelEventsManager.getInstance().processCallback(HookList.CastSpellMode,this._usedWrapper);
         this.drawRange();
         this.refreshTarget();
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var conmsg:CellOverMessage = null;
         var emomsg:EntityMouseOverMessage = null;
         var teoa:TimelineEntityOverAction = null;
         var timelineEntity:IEntity = null;
         var ccmsg:CellClickMessage = null;
         var ecmsg:EntityClickMessage = null;
         var teica:TimelineEntityClickAction = null;
         switch(true)
         {
            case msg is CellOverMessage:
               conmsg = msg as CellOverMessage;
               FightContextFrame.currentCell = conmsg.cellId;
               this.refreshTarget();
               return false;
            case msg is EntityMouseOutMessage:
               this.clearTarget();
               return false;
            case msg is CellOutMessage:
               this.clearTarget();
               return false;
            case msg is EntityMouseOverMessage:
               emomsg = msg as EntityMouseOverMessage;
               FightContextFrame.currentCell = emomsg.entity.position.cellId;
               this.refreshTarget();
               return false;
            case msg is TimelineEntityOverAction:
               teoa = msg as TimelineEntityOverAction;
               timelineEntity = DofusEntities.getEntity(teoa.targetId);
               if((timelineEntity) && (timelineEntity.position) && (timelineEntity.position.cellId > -1))
               {
                  FightContextFrame.currentCell = timelineEntity.position.cellId;
                  this.refreshTarget();
               }
               return false;
            case msg is CellClickMessage:
               ccmsg = msg as CellClickMessage;
               this.castSpell(ccmsg.cellId);
               return true;
            case msg is EntityClickMessage:
               ecmsg = msg as EntityClickMessage;
               this.castSpell(ecmsg.entity.position.cellId,ecmsg.entity.id);
               return true;
            case msg is TimelineEntityClickAction:
               teica = msg as TimelineEntityClickAction;
               this.castSpell(0,teica.fighterId);
               return true;
            case msg is AdjacentMapClickMessage:
            case msg is MouseRightClickMessage:
               this.cancelCast();
               return true;
            case msg is BannerEmptySlotClickAction:
               this.cancelCast();
               return true;
            case msg is MouseUpMessage:
               this._cancelTimer.start();
               return false;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         var fef:FightEntitiesFrame = null;
         var fighters:Dictionary = null;
         var actorInfos:GameContextActorInformations = null;
         var char:AnimatedCharacter = null;
         var fbf:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if((fbf) && (fbf.playingSlaveEntity))
         {
            fef = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            fighters = fef.getEntitiesDictionnary();
            for each(actorInfos in fighters)
            {
               char = DofusEntities.getEntity(actorInfos.contextualId) as AnimatedCharacter;
               if((char) && (!(actorInfos.contextualId == CurrentPlayedFighterManager.getInstance().currentFighterId)))
               {
                  char.setCanSeeThrough(false);
               }
            }
         }
         this._cancelTimer.reset();
         this.hideTargetsTooltips();
         this.removeRange();
         this.removeTarget();
         LinkedCursorSpriteManager.getInstance().removeItem(FORBIDDEN_CURSOR_NAME);
         try
         {
            KernelEventsManager.getInstance().processCallback(HookList.CancelCastSpell,SpellWrapper.getFirstSpellWrapperById(this._spellId,CurrentPlayedFighterManager.getInstance().currentFighterId));
         }
         catch(e:Error)
         {
         }
         return true;
      }
      
      public function refreshTarget(force:Boolean = false) : void {
         var currentFighterId:* = 0;
         var entityInfos:GameFightFighterInformations = null;
         var renderer:ZoneDARenderer = null;
         var spellZone:IZone = null;
         var updateStrata:* = false;
         if(this._clearTargetTimer.running)
         {
            this._clearTargetTimer.reset();
         }
         var target:int = FightContextFrame.currentCell;
         if((!force) && (this._currentCell == target))
         {
            if((this._targetSelection) && (this.isValidCell(target)))
            {
               this.showTargetsTooltips(this._targetSelection);
            }
            return;
         }
         this._currentCell = target;
         var fightTurnFrame:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         if(!fightTurnFrame)
         {
            return;
         }
         var myTurn:Boolean = fightTurnFrame.myTurn;
         _currentTargetIsTargetable = this.isValidCell(target);
         if((!(target == -1)) && (_currentTargetIsTargetable))
         {
            if(!this._targetSelection)
            {
               this._targetSelection = new Selection();
               this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA,1,true);
               this._targetSelection.color = TARGET_COLOR;
               spellZone = SpellZoneManager.getInstance().getSpellZone(this._spellLevel,true);
               this._spellmaximumRange = spellZone.radius;
               this._targetSelection.zone = spellZone;
               SelectionManager.getInstance().addSelection(this._targetSelection,SELECTION_TARGET);
            }
            currentFighterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
            entityInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(currentFighterId) as GameFightFighterInformations;
            if(entityInfos)
            {
               this._targetSelection.zone.direction = MapPoint(MapPoint.fromCellId(entityInfos.disposition.cellId)).advancedOrientationTo(MapPoint.fromCellId(target),false);
            }
            renderer = this._targetSelection.renderer as ZoneDARenderer;
            if((Atouin.getInstance().options.transparentOverlayMode) && (!(this._spellmaximumRange == 63)))
            {
               renderer.currentStrata = PlacementStrataEnums.STRATA_NO_Z_ORDER;
               SelectionManager.getInstance().update(SELECTION_TARGET,target,true);
            }
            else
            {
               if(renderer.currentStrata == PlacementStrataEnums.STRATA_NO_Z_ORDER)
               {
                  renderer.currentStrata = PlacementStrataEnums.STRATA_AREA;
                  updateStrata = true;
               }
               SelectionManager.getInstance().update(SELECTION_TARGET,target,updateStrata);
            }
            if(myTurn)
            {
               LinkedCursorSpriteManager.getInstance().removeItem(FORBIDDEN_CURSOR_NAME);
               this._lastTargetStatus = true;
            }
            else
            {
               if(this._lastTargetStatus)
               {
                  LinkedCursorSpriteManager.getInstance().addItem(FORBIDDEN_CURSOR_NAME,this._cursorData,true);
               }
               this._lastTargetStatus = false;
            }
            this.showTargetsTooltips(this._targetSelection);
         }
         else
         {
            if(this._lastTargetStatus)
            {
               LinkedCursorSpriteManager.getInstance().addItem(FORBIDDEN_CURSOR_NAME,this._cursorData,true);
            }
            this.removeTarget();
            this._lastTargetStatus = false;
            this.hideTargetsTooltips();
         }
      }
      
      public function drawRange() : void {
         var shapePlus:Cross = null;
         var rangeCell:Vector.<uint> = null;
         var noLosRangeCell:Vector.<uint> = null;
         var num:* = 0;
         var i:* = 0;
         var cellId:uint = 0;
         var currentFighterId:int = CurrentPlayedFighterManager.getInstance().currentFighterId;
         var entityInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(currentFighterId) as GameFightFighterInformations;
         var origin:uint = entityInfos.disposition.cellId;
         var playerRange:CharacterBaseCharacteristic = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().range;
         var range:int = this._spellLevel.range;
         if((!this._spellLevel.castInLine) && (!this._spellLevel.castInDiagonal) && (!this._spellLevel.castTestLos) && (range == 63))
         {
            this._isInfiniteTarget = true;
            return;
         }
         this._isInfiniteTarget = false;
         if(this._spellLevel["rangeCanBeBoosted"])
         {
            range = range + (playerRange.base + playerRange.objectsAndMountBonus + playerRange.alignGiftBonus + playerRange.contextModif);
            if(range < this._spellLevel.minRange)
            {
               range = this._spellLevel.minRange;
            }
         }
         range = Math.min(range,AtouinConstants.MAP_WIDTH * AtouinConstants.MAP_HEIGHT);
         if(range < 0)
         {
            range = 0;
         }
         var testLos:Boolean = (this._spellLevel.castTestLos) && (Dofus.getInstance().options.showLineOfSight);
         this._rangeSelection = new Selection();
         this._rangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         this._rangeSelection.color = testLos?RANGE_COLOR:LOS_COLOR;
         this._rangeSelection.alpha = true;
         if((this._spellLevel.castInLine) && (this._spellLevel.castInDiagonal))
         {
            shapePlus = new Cross(this._spellLevel.minRange,range,DataMapProvider.getInstance());
            shapePlus.allDirections = true;
            this._rangeSelection.zone = shapePlus;
         }
         else if(this._spellLevel.castInLine)
         {
            this._rangeSelection.zone = new Cross(this._spellLevel.minRange,range,DataMapProvider.getInstance());
         }
         else if(this._spellLevel.castInDiagonal)
         {
            shapePlus = new Cross(this._spellLevel.minRange,range,DataMapProvider.getInstance());
            shapePlus.diagonal = true;
            this._rangeSelection.zone = shapePlus;
         }
         else
         {
            this._rangeSelection.zone = new Lozenge(this._spellLevel.minRange,range,DataMapProvider.getInstance());
         }
         
         
         this._losSelection = null;
         if(testLos)
         {
            this.drawLos(origin);
         }
         if(this._losSelection)
         {
            this._rangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA,0.5);
            rangeCell = new Vector.<uint>();
            noLosRangeCell = this._rangeSelection.zone.getCells(origin);
            num = noLosRangeCell.length;
            while(i < num)
            {
               cellId = noLosRangeCell[i];
               if(this._losSelection.cells.indexOf(cellId) == -1)
               {
                  rangeCell.push(cellId);
               }
               i++;
            }
            this._rangeSelection.zone = new Custom(rangeCell);
         }
         SelectionManager.getInstance().addSelection(this._rangeSelection,SELECTION_RANGE,origin);
      }
      
      private function showTargetsTooltips(pSelection:Selection) : void {
         var entityId:* = 0;
         var entityInfos:GameFightFighterInformations = null;
         var fcf:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var entitiesIds:Vector.<int> = fcf.entitiesFrame.getEntitiesIdsList();
         var zoneCells:Vector.<uint> = pSelection.zone.getCells(this._currentCell);
         var targetEntities:Vector.<int> = new Vector.<int>(0);
         for each(entityId in entitiesIds)
         {
            entityInfos = fcf.entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations;
            if((!(zoneCells.indexOf(entityInfos.disposition.cellId) == -1)) && (DofusEntities.getEntity(entityId)))
            {
               targetEntities.push(entityId);
               TooltipPlacer.waitBeforeOrder("tooltip_tooltipOverEntity_" + entityId);
            }
            else if((!fcf.showPermanentTooltips) || (fcf.showPermanentTooltips) && (fcf.battleFrame.targetedEntities.indexOf(entityId) == -1))
            {
               TooltipManager.hide("tooltipOverEntity_" + entityId);
            }
            
         }
         fcf.removeSpellTargetsTooltips();
         for each(entityId in targetEntities)
         {
            entityInfos = fcf.entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations;
            if(entityInfos.alive)
            {
               fcf.displayEntityTooltip(entityId,this._spellLevel);
            }
         }
      }
      
      private function hideTargetsTooltips() : void {
         var entityId:* = 0;
         var fcf:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var entitiesId:Vector.<int> = fcf.entitiesFrame.getEntitiesIdsList();
         var overEntity:IEntity = EntitiesManager.getInstance().getEntityOnCell(FightContextFrame.currentCell,AnimatedCharacter);
         for each(entityId in entitiesId)
         {
            if((!fcf.showPermanentTooltips) || (fcf.showPermanentTooltips) && (fcf.battleFrame.targetedEntities.indexOf(entityId) == -1))
            {
               TooltipManager.hide("tooltipOverEntity_" + entityId);
            }
         }
         if((fcf.showPermanentTooltips) && (fcf.battleFrame.targetedEntities.length > 0))
         {
            for each(entityId in fcf.battleFrame.targetedEntities)
            {
               if((!overEntity) || (!(entityId == overEntity.id)))
               {
                  fcf.displayEntityTooltip(entityId);
               }
            }
         }
         if(overEntity)
         {
            fcf.displayEntityTooltip(overEntity.id);
         }
      }
      
      private function clearTarget() : void {
         if(!this._clearTargetTimer.running)
         {
            this._clearTargetTimer.start();
         }
      }
      
      private function onClearTarget(event:TimerEvent) : void {
         this.refreshTarget();
      }
      
      private function castSpell(cell:uint, targetId:int = 0) : void {
         var gafcotrmsg:GameActionFightCastOnTargetRequestMessage = null;
         var gafcrmsg:GameActionFightCastRequestMessage = null;
         var fightTurnFrame:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         if((!fightTurnFrame) || (!fightTurnFrame.myTurn))
         {
            return;
         }
         if(CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent < this._spellLevel.apCost)
         {
            return;
         }
         if((!(targetId == 0)) && (!FightEntitiesFrame.getCurrentInstance().entityIsIllusion(targetId)))
         {
            CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent - this._spellLevel.apCost;
            gafcotrmsg = new GameActionFightCastOnTargetRequestMessage();
            gafcotrmsg.initGameActionFightCastOnTargetRequestMessage(this._spellId,targetId);
            ConnectionsHandler.getConnection().send(gafcotrmsg);
         }
         else if(this.isValidCell(cell))
         {
            CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent - this._spellLevel.apCost;
            gafcrmsg = new GameActionFightCastRequestMessage();
            gafcrmsg.initGameActionFightCastRequestMessage(this._spellId,cell);
            ConnectionsHandler.getConnection().send(gafcrmsg);
         }
         
         this.cancelCast();
      }
      
      private function cancelCast(... args) : void {
         this._cancelTimer.reset();
         Kernel.getWorker().removeFrame(this);
      }
      
      private function drawLos(origin:uint) : void {
         this._losSelection = new Selection();
         this._losSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         this._losSelection.color = LOS_COLOR;
         var cells:Vector.<uint> = this._rangeSelection.zone.getCells(origin);
         this._losSelection.zone = new Custom(LosDetector.getCell(DataMapProvider.getInstance(),cells,MapPoint.fromCellId(origin)));
         SelectionManager.getInstance().addSelection(this._losSelection,SELECTION_LOS,origin);
      }
      
      private function removeRange() : void {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_RANGE);
         if(s)
         {
            s.remove();
            this._rangeSelection = null;
         }
         var los:Selection = SelectionManager.getInstance().getSelection(SELECTION_LOS);
         if(los)
         {
            los.remove();
            this._losSelection = null;
         }
         this._isInfiniteTarget = false;
      }
      
      private function removeTarget() : void {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
         if(s)
         {
            s.remove();
            this._rangeSelection = null;
         }
      }
      
      private function isValidCell(cell:uint) : Boolean {
         var spellLevel:SpellLevel = null;
         var entity:IEntity = null;
         var isGlyph:* = false;
         if(this._isInfiniteTarget)
         {
            return true;
         }
         if(this._spellId)
         {
            spellLevel = this._spellLevel.spellLevelInfos;
            for each(entity in EntitiesManager.getInstance().getEntitiesOnCell(cell))
            {
               if(!CurrentPlayedFighterManager.getInstance().canCastThisSpell(this._spellLevel.spellId,this._spellLevel.spellLevel,entity.id))
               {
                  return false;
               }
               isGlyph = entity is Glyph;
               if((spellLevel.needFreeTrapCell) && (isGlyph) && ((entity as Glyph).glyphType == GameActionMarkTypeEnum.TRAP))
               {
                  return false;
               }
               if((this._spellLevel.needFreeCell) && (!isGlyph))
               {
                  return false;
               }
            }
         }
         if((this._spellLevel.castTestLos) && (Dofus.getInstance().options.showLineOfSight))
         {
            return SelectionManager.getInstance().isInside(cell,SELECTION_LOS);
         }
         return SelectionManager.getInstance().isInside(cell,SELECTION_RANGE);
      }
   }
}
