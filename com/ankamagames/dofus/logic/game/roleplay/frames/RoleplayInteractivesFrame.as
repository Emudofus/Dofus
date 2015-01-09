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
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.network.messages.game.interactive.InteractiveMapUpdateMessage;
    import flash.display.DisplayObject;
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
    import flash.utils.Timer;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
    import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
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
    import com.ankamagames.berilia.frames.ShortcutsFrame;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.jerakine.enum.OperatingSystem;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOutMessage;
    import com.ankamagames.jerakine.messages.Message;
    import flash.utils.clearTimeout;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import flash.display.InteractiveObject;
    import flash.events.MouseEvent;
    import com.ankamagames.dofus.datacenter.interactives.Interactive;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.tiphon.events.TiphonEvent;
    import com.ankamagames.berilia.types.data.LinkedCursorData;
    import com.ankamagames.jerakine.managers.FiltersManager;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.jerakine.managers.PerformanceManager;
    import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
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
    import com.ankamagames.berilia.factories.MenusFactory;
    import com.ankamagames.dofus.datacenter.npcs.Npc;
    import com.ankamagames.dofus.uiApi.MapApi;
    import com.ankamagames.dofus.logic.common.managers.NotificationManager;
    import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
    import com.ankamagames.dofus.network.enums.CompassTypeEnum;
    import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
    import __AS3__.vec.*;

    public class RoleplayInteractivesFrame implements Frame 
    {

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
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayInteractivesFrame));

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
        private var dirmov:uint = 666;

        public function RoleplayInteractivesFrame()
        {
            this._ie = new Dictionary(true);
            this._currentUsages = new Array();
            this._entities = new Dictionary();
            this._interactiveActionTimers = new Dictionary(true);
            this._collectableSpritesToBeStopped = new Dictionary(true);
            this._statedElementsTargetAnimation = new Dictionary(true);
            super();
            this._modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            if (!(cursorClassList))
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
            };
        }

        public static function getCursor(id:int, pEnabled:Boolean=true, pCache:Boolean=true):Sprite
        {
            var cross:Sprite;
            var cursor:Sprite;
            var cursorClass:Class;
            if (!(pEnabled))
            {
                if (cursorList[11])
                {
                    cross = cursorList[11];
                }
                else
                {
                    cursorClass = cursorClassList[11];
                    if (cursorClass)
                    {
                        cross = new (cursorClass)();
                        cursorList[11] = cross;
                    };
                };
            };
            if (((cursorList[id]) && (pCache)))
            {
                cursor = cursorList[id];
            };
            cursorClass = cursorClassList[id];
            if (cursorClass)
            {
                cursor = new (cursorClass)();
                if (pCache)
                {
                    cursorList[id] = cursor;
                };
                cursor.cacheAsBitmap = true;
                if (cross != null)
                {
                    cursor.addChild(cross);
                };
            };
            if (cursor)
            {
                if (cross != null)
                {
                    cursor.addChild(cross);
                }
                else
                {
                    if (cursor.numChildren > 1)
                    {
                        cursor.removeChildAt(0);
                    };
                };
                return (cursor);
            };
            return (new INTERACTIVE_CURSOR_0());
        }


        public function get priority():int
        {
            return (Priority.HIGH);
        }

        private function get roleplayContextFrame():RoleplayContextFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame));
        }

        private function get roleplayWorldFrame():RoleplayWorldFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayWorldFrame) as RoleplayWorldFrame));
        }

        public function get currentRequestedElementId():int
        {
            return (this._currentRequestedElementId);
        }

        public function set currentRequestedElementId(pElementId:int):void
        {
            this._currentRequestedElementId = pElementId;
        }

        public function get usingInteractive():Boolean
        {
            return (this._usingInteractive);
        }

        public function get nextInteractiveUsed():Object
        {
            return (this._nextInteractiveUsed);
        }

        public function set nextInteractiveUsed(object:Object):void
        {
            this._nextInteractiveUsed = object;
        }

        public function get worldInteractionIsEnable():Boolean
        {
            return (this._enableWorldInteraction);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var imumsg:InteractiveMapUpdateMessage;
            var mousePos:Point;
            var objectsUnder:Array;
            var o:DisplayObject;
            var ieObj:* = undefined;
            var ieumsg:InteractiveElementUpdatedMessage;
            var iumsg:InteractiveUsedMessage;
            var worldPos:MapPoint;
            var user:IEntity;
            var iuem:InteractiveUseErrorMessage;
            var smumsg:StatedMapUpdateMessage;
            var seumsg:StatedElementUpdatedMessage;
            var moumsg:MapObstacleUpdateMessage;
            var iuemsg:InteractiveUseEndedMessage;
            var iemimsg:InteractiveElementMouseOverMessage;
            var iel:Object;
            var ie:InteractiveElement;
            var useAnimation:String;
            var useDirection:uint;
            var t:Timer;
            var tiphonSprite:TiphonSprite;
            var currentSpriteAnimation:String;
            var fct:Function;
            var seq:SerialSequencer;
            var sprite:TiphonSprite;
            var rwf:RoleplayWorldFrame;
            var se:StatedElement;
            var mo:MapObstacle;
            switch (true)
            {
                case (msg is InteractiveMapUpdateMessage):
                    imumsg = (msg as InteractiveMapUpdateMessage);
                    this.clear();
                    for each (ie in imumsg.interactiveElements)
                    {
                        if (ie.enabledSkills.length)
                        {
                            this.registerInteractive(ie, ie.enabledSkills[0].skillId);
                        }
                        else
                        {
                            if (ie.disabledSkills.length)
                            {
                                this.registerInteractive(ie, ie.disabledSkills[0].skillId);
                            };
                        };
                    };
                    mousePos = new Point(StageShareManager.stage.mouseX, StageShareManager.stage.mouseY);
                    objectsUnder = StageShareManager.stage.getObjectsUnderPoint(mousePos);
                    for each (o in objectsUnder)
                    {
                        for (ieObj in this._ie)
                        {
                            if (ieObj.contains(o))
                            {
                                Kernel.getWorker().process(new InteractiveElementMouseOverMessage(this._ie[ieObj].element, ieObj));
                                return (true);
                            };
                        };
                    };
                    return (true);
                case (msg is InteractiveElementUpdatedMessage):
                    ieumsg = (msg as InteractiveElementUpdatedMessage);
                    if (ieumsg.interactiveElement.enabledSkills.length)
                    {
                        this.registerInteractive(ieumsg.interactiveElement, ieumsg.interactiveElement.enabledSkills[0].skillId);
                    }
                    else
                    {
                        if (ieumsg.interactiveElement.disabledSkills.length)
                        {
                            this.registerInteractive(ieumsg.interactiveElement, ieumsg.interactiveElement.disabledSkills[0].skillId);
                        }
                        else
                        {
                            this.removeInteractive(ieumsg.interactiveElement);
                        };
                    };
                    return (true);
                case (msg is InteractiveUsedMessage):
                    iumsg = (msg as InteractiveUsedMessage);
                    if (PlayedCharacterManager.getInstance().id == iumsg.entityId)
                    {
                        this._currentUsedElementId = iumsg.elemId;
                    };
                    if (this._currentRequestedElementId == iumsg.elemId)
                    {
                        this._currentRequestedElementId = -1;
                    };
                    worldPos = Atouin.getInstance().getIdentifiedElementPosition(iumsg.elemId);
                    user = DofusEntities.getEntity(iumsg.entityId);
                    if ((user is IAnimated))
                    {
                        useAnimation = Skill.getSkillById(iumsg.skillId).useAnimation;
                        useDirection = this.getUseDirection((user as TiphonSprite), useAnimation, worldPos);
                        if (iumsg.duration > 0)
                        {
                            if (!(this._interactiveActionTimers[user]))
                            {
                                this._interactiveActionTimers[user] = new Timer(1, 1);
                            };
                            t = this._interactiveActionTimers[user];
                            if (t.running)
                            {
                                t.stop();
                                t.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
                            };
                            tiphonSprite = (user as TiphonSprite);
                            tiphonSprite.setAnimationAndDirection(useAnimation, useDirection);
                            currentSpriteAnimation = tiphonSprite.getAnimation();
                            t.delay = (iumsg.duration * 100);
                            fct = function ():void
                            {
                                var userTs:TiphonSprite;
                                t.removeEventListener(TimerEvent.TIMER, fct);
                                if (currentSpriteAnimation.indexOf((user as TiphonSprite).getAnimation()) != -1)
                                {
                                    userTs = (user as TiphonSprite);
                                    if ((((userTs is AnimatedCharacter)) && (!((userTs.getDirection() == DirectionsEnum.DOWN)))))
                                    {
                                        (userTs as AnimatedCharacter).visibleAura = false;
                                    };
                                    userTs.setAnimation(AnimationEnum.ANIM_STATIQUE);
                                };
                            };
                            if (!(t.hasEventListener(TimerEvent.TIMER)))
                            {
                                t.addEventListener(TimerEvent.TIMER, fct);
                            };
                            t.start();
                        }
                        else
                        {
                            seq = new SerialSequencer();
                            sprite = (user as TiphonSprite);
                            seq.addStep(new SetDirectionStep(sprite, useDirection));
                            seq.addStep(new PlayAnimationStep(sprite, useAnimation));
                            seq.start();
                        };
                    };
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
                            };
                        };
                        this._entities[iumsg.elemId] = iumsg.entityId;
                    };
                    return (true);
                case (msg is InteractiveUseErrorMessage):
                    iuem = (msg as InteractiveUseErrorMessage);
                    if (iuem.elemId == this._currentRequestedElementId)
                    {
                        this._currentRequestedElementId = -1;
                    };
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.popup.impossible_action"), ChatFrame.RED_CHANNEL_ID);
                    return (true);
                case (msg is StatedMapUpdateMessage):
                    smumsg = (msg as StatedMapUpdateMessage);
                    for each (se in smumsg.statedElements)
                    {
                        this.updateStatedElement(se, true);
                    };
                    return (true);
                case (msg is StatedElementUpdatedMessage):
                    seumsg = (msg as StatedElementUpdatedMessage);
                    this.updateStatedElement(seumsg.statedElement);
                    return (true);
                case (msg is MapObstacleUpdateMessage):
                    moumsg = (msg as MapObstacleUpdateMessage);
                    for each (mo in moumsg.obstacles)
                    {
                        InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId, (mo.state == MapObstacleStateEnum.OBSTACLE_OPENED));
                    };
                    return (true);
                case (msg is InteractiveUseEndedMessage):
                    iuemsg = InteractiveUseEndedMessage(msg);
                    this.interactiveUsageFinished(this._entities[iuemsg.elemId], iuemsg.elemId, iuemsg.skillId);
                    delete this._entities[iuemsg.elemId];
                    return (true);
                case (msg is InteractiveElementMouseOverMessage):
                    if (((((!(AirScanner.isStreamingVersion())) && ((OptionManager.getOptionManager("dofus")["enableForceWalk"] == true)))) && (((ShortcutsFrame.ctrlKeyDown) || ((((SystemManager.getSingleton().os == OperatingSystem.MAC_OS)) && (ShortcutsFrame.altKeyDown)))))))
                    {
                        return (false);
                    };
                    iemimsg = (msg as InteractiveElementMouseOverMessage);
                    iel = this._ie[iemimsg.sprite];
                    if (((iel) && (iel.element)))
                    {
                        this.highlightInteractiveApparence(iemimsg.sprite, iel.firstSkill, (iel.element.enabledSkills.length > 0));
                    };
                    return (false);
                case (msg is InteractiveElementMouseOutMessage):
                    this.resetInteractiveApparence();
                    currentlyHighlighted = null;
                    return (false);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            var sprite:*;
            var ts:TiphonSprite;
            for (sprite in this._collectableSpritesToBeStopped)
            {
                ts = (sprite as TiphonSprite);
                if (!!(ts))
                {
                    ts.setAnimationAndDirection(("AnimState" + COLLECTABLE_CUT_STATE_ID), 0);
                };
            };
            this._collectableSpritesToBeStopped = new Dictionary(true);
            this._entities = new Dictionary();
            this._ie = new Dictionary(true);
            this._modContextMenu = null;
            this._currentUsages = new Array();
            this._nextInteractiveUsed = null;
            this._interactiveActionTimers = new Dictionary(true);
            return (true);
        }

        public function enableWorldInteraction(pEnable:Boolean):void
        {
            this._enableWorldInteraction = pEnable;
        }

        public function clear():void
        {
            var timeout:int;
            var obj:Object;
            for each (timeout in this._currentUsages)
            {
                clearTimeout(timeout);
            };
            for each (obj in this._ie)
            {
                this.removeInteractive((obj.element as InteractiveElement));
            };
        }

        public function getInteractiveElementsCells():Vector.<uint>
        {
            var cellObj:Object;
            var cells:Vector.<uint> = new Vector.<uint>();
            for each (cellObj in this._ie)
            {
                if (cellObj != null)
                {
                    cells.push(cellObj.position.cellId);
                };
            };
            return (cells);
        }

        public function getInteractiveActionTimer(pUser:*):Timer
        {
            return (this._interactiveActionTimers[pUser]);
        }

        public function isElementChangingState(pElementId:int):Boolean
        {
            var animData:Object;
            var changing:Boolean;
            for each (animData in this._statedElementsTargetAnimation)
            {
                if (animData.elemId == pElementId)
                {
                    changing = true;
                    break;
                };
            };
            return (changing);
        }

        public function getUseDirection(user:TiphonSprite, useAnimation:String, worldPos:MapPoint):uint
        {
            var useDirection:uint;
            var k:int;
            var playerPos:MapPoint = (user as IMovable).position;
            if ((((playerPos.x == worldPos.x)) && ((playerPos.y == worldPos.y))))
            {
                useDirection = user.getDirection();
            }
            else
            {
                useDirection = (user as IMovable).position.advancedOrientationTo(worldPos, true);
            };
            var availableDirections:Array = user.getAvaibleDirection(useAnimation);
            if (availableDirections[5])
            {
                availableDirections[7] = true;
            };
            if (availableDirections[1])
            {
                availableDirections[3] = true;
            };
            if (availableDirections[7])
            {
                availableDirections[5] = true;
            };
            if (availableDirections[3])
            {
                availableDirections[1] = true;
            };
            if (availableDirections[useDirection] == false)
            {
                k = 0;
                while (k < 8)
                {
                    if ((useDirection == 7))
                    {
                        useDirection = 0;
                    }
                    else
                    {
                        useDirection++;
                    };
                    if (availableDirections[useDirection] == true)
                    {
                        break;
                    };
                    k++;
                };
            };
            return (useDirection);
        }

        private function registerInteractive(ie:InteractiveElement, firstSkill:int):void
        {
            var found:Boolean;
            var s:String;
            var cie:InteractiveElement;
            var worldObject:InteractiveObject = Atouin.getInstance().getIdentifiedElement(ie.elementId);
            if (!(worldObject))
            {
                _log.error((("Unknown identified element " + ie.elementId) + ", unable to register it as interactive."));
                return;
            };
            var entitiesFrame:RoleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
            if (entitiesFrame)
            {
                found = false;
                for (s in entitiesFrame.interactiveElements)
                {
                    cie = entitiesFrame.interactiveElements[int(s)];
                    if (cie.elementId == ie.elementId)
                    {
                        found = true;
                        entitiesFrame.interactiveElements[int(s)] = ie;
                        break;
                    };
                };
                if (!(found))
                {
                    entitiesFrame.interactiveElements.push(ie);
                };
            };
            var worldPos:MapPoint = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
            if (!(worldObject.hasEventListener(MouseEvent.MOUSE_OVER)))
            {
                worldObject.addEventListener(MouseEvent.MOUSE_OVER, this.over, false, 0, true);
                worldObject.addEventListener(MouseEvent.MOUSE_OUT, this.out, false, 0, true);
                worldObject.addEventListener(MouseEvent.CLICK, this.click, false, 0, true);
                _log.debug((((((("Add interaction for element " + ie.elementId) + " on cell ") + worldPos.cellId) + " with ") + ((ie.enabledSkills) ? ie.enabledSkills.length : 0)) + " skill actifs"));
            };
            if ((worldObject is Sprite))
            {
                (worldObject as Sprite).useHandCursor = true;
                (worldObject as Sprite).buttonMode = true;
            };
            this._ie[worldObject] = {
                "element":ie,
                "position":worldPos,
                "firstSkill":firstSkill
            };
        }

        private function removeInteractive(ie:InteractiveElement):void
        {
            var interactiveElement:InteractiveObject = Atouin.getInstance().getIdentifiedElement(ie.elementId);
            if (interactiveElement != null)
            {
                interactiveElement.removeEventListener(MouseEvent.MOUSE_OVER, this.over);
                interactiveElement.removeEventListener(MouseEvent.MOUSE_OUT, this.out);
                interactiveElement.removeEventListener(MouseEvent.CLICK, this.click);
                if ((interactiveElement is Sprite))
                {
                    (interactiveElement as Sprite).useHandCursor = false;
                    (interactiveElement as Sprite).buttonMode = false;
                };
            };
            if (currentlyHighlighted == (interactiveElement as Sprite))
            {
                this.resetInteractiveApparence();
            };
            delete this._ie[interactiveElement];
        }

        private function updateStatedElement(se:StatedElement, global:Boolean=false):void
        {
            var interactive:Interactive;
            var worldObject:InteractiveObject = Atouin.getInstance().getIdentifiedElement(se.elementId);
            if (!(worldObject))
            {
                _log.error((((("Unknown identified element " + se.elementId) + "; unable to change its state to ") + se.elementState) + " !"));
                return;
            };
            var ts:TiphonSprite = (((worldObject is DisplayObjectContainer)) ? this.findTiphonSprite((worldObject as DisplayObjectContainer)) : null);
            if (!(ts))
            {
                _log.warn((((("Unable to find an animated element for the stated element " + se.elementId) + " on cell ") + se.elementCellId) + ", this element is probably invisible or is not configured as an animated element."));
                return;
            };
            if (se.elementId == this._currentUsedElementId)
            {
                this._usingInteractive = true;
                this.resetInteractiveApparence();
            };
            if (((((this._ie[worldObject]) && (this._ie[worldObject].element))) && ((this._ie[worldObject].element.elementId == se.elementId))))
            {
                interactive = Interactive.getInteractiveById(this._ie[worldObject].element.elementTypeId);
                if (((interactive) && ((interactive.actionId == COLLECTABLE_INTERACTIVE_ACTION_ID))))
                {
                    this._collectableSpritesToBeStopped[ts] = null;
                }
                else
                {
                    this._statedElementsTargetAnimation[ts] = {
                        "elemId":se.elementId,
                        "animation":("AnimState" + se.elementState)
                    };
                    ts.addEventListener(TiphonEvent.RENDER_SUCCEED, this.onAnimRendered);
                };
            }
            else
            {
                delete this._collectableSpritesToBeStopped[ts];
            };
            ts.setAnimationAndDirection(("AnimState" + se.elementState), 0, global);
        }

        private function findTiphonSprite(doc:DisplayObjectContainer):TiphonSprite
        {
            var child:DisplayObject;
            if ((doc is TiphonSprite))
            {
                return ((doc as TiphonSprite));
            };
            if (!(doc.numChildren))
            {
                return (null);
            };
            var i:uint;
            while (i < doc.numChildren)
            {
                child = doc.getChildAt(i);
                if ((child is TiphonSprite))
                {
                    return ((child as TiphonSprite));
                };
                if ((child is DisplayObjectContainer))
                {
                    return (this.findTiphonSprite((child as DisplayObjectContainer)));
                };
                i++;
            };
            return (null);
        }

        private function highlightInteractiveApparence(ie:Sprite, firstSkill:int, pSkillIsEnabled:Boolean=true):void
        {
            var lcd:LinkedCursorData;
            var infos:Object = this._ie[ie];
            if (!(infos))
            {
                return;
            };
            if (currentlyHighlighted != null)
            {
                this.resetInteractiveApparence(false);
            };
            if ((ie.getChildAt(0) is TiphonSprite))
            {
                FiltersManager.getInstance().addEffect((ie.getChildAt(0) as TiphonSprite).rawAnimation, LUMINOSITY_EFFECTS);
            }
            else
            {
                FiltersManager.getInstance().addEffect(ie, LUMINOSITY_EFFECTS);
            };
            if (MapDisplayManager.getInstance().isBoundingBox(infos.element.elementId))
            {
                ie.alpha = ALPHA_MODIFICATOR;
            };
            if ((((PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)) && (!(PerformanceManager.optimize))))
            {
                lcd = new LinkedCursorData();
                lcd.sprite = getCursor(Skill.getSkillById(firstSkill).cursor, pSkillIsEnabled);
                Mouse.hide();
                lcd.offset = INTERACTIVE_CURSOR_OFFSET;
                LinkedCursorSpriteManager.getInstance().addItem(INTERACTIVE_CURSOR_NAME, lcd);
            };
            currentlyHighlighted = ie;
        }

        private function resetInteractiveApparence(removeIcon:Boolean=true):void
        {
            if (currentlyHighlighted == null)
            {
                return;
            };
            if (((removeIcon) && ((currentlyHighlighted.getChildAt(0) is TiphonSprite))))
            {
                FiltersManager.getInstance().removeEffect((currentlyHighlighted.getChildAt(0) as TiphonSprite).rawAnimation, LUMINOSITY_EFFECTS);
            }
            else
            {
                if (removeIcon)
                {
                    FiltersManager.getInstance().removeEffect(currentlyHighlighted, LUMINOSITY_EFFECTS);
                };
            };
            if (removeIcon)
            {
                LinkedCursorSpriteManager.getInstance().removeItem(INTERACTIVE_CURSOR_NAME);
                Mouse.show();
            };
            var infos:Object = this._ie[currentlyHighlighted];
            if (!(infos))
            {
                return;
            };
            if (MapDisplayManager.getInstance().isBoundingBox(infos.element.elementId))
            {
                currentlyHighlighted.alpha = 0;
                currentlyHighlighted = null;
            };
        }

        private function over(me:MouseEvent):void
        {
            if (((!(this.roleplayWorldFrame)) || (!(this.roleplayContextFrame.hasWorldInteraction))))
            {
                return;
            };
            var ie:Object = this._ie[(me.target as Sprite)];
            if (((ie) && (me)))
            {
                Kernel.getWorker().process(new InteractiveElementMouseOverMessage(ie.element, me.target));
            };
        }

        private function out(me:Object):void
        {
            var ie:Object = this._ie[(me.target as Sprite)];
            if (ie)
            {
                Kernel.getWorker().process(new InteractiveElementMouseOutMessage(ie.element));
            };
        }

        private function click(me:MouseEvent):void
        {
            var skillNameStr:String;
            var enabledSkill:InteractiveElementSkill;
            var jobsApi:JobsApi;
            var skillDisabledData:Skill;
            var jobsDetails:Array;
            var disabledSkill:InteractiveElementSkill;
            var nbSkillsAvailable:int;
            var skillIndex:int;
            var skill:Object;
            var details:Object;
            var knownJob:KnownJob;
            var _local_16:int;
            var _local_17:WeaponWrapper;
            var _local_18:Job;
            var isAlreadyChecked:Boolean;
            var j:Object;
            if (((!(this.roleplayWorldFrame)) || (!(this.roleplayContextFrame.hasWorldInteraction))))
            {
                return;
            };
            TooltipManager.hide();
            var ie:Object = this._ie[(me.target as Sprite)];
            var interactive:Interactive;
            if (ie.element.elementTypeId > 0)
            {
                interactive = Interactive.getInteractiveById(ie.element.elementTypeId);
            };
            if (((((!(AirScanner.isStreamingVersion())) && ((OptionManager.getOptionManager("dofus")["enableForceWalk"] == true)))) && (((ShortcutsFrame.ctrlKeyDown) || ((((SystemManager.getSingleton().os == OperatingSystem.MAC_OS)) && (ShortcutsFrame.altKeyDown)))))))
            {
                this.out(me);
                InteractiveCellManager.getInstance().getCell(ie.position.cellId).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                return;
            };
            var skills:Array = [];
            for each (enabledSkill in ie.element.enabledSkills)
            {
                if ((enabledSkill is InteractiveElementNamedSkill))
                {
                    skillNameStr = SkillName.getSkillNameById((enabledSkill as InteractiveElementNamedSkill).nameId).name;
                }
                else
                {
                    skillNameStr = Skill.getSkillById(enabledSkill.skillId).name;
                };
                skills.push({
                    "id":enabledSkill.skillId,
                    "instanceId":enabledSkill.skillInstanceUid,
                    "name":skillNameStr,
                    "enabled":true
                });
            };
            jobsApi = new JobsApi();
            jobsDetails = new Array();
            for each (disabledSkill in ie.element.disabledSkills)
            {
                if ((disabledSkill is InteractiveElementNamedSkill))
                {
                    skillNameStr = SkillName.getSkillNameById((disabledSkill as InteractiveElementNamedSkill).nameId).name;
                }
                else
                {
                    skillNameStr = Skill.getSkillById(disabledSkill.skillId).name;
                };
                skillDisabledData = Skill.getSkillById(disabledSkill.skillId);
                skillNameStr = skillDisabledData.name;
                if (skillDisabledData.parentJobId != 1)
                {
                    knownJob = jobsApi.getKnownJob(skillDisabledData.parentJobId);
                    if (knownJob == null)
                    {
                        details = new Object();
                        details.job = skillDisabledData.parentJob.name;
                        details.jobId = skillDisabledData.parentJob.id;
                        details.type = "job";
                        details.value = [skillDisabledData.parentJob.name];
                    }
                    else
                    {
                        _local_16 = knownJob.jobExperience.jobLevel;
                        if (_local_16 < skillDisabledData.levelMin)
                        {
                            details = new Object();
                            details.job = skillDisabledData.parentJob.name;
                            details.jobId = skillDisabledData.parentJob.id;
                            details.type = "level";
                            details.value = [skillDisabledData.parentJob.name, skillDisabledData.levelMin, _local_16];
                        }
                        else
                        {
                            _local_17 = PlayedCharacterApi.getWeapon();
                            _local_18 = skillDisabledData.parentJob;
                            if ((((_local_17 == null)) || ((_local_18.toolIds.indexOf(_local_17.id) == -1))))
                            {
                                details = new Object();
                                details.job = skillDisabledData.parentJob.name;
                                details.jobId = skillDisabledData.parentJob.id;
                                details.type = "tool";
                                details.value = [skillDisabledData.parentJob.name];
                            };
                        };
                    };
                    if (details != null)
                    {
                        isAlreadyChecked = false;
                        for each (j in jobsDetails)
                        {
                            if (j.jobId == details.jobId)
                            {
                                isAlreadyChecked = true;
                                break;
                            };
                        };
                        if (!(isAlreadyChecked))
                        {
                            jobsDetails.push(details);
                        };
                    };
                    skills.push({
                        "id":disabledSkill.skillId,
                        "instanceId":disabledSkill.skillInstanceUid,
                        "name":skillNameStr,
                        "enabled":false
                    });
                };
            };
            nbSkillsAvailable = 0;
            for each (skill in skills)
            {
                if (skill.enabled)
                {
                    skillIndex = skills.indexOf(skill);
                    nbSkillsAvailable++;
                };
            };
            if (nbSkillsAvailable == 1)
            {
                this.skillClicked(ie, skills[skillIndex].instanceId);
                return;
            };
            if ((((nbSkillsAvailable > 0)) && ((skills.length > 1))))
            {
                this._modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                this._modContextMenu.createContextMenu(MenusFactory.create(skills, "skill", [ie, interactive]));
            };
            if (nbSkillsAvailable == 0)
            {
                this.showInteractiveElementNotification(jobsDetails);
            };
        }

        private function showInteractiveElementNotification(dataTab:Array):void
        {
            var details:String;
            var needBtn:Boolean;
            var data:Object;
            var npcName:String;
            var jobKnown:Array;
            var noToolsStr:String;
            var noLvlStr:String;
            var _local_9:Npc;
            var _local_10:Point;
            var _local_11:MapApi;
            var _local_12:String;
            var nid:uint;
            if (dataTab.length > 0)
            {
                details = "";
                needBtn = false;
                jobKnown = this.getJobKnown(dataTab);
                if (jobKnown.length > 0)
                {
                    noToolsStr = "";
                    noLvlStr = "";
                    for each (data in jobKnown)
                    {
                        if (data.type == "level")
                        {
                            noLvlStr = (noLvlStr + (((jobKnown.length > 1)) ? "<li>" : ""));
                            noLvlStr = (noLvlStr + I18n.getUiText("ui.skill.levelLowJob", data.value));
                            noLvlStr = (noLvlStr + (((jobKnown.length > 1)) ? "</li>" : ""));
                        }
                        else
                        {
                            if (data.type == "tool")
                            {
                                noToolsStr = (noToolsStr + (((jobKnown.length > 1)) ? "<li>" : ""));
                                noToolsStr = (noToolsStr + data.value[0]);
                                noToolsStr = (noToolsStr + (((jobKnown.length > 1)) ? "</li>" : ""));
                            };
                        };
                    };
                    if (noLvlStr != "")
                    {
                        details = (details + I18n.getUiText("ui.skill.levelLow", [(((((jobKnown.length > 1)) ? "<ul>" : "") + noLvlStr) + (((jobKnown.length > 1)) ? "</ul>" : "."))]));
                    };
                    if (noToolsStr != "")
                    {
                        details = (details + I18n.getUiText("ui.skill.toolNeeded", [(((((jobKnown.length > 1)) ? "<ul>" : "") + noToolsStr) + (((jobKnown.length > 1)) ? "</ul>" : "."))]));
                    };
                }
                else
                {
                    _local_11 = new MapApi();
                    if (_local_11.isInIncarnam())
                    {
                        _local_9 = Npc.getNpcById(849);
                        _local_10 = _local_11.getMapCoords(80218116);
                    }
                    else
                    {
                        _local_9 = Npc.getNpcById(601);
                        _local_10 = _local_11.getMapCoords(83889152);
                    };
                    _local_12 = "";
                    for each (data in dataTab)
                    {
                        _local_12 = (_local_12 + (((((dataTab.length > 1)) ? "<li>" : "") + data.value[0]) + (((dataTab.length > 1)) ? "</li>" : "")));
                    };
                    details = I18n.getUiText("ui.skill.jobNotKnown", [(((((dataTab.length > 1)) ? "<ul>" : "") + _local_12) + (((dataTab.length > 1)) ? "</ul>" : "."))]);
                    details = (details + "\n");
                    details = (details + I18n.getUiText("ui.npc.learnJobs", [_local_9.name, _local_10.x, _local_10.y]));
                    npcName = _local_9.name;
                    needBtn = true;
                };
                if (details != "")
                {
                    nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.skill.disabled"), details, NotificationTypeEnum.INFORMATION, "interactiveElementDisabled");
                    if (needBtn)
                    {
                        NotificationManager.getInstance().addButtonToNotification(nid, I18n.getUiText("ui.npc.location"), "AddMapFlag", [(("flag_srv" + CompassTypeEnum.COMPASS_TYPE_SIMPLE) + "_job"), (((((npcName + " (") + _local_10.x) + ",") + _local_10.y) + ")"), PlayedCharacterManager.getInstance().currentWorldMap.id, _local_10.x, _local_10.y, 0x558800, false, true], false, 150, 0, "hook");
                    };
                    NotificationManager.getInstance().addTimerToNotification(nid, 30, true);
                    NotificationManager.getInstance().sendNotification(nid);
                };
            };
        }

        private function getJobKnown(data:Array):Array
        {
            var pb:Object;
            var newData:Array = new Array();
            for each (pb in data)
            {
                if (pb.type != "job")
                {
                    newData.push(pb);
                };
            };
            return (newData);
        }

        private function formateInteractiveElementProblem(type:String, data:Array):String
        {
            switch (type)
            {
                case "job":
                    return (I18n.getUiText("ui.skill.jobNotKnown", data));
                case "level":
                    return (I18n.getUiText("ui.skill.levelLow", data));
                case "tool":
                    return (I18n.getUiText("ui.skill.toolNeeded", data));
            };
            return (null);
        }

        private function skillClicked(ie:Object, skillInstanceId:int):void
        {
            var msg:InteractiveElementActivationMessage = new InteractiveElementActivationMessage(ie.element, ie.position, skillInstanceId);
            Kernel.getWorker().process(msg);
        }

        private function interactiveUsageFinished(entityId:int, elementId:uint, skillId:uint):void
        {
            var ieamsg:InteractiveElementActivationMessage;
            if (entityId == PlayedCharacterManager.getInstance().id)
            {
                Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                if (this.roleplayWorldFrame)
                {
                    this.roleplayWorldFrame.cellClickEnabled = true;
                };
                this._usingInteractive = false;
                this._currentUsedElementId = -1;
                if (this._nextInteractiveUsed)
                {
                    ieamsg = new InteractiveElementActivationMessage(this._nextInteractiveUsed.ie, this._nextInteractiveUsed.position, this._nextInteractiveUsed.skillInstanceId);
                    this._nextInteractiveUsed = null;
                    Kernel.getWorker().process(ieamsg);
                };
            };
        }

        private function onAnimRendered(pEvent:TiphonEvent):void
        {
            var ts:TiphonSprite = (pEvent.currentTarget as TiphonSprite);
            if (pEvent.animationType == this._statedElementsTargetAnimation[ts].animation)
            {
                ts.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onAnimRendered);
                if (this._statedElementsTargetAnimation[ts].elemId == this._currentUsedElementId)
                {
                    this._usingInteractive = false;
                    this._currentUsedElementId = -1;
                };
                if (((((ts.getBounds(StageShareManager.stage).contains(StageShareManager.stage.mouseX, StageShareManager.stage.mouseY)) && (this._ie[currentlyHighlighted]))) && ((this._ie[currentlyHighlighted].element.elementId == this._statedElementsTargetAnimation[ts].elemId))))
                {
                    Kernel.getWorker().process(new InteractiveElementMouseOverMessage(this._ie[currentlyHighlighted].element, currentlyHighlighted));
                };
                delete this._statedElementsTargetAnimation[ts];
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.frames

