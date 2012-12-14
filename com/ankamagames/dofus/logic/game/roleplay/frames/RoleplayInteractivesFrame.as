package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.interactives.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.jobs.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.roleplay.messages.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.messages.game.interactive.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.sequence.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;

    public class RoleplayInteractivesFrame extends Object implements Frame
    {
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
        private var dirmov:uint = 666;
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
        private static const INTERACTIVE_CURSOR_OFFSET:Point = new Point(0, 0);
        private static const INTERACTIVE_CURSOR_NAME:String = "interactiveCursor";
        private static const LUMINOSITY_FACTOR:Number = 1.2;
        private static const LUMINOSITY_EFFECTS:ColorMatrixFilter = new ColorMatrixFilter([LUMINOSITY_FACTOR, 0, 0, 0, 0, 0, LUMINOSITY_FACTOR, 0, 0, 0, 0, 0, LUMINOSITY_FACTOR, 0, 0, 0, 0, 0, 1, 0]);
        private static const ALPHA_MODIFICATOR:Number = 0.2;
        private static const COLLECTABLE_COLLECTING_STATE_ID:uint = 2;
        private static const COLLECTABLE_CUT_STATE_ID:uint = 1;
        private static const COLLECTABLE_INTERACTIVE_ACTION_ID:uint = 1;
        public static var currentlyHighlighted:Sprite;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayInteractivesFrame));

        public function RoleplayInteractivesFrame()
        {
            this._ie = new Dictionary(true);
            this._currentUsages = new Array();
            this._entities = new Dictionary();
            this._interactiveActionTimers = new Dictionary(true);
            this._collectableSpritesToBeStopped = new Dictionary(true);
            this._modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            if (!cursorClassList)
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
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGH;
        }// end function

        private function get roleplayContextFrame() : RoleplayContextFrame
        {
            return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
        }// end function

        private function get roleplayWorldFrame() : RoleplayWorldFrame
        {
            return Kernel.getWorker().getFrame(RoleplayWorldFrame) as RoleplayWorldFrame;
        }// end function

        public function get usingInteractive() : Boolean
        {
            return this._usingInteractive;
        }// end function

        public function get nextInteractiveUsed() : Object
        {
            return this._nextInteractiveUsed;
        }// end function

        public function set nextInteractiveUsed(param1:Object) : void
        {
            this._nextInteractiveUsed = param1;
            return;
        }// end function

        public function get worldInteractionIsEnable() : Boolean
        {
            return this._enableWorldInteraction;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var imumsg:InteractiveMapUpdateMessage;
            var ieumsg:InteractiveElementUpdatedMessage;
            var iumsg:InteractiveUsedMessage;
            var worldPos:MapPoint;
            var user:IEntity;
            var smumsg:StatedMapUpdateMessage;
            var seumsg:StatedElementUpdatedMessage;
            var moumsg:MapObstacleUpdateMessage;
            var iuemsg:InteractiveUseEndedMessage;
            var iemimsg:InteractiveElementMouseOverMessage;
            var iel:Object;
            var ie:InteractiveElement;
            var useAnimation:String;
            var useDirection:uint;
            var playerPos:MapPoint;
            var availableDirections:Array;
            var k:int;
            var tiphonSprite:TiphonSprite;
            var currentSpriteAnimation:String;
            var t:Timer;
            var fct:Function;
            var seq:SerialSequencer;
            var sprite:TiphonSprite;
            var rwf:RoleplayWorldFrame;
            var se:StatedElement;
            var mo:MapObstacle;
            var msg:* = param1;
            switch(true)
            {
                case msg is InteractiveMapUpdateMessage:
                {
                    imumsg = msg as InteractiveMapUpdateMessage;
                    this.clear();
                    var _loc_3:* = 0;
                    var _loc_4:* = imumsg.interactiveElements;
                    while (_loc_4 in _loc_3)
                    {
                        
                        ie = _loc_4[_loc_3];
                        if (ie.enabledSkills.length)
                        {
                            this.registerInteractive(ie, ie.enabledSkills[0].skillId);
                            continue;
                        }
                        if (ie.disabledSkills.length)
                        {
                            this.registerInteractive(ie, ie.disabledSkills[0].skillId);
                        }
                    }
                    return true;
                }
                case msg is InteractiveElementUpdatedMessage:
                {
                    ieumsg = msg as InteractiveElementUpdatedMessage;
                    if (ieumsg.interactiveElement.enabledSkills.length)
                    {
                        this.registerInteractive(ieumsg.interactiveElement, ieumsg.interactiveElement.enabledSkills[0].skillId);
                    }
                    else if (ieumsg.interactiveElement.disabledSkills.length)
                    {
                        this.registerInteractive(ieumsg.interactiveElement, ieumsg.interactiveElement.disabledSkills[0].skillId);
                    }
                    return true;
                }
                case msg is InteractiveUsedMessage:
                {
                    iumsg = msg as InteractiveUsedMessage;
                    worldPos = Atouin.getInstance().getIdentifiedElementPosition(iumsg.elemId);
                    user = DofusEntities.getEntity(iumsg.entityId);
                    if (user is IAnimated)
                    {
                        useAnimation = Skill.getSkillById(iumsg.skillId).useAnimation;
                        playerPos = (user as IMovable).position;
                        if (playerPos.x == worldPos.x && playerPos.y == worldPos.y)
                        {
                            useDirection = (user as TiphonSprite).getDirection();
                        }
                        else
                        {
                            useDirection = (user as IMovable).position.advancedOrientationTo(worldPos, true);
                        }
                        availableDirections = TiphonSprite(user).getAvaibleDirection(useAnimation);
                        if (availableDirections[5])
                        {
                            availableDirections[7] = true;
                        }
                        if (availableDirections[1])
                        {
                            availableDirections[3] = true;
                        }
                        if (availableDirections[7])
                        {
                            availableDirections[5] = true;
                        }
                        if (availableDirections[3])
                        {
                            availableDirections[1] = true;
                        }
                        if (availableDirections[useDirection] == false)
                        {
                            k;
                            while (k < 8)
                            {
                                
                                if (useDirection == 7)
                                {
                                    useDirection;
                                }
                                else
                                {
                                    useDirection = (useDirection + 1);
                                }
                                if (availableDirections[useDirection] == true)
                                {
                                    break;
                                }
                                k = (k + 1);
                            }
                        }
                        if (iumsg.duration > 0)
                        {
                            tiphonSprite = user as TiphonSprite;
                            tiphonSprite.setAnimationAndDirection(useAnimation, useDirection);
                            currentSpriteAnimation = tiphonSprite.getAnimation();
                            if (!this._interactiveActionTimers[user])
                            {
                                this._interactiveActionTimers[user] = new Timer(1, 1);
                            }
                            t = this._interactiveActionTimers[user];
                            t.delay = iumsg.duration * 100;
                            fct = function () : void
            {
                t.removeEventListener(TimerEvent.TIMER, fct);
                if (currentSpriteAnimation.indexOf((user as TiphonSprite).getAnimation()) != -1)
                {
                    (user as IAnimated).setAnimation(AnimationEnum.ANIM_STATIQUE);
                }
                return;
            }// end function
            ;
                            if (!t.hasEventListener(TimerEvent.TIMER))
                            {
                                t.addEventListener(TimerEvent.TIMER, fct);
                            }
                            t.start();
                        }
                        else
                        {
                            seq = new SerialSequencer();
                            sprite = user as TiphonSprite;
                            seq.addStep(new SetDirectionStep(sprite, useDirection));
                            seq.addStep(new PlayAnimationStep(sprite, useAnimation));
                            seq.start();
                        }
                    }
                    if (iumsg.duration > 0)
                    {
                        if (PlayedCharacterManager.getInstance().id == iumsg.entityId)
                        {
                            this._usingInteractive = true;
                            this.resetInteractiveApparence(false);
                            rwf = this.roleplayWorldFrame;
                            if (rwf)
                            {
                                rwf.cellClickEnabled = false;
                            }
                        }
                        this._entities[iumsg.elemId] = iumsg.entityId;
                    }
                    return true;
                }
                case msg is StatedMapUpdateMessage:
                {
                    smumsg = msg as StatedMapUpdateMessage;
                    var _loc_3:* = 0;
                    var _loc_4:* = smumsg.statedElements;
                    while (_loc_4 in _loc_3)
                    {
                        
                        se = _loc_4[_loc_3];
                        this.updateStatedElement(se);
                    }
                    return true;
                }
                case msg is StatedElementUpdatedMessage:
                {
                    seumsg = msg as StatedElementUpdatedMessage;
                    this.updateStatedElement(seumsg.statedElement);
                    return true;
                }
                case msg is MapObstacleUpdateMessage:
                {
                    moumsg = msg as MapObstacleUpdateMessage;
                    var _loc_3:* = 0;
                    var _loc_4:* = moumsg.obstacles;
                    while (_loc_4 in _loc_3)
                    {
                        
                        mo = _loc_4[_loc_3];
                        InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId, mo.state == MapObstacleStateEnum.OBSTACLE_OPENED);
                    }
                    return true;
                }
                case msg is InteractiveUseEndedMessage:
                {
                    iuemsg = InteractiveUseEndedMessage(msg);
                    this.interactiveUsageFinished(this._entities[iuemsg.elemId], iuemsg.elemId, iuemsg.skillId);
                    delete this._entities[iuemsg.elemId];
                    return true;
                }
                case msg is InteractiveElementMouseOverMessage:
                {
                    iemimsg = msg as InteractiveElementMouseOverMessage;
                    iel = this._ie[iemimsg.sprite];
                    this.highlightInteractiveApparence(iemimsg.sprite, iel.firstSkill, iel.element.enabledSkills.length > 0);
                    return false;
                }
                case msg is InteractiveElementMouseOutMessage:
                {
                    this.resetInteractiveApparence();
                    return false;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            for (_loc_1 in this._collectableSpritesToBeStopped)
            {
                
                _loc_2 = _loc_1 as TiphonSprite;
                if (!_loc_2)
                {
                    continue;
                }
                _loc_2.setAnimationAndDirection("AnimState" + COLLECTABLE_CUT_STATE_ID, 0);
            }
            this._collectableSpritesToBeStopped = new Dictionary(true);
            this._entities = new Dictionary();
            this._ie = new Dictionary(true);
            this._modContextMenu = null;
            this._currentUsages = new Array();
            this._nextInteractiveUsed = null;
            this._interactiveActionTimers = new Dictionary(true);
            return true;
        }// end function

        public function enableWorldInteraction(param1:Boolean) : void
        {
            this._enableWorldInteraction = param1;
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            for each (_loc_1 in this._currentUsages)
            {
                
                clearTimeout(_loc_1);
            }
            for each (_loc_2 in this._ie)
            {
                
                this.removeInteractive(_loc_2.element as InteractiveElement);
            }
            return;
        }// end function

        public function getInteractiveElementsCells() : Vector.<uint>
        {
            var _loc_2:* = null;
            var _loc_1:* = new Vector.<uint>;
            for each (_loc_2 in this._ie)
            {
                
                if (_loc_2 != null)
                {
                    _loc_1.push(_loc_2.position.cellId);
                }
            }
            return _loc_1;
        }// end function

        public function getInteractiveActionTimer(param1) : Timer
        {
            return this._interactiveActionTimers[param1];
        }// end function

        private function registerInteractive(param1:InteractiveElement, param2:int) : void
        {
            var _loc_6:* = false;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = Atouin.getInstance().getIdentifiedElement(param1.elementId);
            if (!_loc_3)
            {
                _log.error("Unknown identified element " + param1.elementId + ", unable to register it as interactive.");
                return;
            }
            var _loc_4:* = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            if (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame)
            {
                _loc_6 = false;
                for (_loc_7 in _loc_4.interactiveElements)
                {
                    
                    _loc_8 = _loc_4.interactiveElements[int(_loc_7)];
                    if (_loc_8.elementId == param1.elementId)
                    {
                        _loc_6 = true;
                        _loc_4.interactiveElements[int(_loc_7)] = param1;
                        break;
                    }
                }
                if (!_loc_6)
                {
                    _loc_4.interactiveElements.push(param1);
                }
            }
            var _loc_5:* = Atouin.getInstance().getIdentifiedElementPosition(param1.elementId);
            if (!_loc_3.hasEventListener(MouseEvent.MOUSE_OVER))
            {
                _loc_3.addEventListener(MouseEvent.MOUSE_OVER, this.over, false, 0, true);
                _loc_3.addEventListener(MouseEvent.MOUSE_OUT, this.out, false, 0, true);
                _loc_3.addEventListener(MouseEvent.CLICK, this.click, false, 0, true);
            }
            if (_loc_3 is Sprite)
            {
                (_loc_3 as Sprite).useHandCursor = true;
                (_loc_3 as Sprite).buttonMode = true;
            }
            this._ie[_loc_3] = {element:param1, position:_loc_5, firstSkill:param2};
            return;
        }// end function

        private function removeInteractive(param1:InteractiveElement) : void
        {
            var _loc_2:* = Atouin.getInstance().getIdentifiedElement(param1.elementId);
            if (_loc_2 != null)
            {
                _loc_2.removeEventListener(MouseEvent.MOUSE_OVER, this.over);
                _loc_2.removeEventListener(MouseEvent.MOUSE_OUT, this.out);
                _loc_2.removeEventListener(MouseEvent.CLICK, this.click);
            }
            delete this._ie[_loc_2];
            return;
        }// end function

        private function updateStatedElement(param1:StatedElement) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = Atouin.getInstance().getIdentifiedElement(param1.elementId);
            if (!_loc_2)
            {
                _log.error("Unknown identified element " + param1.elementId + "; unable to change its state to " + param1.elementState + " !");
                return;
            }
            var _loc_3:* = _loc_2 is DisplayObjectContainer ? (this.findTiphonSprite(_loc_2 as DisplayObjectContainer)) : (null);
            if (!_loc_3)
            {
                _log.warn("Unable to find an animated element for the stated element " + param1.elementId + " on cell " + param1.elementCellId + ", this element is probably invisible.");
                return;
            }
            _loc_3.setAnimationAndDirection("AnimState" + param1.elementState, 0);
            if (param1.elementState == COLLECTABLE_COLLECTING_STATE_ID && this._ie[_loc_2] && this._ie[_loc_2].element.elementId == param1.elementId)
            {
                _loc_4 = Interactive.getInteractiveById(this._ie[_loc_2].element.elementTypeId);
                if (!_loc_4)
                {
                    return;
                }
                if (_loc_4.actionId == COLLECTABLE_INTERACTIVE_ACTION_ID)
                {
                    this._collectableSpritesToBeStopped[_loc_3] = null;
                }
            }
            else
            {
                delete this._collectableSpritesToBeStopped[_loc_3];
            }
            return;
        }// end function

        private function findTiphonSprite(param1:DisplayObjectContainer) : TiphonSprite
        {
            var _loc_3:* = null;
            if (param1 is TiphonSprite)
            {
                return param1 as TiphonSprite;
            }
            if (!param1.numChildren)
            {
                return null;
            }
            var _loc_2:* = 0;
            while (_loc_2 < param1.numChildren)
            {
                
                _loc_3 = param1.getChildAt(_loc_2);
                if (_loc_3 is TiphonSprite)
                {
                    return _loc_3 as TiphonSprite;
                }
                if (_loc_3 is DisplayObjectContainer)
                {
                    return this.findTiphonSprite(_loc_3 as DisplayObjectContainer);
                }
                _loc_2 = _loc_2 + 1;
            }
            return null;
        }// end function

        private function highlightInteractiveApparence(param1:Sprite, param2:int, param3:Boolean = true) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = this._ie[param1];
            if (!this._ie[param1])
            {
                return;
            }
            if (currentlyHighlighted != null)
            {
                this.resetInteractiveApparence(false);
            }
            if (param1.getChildAt(0) is TiphonSprite)
            {
                FiltersManager.getInstance().addEffect((param1.getChildAt(0) as TiphonSprite).rawAnimation, LUMINOSITY_EFFECTS);
            }
            else
            {
                FiltersManager.getInstance().addEffect(param1, LUMINOSITY_EFFECTS);
            }
            if (MapDisplayManager.getInstance().isBoundingBox(_loc_4.element.elementId))
            {
                param1.alpha = ALPHA_MODIFICATOR;
            }
            if (PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING && !PerformanceManager.optimize)
            {
                _loc_5 = new LinkedCursorData();
                _loc_5.sprite = getCursor(Skill.getSkillById(param2).cursor, param3);
                Mouse.hide();
                _loc_5.offset = INTERACTIVE_CURSOR_OFFSET;
                LinkedCursorSpriteManager.getInstance().addItem(INTERACTIVE_CURSOR_NAME, _loc_5);
            }
            currentlyHighlighted = param1;
            return;
        }// end function

        private function resetInteractiveApparence(param1:Boolean = true) : void
        {
            if (currentlyHighlighted == null)
            {
                return;
            }
            var _loc_2:* = this._ie[currentlyHighlighted];
            if (!_loc_2)
            {
                return;
            }
            if (param1 && currentlyHighlighted.getChildAt(0) is TiphonSprite)
            {
                FiltersManager.getInstance().removeEffect((currentlyHighlighted.getChildAt(0) as TiphonSprite).rawAnimation, LUMINOSITY_EFFECTS);
            }
            else if (param1)
            {
                FiltersManager.getInstance().removeEffect(currentlyHighlighted, LUMINOSITY_EFFECTS);
            }
            if (MapDisplayManager.getInstance().isBoundingBox(_loc_2.element.elementId))
            {
                currentlyHighlighted.alpha = 0;
                currentlyHighlighted = null;
            }
            if (param1)
            {
                LinkedCursorSpriteManager.getInstance().removeItem(INTERACTIVE_CURSOR_NAME);
                Mouse.show();
            }
            return;
        }// end function

        private function over(event:MouseEvent) : void
        {
            if (!this.roleplayWorldFrame || !this.roleplayContextFrame.hasWorldInteraction)
            {
                return;
            }
            var _loc_2:* = this._ie[event.target as Sprite];
            Kernel.getWorker().process(new InteractiveElementMouseOverMessage(_loc_2.element, event.target));
            return;
        }// end function

        private function out(param1:Object) : void
        {
            var _loc_2:* = this._ie[param1.target as Sprite];
            if (_loc_2)
            {
                Kernel.getWorker().process(new InteractiveElementMouseOutMessage(_loc_2.element));
            }
            return;
        }// end function

        private function click(event:MouseEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = false;
            var _loc_20:* = null;
            if (!this.roleplayWorldFrame || !this.roleplayContextFrame.hasWorldInteraction)
            {
                return;
            }
            TooltipManager.hide();
            var _loc_2:* = this._ie[event.target as Sprite];
            var _loc_3:* = null;
            if (_loc_2.element.elementTypeId > 0)
            {
                _loc_3 = Interactive.getInteractiveById(_loc_2.element.elementTypeId);
            }
            var _loc_4:* = [];
            for each (_loc_6 in _loc_2.element.enabledSkills)
            {
                
                if (_loc_6 is InteractiveElementNamedSkill)
                {
                    _loc_5 = SkillName.getSkillNameById((_loc_6 as InteractiveElementNamedSkill).nameId).name;
                }
                else
                {
                    _loc_5 = Skill.getSkillById(_loc_6.skillId).name;
                }
                _loc_4.push({id:_loc_6.skillId, instanceId:_loc_6.skillInstanceUid, name:_loc_5, enabled:true});
            }
            _loc_7 = new JobsApi();
            _loc_9 = new Array();
            for each (_loc_10 in _loc_2.element.disabledSkills)
            {
                
                if (_loc_10 is InteractiveElementNamedSkill)
                {
                    _loc_5 = SkillName.getSkillNameById((_loc_10 as InteractiveElementNamedSkill).nameId).name;
                }
                else
                {
                    _loc_5 = Skill.getSkillById(_loc_10.skillId).name;
                }
                _loc_8 = Skill.getSkillById(_loc_10.skillId);
                _loc_5 = _loc_8.name;
                if (_loc_8.parentJobId == 1)
                {
                    continue;
                }
                _loc_15 = _loc_7.getKnownJob(_loc_8.parentJobId);
                if (_loc_15 == null)
                {
                    _loc_14 = new Object();
                    _loc_14.job = _loc_8.parentJob.name;
                    _loc_14.jobId = _loc_8.parentJob.id;
                    _loc_14.type = "job";
                    _loc_14.value = [_loc_8.parentJob.name];
                }
                else
                {
                    _loc_16 = _loc_15.jobExperience.jobLevel;
                    if (_loc_16 < _loc_8.levelMin)
                    {
                        _loc_14 = new Object();
                        _loc_14.job = _loc_8.parentJob.name;
                        _loc_14.jobId = _loc_8.parentJob.id;
                        _loc_14.type = "level";
                        _loc_14.value = [_loc_8.parentJob.name, _loc_8.levelMin, _loc_16];
                    }
                    else
                    {
                        _loc_17 = PlayedCharacterApi.getWeapon();
                        _loc_18 = _loc_8.parentJob;
                        if (_loc_17 == null || _loc_18.toolIds.indexOf(_loc_17.id) == -1)
                        {
                            _loc_14 = new Object();
                            _loc_14.job = _loc_8.parentJob.name;
                            _loc_14.jobId = _loc_8.parentJob.id;
                            _loc_14.type = "tool";
                            _loc_14.value = [_loc_8.parentJob.name];
                        }
                    }
                }
                if (_loc_14 != null)
                {
                    _loc_19 = false;
                    for each (_loc_20 in _loc_9)
                    {
                        
                        if (_loc_20.jobId == _loc_14.jobId)
                        {
                            _loc_19 = true;
                            break;
                        }
                    }
                    if (!_loc_19)
                    {
                        _loc_9.push(_loc_14);
                    }
                }
                _loc_4.push({id:_loc_10.skillId, instanceId:_loc_10.skillInstanceUid, name:_loc_5, enabled:false});
            }
            _loc_11 = 0;
            for each (_loc_13 in _loc_4)
            {
                
                if (_loc_13.enabled)
                {
                    _loc_12 = _loc_4.indexOf(_loc_13);
                    _loc_11++;
                }
            }
            if (_loc_11 == 1)
            {
                this.skillClicked(_loc_2, _loc_4[_loc_12].instanceId);
                return;
            }
            if (_loc_11 > 0 && _loc_4.length > 1)
            {
                this._modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                this._modContextMenu.createContextMenu(MenusFactory.create(_loc_4, "skill", [_loc_2, _loc_3]));
            }
            if (_loc_11 == 0)
            {
                this.showInteractiveElementNotification(_loc_9);
            }
            return;
        }// end function

        private function showInteractiveElementNotification(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            if (param1.length > 0)
            {
                _loc_2 = "";
                _loc_3 = false;
                _loc_6 = this.getJobKnown(param1);
                if (_loc_6.length > 0)
                {
                    _loc_7 = "";
                    _loc_8 = "";
                    for each (_loc_4 in _loc_6)
                    {
                        
                        if (_loc_4.type == "level")
                        {
                            _loc_8 = _loc_8 + (_loc_6.length > 1 ? ("<li>") : (""));
                            _loc_8 = _loc_8 + I18n.getUiText("ui.skill.levelLowJob", _loc_4.value);
                            _loc_8 = _loc_8 + (_loc_6.length > 1 ? ("</li>") : (""));
                            continue;
                        }
                        if (_loc_4.type == "tool")
                        {
                            _loc_7 = _loc_7 + (_loc_6.length > 1 ? ("<li>") : (""));
                            _loc_7 = _loc_7 + _loc_4.value[0];
                            _loc_7 = _loc_7 + (_loc_6.length > 1 ? ("</li>") : (""));
                        }
                    }
                    if (_loc_8 != "")
                    {
                        _loc_2 = _loc_2 + I18n.getUiText("ui.skill.levelLow", [(_loc_6.length > 1 ? ("<ul>") : ("")) + _loc_8 + (_loc_6.length > 1 ? ("</ul>") : ("."))]);
                    }
                    if (_loc_7 != "")
                    {
                        _loc_2 = _loc_2 + I18n.getUiText("ui.skill.toolNeeded", [(_loc_6.length > 1 ? ("<ul>") : ("")) + _loc_7 + (_loc_6.length > 1 ? ("</ul>") : ("."))]);
                    }
                }
                else
                {
                    _loc_11 = new MapApi();
                    if (_loc_11.isInIncarnam())
                    {
                        _loc_9 = Npc.getNpcById(849);
                        _loc_10 = _loc_11.getMapCoords(80218116);
                    }
                    else
                    {
                        _loc_9 = Npc.getNpcById(601);
                        _loc_10 = _loc_11.getMapCoords(83889152);
                    }
                    _loc_12 = "";
                    for each (_loc_4 in param1)
                    {
                        
                        _loc_12 = _loc_12 + ((param1.length > 1 ? ("<li>") : ("")) + _loc_4.value[0] + (param1.length > 1 ? ("</li>") : ("")));
                    }
                    _loc_2 = I18n.getUiText("ui.skill.jobNotKnown", [(param1.length > 1 ? ("<ul>") : ("")) + _loc_12 + (param1.length > 1 ? ("</ul>") : ("."))]);
                    _loc_2 = _loc_2 + "\n";
                    _loc_2 = _loc_2 + I18n.getUiText("ui.npc.learnJobs", [_loc_9.name, _loc_10.x, _loc_10.y]);
                    _loc_5 = _loc_9.name;
                    _loc_3 = true;
                }
                if (_loc_2 != "")
                {
                    _loc_13 = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.skill.disabled"), _loc_2, NotificationTypeEnum.INFORMATION, "interactiveElementDisabled");
                    if (_loc_3)
                    {
                        NotificationManager.getInstance().addButtonToNotification(_loc_13, I18n.getUiText("ui.npc.location"), "AddMapFlag", ["flag_srv" + CompassTypeEnum.COMPASS_TYPE_SIMPLE + "_job", _loc_5 + " (" + _loc_10.x + "," + _loc_10.y + ")", _loc_10.x, _loc_10.y, 5605376, false, true], false, 150, 0, "hook");
                    }
                    NotificationManager.getInstance().addTimerToNotification(_loc_13, 30, true);
                    NotificationManager.getInstance().sendNotification(_loc_13);
                }
            }
            return;
        }// end function

        private function getJobKnown(param1:Array) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = new Array();
            for each (_loc_3 in param1)
            {
                
                if (_loc_3.type != "job")
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        private function formateInteractiveElementProblem(param1:String, param2:Array) : String
        {
            switch(param1)
            {
                case "job":
                {
                    return I18n.getUiText("ui.skill.jobNotKnown", param2);
                }
                case "level":
                {
                    return I18n.getUiText("ui.skill.levelLow", param2);
                }
                case "tool":
                {
                    return I18n.getUiText("ui.skill.toolNeeded", param2);
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        private function skillClicked(param1:Object, param2:int) : void
        {
            var _loc_3:* = new InteractiveElementActivationMessage(param1.element, param1.position, param2);
            Kernel.getWorker().process(_loc_3);
            return;
        }// end function

        private function interactiveUsageFinished(param1:int, param2:uint, param3:uint) : void
        {
            var _loc_4:* = null;
            if (param1 == PlayedCharacterManager.getInstance().id)
            {
                Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                if (this.roleplayWorldFrame)
                {
                    this.roleplayWorldFrame.cellClickEnabled = true;
                }
                this._usingInteractive = false;
                if (this._nextInteractiveUsed)
                {
                    _loc_4 = new InteractiveElementActivationMessage(this._nextInteractiveUsed.ie, this._nextInteractiveUsed.position, this._nextInteractiveUsed.skillInstanceId);
                    this._nextInteractiveUsed = null;
                    Kernel.getWorker().process(_loc_4);
                }
            }
            return;
        }// end function

        public static function getCursor(param1:int, param2:Boolean = true, param3:Boolean = true) : Sprite
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!param2)
            {
                if (cursorList[11])
                {
                    _loc_4 = cursorList[11];
                }
                else
                {
                    _loc_6 = cursorClassList[11];
                    if (_loc_6)
                    {
                        _loc_4 = new _loc_6;
                        cursorList[11] = _loc_4;
                    }
                }
            }
            if (cursorList[param1] && param3)
            {
                _loc_5 = cursorList[param1];
            }
            _loc_6 = cursorClassList[param1];
            if (_loc_6)
            {
                _loc_5 = new _loc_6;
                if (param3)
                {
                    cursorList[param1] = _loc_5;
                }
                _loc_5.cacheAsBitmap = true;
                if (_loc_4 != null)
                {
                    _loc_5.addChild(_loc_4);
                }
            }
            if (_loc_5)
            {
                if (_loc_4 != null)
                {
                    _loc_5.addChild(_loc_4);
                }
                else if (_loc_5.numChildren > 1)
                {
                    _loc_5.removeChildAt(0);
                }
                return _loc_5;
            }
            return new INTERACTIVE_CURSOR_0();
        }// end function

    }
}
