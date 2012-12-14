package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.dofus.datacenter.interactives.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.actions.roleplay.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.actions.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.messages.*;
    import com.ankamagames.dofus.logic.game.roleplay.managers.*;
    import com.ankamagames.dofus.network.messages.game.actions.fight.*;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class InfoEntitiesFrame extends Object implements Frame
    {
        private var _namesVisible:Boolean = false;
        private var _labelContainer:Sprite;
        private var _playersNames:Vector.<DisplayedEntity>;
        private var _movableEntities:Vector.<uint>;
        private var _waitList:Vector.<uint>;
        private var _roleplayEntitiesFrame:RoleplayEntitiesFrame;
        private var _fightEntitiesFrame:FightEntitiesFrame;
        private var _fightContextFrame:FightContextFrame;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(InfoEntitiesFrame));

        public function InfoEntitiesFrame()
        {
            this._labelContainer = new Sprite();
            this._movableEntities = new Vector.<uint>;
            this._waitList = new Vector.<uint>;
            return;
        }// end function

        public function pushed() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this._namesVisible)
            {
                this._playersNames = new Vector.<DisplayedEntity>;
                if (PlayedCharacterApi.isInFight())
                {
                    if (this._fightEntitiesFrame == null)
                    {
                        this._fightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                    }
                    if (this._fightContextFrame == null)
                    {
                        this._fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                    }
                    for each (_loc_1 in this._fightEntitiesFrame.getEntitiesIdsList())
                    {
                        
                        if (_loc_1 > 0)
                        {
                            this.addEntity(_loc_1, this._fightContextFrame.getFighterName(_loc_1));
                        }
                    }
                }
                else
                {
                    if (this._roleplayEntitiesFrame == null)
                    {
                        this._roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                    }
                    _loc_3 = this._roleplayEntitiesFrame.playersId;
                    for each (_loc_1 in _loc_3)
                    {
                        
                        _loc_2 = this._roleplayEntitiesFrame.getEntityInfos(_loc_1) as GameRolePlayCharacterInformations;
                        if (_loc_2 != null)
                        {
                            this.addEntity(_loc_1, _loc_2.name);
                            continue;
                        }
                        _log.warn("Entity info for " + _loc_1 + " not found");
                    }
                }
                this.addListener();
                this._namesVisible = true;
                DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt((StrataEnum.STRATA_WORLD + 1))).addChild(this._labelContainer);
            }
            return true;
        }// end function

        public function pulled() : Boolean
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._namesVisible)
            {
                _loc_3 = this._playersNames.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    _loc_1 = this._playersNames.pop();
                    if (_loc_1 == null)
                    {
                    }
                    else
                    {
                        if (this._labelContainer.contains(_loc_1.text))
                        {
                            this._labelContainer.removeChild(_loc_1.text);
                        }
                        _loc_1.clear();
                        _loc_1 = null;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                this._namesVisible = false;
                EnterFrameDispatcher.removeEventListener(this.updateTextsPosition);
                DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt((StrataEnum.STRATA_WORLD + 1))).removeChild(this._labelContainer);
            }
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            this.addListener();
            switch(true)
            {
                case param1 is GameMapMovementMessage:
                {
                    _loc_2 = param1 as GameMapMovementMessage;
                    this.movementHandler(_loc_2.actorId);
                    break;
                }
                case param1 is EntityMovementCompleteMessage:
                {
                    this.entityMovementCompleteHandler((param1 as EntityMovementCompleteMessage).entity);
                    break;
                }
                case param1 is EntityMovementStoppedMessage:
                {
                    this.entityMovementCompleteHandler((param1 as EntityMovementStoppedMessage).entity);
                    break;
                }
                case param1 is TeleportOnSameMapMessage:
                {
                    _loc_3 = param1 as TeleportOnSameMapMessage;
                    this.movementHandler(_loc_3.targetId);
                    break;
                }
                case param1 is GameRolePlayShowActorMessage:
                {
                    this.gameRolePlayShowActorHandler(param1);
                    break;
                }
                case param1 is GameContextRemoveElementMessage:
                {
                    _loc_4 = param1 as GameContextRemoveElementMessage;
                    this.removeElementHandler(_loc_4.id);
                    break;
                }
                case param1 is GameFightStartingMessage:
                {
                    Kernel.getWorker().removeFrame(this);
                    break;
                }
                case param1 is GameFightEndMessage:
                {
                    Kernel.getWorker().removeFrame(this);
                    break;
                }
                case param1 is EntityMouseOverMessage:
                {
                    _loc_5 = param1 as EntityMouseOverMessage;
                    this.mouseOverHandler(_loc_5.entity.id);
                    break;
                }
                case param1 is CellOverMessage:
                {
                    _loc_6 = param1 as CellOverMessage;
                    for each (_loc_14 in EntitiesManager.getInstance().getEntitiesOnCell(_loc_6.cellId))
                    {
                        
                        if (_loc_14 is AnimatedCharacter && !(_loc_14 as AnimatedCharacter).isMoving)
                        {
                            _loc_7 = _loc_14 as AnimatedCharacter;
                            break;
                        }
                    }
                    if (_loc_7)
                    {
                        this.mouseOverHandler(_loc_7.id);
                    }
                    break;
                }
                case param1 is CellOutMessage:
                {
                    _loc_8 = param1 as CellOutMessage;
                    for each (_loc_15 in EntitiesManager.getInstance().getEntitiesOnCell(_loc_8.cellId))
                    {
                        
                        if (_loc_15 is AnimatedCharacter)
                        {
                            _loc_9 = _loc_15 as AnimatedCharacter;
                            break;
                        }
                    }
                    if (_loc_9)
                    {
                        this.mouseOutHandler(_loc_9.id);
                    }
                    break;
                }
                case param1 is TimelineEntityOverAction:
                {
                    this.mouseOverHandler((param1 as TimelineEntityOverAction).targetId);
                    break;
                }
                case param1 is TimelineEntityOutAction:
                {
                    this.mouseOutHandler((param1 as TimelineEntityOutAction).targetId);
                    break;
                }
                case param1 is EntityMouseOutMessage:
                {
                    _loc_10 = param1 as EntityMouseOutMessage;
                    this.mouseOutHandler(_loc_10.entity.id);
                    break;
                }
                case param1 is CurrentMapMessage:
                {
                    Kernel.getWorker().removeFrame(this);
                    break;
                }
                case param1 is GameActionFightTeleportOnSameMapMessage:
                {
                    _loc_11 = param1 as GameActionFightTeleportOnSameMapMessage;
                    this.getEntity(_loc_11.targetId).visible = false;
                    (DofusEntities.getEntity(_loc_11.targetId) as AnimatedCharacter).addEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
                    break;
                }
                case param1 is GameActionFightLeaveMessage:
                {
                    _loc_12 = param1 as GameActionFightLeaveMessage;
                    this.removeElementHandler(_loc_12.targetId);
                    break;
                }
                case param1 is GameActionFightDeathMessage:
                {
                    _loc_13 = param1 as GameActionFightDeathMessage;
                    this.removeElementHandler(_loc_13.targetId);
                    break;
                }
                case param1 is ToggleDematerializationAction:
                {
                    this.updateAllTooltipsAfterRender();
                    break;
                }
                case param1 is SwitchCreatureModeAction:
                {
                    this.updateAllTooltipsAfterRender();
                    break;
                }
                case param1 is GameFightSynchronizeMessage:
                {
                    this.updateAllTooltips();
                    break;
                }
                case param1 is SequenceEndMessage:
                {
                    this.updateAllTooltips();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGHEST;
        }// end function

        private function movementHandler(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = DofusEntities.getEntity(param1);
            if (!_loc_2)
            {
                _log.warn("The entity " + param1 + " not found.");
            }
            else
            {
                _loc_3 = this.getEntity(_loc_2.id);
                if (_loc_3)
                {
                    this._movableEntities.push(this._playersNames.indexOf(_loc_3));
                }
            }
            this.addListener();
            return;
        }// end function

        private function entityMovementCompleteHandler(param1:IEntity) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = this.getEntity(param1.id);
            var _loc_3:* = this._playersNames.indexOf(_loc_2);
            if (_loc_3 != -1)
            {
                _loc_4 = this._movableEntities.indexOf(_loc_3);
                this._movableEntities.splice(_loc_4, 1);
                _loc_2.target = this.getBounds(param1.id);
                this.updateDisplayedEntityPosition(_loc_2);
            }
            return;
        }// end function

        private function gameRolePlayShowActorHandler(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (param1.informations is GameRolePlayMerchantInformations)
            {
                this.removeElementHandler(param1.informations.contextualId);
            }
            else
            {
                _loc_2 = param1.informations as GameRolePlayCharacterInformations;
                if (_loc_2 == null)
                {
                    return;
                }
                _loc_3 = _loc_2.contextualId;
                _loc_4 = this.getEntity(_loc_3);
                if (_loc_4 == null)
                {
                    this.addEntity(_loc_3, _loc_2.name);
                }
                else
                {
                    _loc_4.visible = false;
                    (DofusEntities.getEntity(_loc_3) as AnimatedCharacter).addEventListener(TiphonEvent.RENDER_SUCCEED, this.onAnimationEnd);
                }
            }
            return;
        }// end function

        private function removeElementHandler(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_2:* = this.getEntity(param1);
            if (_loc_2 != null)
            {
                _loc_3 = this._playersNames.indexOf(_loc_2);
                if (_loc_3 != -1)
                {
                    _loc_4 = this._movableEntities.indexOf(_loc_3);
                    if (_loc_4 != -1)
                    {
                        this._movableEntities.splice(_loc_4, 1);
                    }
                    this._playersNames.splice(_loc_3, 1);
                    if (this._labelContainer.contains(_loc_2.text))
                    {
                        this._labelContainer.removeChild(_loc_2.text);
                    }
                    _loc_2.text.removeEventListener(MouseEvent.CLICK, this.onTooltipClicked);
                    _loc_2.clear();
                    _loc_2 = null;
                }
            }
            return;
        }// end function

        private function mouseOverHandler(param1:int) : void
        {
            var _loc_2:* = this.getEntity(param1);
            if (_loc_2 != null)
            {
                _loc_2.visible = false;
            }
            return;
        }// end function

        private function mouseOutHandler(param1:int) : void
        {
            var _loc_2:* = this.getEntity(param1);
            if (_loc_2 != null)
            {
                _loc_2.visible = true;
            }
            return;
        }// end function

        private function onAnimationEnd(event:TiphonEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.currentTarget as AnimatedCharacter;
            if (_loc_2.hasEventListener(TiphonEvent.ANIMATION_END))
            {
                _loc_2.removeEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
            }
            if (_loc_2.hasEventListener(TiphonEvent.RENDER_SUCCEED))
            {
                _loc_2.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onAnimationEnd);
            }
            if (StealthBones.getStealthBonesById((event.currentTarget as TiphonSprite).look.getBone()))
            {
                this.removeElementHandler(_loc_2.id);
            }
            else
            {
                _loc_3 = this.getEntity(_loc_2.id);
                _loc_3.visible = true;
                _loc_3.target = this.getBounds(_loc_2.id);
                this.updateDisplayedEntityPosition(_loc_3);
            }
            return;
        }// end function

        private function getEntity(param1:int) : DisplayedEntity
        {
            var _loc_2:* = 0;
            var _loc_3:* = this._playersNames.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                if (this._playersNames[_loc_2].entityId == param1)
                {
                    return this._playersNames[_loc_2];
                }
                _loc_2++;
            }
            _log.warn("DisplayedEntity " + param1 + " not found");
            return null;
        }// end function

        private function getEntityFromLabel(param1:Label) : DisplayedEntity
        {
            var _loc_2:* = 0;
            var _loc_3:* = this._playersNames.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                if (this._playersNames[_loc_2].text == param1)
                {
                    return this._playersNames[_loc_2];
                }
                _loc_2++;
            }
            _log.warn("DisplayedEntity not found");
            return null;
        }// end function

        private function updateDisplayedEntityPosition(param1:DisplayedEntity) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (param1.target == null || param1.target.width == 0 || param1.target.height == 0)
            {
                this._waitList.push(param1.entityId);
                if (!EnterFrameDispatcher.hasEventListener(this.waitForEntity))
                {
                    EnterFrameDispatcher.addEventListener(this.waitForEntity, "wait for entity", 5);
                }
            }
            else
            {
                param1.text.x = param1.target.x + (param1.target.width > param1.text.textWidth ? ((param1.target.width - param1.text.textWidth) / 2) : ((param1.text.textWidth - param1.target.width) / 2 * -1));
                param1.text.y = param1.target.y - 30;
            }
            return;
        }// end function

        private function addEntity(param1:int, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            if (this.getEntity(param1) == null)
            {
                _loc_3 = new Label();
                _loc_3.css = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css");
                _loc_3.text = param2;
                _loc_3.mouseEnabled = true;
                _loc_3.bgColor = XmlConfig.getInstance().getEntry("colors.tooltip.bg");
                _loc_3.bgAlpha = XmlConfig.getInstance().getEntry("colors.tooltip.bg.alpha");
                _loc_3.width = _loc_3.textWidth + 7;
                _loc_3.height = _loc_3.height + 4;
                _loc_3.buttonMode = true;
                _loc_3.addEventListener(MouseEvent.CLICK, this.onTooltipClicked);
                if (param1 == PlayedCharacterApi.id())
                {
                    _loc_3.colorText = XmlConfig.getInstance().getEntry("colors.tooltip.text.red");
                }
                _loc_4 = DofusEntities.getEntity(param1) as TiphonSprite;
                if (_loc_4 == null)
                {
                    _loc_5 = new DisplayedEntity(param1, _loc_3);
                }
                else
                {
                    _loc_5 = new DisplayedEntity(param1, _loc_3, this.getBounds(param1));
                    if (StealthBones.getStealthBonesById(_loc_4.look.getBone()))
                    {
                        return;
                    }
                    this._labelContainer.addChild(_loc_3);
                }
                this.updateDisplayedEntityPosition(_loc_5);
                this._playersNames.push(_loc_5);
                _loc_6 = DofusEntities.getEntity(param1);
                if (_loc_6 is IMovable)
                {
                    if (IMovable(_loc_6).isMoving)
                    {
                        this._movableEntities.push(this._playersNames.indexOf(_loc_5));
                    }
                    else
                    {
                        _loc_7 = this._movableEntities.indexOf(this._playersNames.indexOf(_loc_5));
                        if (_loc_7 != -1)
                        {
                            this._movableEntities.splice(_loc_7, 1);
                        }
                    }
                }
            }
            return;
        }// end function

        private function updateAllTooltips() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._playersNames)
            {
                
                _loc_1.target = this.getBounds(_loc_1.entityId);
                this.updateDisplayedEntityPosition(_loc_1);
            }
            return;
        }// end function

        private function updateAllTooltipsAfterRender() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._playersNames)
            {
                
                _loc_2 = DofusEntities.getEntity(_loc_1.entityId) as AnimatedCharacter;
                _loc_2.addEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail, false, 0, true);
                _loc_2.addEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess, false, 0, true);
            }
            return;
        }// end function

        private function onUpdateEntitySuccess(event:TiphonEvent) : void
        {
            event.sprite.removeEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail);
            event.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess);
            var _loc_2:* = this.getEntity(event.target.id);
            _loc_2.target = this.getBounds(_loc_2.entityId);
            this.updateDisplayedEntityPosition(_loc_2);
            return;
        }// end function

        private function onUpdateEntityFail(event:TiphonEvent) : void
        {
            event.sprite.removeEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail);
            event.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess);
            return;
        }// end function

        private function onTooltipClicked(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!PlayedCharacterManager.getInstance().isFighting)
            {
                _loc_2 = this.getEntityFromLabel(event.currentTarget as Label);
                _loc_3 = this._roleplayEntitiesFrame.getEntityInfos(_loc_2.entityId);
                if (_loc_3)
                {
                    RoleplayManager.getInstance().displayCharacterContextualMenu(_loc_3);
                }
            }
            return;
        }// end function

        private function updateTextsPosition(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (!this.removeListener())
            {
                _loc_3 = this._movableEntities.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    if (_loc_2 >= this._movableEntities.length || this._movableEntities[_loc_2] >= this._playersNames.length || this._playersNames[this._movableEntities[_loc_2]] == null)
                    {
                    }
                    else
                    {
                        _loc_5 = this._playersNames[this._movableEntities[_loc_2]].entityId;
                        _loc_4 = this.getEntity(_loc_5);
                        if (_loc_4)
                        {
                            _loc_4.target = this.getBounds(_loc_5);
                            this.updateDisplayedEntityPosition(_loc_4);
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        private function addListener() : Boolean
        {
            if (this._movableEntities.length > 0 && !EnterFrameDispatcher.hasEventListener(this.updateTextsPosition))
            {
                EnterFrameDispatcher.addEventListener(this.updateTextsPosition, "Infos Entities", 25);
                return true;
            }
            return false;
        }// end function

        private function removeListener() : Boolean
        {
            if (this._movableEntities.length <= 0 && EnterFrameDispatcher.hasEventListener(this.updateTextsPosition))
            {
                EnterFrameDispatcher.removeEventListener(this.updateTextsPosition);
                return true;
            }
            return false;
        }// end function

        private function waitForEntity(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            for each (_loc_2 in this._waitList)
            {
                
                _loc_3 = this.getEntity(_loc_2);
                if (_loc_3 != null && DofusEntities.getEntity(_loc_2) != null)
                {
                    _loc_4 = DofusEntities.getEntity(_loc_2) as TiphonSprite;
                    _loc_5 = _loc_4.getSlot("Tete");
                    _loc_3.target = this.getBounds(_loc_2);
                    if (_loc_3.target.width != 0 && _loc_3.target.height != 0)
                    {
                        this._waitList.splice(this._waitList.indexOf(_loc_2), 1);
                        if (StealthBones.getStealthBonesById(_loc_4.look.getBone()))
                        {
                            return;
                        }
                        if (!this._labelContainer.contains(_loc_3.text))
                        {
                            this._labelContainer.addChild(_loc_3.text);
                        }
                        this.updateDisplayedEntityPosition(_loc_3);
                    }
                }
            }
            if (this._waitList.length <= 0)
            {
                EnterFrameDispatcher.removeEventListener(this.waitForEntity);
            }
            return;
        }// end function

        private function getBounds(param1:int) : IRectangle
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = DofusEntities.getEntity(param1) as TiphonSprite;
            if (_loc_2 == null)
            {
                return null;
            }
            var _loc_3:* = _loc_2.getSlot("Tete");
            if (_loc_3)
            {
                _loc_5 = _loc_3.getBounds(StageShareManager.stage);
                _loc_6 = new Rectangle2(_loc_5.x, _loc_5.y, _loc_5.width, _loc_5.height);
                _loc_4 = _loc_6;
                if (_loc_4.y <= _loc_4.height)
                {
                    _loc_7 = _loc_2.getSlot("Pied");
                    if (_loc_7)
                    {
                        _loc_5 = _loc_7.getBounds(StageShareManager.stage);
                        _loc_6 = new Rectangle2(_loc_5.x, _loc_5.y + _loc_4.height + 30, _loc_5.width, _loc_5.height);
                        _loc_4 = _loc_6;
                    }
                }
            }
            if (!_loc_4)
            {
                _loc_4 = (_loc_2 as IDisplayable).absoluteBounds;
                if (_loc_4.y <= _loc_4.height)
                {
                    _loc_4.y = _loc_4.y + (_loc_4.height + 30);
                }
            }
            return _loc_4;
        }// end function

    }
}

import __AS3__.vec.*;

import com.ankamagames.atouin.managers.*;

import com.ankamagames.atouin.messages.*;

import com.ankamagames.berilia.*;

import com.ankamagames.berilia.components.*;

import com.ankamagames.berilia.enums.*;

import com.ankamagames.dofus.datacenter.interactives.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.logic.game.common.actions.roleplay.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.logic.game.common.misc.*;

import com.ankamagames.dofus.logic.game.fight.actions.*;

import com.ankamagames.dofus.logic.game.fight.frames.*;

import com.ankamagames.dofus.logic.game.fight.messages.*;

import com.ankamagames.dofus.logic.game.roleplay.managers.*;

import com.ankamagames.dofus.network.messages.game.actions.fight.*;

import com.ankamagames.dofus.network.messages.game.actions.sequence.*;

import com.ankamagames.dofus.network.messages.game.context.*;

import com.ankamagames.dofus.network.messages.game.context.fight.*;

import com.ankamagames.dofus.network.messages.game.context.roleplay.*;

import com.ankamagames.dofus.network.types.game.context.*;

import com.ankamagames.dofus.network.types.game.context.roleplay.*;

import com.ankamagames.dofus.types.entities.*;

import com.ankamagames.dofus.uiApi.*;

import com.ankamagames.jerakine.data.*;

import com.ankamagames.jerakine.entities.interfaces.*;

import com.ankamagames.jerakine.entities.messages.*;

import com.ankamagames.jerakine.interfaces.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.types.enums.*;

import com.ankamagames.jerakine.utils.display.*;

import com.ankamagames.tiphon.display.*;

import com.ankamagames.tiphon.events.*;

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.utils.*;

class DisplayedEntity extends Object
{
    public var entityId:int;
    public var text:Label;
    public var target:IRectangle;

    function DisplayedEntity(param1:int = 0, param2:Label = null, param3:IRectangle = null) : void
    {
        this.entityId = param1;
        this.text = param2;
        this.target = param3;
        return;
    }// end function

    public function clear() : void
    {
        this.text.remove();
        this.text = null;
        this.target = null;
        return;
    }// end function

    public function set visible(param1:Boolean) : void
    {
        this.text.visible = param1;
        return;
    }// end function

}

