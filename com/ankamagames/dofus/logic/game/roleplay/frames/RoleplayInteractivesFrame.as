package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import flash.geom.Point;
   import flash.filters.ColorMatrixFilter;
   import flash.display.Sprite;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveMapUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveElementUpdatedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUsedMessage;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseErrorMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.StatedMapUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.StatedElementUpdatedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapObstacleUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseEndedMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOverMessage;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOutMessage;
   import flash.utils.clearTimeout;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import com.ankamagames.dofus.datacenter.interactives.Interactive;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.jerakine.managers.FiltersManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.jerakine.managers.PerformanceManager;
   import flash.ui.Mouse;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.internalDatacenter.jobs.KnownJob;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementNamedSkill;
   import com.ankamagames.dofus.datacenter.interactives.SkillName;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   
   public class RoleplayInteractivesFrame extends Object implements Frame
   {
      
      public function RoleplayInteractivesFrame() {
         this._ie = new Dictionary(true);
         this._currentUsages = new Array();
         this._entities = new Dictionary();
         this._interactiveActionTimers = new Dictionary(true);
         this._collectableSpritesToBeStopped = new Dictionary(true);
         this._statedElementsTargetAnimation = new Dictionary(true);
         super();
         this._modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         if(!cursorClassList)
         {
            cursorClassList = new Array();
            cursorClassList[0] = INTERACTIVE_CURSOR_0;
            cursorClassList[1] = INTERACTIVE_CURSOR_1;
            cursorClassList[2] = INTERACTIVE_CURSOR_2;
            cursorClassList[3] = INTERACTIVE_CURSOR_3;
            cursorClassList[4] = INTERACTIVE_CURSOR_4;
            cursorClassList[5] = INTERACTIVE_CURSOR_5;
            cursorClassList[6] = INTERACTIVE_CURSOR_6;
            cursorClassList[7] = INTERACTIVE_CURSOR_7;
            cursorClassList[8] = INTERACTIVE_CURSOR_8;
            cursorClassList[9] = INTERACTIVE_CURSOR_9;
            cursorClassList[10] = INTERACTIVE_CURSOR_10;
            cursorClassList[11] = INTERACTIVE_CURSOR_DISABLED;
         }
      }
      
      private static const INTERACTIVE_CURSOR_0:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_0;
      
      private static const INTERACTIVE_CURSOR_1:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_1;
      
      private static const INTERACTIVE_CURSOR_2:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_2;
      
      private static const INTERACTIVE_CURSOR_3:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_3;
      
      private static const INTERACTIVE_CURSOR_4:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_4;
      
      private static const INTERACTIVE_CURSOR_5:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_5;
      
      private static const INTERACTIVE_CURSOR_6:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_6;
      
      private static const INTERACTIVE_CURSOR_7:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_7;
      
      private static const INTERACTIVE_CURSOR_8:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_8;
      
      private static const INTERACTIVE_CURSOR_9:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_9;
      
      private static const INTERACTIVE_CURSOR_10:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_10;
      
      private static const INTERACTIVE_CURSOR_DISABLED:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_DISABLED;
      
      private static var cursorList:Array = new Array();
      
      private static var cursorClassList:Array;
      
      private static const INTERACTIVE_CURSOR_OFFSET:Point = new Point(0,0);
      
      private static const INTERACTIVE_CURSOR_NAME:String = "interactiveCursor";
      
      private static const LUMINOSITY_FACTOR:Number = 1.2;
      
      private static const LUMINOSITY_EFFECTS:ColorMatrixFilter = new ColorMatrixFilter([LUMINOSITY_FACTOR,0,0,0,0,0,LUMINOSITY_FACTOR,0,0,0,0,0,LUMINOSITY_FACTOR,0,0,0,0,0,1,0]);
      
      private static const ALPHA_MODIFICATOR:Number = 0.2;
      
      private static const COLLECTABLE_COLLECTING_STATE_ID:uint = 2;
      
      private static const COLLECTABLE_CUT_STATE_ID:uint = 1;
      
      private static const COLLECTABLE_INTERACTIVE_ACTION_ID:uint = 1;
      
      public static var currentlyHighlighted:Sprite;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayInteractivesFrame));
      
      public static function getCursor(param1:int, param2:Boolean=true, param3:Boolean=true) : Sprite {
         var _loc4_:Sprite = null;
         var _loc5_:Sprite = null;
         var _loc6_:Class = null;
         if(!param2)
         {
            if(cursorList[11])
            {
               _loc4_ = cursorList[11];
            }
            else
            {
               _loc6_ = cursorClassList[11];
               if(_loc6_)
               {
                  _loc4_ = new _loc6_();
                  cursorList[11] = _loc4_;
               }
            }
         }
         if((cursorList[param1]) && (param3))
         {
            _loc5_ = cursorList[param1];
         }
         _loc6_ = cursorClassList[param1];
         if(_loc6_)
         {
            _loc5_ = new _loc6_();
            if(param3)
            {
               cursorList[param1] = _loc5_;
            }
            _loc5_.cacheAsBitmap = true;
            if(_loc4_ != null)
            {
               _loc5_.addChild(_loc4_);
            }
         }
         if(_loc5_)
         {
            if(_loc4_ != null)
            {
               _loc5_.addChild(_loc4_);
            }
            else
            {
               if(_loc5_.numChildren > 1)
               {
                  _loc5_.removeChildAt(0);
               }
            }
            return _loc5_;
         }
         return new INTERACTIVE_CURSOR_0();
      }
      
      private var _modContextMenu:Object;
      
      private var _ie:Dictionary;
      
      private var _currentUsages:Array;
      
      private var _baseAlpha:Number;
      
      private var i:int;
      
      private var _entities:Dictionary;
      
      private var _usingInteractive:Boolean = false;
      
      private var _nextInteractiveUsed:Object;
      
      private var _interactiveActionTimers:Dictionary;
      
      private var _enableWorldInteraction:Boolean = true;
      
      private var _collectableSpritesToBeStopped:Dictionary;
      
      private var _currentRequestedElementId:int = -1;
      
      private var _currentUsedElementId:int = -1;
      
      private var _statedElementsTargetAnimation:Dictionary;
      
      public function get priority() : int {
         return Priority.HIGH;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get roleplayWorldFrame() : RoleplayWorldFrame {
         return Kernel.getWorker().getFrame(RoleplayWorldFrame) as RoleplayWorldFrame;
      }
      
      public function get currentRequestedElementId() : int {
         return this._currentRequestedElementId;
      }
      
      public function set currentRequestedElementId(param1:int) : void {
         this._currentRequestedElementId = param1;
      }
      
      public function get usingInteractive() : Boolean {
         return this._usingInteractive;
      }
      
      public function get nextInteractiveUsed() : Object {
         return this._nextInteractiveUsed;
      }
      
      public function set nextInteractiveUsed(param1:Object) : void {
         this._nextInteractiveUsed = param1;
      }
      
      public function get worldInteractionIsEnable() : Boolean {
         return this._enableWorldInteraction;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var imumsg:InteractiveMapUpdateMessage = null;
         var ieumsg:InteractiveElementUpdatedMessage = null;
         var iumsg:InteractiveUsedMessage = null;
         var worldPos:MapPoint = null;
         var user:IEntity = null;
         var iuem:InteractiveUseErrorMessage = null;
         var smumsg:StatedMapUpdateMessage = null;
         var seumsg:StatedElementUpdatedMessage = null;
         var moumsg:MapObstacleUpdateMessage = null;
         var iuemsg:InteractiveUseEndedMessage = null;
         var iemimsg:InteractiveElementMouseOverMessage = null;
         var iel:Object = null;
         var ie:InteractiveElement = null;
         var useAnimation:String = null;
         var useDirection:uint = 0;
         var tiphonSprite:TiphonSprite = null;
         var currentSpriteAnimation:String = null;
         var t:Timer = null;
         var fct:Function = null;
         var seq:SerialSequencer = null;
         var sprite:TiphonSprite = null;
         var rwf:RoleplayWorldFrame = null;
         var se:StatedElement = null;
         var mo:MapObstacle = null;
         var msg:Message = param1;
         switch(true)
         {
            case msg is InteractiveMapUpdateMessage:
               imumsg = msg as InteractiveMapUpdateMessage;
               this.clear();
               for each (ie in imumsg.interactiveElements)
               {
                  if(ie.enabledSkills.length)
                  {
                     this.registerInteractive(ie,ie.enabledSkills[0].skillId);
                  }
                  else
                  {
                     if(ie.disabledSkills.length)
                     {
                        this.registerInteractive(ie,ie.disabledSkills[0].skillId);
                     }
                  }
               }
               return true;
            case msg is InteractiveElementUpdatedMessage:
               ieumsg = msg as InteractiveElementUpdatedMessage;
               if(ieumsg.interactiveElement.enabledSkills.length)
               {
                  this.registerInteractive(ieumsg.interactiveElement,ieumsg.interactiveElement.enabledSkills[0].skillId);
               }
               else
               {
                  if(ieumsg.interactiveElement.disabledSkills.length)
                  {
                     this.registerInteractive(ieumsg.interactiveElement,ieumsg.interactiveElement.disabledSkills[0].skillId);
                  }
                  else
                  {
                     this.removeInteractive(ieumsg.interactiveElement);
                  }
               }
               return true;
            case msg is InteractiveUsedMessage:
               iumsg = msg as InteractiveUsedMessage;
               if(PlayedCharacterManager.getInstance().id == iumsg.entityId)
               {
                  this._currentUsedElementId = iumsg.elemId;
               }
               if(this._currentRequestedElementId == iumsg.elemId)
               {
                  this._currentRequestedElementId = -1;
               }
               worldPos = Atouin.getInstance().getIdentifiedElementPosition(iumsg.elemId);
               user = DofusEntities.getEntity(iumsg.entityId);
               if(user is IAnimated)
               {
                  useAnimation = Skill.getSkillById(iumsg.skillId).useAnimation;
                  useDirection = this.getUseDirection(user as TiphonSprite,useAnimation,worldPos);
                  if(iumsg.duration > 0)
                  {
                     tiphonSprite = user as TiphonSprite;
                     tiphonSprite.setAnimationAndDirection(useAnimation,useDirection);
                     currentSpriteAnimation = tiphonSprite.getAnimation();
                     if(!this._interactiveActionTimers[user])
                     {
                        this._interactiveActionTimers[user] = new Timer(1,1);
                     }
                     t = this._interactiveActionTimers[user];
                     t.delay = iumsg.duration * 100;
                     fct = function():void
                     {
                        var _loc1_:TiphonSprite = null;
                        t.removeEventListener(TimerEvent.TIMER,fct);
                        if(currentSpriteAnimation.indexOf((user as TiphonSprite).getAnimation()) != -1)
                        {
                           _loc1_ = user as TiphonSprite;
                           if(_loc1_ is AnimatedCharacter && !(_loc1_.getDirection() == DirectionsEnum.DOWN))
                           {
                              (_loc1_ as AnimatedCharacter).visibleAura = false;
                           }
                           _loc1_.setAnimation(AnimationEnum.ANIM_STATIQUE);
                        }
                     };
                     if(!t.hasEventListener(TimerEvent.TIMER))
                     {
                        t.addEventListener(TimerEvent.TIMER,fct);
                     }
                     t.start();
                  }
                  else
                  {
                     seq = new SerialSequencer();
                     sprite = user as TiphonSprite;
                     seq.addStep(new SetDirectionStep(sprite,useDirection));
                     seq.addStep(new PlayAnimationStep(sprite,useAnimation));
                     seq.start();
                  }
               }
               if(iumsg.duration > 0)
               {
                  if(PlayedCharacterManager.getInstance().id == iumsg.entityId)
                  {
                     this._usingInteractive = true;
                     this.resetInteractiveApparence(false);
                     rwf = this.roleplayWorldFrame;
                     if(rwf)
                     {
                        rwf.cellClickEnabled = false;
                     }
                  }
                  this._entities[iumsg.elemId] = iumsg.entityId;
               }
               return true;
            case msg is InteractiveUseErrorMessage:
               iuem = msg as InteractiveUseErrorMessage;
               if(iuem.elemId == this._currentRequestedElementId)
               {
                  this._currentRequestedElementId = -1;
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.popup.impossible_action"),ChatFrame.RED_CHANNEL_ID);
               return true;
            case msg is StatedMapUpdateMessage:
               smumsg = msg as StatedMapUpdateMessage;
               for each (se in smumsg.statedElements)
               {
                  this.updateStatedElement(se,true);
               }
               return true;
            case msg is StatedElementUpdatedMessage:
               seumsg = msg as StatedElementUpdatedMessage;
               this.updateStatedElement(seumsg.statedElement);
               return true;
            case msg is MapObstacleUpdateMessage:
               moumsg = msg as MapObstacleUpdateMessage;
               for each (mo in moumsg.obstacles)
               {
                  InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId,mo.state == MapObstacleStateEnum.OBSTACLE_OPENED);
               }
               return true;
            case msg is InteractiveUseEndedMessage:
               iuemsg = InteractiveUseEndedMessage(msg);
               this.interactiveUsageFinished(this._entities[iuemsg.elemId],iuemsg.elemId,iuemsg.skillId);
               delete this._entities[[iuemsg.elemId]];
               return true;
            case msg is InteractiveElementMouseOverMessage:
               iemimsg = msg as InteractiveElementMouseOverMessage;
               iel = this._ie[iemimsg.sprite];
               if((iel) && (iel.element))
               {
                  this.highlightInteractiveApparence(iemimsg.sprite,iel.firstSkill,iel.element.enabledSkills.length > 0);
               }
               return false;
            case msg is InteractiveElementMouseOutMessage:
               this.resetInteractiveApparence();
               currentlyHighlighted = null;
               return false;
            default:
               return false;
         }
      }
      
      private var dirmov:uint = 666;
      
      public function pulled() : Boolean {
         var _loc1_:* = undefined;
         var _loc2_:TiphonSprite = null;
         for (_loc1_ in this._collectableSpritesToBeStopped)
         {
            _loc2_ = _loc1_ as TiphonSprite;
            if(_loc2_)
            {
               _loc2_.setAnimationAndDirection("AnimState" + COLLECTABLE_CUT_STATE_ID,0);
            }
         }
         this._collectableSpritesToBeStopped = new Dictionary(true);
         this._entities = new Dictionary();
         this._ie = new Dictionary(true);
         this._modContextMenu = null;
         this._currentUsages = new Array();
         this._nextInteractiveUsed = null;
         this._interactiveActionTimers = new Dictionary(true);
         return true;
      }
      
      public function enableWorldInteraction(param1:Boolean) : void {
         this._enableWorldInteraction = param1;
      }
      
      public function clear() : void {
         var _loc1_:* = 0;
         var _loc2_:Object = null;
         for each (_loc1_ in this._currentUsages)
         {
            clearTimeout(_loc1_);
         }
         for each (_loc2_ in this._ie)
         {
            this.removeInteractive(_loc2_.element as InteractiveElement);
         }
      }
      
      public function getInteractiveElementsCells() : Vector.<uint> {
         var _loc2_:Object = null;
         var _loc1_:Vector.<uint> = new Vector.<uint>();
         for each (_loc2_ in this._ie)
         {
            if(_loc2_ != null)
            {
               _loc1_.push(_loc2_.position.cellId);
            }
         }
         return _loc1_;
      }
      
      public function getInteractiveActionTimer(param1:*) : Timer {
         return this._interactiveActionTimers[param1];
      }
      
      public function isElementChangingState(param1:int) : Boolean {
         var _loc3_:Object = null;
         var _loc2_:* = false;
         for each (_loc3_ in this._statedElementsTargetAnimation)
         {
            if(_loc3_.elemId == param1)
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      public function getUseDirection(param1:TiphonSprite, param2:String, param3:MapPoint) : uint {
         var _loc4_:uint = 0;
         var _loc7_:* = 0;
         var _loc5_:MapPoint = (param1 as IMovable).position;
         if(_loc5_.x == param3.x && _loc5_.y == param3.y)
         {
            _loc4_ = param1.getDirection();
         }
         else
         {
            _loc4_ = (param1 as IMovable).position.advancedOrientationTo(param3,true);
         }
         var _loc6_:Array = param1.getAvaibleDirection(param2);
         if(_loc6_[5])
         {
            _loc6_[7] = true;
         }
         if(_loc6_[1])
         {
            _loc6_[3] = true;
         }
         if(_loc6_[7])
         {
            _loc6_[5] = true;
         }
         if(_loc6_[3])
         {
            _loc6_[1] = true;
         }
         if(_loc6_[_loc4_] == false)
         {
            _loc7_ = 0;
            while(_loc7_ < 8)
            {
               if(_loc4_ == 7)
               {
                  _loc4_ = 0;
               }
               else
               {
                  _loc4_++;
               }
               if(_loc6_[_loc4_] == true)
               {
                  break;
               }
               _loc7_++;
            }
         }
         return _loc4_;
      }
      
      private function registerInteractive(param1:InteractiveElement, param2:int) : void {
         var _loc6_:* = false;
         var _loc7_:String = null;
         var _loc8_:InteractiveElement = null;
         var _loc3_:InteractiveObject = Atouin.getInstance().getIdentifiedElement(param1.elementId);
         if(!_loc3_)
         {
            _log.error("Unknown identified element " + param1.elementId + ", unable to register it as interactive.");
            return;
         }
         var _loc4_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(_loc4_)
         {
            _loc6_ = false;
            for (_loc7_ in _loc4_.interactiveElements)
            {
               _loc8_ = _loc4_.interactiveElements[int(_loc7_)];
               if(_loc8_.elementId == param1.elementId)
               {
                  _loc6_ = true;
                  _loc4_.interactiveElements[int(_loc7_)] = param1;
                  break;
               }
            }
            if(!_loc6_)
            {
               _loc4_.interactiveElements.push(param1);
            }
         }
         var _loc5_:MapPoint = Atouin.getInstance().getIdentifiedElementPosition(param1.elementId);
         if(!_loc3_.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            _loc3_.addEventListener(MouseEvent.MOUSE_OVER,this.over,false,0,true);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.out,false,0,true);
            _loc3_.addEventListener(MouseEvent.CLICK,this.click,false,0,true);
            _log.debug("Add interaction for element " + param1.elementId + " on cell " + _loc5_.cellId + " with " + (param1.enabledSkills?param1.enabledSkills.length:0) + " skill actifs");
         }
         if(_loc3_ is Sprite)
         {
            (_loc3_ as Sprite).useHandCursor = true;
            (_loc3_ as Sprite).buttonMode = true;
         }
         this._ie[_loc3_] = 
            {
               "element":param1,
               "position":_loc5_,
               "firstSkill":param2
            };
      }
      
      private function removeInteractive(param1:InteractiveElement) : void {
         var _loc2_:InteractiveObject = Atouin.getInstance().getIdentifiedElement(param1.elementId);
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,this.over);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,this.out);
            _loc2_.removeEventListener(MouseEvent.CLICK,this.click);
            if(_loc2_ is Sprite)
            {
               (_loc2_ as Sprite).useHandCursor = false;
               (_loc2_ as Sprite).buttonMode = false;
            }
         }
         if(currentlyHighlighted == _loc2_ as Sprite)
         {
            this.resetInteractiveApparence();
         }
         delete this._ie[[_loc2_]];
      }
      
      private function updateStatedElement(param1:StatedElement, param2:Boolean=false) : void {
         var _loc5_:Interactive = null;
         var _loc3_:InteractiveObject = Atouin.getInstance().getIdentifiedElement(param1.elementId);
         if(!_loc3_)
         {
            _log.error("Unknown identified element " + param1.elementId + "; unable to change its state to " + param1.elementState + " !");
            return;
         }
         var _loc4_:TiphonSprite = _loc3_ is DisplayObjectContainer?this.findTiphonSprite(_loc3_ as DisplayObjectContainer):null;
         if(!_loc4_)
         {
            _log.warn("Unable to find an animated element for the stated element " + param1.elementId + " on cell " + param1.elementCellId + ", this element is probably invisible or is not configured as an animated element.");
            return;
         }
         if(param1.elementId == this._currentUsedElementId)
         {
            this._usingInteractive = true;
            this.resetInteractiveApparence();
         }
         if((this._ie[_loc3_]) && (this._ie[_loc3_].element) && this._ie[_loc3_].element.elementId == param1.elementId)
         {
            _loc5_ = Interactive.getInteractiveById(this._ie[_loc3_].element.elementTypeId);
            if((_loc5_) && _loc5_.actionId == COLLECTABLE_INTERACTIVE_ACTION_ID)
            {
               this._collectableSpritesToBeStopped[_loc4_] = null;
            }
            else
            {
               this._statedElementsTargetAnimation[_loc4_] = 
                  {
                     "elemId":param1.elementId,
                     "animation":"AnimState" + param1.elementState
                  };
               _loc4_.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onAnimRendered);
            }
         }
         else
         {
            delete this._collectableSpritesToBeStopped[[_loc4_]];
         }
         _loc4_.setAnimationAndDirection("AnimState" + param1.elementState,0,param2);
      }
      
      private function findTiphonSprite(param1:DisplayObjectContainer) : TiphonSprite {
         var _loc3_:DisplayObject = null;
         if(param1 is TiphonSprite)
         {
            return param1 as TiphonSprite;
         }
         if(!param1.numChildren)
         {
            return null;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            if(_loc3_ is TiphonSprite)
            {
               return _loc3_ as TiphonSprite;
            }
            if(_loc3_ is DisplayObjectContainer)
            {
               return this.findTiphonSprite(_loc3_ as DisplayObjectContainer);
            }
            _loc2_++;
         }
         return null;
      }
      
      private function highlightInteractiveApparence(param1:Sprite, param2:int, param3:Boolean=true) : void {
         var _loc5_:LinkedCursorData = null;
         var _loc4_:Object = this._ie[param1];
         if(!_loc4_)
         {
            return;
         }
         if(currentlyHighlighted != null)
         {
            this.resetInteractiveApparence(false);
         }
         if(param1.getChildAt(0) is TiphonSprite)
         {
            FiltersManager.getInstance().addEffect((param1.getChildAt(0) as TiphonSprite).rawAnimation,LUMINOSITY_EFFECTS);
         }
         else
         {
            FiltersManager.getInstance().addEffect(param1,LUMINOSITY_EFFECTS);
         }
         if(MapDisplayManager.getInstance().isBoundingBox(_loc4_.element.elementId))
         {
            param1.alpha = ALPHA_MODIFICATOR;
         }
         if(PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING && !PerformanceManager.optimize)
         {
            _loc5_ = new LinkedCursorData();
            _loc5_.sprite = getCursor(Skill.getSkillById(param2).cursor,param3);
            Mouse.hide();
            _loc5_.offset = INTERACTIVE_CURSOR_OFFSET;
            LinkedCursorSpriteManager.getInstance().addItem(INTERACTIVE_CURSOR_NAME,_loc5_);
         }
         currentlyHighlighted = param1;
      }
      
      private function resetInteractiveApparence(param1:Boolean=true) : void {
         if(currentlyHighlighted == null)
         {
            return;
         }
         if((param1) && currentlyHighlighted.getChildAt(0) is TiphonSprite)
         {
            FiltersManager.getInstance().removeEffect((currentlyHighlighted.getChildAt(0) as TiphonSprite).rawAnimation,LUMINOSITY_EFFECTS);
         }
         else
         {
            if(param1)
            {
               FiltersManager.getInstance().removeEffect(currentlyHighlighted,LUMINOSITY_EFFECTS);
            }
         }
         if(param1)
         {
            LinkedCursorSpriteManager.getInstance().removeItem(INTERACTIVE_CURSOR_NAME);
            Mouse.show();
         }
         var _loc2_:Object = this._ie[currentlyHighlighted];
         if(!_loc2_)
         {
            return;
         }
         if(MapDisplayManager.getInstance().isBoundingBox(_loc2_.element.elementId))
         {
            currentlyHighlighted.alpha = 0;
            currentlyHighlighted = null;
         }
      }
      
      private function over(param1:MouseEvent) : void {
         if(!this.roleplayWorldFrame || !this.roleplayContextFrame.hasWorldInteraction)
         {
            return;
         }
         var _loc2_:Object = this._ie[param1.target as Sprite];
         Kernel.getWorker().process(new InteractiveElementMouseOverMessage(_loc2_.element,param1.target));
      }
      
      private function out(param1:Object) : void {
         var _loc2_:Object = this._ie[param1.target as Sprite];
         if(_loc2_)
         {
            Kernel.getWorker().process(new InteractiveElementMouseOutMessage(_loc2_.element));
         }
      }
      
      private function click(param1:MouseEvent) : void {
         var _loc5_:String = null;
         var _loc6_:InteractiveElementSkill = null;
         var _loc7_:JobsApi = null;
         var _loc8_:Skill = null;
         var _loc9_:Array = null;
         var _loc10_:InteractiveElementSkill = null;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:Object = null;
         var _loc14_:Object = null;
         var _loc15_:KnownJob = null;
         var _loc16_:* = 0;
         var _loc17_:WeaponWrapper = null;
         var _loc18_:Job = null;
         var _loc19_:* = false;
         var _loc20_:Object = null;
         if(!this.roleplayWorldFrame || !this.roleplayContextFrame.hasWorldInteraction)
         {
            return;
         }
         TooltipManager.hide();
         var _loc2_:Object = this._ie[param1.target as Sprite];
         var _loc3_:Interactive = null;
         if(_loc2_.element.elementTypeId > 0)
         {
            _loc3_ = Interactive.getInteractiveById(_loc2_.element.elementTypeId);
         }
         var _loc4_:Array = [];
         for each (_loc6_ in _loc2_.element.enabledSkills)
         {
            if(_loc6_ is InteractiveElementNamedSkill)
            {
               _loc5_ = SkillName.getSkillNameById((_loc6_ as InteractiveElementNamedSkill).nameId).name;
            }
            else
            {
               _loc5_ = Skill.getSkillById(_loc6_.skillId).name;
            }
            _loc4_.push(
               {
                  "id":_loc6_.skillId,
                  "instanceId":_loc6_.skillInstanceUid,
                  "name":_loc5_,
                  "enabled":true
               });
         }
         _loc7_ = new JobsApi();
         _loc9_ = new Array();
         for each (_loc10_ in _loc2_.element.disabledSkills)
         {
            if(_loc10_ is InteractiveElementNamedSkill)
            {
               _loc5_ = SkillName.getSkillNameById((_loc10_ as InteractiveElementNamedSkill).nameId).name;
            }
            else
            {
               _loc5_ = Skill.getSkillById(_loc10_.skillId).name;
            }
            _loc8_ = Skill.getSkillById(_loc10_.skillId);
            _loc5_ = _loc8_.name;
            if(_loc8_.parentJobId != 1)
            {
               _loc15_ = _loc7_.getKnownJob(_loc8_.parentJobId);
               if(_loc15_ == null)
               {
                  _loc14_ = new Object();
                  _loc14_.job = _loc8_.parentJob.name;
                  _loc14_.jobId = _loc8_.parentJob.id;
                  _loc14_.type = "job";
                  _loc14_.value = [_loc8_.parentJob.name];
               }
               else
               {
                  _loc16_ = _loc15_.jobExperience.jobLevel;
                  if(_loc16_ < _loc8_.levelMin)
                  {
                     _loc14_ = new Object();
                     _loc14_.job = _loc8_.parentJob.name;
                     _loc14_.jobId = _loc8_.parentJob.id;
                     _loc14_.type = "level";
                     _loc14_.value = [_loc8_.parentJob.name,_loc8_.levelMin,_loc16_];
                  }
                  else
                  {
                     _loc17_ = PlayedCharacterApi.getWeapon();
                     _loc18_ = _loc8_.parentJob;
                     if(_loc17_ == null || _loc18_.toolIds.indexOf(_loc17_.id) == -1)
                     {
                        _loc14_ = new Object();
                        _loc14_.job = _loc8_.parentJob.name;
                        _loc14_.jobId = _loc8_.parentJob.id;
                        _loc14_.type = "tool";
                        _loc14_.value = [_loc8_.parentJob.name];
                     }
                  }
               }
               if(_loc14_ != null)
               {
                  _loc19_ = false;
                  for each (_loc20_ in _loc9_)
                  {
                     if(_loc20_.jobId == _loc14_.jobId)
                     {
                        _loc19_ = true;
                        break;
                     }
                  }
                  if(!_loc19_)
                  {
                     _loc9_.push(_loc14_);
                  }
               }
               _loc4_.push(
                  {
                     "id":_loc10_.skillId,
                     "instanceId":_loc10_.skillInstanceUid,
                     "name":_loc5_,
                     "enabled":false
                  });
            }
         }
         _loc11_ = 0;
         for each (_loc13_ in _loc4_)
         {
            if(_loc13_.enabled)
            {
               _loc12_ = _loc4_.indexOf(_loc13_);
               _loc11_++;
            }
         }
         if(_loc11_ == 1)
         {
            this.skillClicked(_loc2_,_loc4_[_loc12_].instanceId);
            return;
         }
         if(_loc11_ > 0 && _loc4_.length > 1)
         {
            this._modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            this._modContextMenu.createContextMenu(MenusFactory.create(_loc4_,"skill",[_loc2_,_loc3_]));
         }
         if(_loc11_ == 0)
         {
            this.showInteractiveElementNotification(_loc9_);
         }
      }
      
      private function showInteractiveElementNotification(param1:Array) : void {
         var _loc2_:String = null;
         var _loc3_:* = false;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Npc = null;
         var _loc10_:Point = null;
         var _loc11_:MapApi = null;
         var _loc12_:String = null;
         var _loc13_:uint = 0;
         if(param1.length > 0)
         {
            _loc2_ = "";
            _loc3_ = false;
            _loc6_ = this.getJobKnown(param1);
            if(_loc6_.length > 0)
            {
               _loc7_ = "";
               _loc8_ = "";
               for each (_loc4_ in _loc6_)
               {
                  if(_loc4_.type == "level")
                  {
                     _loc8_ = _loc8_ + (_loc6_.length > 1?"<li>":"");
                     _loc8_ = _loc8_ + I18n.getUiText("ui.skill.levelLowJob",_loc4_.value);
                     _loc8_ = _loc8_ + (_loc6_.length > 1?"</li>":"");
                  }
                  else
                  {
                     if(_loc4_.type == "tool")
                     {
                        _loc7_ = _loc7_ + (_loc6_.length > 1?"<li>":"");
                        _loc7_ = _loc7_ + _loc4_.value[0];
                        _loc7_ = _loc7_ + (_loc6_.length > 1?"</li>":"");
                     }
                  }
               }
               if(_loc8_ != "")
               {
                  _loc2_ = _loc2_ + I18n.getUiText("ui.skill.levelLow",[(_loc6_.length > 1?"<ul>":"") + _loc8_ + (_loc6_.length > 1?"</ul>":".")]);
               }
               if(_loc7_ != "")
               {
                  _loc2_ = _loc2_ + I18n.getUiText("ui.skill.toolNeeded",[(_loc6_.length > 1?"<ul>":"") + _loc7_ + (_loc6_.length > 1?"</ul>":".")]);
               }
            }
            else
            {
               _loc11_ = new MapApi();
               if(_loc11_.isInIncarnam())
               {
                  _loc9_ = Npc.getNpcById(849);
                  _loc10_ = _loc11_.getMapCoords(80218116);
               }
               else
               {
                  _loc9_ = Npc.getNpcById(601);
                  _loc10_ = _loc11_.getMapCoords(83889152);
               }
               _loc12_ = "";
               for each (_loc4_ in param1)
               {
                  _loc12_ = _loc12_ + ((param1.length > 1?"<li>":"") + _loc4_.value[0] + (param1.length > 1?"</li>":""));
               }
               _loc2_ = I18n.getUiText("ui.skill.jobNotKnown",[(param1.length > 1?"<ul>":"") + _loc12_ + (param1.length > 1?"</ul>":".")]);
               _loc2_ = _loc2_ + "\n";
               _loc2_ = _loc2_ + I18n.getUiText("ui.npc.learnJobs",[_loc9_.name,_loc10_.x,_loc10_.y]);
               _loc5_ = _loc9_.name;
               _loc3_ = true;
            }
            if(_loc2_ != "")
            {
               _loc13_ = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.skill.disabled"),_loc2_,NotificationTypeEnum.INFORMATION,"interactiveElementDisabled");
               if(_loc3_)
               {
                  NotificationManager.getInstance().addButtonToNotification(_loc13_,I18n.getUiText("ui.npc.location"),"AddMapFlag",["flag_srv" + CompassTypeEnum.COMPASS_TYPE_SIMPLE + "_job",_loc5_ + " (" + _loc10_.x + "," + _loc10_.y + ")",PlayedCharacterManager.getInstance().currentWorldMap.id,_loc10_.x,_loc10_.y,5605376,false,true],false,150,0,"hook");
               }
               NotificationManager.getInstance().addTimerToNotification(_loc13_,30,true);
               NotificationManager.getInstance().sendNotification(_loc13_);
            }
         }
      }
      
      private function getJobKnown(param1:Array) : Array {
         var _loc3_:Object = null;
         var _loc2_:Array = new Array();
         for each (_loc3_ in param1)
         {
            if(_loc3_.type != "job")
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function formateInteractiveElementProblem(param1:String, param2:Array) : String {
         switch(param1)
         {
            case "job":
               return I18n.getUiText("ui.skill.jobNotKnown",param2);
            case "level":
               return I18n.getUiText("ui.skill.levelLow",param2);
            case "tool":
               return I18n.getUiText("ui.skill.toolNeeded",param2);
            default:
               return null;
         }
      }
      
      private function skillClicked(param1:Object, param2:int) : void {
         var _loc3_:InteractiveElementActivationMessage = new InteractiveElementActivationMessage(param1.element,param1.position,param2);
         Kernel.getWorker().process(_loc3_);
      }
      
      private function interactiveUsageFinished(param1:int, param2:uint, param3:uint) : void {
         var _loc4_:InteractiveElementActivationMessage = null;
         if(param1 == PlayedCharacterManager.getInstance().id)
         {
            Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
            if(this.roleplayWorldFrame)
            {
               this.roleplayWorldFrame.cellClickEnabled = true;
            }
            this._usingInteractive = false;
            this._currentUsedElementId = -1;
            if(this._nextInteractiveUsed)
            {
               _loc4_ = new InteractiveElementActivationMessage(this._nextInteractiveUsed.ie,this._nextInteractiveUsed.position,this._nextInteractiveUsed.skillInstanceId);
               this._nextInteractiveUsed = null;
               Kernel.getWorker().process(_loc4_);
            }
         }
      }
      
      private function onAnimRendered(param1:TiphonEvent) : void {
         var _loc2_:TiphonSprite = param1.currentTarget as TiphonSprite;
         if(param1.animationType == this._statedElementsTargetAnimation[_loc2_].animation)
         {
            _loc2_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onAnimRendered);
            if(this._statedElementsTargetAnimation[_loc2_].elemId == this._currentUsedElementId)
            {
               this._usingInteractive = false;
               this._currentUsedElementId = -1;
            }
            if((_loc2_.getBounds(StageShareManager.stage).contains(StageShareManager.stage.mouseX,StageShareManager.stage.mouseY)) && (this._ie[currentlyHighlighted]) && this._ie[currentlyHighlighted].element.elementId == this._statedElementsTargetAnimation[_loc2_].elemId)
            {
               Kernel.getWorker().process(new InteractiveElementMouseOverMessage(this._ie[currentlyHighlighted].element,currentlyHighlighted));
            }
            delete this._statedElementsTargetAnimation[[_loc2_]];
         }
      }
   }
}
