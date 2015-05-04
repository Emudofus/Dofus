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
   import com.ankamagames.dofus.logic.game.fight.types.FightTeleportationPreview;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityClickAction;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.BannerEmptySlotClickAction;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.atouin.managers.*;
   import com.ankamagames.atouin.renderers.*;
   import com.ankamagames.atouin.types.*;
   import com.ankamagames.jerakine.map.*;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.types.entities.RiderBehavior;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import flash.geom.Point;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import com.ankamagames.dofus.logic.game.fight.managers.LinkedCellsManager;
   import com.ankamagames.jerakine.utils.display.Dofus2Line;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCastOnTargetRequestMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCastRequestMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   
   public class FightSpellCastFrame extends Object implements Frame
   {
      
      public function FightSpellCastFrame(param1:uint)
      {
         var _loc2_:SpellWrapper = null;
         var _loc3_:EffectInstance = null;
         var _loc4_:TiphonEntityLook = null;
         var _loc5_:* = 0;
         var _loc6_:* = undefined;
         var _loc7_:Monster = null;
         var _loc8_:* = 0;
         var _loc9_:IEntity = null;
         var _loc10_:* = undefined;
         this._invocationPreview = new Array();
         super();
         this._spellId = param1;
         this._cursorData = new LinkedCursorData();
         this._cursorData.sprite = new FORBIDDEN_CURSOR();
         this._cursorData.sprite.cacheAsBitmap = true;
         this._cursorData.offset = new Point(14,14);
         this._cancelTimer = new Timer(50);
         this._cancelTimer.addEventListener(TimerEvent.TIMER,this.cancelCast);
         if((param1) || !PlayedCharacterManager.getInstance().currentWeapon)
         {
            for each(_loc2_ in PlayedCharacterManager.getInstance().spellsInventory)
            {
               if(_loc2_.spellId == this._spellId)
               {
                  this._spellLevel = _loc2_;
                  if(this._spellId == 74)
                  {
                     _loc4_ = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
                     _loc5_ = 1;
                  }
                  else if(this._spellId == 2763)
                  {
                     _loc4_ = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
                     _loc5_ = 4;
                  }
                  else
                  {
                     for each(_loc3_ in this.currentSpell.effects)
                     {
                        if(_loc3_.effectId == 181 || _loc3_.effectId == 1008 || _loc3_.effectId == 1011)
                        {
                           _loc6_ = _loc3_.parameter0;
                           _loc7_ = Monster.getMonsterById(_loc6_);
                           _loc4_ = new TiphonEntityLook(_loc7_.look);
                           _loc5_ = 1;
                           break;
                        }
                     }
                  }
                  
                  if(_loc4_)
                  {
                     _loc8_ = 0;
                     while(_loc8_ < _loc5_)
                     {
                        _loc9_ = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),_loc4_);
                        (_loc9_ as AnimatedCharacter).setCanSeeThrough(true);
                        (_loc9_ as AnimatedCharacter).transparencyAllowed = true;
                        (_loc9_ as AnimatedCharacter).alpha = 0.65;
                        (_loc9_ as AnimatedCharacter).mouseEnabled = false;
                        this._invocationPreview.push(_loc9_);
                        _loc8_++;
                     }
                  }
                  else
                  {
                     this.removeInvocationPreview();
                  }
                  break;
               }
            }
         }
         else
         {
            _loc10_ = PlayedCharacterManager.getInstance().currentWeapon;
            this._spellLevel = {
               "effects":_loc10_.effects,
               "castTestLos":_loc10_.castTestLos,
               "castInLine":_loc10_.castInLine,
               "castInDiagonal":_loc10_.castInDiagonal,
               "minRange":_loc10_.minRange,
               "range":_loc10_.range,
               "apCost":_loc10_.apCost,
               "needFreeCell":false,
               "needTakenCell":false,
               "needFreeTrapCell":false
            };
         }
         this._clearTargetTimer = new Timer(50,1);
         this._clearTargetTimer.addEventListener(TimerEvent.TIMER,this.onClearTarget);
      }
      
      private static const FORBIDDEN_CURSOR:Class = FightSpellCastFrame_FORBIDDEN_CURSOR;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightSpellCastFrame));
      
      private static const RANGE_COLOR:Color = new Color(5533093);
      
      private static const LOS_COLOR:Color = new Color(2241433);
      
      private static const PORTAL_COLOR:Color = new Color(251623);
      
      private static const TARGET_COLOR:Color = new Color(14487842);
      
      private static const SELECTION_RANGE:String = "SpellCastRange";
      
      private static const SELECTION_PORTALS:String = "SpellCastPortals";
      
      private static const SELECTION_LOS:String = "SpellCastLos";
      
      private static const SELECTION_TARGET:String = "SpellCastTarget";
      
      private static const FORBIDDEN_CURSOR_NAME:String = "SpellCastForbiddenCusror";
      
      private static const TELEPORTATION_EFFECTS:Array = [1100,1104,1105,1106];
      
      private static var _currentTargetIsTargetable:Boolean;
      
      public static function isCurrentTargetTargetable() : Boolean
      {
         return _currentTargetIsTargetable;
      }
      
      public static function updateRangeAndTarget() : void
      {
         var _loc1_:FightSpellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         if(_loc1_)
         {
            _loc1_.removeRange();
            _loc1_.drawRange();
            _loc1_.refreshTarget(true);
         }
      }
      
      private var _spellLevel:Object;
      
      private var _spellId:uint;
      
      private var _rangeSelection:Selection;
      
      private var _losSelection:Selection;
      
      private var _portalsSelection:Selection;
      
      private var _targetSelection:Selection;
      
      private var _currentCell:int = -1;
      
      private var _virtualCast:Boolean;
      
      private var _cancelTimer:Timer;
      
      private var _cursorData:LinkedCursorData;
      
      private var _lastTargetStatus:Boolean = true;
      
      private var _isInfiniteTarget:Boolean;
      
      private var _usedWrapper;
      
      private var _targetingThroughPortal:Boolean;
      
      private var _clearTargetTimer:Timer;
      
      private var _spellmaximumRange:uint;
      
      private var _invocationPreview:Array;
      
      private var _fightTeleportationPreview:FightTeleportationPreview;
      
      private var _replacementInvocationPreview:AnimatedCharacter;
      
      private var _currentCellEntity:AnimatedCharacter;
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function get currentSpell() : Object
      {
         return this._spellLevel;
      }
      
      public function pushed() : Boolean
      {
         var _loc2_:FightEntitiesFrame = null;
         var _loc3_:Dictionary = null;
         var _loc4_:GameContextActorInformations = null;
         var _loc5_:GameFightFighterInformations = null;
         var _loc6_:AnimatedCharacter = null;
         var _loc1_:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(_loc1_.playingSlaveEntity)
         {
            _loc2_ = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            _loc3_ = _loc2_.getEntitiesDictionnary();
            for each(_loc4_ in _loc3_)
            {
               _loc5_ = _loc4_ as GameFightFighterInformations;
               _loc6_ = DofusEntities.getEntity(_loc5_.contextualId) as AnimatedCharacter;
               if((_loc6_) && (!(_loc5_.contextualId == CurrentPlayedFighterManager.getInstance().currentFighterId)) && _loc5_.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED)
               {
                  _loc6_.setCanSeeThrough(true);
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
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:CellOverMessage = null;
         var _loc3_:CellOutMessage = null;
         var _loc4_:IEntity = null;
         var _loc5_:EntityMouseOverMessage = null;
         var _loc6_:TimelineEntityOverAction = null;
         var _loc7_:IEntity = null;
         var _loc8_:TimelineEntityOutAction = null;
         var _loc9_:IEntity = null;
         var _loc10_:CellClickMessage = null;
         var _loc11_:EntityClickMessage = null;
         var _loc12_:TimelineEntityClickAction = null;
         var _loc13_:IEntity = null;
         switch(true)
         {
            case param1 is CellOverMessage:
               _loc2_ = param1 as CellOverMessage;
               FightContextFrame.currentCell = _loc2_.cellId;
               this.refreshTarget();
               return false;
            case param1 is EntityMouseOutMessage:
               this.clearTarget();
               return false;
            case param1 is CellOutMessage:
               _loc3_ = param1 as CellOutMessage;
               _loc4_ = EntitiesManager.getInstance().getEntityOnCell(_loc3_.cellId,AnimatedCharacter);
               if((_loc4_) && (this._fightTeleportationPreview) && (FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc4_.id)))
               {
                  this.removeTeleportationPreview();
               }
               if(!this._fightTeleportationPreview)
               {
                  this.removeReplacementInvocationPreview();
               }
               this.clearTarget();
               return false;
            case param1 is EntityMouseOverMessage:
               _loc5_ = param1 as EntityMouseOverMessage;
               FightContextFrame.currentCell = _loc5_.entity.position.cellId;
               this.refreshTarget();
               return false;
            case param1 is TimelineEntityOverAction:
               _loc6_ = param1 as TimelineEntityOverAction;
               _loc7_ = DofusEntities.getEntity(_loc6_.targetId);
               if((_loc7_) && (_loc7_.position) && _loc7_.position.cellId > -1)
               {
                  FightContextFrame.currentCell = _loc7_.position.cellId;
                  this.refreshTarget();
               }
               return false;
            case param1 is TimelineEntityOutAction:
               _loc8_ = param1 as TimelineEntityOutAction;
               _loc9_ = DofusEntities.getEntity(_loc8_.targetId);
               if((_loc9_) && (_loc9_.position) && _loc9_.position.cellId == this._currentCell)
               {
                  this.removeTeleportationPreview();
                  this.removeReplacementInvocationPreview();
               }
               return false;
            case param1 is CellClickMessage:
               _loc10_ = param1 as CellClickMessage;
               this.castSpell(_loc10_.cellId);
               return true;
            case param1 is EntityClickMessage:
               _loc11_ = param1 as EntityClickMessage;
               if(this._invocationPreview.length > 0)
               {
                  for each(_loc13_ in this._invocationPreview)
                  {
                     if(_loc13_.id == _loc11_.entity.id)
                     {
                        this.castSpell(_loc11_.entity.position.cellId);
                        return true;
                     }
                  }
               }
               this.castSpell(_loc11_.entity.position.cellId,_loc11_.entity.id);
               return true;
            case param1 is TimelineEntityClickAction:
               _loc12_ = param1 as TimelineEntityClickAction;
               this.castSpell(0,_loc12_.fighterId);
               return true;
            case param1 is AdjacentMapClickMessage:
            case param1 is MouseRightClickMessage:
               this.cancelCast();
               return true;
            case param1 is BannerEmptySlotClickAction:
               this.cancelCast();
               return true;
            case param1 is MouseUpMessage:
               this._cancelTimer.start();
               return false;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         var _loc2_:FightEntitiesFrame = null;
         var _loc3_:Dictionary = null;
         var _loc4_:GameContextActorInformations = null;
         var _loc5_:AnimatedCharacter = null;
         var _loc1_:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if((_loc1_) && (_loc1_.playingSlaveEntity))
         {
            _loc2_ = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            _loc3_ = _loc2_.getEntitiesDictionnary();
            for each(_loc4_ in _loc3_)
            {
               _loc5_ = DofusEntities.getEntity(_loc4_.contextualId) as AnimatedCharacter;
               if((_loc5_) && !(_loc4_.contextualId == CurrentPlayedFighterManager.getInstance().currentFighterId))
               {
                  _loc5_.setCanSeeThrough(false);
               }
            }
         }
         this._cancelTimer.reset();
         this.hideTargetsTooltips();
         this.removeRange();
         this.removeTarget();
         this.removeInvocationPreview();
         LinkedCursorSpriteManager.getInstance().removeItem(FORBIDDEN_CURSOR_NAME);
         this.removeTeleportationPreview();
         this.removeReplacementInvocationPreview();
         try
         {
            KernelEventsManager.getInstance().processCallback(HookList.CancelCastSpell,SpellWrapper.getFirstSpellWrapperById(this._spellId,CurrentPlayedFighterManager.getInstance().currentFighterId));
         }
         catch(e:Error)
         {
         }
         return true;
      }
      
      public function entityMovement(param1:int) : void
      {
         if((this._currentCellEntity) && this._currentCellEntity.id == param1)
         {
            this.removeReplacementInvocationPreview();
            if(this._fightTeleportationPreview)
            {
               this.removeTeleportationPreview();
            }
         }
         else if((this._fightTeleportationPreview) && (!(this._fightTeleportationPreview.getEntitiesIds().indexOf(param1) == -1) || !(this._fightTeleportationPreview.getTelefraggedEntitiesIds().indexOf(param1) == -1)))
         {
            this.removeTeleportationPreview();
         }
         
      }
      
      public function refreshTarget(param1:Boolean = false) : void
      {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:GameFightFighterInformations = null;
         var _loc9_:ZoneDARenderer = null;
         var _loc10_:IZone = null;
         var _loc11_:* = false;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:Array = null;
         var _loc16_:* = 0;
         var _loc17_:TiphonSprite = null;
         var _loc18_:IEntity = null;
         var _loc19_:IEntity = null;
         if(this._clearTargetTimer.running)
         {
            this._clearTargetTimer.reset();
         }
         var _loc2_:int = FightContextFrame.currentCell;
         if(_loc2_ == -1)
         {
            return;
         }
         this._targetingThroughPortal = false;
         if((SelectionManager.getInstance().isInside(_loc2_,SELECTION_PORTALS)) && (SelectionManager.getInstance().isInside(_loc2_,SELECTION_LOS)) && !(this._spellId == 0))
         {
            _loc6_ = -1;
            _loc6_ = this.getTargetThroughPortal(_loc2_,true);
            if(_loc6_ != _loc2_)
            {
               this._targetingThroughPortal = true;
               _loc2_ = _loc6_;
            }
         }
         this.removeReplacementInvocationPreview();
         if(!param1 && this._currentCell == _loc2_)
         {
            if((this._targetSelection) && (this.isValidCell(_loc2_)))
            {
               this.showTargetsTooltips(this._targetSelection);
               this.showReplacementInvocationPreview();
               this.showTeleportationPreview();
            }
            return;
         }
         this._currentCell = _loc2_;
         var _loc3_:Array = EntitiesManager.getInstance().getEntitiesOnCell(this._currentCell,AnimatedCharacter);
         this._currentCellEntity = _loc3_.length > 0?this.getParentEntity(_loc3_[0]) as AnimatedCharacter:null;
         var _loc4_:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:Boolean = _loc4_.myTurn;
         _currentTargetIsTargetable = this.isValidCell(_loc2_);
         if(_currentTargetIsTargetable)
         {
            if(!this._targetSelection)
            {
               this._targetSelection = new Selection();
               this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA,1,true);
               (this._targetSelection.renderer as ZoneDARenderer).showFarmCell = false;
               this._targetSelection.color = TARGET_COLOR;
               _loc10_ = SpellZoneManager.getInstance().getSpellZone(this._spellLevel,true);
               this._spellmaximumRange = _loc10_.radius;
               this._targetSelection.zone = _loc10_;
               SelectionManager.getInstance().addSelection(this._targetSelection,SELECTION_TARGET);
            }
            _loc7_ = CurrentPlayedFighterManager.getInstance().currentFighterId;
            _loc8_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc7_) as GameFightFighterInformations;
            if(_loc8_)
            {
               if(this._targetingThroughPortal)
               {
                  this._targetSelection.zone.direction = MapPoint(MapPoint.fromCellId(_loc8_.disposition.cellId)).advancedOrientationTo(MapPoint.fromCellId(FightContextFrame.currentCell),false);
               }
               else
               {
                  this._targetSelection.zone.direction = MapPoint(MapPoint.fromCellId(_loc8_.disposition.cellId)).advancedOrientationTo(MapPoint.fromCellId(_loc2_),false);
               }
            }
            _loc9_ = this._targetSelection.renderer as ZoneDARenderer;
            if((Atouin.getInstance().options.transparentOverlayMode) && !(this._spellmaximumRange == 63))
            {
               _loc9_.currentStrata = PlacementStrataEnums.STRATA_NO_Z_ORDER;
               SelectionManager.getInstance().update(SELECTION_TARGET,_loc2_,true);
            }
            else
            {
               if(_loc9_.currentStrata == PlacementStrataEnums.STRATA_NO_Z_ORDER)
               {
                  _loc9_.currentStrata = PlacementStrataEnums.STRATA_AREA;
                  _loc11_ = true;
               }
               SelectionManager.getInstance().update(SELECTION_TARGET,_loc2_,_loc11_);
            }
            if(_loc5_)
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
            if(this._invocationPreview.length > 0)
            {
               if(this._spellId == 2763)
               {
                  _loc12_ = MapPoint.fromCellId(_loc8_.disposition.cellId).x;
                  _loc13_ = MapPoint.fromCellId(_loc8_.disposition.cellId).y;
                  _loc14_ = MapPoint.fromCellId(_loc8_.disposition.cellId).distanceTo(MapPoint.fromCellId(this._currentCell));
                  _loc15_ = [MapPoint.fromCoords(_loc12_ + _loc14_,_loc13_),MapPoint.fromCoords(_loc12_ - _loc14_,_loc13_),MapPoint.fromCoords(_loc12_,_loc13_ + _loc14_),MapPoint.fromCoords(_loc12_,_loc13_ - _loc14_)];
                  _loc16_ = 0;
                  while(_loc16_ < 4)
                  {
                     _loc19_ = this._invocationPreview[_loc16_];
                     _loc17_ = _loc19_ as TiphonSprite;
                     if((_loc17_) && (_loc17_.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0)) && !_loc17_.getSubEntityBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER))
                     {
                        _loc17_.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
                     }
                     (_loc19_ as AnimatedCharacter).visible = true;
                     _loc19_.position = _loc15_[_loc16_];
                     (_loc19_ as AnimatedCharacter).setDirection(MapPoint.fromCellId(_loc8_.disposition.cellId).advancedOrientationTo(_loc19_.position,true));
                     if((this.isValidCell(_loc19_.position.cellId)) && !(_loc19_.position.cellId == this._currentCell))
                     {
                        (_loc19_ as AnimatedCharacter).display(PlacementStrataEnums.STRATA_PLAYER);
                        (_loc19_ as AnimatedCharacter).visible = true;
                     }
                     else
                     {
                        (_loc19_ as AnimatedCharacter).visible = false;
                     }
                     _loc16_++;
                  }
               }
               else
               {
                  _loc18_ = this._invocationPreview[0];
                  (_loc18_ as AnimatedCharacter).visible = true;
                  _loc18_.position = MapPoint.fromCellId(this._currentCell);
                  (_loc18_ as AnimatedCharacter).setDirection(MapPoint.fromCellId(_loc8_.disposition.cellId).advancedOrientationTo(MapPoint.fromCellId(this._currentCell),true));
                  _loc17_ = _loc18_ as TiphonSprite;
                  if((_loc17_) && (_loc17_.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0)) && !_loc17_.getSubEntityBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER))
                  {
                     _loc17_.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
                  }
                  (_loc18_ as AnimatedCharacter).display(PlacementStrataEnums.STRATA_PLAYER);
               }
            }
            this.showTargetsTooltips(this._targetSelection);
            this.showReplacementInvocationPreview();
            this.showTeleportationPreview();
         }
         else
         {
            if(this._invocationPreview.length > 0)
            {
               for each(_loc19_ in this._invocationPreview)
               {
                  (_loc19_ as AnimatedCharacter).visible = false;
               }
            }
            if(this._lastTargetStatus)
            {
               LinkedCursorSpriteManager.getInstance().addItem(FORBIDDEN_CURSOR_NAME,this._cursorData,true);
            }
            this.removeTarget();
            this._lastTargetStatus = false;
            this.hideTargetsTooltips();
            this.removeTeleportationPreview();
            this.removeReplacementInvocationPreview();
         }
      }
      
      private function removeInvocationPreview() : void
      {
         var _loc1_:IEntity = null;
         for each(_loc1_ in this._invocationPreview)
         {
            (_loc1_ as AnimatedCharacter).remove();
            (_loc1_ as AnimatedCharacter).destroy();
            _loc1_ = null;
         }
      }
      
      private function showReplacementInvocationPreview() : void
      {
         var _loc3_:EffectInstance = null;
         var _loc4_:AnimatedCharacter = null;
         var _loc5_:Monster = null;
         var _loc6_:AnimatedCharacter = null;
         var _loc1_:SpellWrapper = this._usedWrapper as SpellWrapper;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Vector.<EffectInstance> = _loc1_.effects.concat(_loc1_.criticalEffect);
         var _loc7_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(CurrentPlayedFighterManager.getInstance().currentFighterId) as GameFightFighterInformations;
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.effectId == 405 || _loc3_.effectId == 2796)
            {
               if((this._currentCellEntity) && (DamageUtil.verifySpellEffectMask(PlayedCharacterManager.getInstance().id,this._currentCellEntity.id,_loc3_,this._currentCell)))
               {
                  this._currentCellEntity.visible = false;
                  TooltipManager.hide("tooltipOverEntity_" + this._currentCellEntity.id);
                  _loc5_ = Monster.getMonsterById(_loc3_.parameter0 as uint);
                  this._replacementInvocationPreview = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),new TiphonEntityLook(_loc5_.look));
                  this._replacementInvocationPreview.setCanSeeThrough(true);
                  this._replacementInvocationPreview.transparencyAllowed = true;
                  this._replacementInvocationPreview.alpha = 0.65;
                  this._replacementInvocationPreview.mouseEnabled = false;
                  this._replacementInvocationPreview.visible = true;
                  this._replacementInvocationPreview.position = MapPoint.fromCellId(this._currentCell);
                  this._replacementInvocationPreview.setDirection(MapPoint.fromCellId(_loc7_.disposition.cellId).advancedOrientationTo(MapPoint.fromCellId(this._currentCell),true));
                  this._replacementInvocationPreview.display(PlacementStrataEnums.STRATA_PLAYER);
                  break;
               }
            }
         }
      }
      
      private function removeReplacementInvocationPreview() : void
      {
         if(this._replacementInvocationPreview)
         {
            this._replacementInvocationPreview.destroy();
            this._replacementInvocationPreview = null;
         }
         if(this._currentCellEntity)
         {
            this._currentCellEntity.visible = true;
         }
      }
      
      public function drawRange() : void
      {
         var _loc6_:Cross = null;
         var _loc14_:uint = 0;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:uint = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         var _loc22_:uint = 0;
         var _loc23_:MarkInstance = null;
         var _loc24_:Vector.<MapPoint> = null;
         var _loc25_:Vector.<uint> = null;
         var _loc26_:MapPoint = null;
         var _loc27_:MapPoint = null;
         var _loc28_:Vector.<Point> = null;
         var _loc29_:MapPoint = null;
         var _loc30_:Point = null;
         var _loc31_:Vector.<uint> = null;
         var _loc1_:int = CurrentPlayedFighterManager.getInstance().currentFighterId;
         var _loc2_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc1_) as GameFightFighterInformations;
         var _loc3_:uint = _loc2_.disposition.cellId;
         var _loc4_:CharacterBaseCharacteristic = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().range;
         var _loc5_:int = this._spellLevel.range;
         if(!this._spellLevel.castInLine && !this._spellLevel.castInDiagonal && !this._spellLevel.castTestLos && _loc5_ == 63)
         {
            this._isInfiniteTarget = true;
            return;
         }
         this._isInfiniteTarget = false;
         if(this._spellLevel["rangeCanBeBoosted"])
         {
            _loc5_ = _loc5_ + (_loc4_.base + _loc4_.objectsAndMountBonus + _loc4_.alignGiftBonus + _loc4_.contextModif);
            if(_loc5_ < this._spellLevel.minRange)
            {
               _loc5_ = this._spellLevel.minRange;
            }
         }
         _loc5_ = Math.min(_loc5_,AtouinConstants.MAP_WIDTH * AtouinConstants.MAP_HEIGHT);
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         this._rangeSelection = new Selection();
         this._rangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         (this._rangeSelection.renderer as ZoneDARenderer).showFarmCell = false;
         this._rangeSelection.color = RANGE_COLOR;
         this._rangeSelection.alpha = true;
         if((this._spellLevel.castInLine) && (this._spellLevel.castInDiagonal))
         {
            _loc6_ = new Cross(this._spellLevel.minRange,_loc5_,DataMapProvider.getInstance());
            _loc6_.allDirections = true;
            this._rangeSelection.zone = _loc6_;
         }
         else if(this._spellLevel.castInLine)
         {
            this._rangeSelection.zone = new Cross(this._spellLevel.minRange,_loc5_,DataMapProvider.getInstance());
         }
         else if(this._spellLevel.castInDiagonal)
         {
            _loc6_ = new Cross(this._spellLevel.minRange,_loc5_,DataMapProvider.getInstance());
            _loc6_.diagonal = true;
            this._rangeSelection.zone = _loc6_;
         }
         else
         {
            this._rangeSelection.zone = new Lozenge(this._spellLevel.minRange,_loc5_,DataMapProvider.getInstance());
         }
         
         
         var _loc7_:Vector.<uint> = new Vector.<uint>();
         this._losSelection = new Selection();
         this._losSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         (this._losSelection.renderer as ZoneDARenderer).showFarmCell = false;
         this._losSelection.color = LOS_COLOR;
         var _loc8_:Vector.<uint> = this._rangeSelection.zone.getCells(_loc3_);
         if(!this._spellLevel.castTestLos)
         {
            this._losSelection.zone = new Custom(_loc8_);
         }
         else
         {
            this._losSelection.zone = new Custom(LosDetector.getCell(DataMapProvider.getInstance(),_loc8_,MapPoint.fromCellId(_loc3_)));
            this._rangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA,0.5);
            (this._rangeSelection.renderer as ZoneDARenderer).showFarmCell = false;
            _loc15_ = this._rangeSelection.zone.getCells(_loc3_);
            _loc16_ = this._losSelection.zone.getCells(_loc3_);
            _loc17_ = _loc15_.length;
            _loc18_ = 0;
            while(_loc18_ < _loc17_)
            {
               _loc19_ = _loc15_[_loc18_];
               if(_loc16_.indexOf(_loc19_) == -1)
               {
                  _loc7_.push(_loc19_);
               }
               _loc18_++;
            }
         }
         var _loc9_:Vector.<MapPoint> = MarkedCellsManager.getInstance().getMarksMapPoint(GameActionMarkTypeEnum.PORTAL);
         var _loc10_:Vector.<uint> = new Vector.<uint>();
         var _loc11_:Vector.<uint> = new Vector.<uint>();
         if((_loc9_) && _loc9_.length >= 2)
         {
            for each(_loc22_ in this._losSelection.zone.getCells(_loc3_))
            {
               _loc20_ = this.getTargetThroughPortal(_loc22_);
               if(_loc20_ != _loc22_)
               {
                  this._targetingThroughPortal = true;
                  if(this.isValidCell(_loc20_,true))
                  {
                     if(this._spellLevel.castTestLos)
                     {
                        _loc23_ = MarkedCellsManager.getInstance().getMarkAtCellId(_loc22_,GameActionMarkTypeEnum.PORTAL);
                        _loc24_ = MarkedCellsManager.getInstance().getMarksMapPoint(GameActionMarkTypeEnum.PORTAL,_loc23_.teamId);
                        _loc25_ = LinkedCellsManager.getInstance().getLinks(MapPoint.fromCellId(_loc22_),_loc24_);
                        _loc21_ = _loc25_.pop();
                        _loc26_ = MapPoint.fromCellId(_loc21_);
                        _loc27_ = MapPoint.fromCellId(_loc20_);
                        _loc28_ = Dofus2Line.getLine(_loc26_.cellId,_loc27_.cellId);
                        for each(_loc30_ in _loc28_)
                        {
                           _loc29_ = MapPoint.fromCoords(_loc30_.x,_loc30_.y);
                           _loc11_.push(_loc29_.cellId);
                        }
                        _loc31_ = LosDetector.getCell(DataMapProvider.getInstance(),_loc11_,_loc26_);
                        if(_loc31_.indexOf(_loc20_) > -1)
                        {
                           _loc10_.push(_loc22_);
                        }
                        else
                        {
                           _loc7_.push(_loc22_);
                        }
                     }
                     else
                     {
                        _loc10_.push(_loc22_);
                     }
                  }
                  else
                  {
                     _loc7_.push(_loc22_);
                  }
                  this._targetingThroughPortal = false;
               }
            }
         }
         var _loc12_:Vector.<uint> = new Vector.<uint>();
         var _loc13_:Vector.<uint> = this._losSelection.zone.getCells(_loc3_);
         for each(_loc14_ in _loc13_)
         {
            if(_loc10_.indexOf(_loc14_) != -1)
            {
               _loc12_.push(_loc14_);
            }
            else if((this._usedWrapper is SpellWrapper) && (this._usedWrapper.spellLevelInfos) && ((this._usedWrapper.spellLevelInfos.needFreeCell) && (this.cellHasEntity(_loc14_)) || (this._usedWrapper.spellLevelInfos.needFreeTrapCell) && (MarkedCellsManager.getInstance().cellHasTrap(_loc14_))))
            {
               _loc7_.push(_loc14_);
            }
            else if(_loc7_.indexOf(_loc14_) == -1)
            {
               _loc12_.push(_loc14_);
            }
            
            
         }
         this._losSelection.zone = new Custom(_loc12_);
         SelectionManager.getInstance().addSelection(this._losSelection,SELECTION_LOS,_loc3_);
         if(_loc7_.length > 0)
         {
            this._rangeSelection.zone = new Custom(_loc7_);
            SelectionManager.getInstance().addSelection(this._rangeSelection,SELECTION_RANGE,_loc3_);
         }
         if(_loc10_.length > 0)
         {
            this._portalsSelection = new Selection();
            this._portalsSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._portalsSelection.color = PORTAL_COLOR;
            this._portalsSelection.alpha = true;
            this._portalsSelection.zone = new Custom(_loc10_);
            SelectionManager.getInstance().addSelection(this._portalsSelection,SELECTION_PORTALS,_loc3_);
         }
      }
      
      private function showTeleportationPreview() : void
      {
         var _loc2_:Vector.<EffectInstance> = null;
         var _loc3_:EffectInstance = null;
         var _loc4_:FightContextFrame = null;
         var _loc5_:IZone = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:uint = 0;
         var _loc8_:Vector.<int> = null;
         var _loc9_:* = 0;
         var _loc10_:GameFightFighterInformations = null;
         var _loc11_:Vector.<int> = null;
         var _loc12_:* = 0;
         var _loc13_:SpellWrapper = null;
         var _loc14_:uint = 0;
         var _loc15_:* = 0;
         var _loc16_:uint = 0;
         var _loc17_:MarkInstance = null;
         var _loc18_:Vector.<MapPoint> = null;
         var _loc19_:Vector.<uint> = null;
         var _loc1_:SpellWrapper = this._usedWrapper as SpellWrapper;
         if((_loc1_) && ((!_loc1_.spellLevelInfos.needTakenCell) || (this._currentCellEntity)))
         {
            _loc2_ = _loc1_.effects.concat(_loc1_.criticalEffect);
            _loc4_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            _loc7_ = this._currentCell;
            _loc8_ = _loc4_.entitiesFrame.getEntitiesIdsList();
            _loc11_ = new Vector.<int>(0);
            _loc12_ = PlayedCharacterManager.getInstance().id;
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_.effectId == 1160)
               {
                  _loc13_ = SpellWrapper.create(0,_loc3_.parameter0 as uint,_loc1_.spellLevel);
                  if(this.hasTeleportation(_loc13_))
                  {
                     for each(_loc9_ in _loc8_)
                     {
                        _loc10_ = _loc4_.entitiesFrame.getEntityInfos(_loc9_) as GameFightFighterInformations;
                        if((_loc10_.alive) && (DamageUtil.verifySpellEffectMask(_loc12_,_loc9_,_loc3_,_loc7_)))
                        {
                           _loc7_ = _loc10_.disposition.cellId;
                           _loc2_ = _loc13_.effects.concat(_loc13_.criticalEffect);
                           break;
                        }
                     }
                     break;
                  }
               }
            }
            for each(_loc3_ in _loc2_)
            {
               if(TELEPORTATION_EFFECTS.indexOf(_loc3_.effectId) != -1)
               {
                  _loc14_ = _loc3_.effectId;
                  _loc5_ = SpellZoneManager.getInstance().getZone(_loc3_.zoneShape,_loc3_.zoneSize as uint,_loc3_.zoneMinSize as uint);
                  _loc6_ = _loc5_.getCells(_loc7_);
                  for each(_loc9_ in _loc8_)
                  {
                     _loc10_ = _loc4_.entitiesFrame.getEntityInfos(_loc9_) as GameFightFighterInformations;
                     if((_loc10_.alive && !(_loc6_.indexOf(_loc10_.disposition.cellId) == -1) && DofusEntities.getEntity(_loc9_) && _loc11_.indexOf(_loc9_) == -1 && DamageUtil.verifySpellEffectMask(_loc12_,_loc9_,_loc3_,_loc7_)) && (!(_loc7_ == _loc10_.disposition.cellId && (_loc14_ == 1104 || _loc14_ == 1106))) && (this.canTeleport(_loc10_.contextualId)))
                     {
                        _loc11_.push(_loc9_);
                     }
                  }
                  _loc15_++;
               }
            }
            if(_loc11_.length == 0 && _loc14_ == 1104 && (this.canTeleport(_loc12_)))
            {
               _loc11_.push(_loc12_);
            }
            this.removeTeleportationPreview();
            if(_loc11_.length > 0)
            {
               if(this._targetingThroughPortal)
               {
                  _loc17_ = MarkedCellsManager.getInstance().getMarkAtCellId(FightContextFrame.currentCell,GameActionMarkTypeEnum.PORTAL);
                  _loc18_ = MarkedCellsManager.getInstance().getMarksMapPoint(GameActionMarkTypeEnum.PORTAL,_loc17_.teamId);
                  _loc19_ = LinkedCellsManager.getInstance().getLinks(MapPoint.fromCellId(_loc17_.markImpactCellId),_loc18_);
                  _loc16_ = _loc19_.pop();
               }
               else
               {
                  _loc16_ = _loc4_.entitiesFrame.getEntityInfos(_loc12_).disposition.cellId;
               }
               this._fightTeleportationPreview = new FightTeleportationPreview(_loc11_,_loc14_,_loc7_,_loc16_,_loc15_ > 1,_loc11_.length == _loc8_.length);
               this._fightTeleportationPreview.show();
            }
         }
      }
      
      private function canTeleport(param1:int) : Boolean
      {
         var _loc5_:Monster = null;
         var _loc2_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var _loc3_:GameFightFighterInformations = _loc2_.entitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
         if(_loc3_ is GameFightMonsterInformations)
         {
            _loc5_ = Monster.getMonsterById((_loc3_ as GameFightMonsterInformations).creatureGenericId);
            if(!_loc5_.canSwitchPos)
            {
               return false;
            }
         }
         var _loc4_:Array = FightersStateManager.getInstance().getStates(param1);
         return !_loc4_ || _loc4_.indexOf(6) == -1 && _loc4_.indexOf(97) == -1;
      }
      
      private function hasTeleportation(param1:SpellWrapper) : Boolean
      {
         var _loc2_:EffectInstance = null;
         for each(_loc2_ in param1.effects)
         {
            if(TELEPORTATION_EFFECTS.indexOf(_loc2_.effectId) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function removeTeleportationPreview() : void
      {
         if(this._fightTeleportationPreview)
         {
            this._fightTeleportationPreview.remove();
            this._fightTeleportationPreview = null;
         }
      }
      
      private function getParentEntity(param1:TiphonSprite) : TiphonSprite
      {
         var _loc2_:TiphonSprite = null;
         var _loc3_:TiphonSprite = param1.parentSprite;
         while(_loc3_)
         {
            _loc2_ = _loc3_;
            _loc3_ = _loc3_.parentSprite;
         }
         return !_loc2_?param1:_loc2_;
      }
      
      private function showTargetsTooltips(param1:Selection) : void
      {
         var _loc4_:* = 0;
         var _loc7_:GameFightFighterInformations = null;
         var _loc2_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var _loc3_:Vector.<int> = _loc2_.entitiesFrame.getEntitiesIdsList();
         var _loc5_:Vector.<uint> = param1.zone.getCells(this._currentCell);
         var _loc6_:Vector.<int> = new Vector.<int>(0);
         for each(_loc4_ in _loc3_)
         {
            _loc7_ = _loc2_.entitiesFrame.getEntityInfos(_loc4_) as GameFightFighterInformations;
            if(!(_loc5_.indexOf(_loc7_.disposition.cellId) == -1) && (DofusEntities.getEntity(_loc4_)))
            {
               _loc6_.push(_loc4_);
               TooltipPlacer.waitBeforeOrder("tooltip_tooltipOverEntity_" + _loc4_);
            }
            else if(!_loc2_.showPermanentTooltips || (_loc2_.showPermanentTooltips) && _loc2_.battleFrame.targetedEntities.indexOf(_loc4_) == -1)
            {
               TooltipManager.hide("tooltipOverEntity_" + _loc4_);
            }
            
         }
         if(_loc6_.length > 0 && _loc6_.indexOf(CurrentPlayedFighterManager.getInstance().currentFighterId) == -1 && this._usedWrapper is SpellWrapper && ((this._usedWrapper as SpellWrapper).canTargetCasterOutOfZone))
         {
            _loc6_.push(CurrentPlayedFighterManager.getInstance().currentFighterId);
         }
         _loc2_.removeSpellTargetsTooltips();
         for each(_loc4_ in _loc6_)
         {
            _loc7_ = _loc2_.entitiesFrame.getEntityInfos(_loc4_) as GameFightFighterInformations;
            if(_loc7_.alive)
            {
               _loc2_.displayEntityTooltip(_loc4_,this._spellLevel,null,false,this._currentCell);
            }
         }
      }
      
      private function hideTargetsTooltips() : void
      {
         var _loc3_:* = 0;
         var _loc5_:AnimatedCharacter = null;
         var _loc1_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var _loc2_:Vector.<int> = _loc1_.entitiesFrame.getEntitiesIdsList();
         var _loc4_:IEntity = EntitiesManager.getInstance().getEntityOnCell(FightContextFrame.currentCell,AnimatedCharacter);
         if(_loc4_)
         {
            _loc5_ = _loc4_ as AnimatedCharacter;
            if((_loc5_) && (_loc5_.parentSprite) && _loc5_.parentSprite.carriedEntity == _loc5_)
            {
               _loc4_ = _loc5_.parentSprite as AnimatedCharacter;
            }
         }
         for each(_loc3_ in _loc2_)
         {
            if(!_loc1_.showPermanentTooltips || (_loc1_.showPermanentTooltips) && _loc1_.battleFrame.targetedEntities.indexOf(_loc3_) == -1)
            {
               TooltipManager.hide("tooltipOverEntity_" + _loc3_);
            }
         }
         if((_loc1_.showPermanentTooltips) && _loc1_.battleFrame.targetedEntities.length > 0)
         {
            for each(_loc3_ in _loc1_.battleFrame.targetedEntities)
            {
               if(!_loc4_ || !(_loc3_ == _loc4_.id))
               {
                  _loc1_.displayEntityTooltip(_loc3_);
               }
            }
         }
         if(_loc4_)
         {
            _loc1_.displayEntityTooltip(_loc4_.id);
         }
      }
      
      private function clearTarget() : void
      {
         if(!this._clearTargetTimer.running)
         {
            this._clearTargetTimer.start();
         }
      }
      
      private function onClearTarget(param1:TimerEvent) : void
      {
         this.refreshTarget();
      }
      
      private function getTargetThroughPortal(param1:int, param2:Boolean = false) : int
      {
         var _loc3_:MapPoint = null;
         var _loc8_:MarkInstance = null;
         var _loc9_:MapPoint = null;
         var _loc15_:EffectInstance = null;
         var _loc16_:MapPoint = null;
         var _loc17_:Vector.<uint> = null;
         var _loc18_:Vector.<uint> = null;
         if((this._spellLevel) && (this._spellLevel.effects))
         {
            for each(_loc15_ in this._spellLevel.effects)
            {
               if(_loc15_.effectId == ActionIdConverter.ACTION_FIGHT_DISABLE_PORTAL)
               {
                  return param1;
               }
            }
         }
         var _loc4_:int = CurrentPlayedFighterManager.getInstance().currentFighterId;
         var _loc5_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc4_) as GameFightFighterInformations;
         if(!_loc5_)
         {
            return param1;
         }
         var _loc6_:MarkedCellsManager = MarkedCellsManager.getInstance();
         var _loc7_:Vector.<MapPoint> = _loc6_.getMarksMapPoint(GameActionMarkTypeEnum.PORTAL);
         if(!_loc7_ || _loc7_.length < 2)
         {
            return param1;
         }
         for each(_loc9_ in _loc7_)
         {
            _loc8_ = _loc6_.getMarkAtCellId(_loc9_.cellId,GameActionMarkTypeEnum.PORTAL);
            if((_loc8_) && (_loc8_.active))
            {
               if(_loc9_.cellId == param1)
               {
                  _loc3_ = _loc9_;
                  break;
               }
            }
         }
         if(!_loc3_)
         {
            return param1;
         }
         _loc7_ = _loc6_.getMarksMapPoint(GameActionMarkTypeEnum.PORTAL,_loc8_.teamId);
         var _loc10_:Vector.<uint> = LinkedCellsManager.getInstance().getLinks(_loc3_,_loc7_);
         var _loc11_:MapPoint = MapPoint.fromCellId(_loc10_.pop());
         var _loc12_:MapPoint = MapPoint.fromCellId(_loc5_.disposition.cellId);
         if(!_loc12_)
         {
            return param1;
         }
         var _loc13_:int = _loc3_.x - _loc12_.x + _loc11_.x;
         var _loc14_:int = _loc3_.y - _loc12_.y + _loc11_.y;
         if(!MapPoint.isInMap(_loc13_,_loc14_))
         {
            return AtouinConstants.MAP_CELLS_COUNT + 1;
         }
         _loc16_ = MapPoint.fromCoords(_loc13_,_loc14_);
         if(param2)
         {
            _loc17_ = new Vector.<uint>();
            _loc17_.push(_loc12_.cellId);
            _loc17_.push(_loc3_.cellId);
            LinkedCellsManager.getInstance().drawLinks("spellEntryLink",_loc17_,10,TARGET_COLOR.color,1);
            if(_loc16_.cellId < AtouinConstants.MAP_CELLS_COUNT)
            {
               _loc18_ = new Vector.<uint>();
               _loc18_.push(_loc11_.cellId);
               _loc18_.push(_loc16_.cellId);
               LinkedCellsManager.getInstance().drawLinks("spellExitLink",_loc18_,6,TARGET_COLOR.color,1);
            }
         }
         return _loc16_.cellId;
      }
      
      private function castSpell(param1:uint, param2:int = 0) : void
      {
         var _loc4_:GameActionFightCastOnTargetRequestMessage = null;
         var _loc5_:GameActionFightCastRequestMessage = null;
         var _loc3_:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         if(!_loc3_ || !_loc3_.myTurn)
         {
            return;
         }
         if(CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent < this._spellLevel.apCost)
         {
            return;
         }
         if(!(param2 == 0) && !FightEntitiesFrame.getCurrentInstance().entityIsIllusion(param2))
         {
            CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent - this._spellLevel.apCost;
            _loc4_ = new GameActionFightCastOnTargetRequestMessage();
            _loc4_.initGameActionFightCastOnTargetRequestMessage(this._spellId,param2);
            ConnectionsHandler.getConnection().send(_loc4_);
         }
         else if(this.isValidCell(param1))
         {
            if(this._invocationPreview.length > 0)
            {
               this.removeInvocationPreview();
            }
            CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent - this._spellLevel.apCost;
            _loc5_ = new GameActionFightCastRequestMessage();
            _loc5_.initGameActionFightCastRequestMessage(this._spellId,param1);
            ConnectionsHandler.getConnection().send(_loc5_);
         }
         
         this.cancelCast();
      }
      
      private function cancelCast(... rest) : void
      {
         this.removeInvocationPreview();
         this._cancelTimer.reset();
         Kernel.getWorker().removeFrame(this);
      }
      
      private function removeRange() : void
      {
         var _loc1_:Selection = SelectionManager.getInstance().getSelection(SELECTION_RANGE);
         if(_loc1_)
         {
            _loc1_.remove();
            this._rangeSelection = null;
         }
         var _loc2_:Selection = SelectionManager.getInstance().getSelection(SELECTION_LOS);
         if(_loc2_)
         {
            _loc2_.remove();
            this._losSelection = null;
         }
         var _loc3_:Selection = SelectionManager.getInstance().getSelection(SELECTION_PORTALS);
         if(_loc3_)
         {
            _loc3_.remove();
            this._portalsSelection = null;
         }
         this._isInfiniteTarget = false;
      }
      
      private function removeTarget() : void
      {
         var _loc1_:Selection = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
         if(_loc1_)
         {
            _loc1_.remove();
            this._rangeSelection = null;
         }
      }
      
      private function cellHasEntity(param1:uint) : Boolean
      {
         var _loc4_:IEntity = null;
         var _loc5_:IEntity = null;
         var _loc6_:* = false;
         var _loc2_:Array = EntitiesManager.getInstance().getEntitiesOnCell(param1,AnimatedCharacter);
         var _loc3_:int = _loc2_?_loc2_.length:0;
         if((_loc3_) && this._invocationPreview.length > 0)
         {
            while(true)
            {
               for each(_loc4_ in _loc2_)
               {
                  _loc6_ = false;
                  for each(_loc5_ in this._invocationPreview)
                  {
                     if(_loc4_.id == _loc5_.id)
                     {
                        _loc3_--;
                        _loc6_ = true;
                        break;
                     }
                  }
                  if(_loc6_)
                  {
                     continue;
                  }
                  break;
               }
            }
            return true;
         }
         return _loc3_ > 0;
      }
      
      private function isValidCell(param1:uint, param2:Boolean = false) : Boolean
      {
         var _loc4_:SpellLevel = null;
         var _loc5_:Array = null;
         var _loc6_:IEntity = null;
         var _loc7_:* = false;
         var _loc8_:* = false;
         var _loc9_:IEntity = null;
         var _loc10_:* = false;
         var _loc3_:CellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[param1];
         if(!_loc3_ || (_loc3_.farmCell))
         {
            return false;
         }
         if(this._isInfiniteTarget)
         {
            return true;
         }
         if(this._spellId)
         {
            _loc4_ = this._spellLevel.spellLevelInfos;
            _loc5_ = EntitiesManager.getInstance().getEntitiesOnCell(param1);
            for each(_loc6_ in _loc5_)
            {
               if(this._invocationPreview.length > 0)
               {
                  _loc8_ = false;
                  for each(_loc9_ in this._invocationPreview)
                  {
                     if(_loc6_.id == _loc9_.id)
                     {
                        _loc8_ = true;
                        break;
                     }
                  }
                  if(_loc8_)
                  {
                     continue;
                  }
               }
               if(!CurrentPlayedFighterManager.getInstance().canCastThisSpell(this._spellLevel.spellId,this._spellLevel.spellLevel,_loc6_.id))
               {
                  return false;
               }
               _loc7_ = _loc6_ is Glyph;
               if((_loc4_.needFreeTrapCell) && (_loc7_) && (_loc6_ as Glyph).glyphType == GameActionMarkTypeEnum.TRAP)
               {
                  return false;
               }
               if((this._spellLevel.needFreeCell) && !_loc7_)
               {
                  return false;
               }
            }
         }
         if((this._targetingThroughPortal) && !param2)
         {
            _loc10_ = this.isValidCell(this.getTargetThroughPortal(param1),true);
            if(!_loc10_)
            {
               return false;
            }
         }
         if(this._targetingThroughPortal)
         {
            if(_loc3_.nonWalkableDuringFight)
            {
               return false;
            }
            if(_loc3_.mov)
            {
               return true;
            }
            return false;
         }
         return SelectionManager.getInstance().isInside(param1,SELECTION_LOS);
      }
   }
}
