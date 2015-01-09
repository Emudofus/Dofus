package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.display.Sprite;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.kernel.Kernel;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.TeleportOnSameMapMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveElementMessage;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
    import com.ankamagames.atouin.messages.CellOverMessage;
    import com.ankamagames.atouin.messages.CellOutMessage;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTeleportOnSameMapMessage;
    import com.ankamagames.dofus.logic.game.fight.messages.GameActionFightLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDeathMessage;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
    import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
    import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.GameRolePlayShowActorMessage;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.tiphon.events.TiphonEvent;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartingMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
    import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
    import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
    import com.ankamagames.dofus.logic.game.common.actions.roleplay.SwitchCreatureModeAction;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSynchronizeMessage;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
    import com.ankamagames.atouin.messages.MapZoomMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
    import flash.events.MouseEvent;
    import com.ankamagames.dofus.datacenter.interactives.StealthBones;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import com.ankamagames.jerakine.interfaces.IRectangle;
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.utils.display.Rectangle2;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import __AS3__.vec.*;

    public class InfoEntitiesFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InfoEntitiesFrame));

        private var _namesVisible:Boolean = false;
        private var _labelContainer:Sprite;
        private var _playersNames:Vector.<DisplayedEntity>;
        private var _movableEntities:Vector.<uint>;
        private var _waitList:Vector.<uint>;
        private var _roleplayEntitiesFrame:RoleplayEntitiesFrame;
        private var _fightEntitiesFrame:FightEntitiesFrame;
        private var _fightContextFrame:FightContextFrame;

        public function InfoEntitiesFrame()
        {
            this._labelContainer = new Sprite();
            this._movableEntities = new Vector.<uint>();
            this._waitList = new Vector.<uint>();
        }

        public function pushed():Boolean
        {
            var entityId:int;
            if (!(this._namesVisible))
            {
                this._playersNames = new Vector.<DisplayedEntity>();
                if (PlayedCharacterApi.isInFight())
                {
                    if (this._fightEntitiesFrame == null)
                    {
                        this._fightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
                    };
                    if (this._fightContextFrame == null)
                    {
                        this._fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    };
                    for each (entityId in this._fightEntitiesFrame.getEntitiesIdsList())
                    {
                        if (entityId > 0)
                        {
                            this.addEntity(entityId, this._fightContextFrame.getFighterName(entityId));
                        };
                    };
                }
                else
                {
                    this.updateEntities();
                };
                this.addListener();
                this._namesVisible = true;
                DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt((StrataEnum.STRATA_WORLD + 1))).addChild(this._labelContainer);
            };
            return (true);
        }

        public function pulled():Boolean
        {
            if (this._namesVisible)
            {
                this.removeAllTooltips();
                this._namesVisible = false;
                EnterFrameDispatcher.removeEventListener(this.updateTextsPosition);
                DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt((StrataEnum.STRATA_WORLD + 1))).removeChild(this._labelContainer);
                KernelEventsManager.getInstance().processCallback(HookList.ShowPlayersNames, false);
            };
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:GameMapMovementMessage;
            var _local_3:TeleportOnSameMapMessage;
            var _local_4:GameContextRemoveElementMessage;
            var _local_5:AnimatedCharacter;
            var _local_6:EntityMouseOverMessage;
            var _local_7:CellOverMessage;
            var _local_8:AnimatedCharacter;
            var _local_9:CellOutMessage;
            var _local_10:AnimatedCharacter;
            var _local_11:EntityMouseOutMessage;
            var _local_12:GameActionFightTeleportOnSameMapMessage;
            var _local_13:GameActionFightLeaveMessage;
            var _local_14:GameActionFightDeathMessage;
            var entity:IEntity;
            var entity2:IEntity;
            this.addListener();
            switch (true)
            {
                case (msg is CurrentMapMessage):
                    this.removeAllTooltips();
                    break;
                case (msg is GameMapMovementMessage):
                    _local_2 = (msg as GameMapMovementMessage);
                    this.movementHandler(_local_2.actorId);
                    break;
                case (msg is EntityMovementCompleteMessage):
                    this.entityMovementCompleteHandler((msg as EntityMovementCompleteMessage).entity);
                    break;
                case (msg is EntityMovementStoppedMessage):
                    this.entityMovementCompleteHandler((msg as EntityMovementStoppedMessage).entity);
                    break;
                case (msg is TeleportOnSameMapMessage):
                    _local_3 = (msg as TeleportOnSameMapMessage);
                    this.movementHandler(_local_3.targetId);
                    break;
                case (msg is GameRolePlayShowActorMessage):
                    this.gameRolePlayShowActorHandler(msg);
                    break;
                case (msg is GameContextRemoveElementMessage):
                    _local_4 = (msg as GameContextRemoveElementMessage);
                    _local_5 = (DofusEntities.getEntity(_local_4.id) as AnimatedCharacter);
                    if (_local_5)
                    {
                        _local_5.removeEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail);
                        _local_5.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess);
                    };
                    this.removeElementHandler(_local_4.id);
                    break;
                case (msg is GameFightStartingMessage):
                    Kernel.getWorker().removeFrame(this);
                    break;
                case (msg is GameFightEndMessage):
                    Kernel.getWorker().removeFrame(this);
                    break;
                case (msg is EntityMouseOverMessage):
                    _local_6 = (msg as EntityMouseOverMessage);
                    this.mouseOverHandler(_local_6.entity.id);
                    break;
                case (msg is CellOverMessage):
                    _local_7 = (msg as CellOverMessage);
                    for each (entity in EntitiesManager.getInstance().getEntitiesOnCell(_local_7.cellId))
                    {
                        if ((((entity is AnimatedCharacter)) && (!((entity as AnimatedCharacter).isMoving))))
                        {
                            _local_8 = (entity as AnimatedCharacter);
                            break;
                        };
                    };
                    if (_local_8)
                    {
                        this.mouseOverHandler(_local_8.id);
                    };
                    break;
                case (msg is CellOutMessage):
                    _local_9 = (msg as CellOutMessage);
                    for each (entity2 in EntitiesManager.getInstance().getEntitiesOnCell(_local_9.cellId))
                    {
                        if ((entity2 is AnimatedCharacter))
                        {
                            _local_10 = (entity2 as AnimatedCharacter);
                            break;
                        };
                    };
                    if (_local_10)
                    {
                        this.mouseOutHandler(_local_10.id);
                    };
                    break;
                case (msg is TimelineEntityOverAction):
                    this.mouseOverHandler((msg as TimelineEntityOverAction).targetId);
                    break;
                case (msg is TimelineEntityOutAction):
                    this.mouseOutHandler((msg as TimelineEntityOutAction).targetId);
                    break;
                case (msg is EntityMouseOutMessage):
                    _local_11 = (msg as EntityMouseOutMessage);
                    this.mouseOutHandler(_local_11.entity.id);
                    break;
                case (msg is GameActionFightTeleportOnSameMapMessage):
                    _local_12 = (msg as GameActionFightTeleportOnSameMapMessage);
                    this.getEntity(_local_12.targetId).visible = false;
                    (DofusEntities.getEntity(_local_12.targetId) as AnimatedCharacter).addEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
                    break;
                case (msg is GameActionFightLeaveMessage):
                    _local_13 = (msg as GameActionFightLeaveMessage);
                    this.removeElementHandler(_local_13.targetId);
                    break;
                case (msg is GameActionFightDeathMessage):
                    _local_14 = (msg as GameActionFightDeathMessage);
                    this.removeElementHandler(_local_14.targetId);
                    break;
                case (msg is ToggleDematerializationAction):
                    this.updateAllTooltipsAfterRender();
                    break;
                case (msg is SwitchCreatureModeAction):
                    this.updateAllTooltipsAfterRender();
                    break;
                case (msg is GameFightSynchronizeMessage):
                    this.updateAllTooltips();
                    break;
                case (msg is SequenceEndMessage):
                    this.updateAllTooltips();
                    break;
                case (msg is MapZoomMessage):
                    this.updateAllTooltips();
                    break;
            };
            return (false);
        }

        public function get priority():int
        {
            return (Priority.HIGHEST);
        }

        public function update():void
        {
            this.removeAllTooltips();
            this.updateEntities();
            this.updateAllTooltipsAfterRender();
        }

        private function movementHandler(actorId:int):void
        {
            var _local_3:DisplayedEntity;
            var movedEntity:IEntity = DofusEntities.getEntity(actorId);
            if (!(movedEntity))
            {
                _log.warn((("The entity " + actorId) + " not found."));
            }
            else
            {
                _local_3 = this.getEntity(movedEntity.id);
                if (_local_3)
                {
                    this._movableEntities.push(this._playersNames.indexOf(_local_3));
                };
            };
            this.addListener();
        }

        private function entityMovementCompleteHandler(entity:IEntity):void
        {
            var startIndex:int;
            var de:DisplayedEntity = this.getEntity(entity.id);
            var index:int = this._playersNames.indexOf(de);
            if (index != -1)
            {
                startIndex = this._movableEntities.indexOf(index);
                this._movableEntities.splice(startIndex, 1);
                de.target = this.getBounds(entity.id);
                this.updateDisplayedEntityPosition(de);
            };
        }

        private function gameRolePlayShowActorHandler(grpsamsg:Object):void
        {
            var _local_2:GameRolePlayCharacterInformations;
            var _local_3:int;
            var _local_4:DisplayedEntity;
            var _local_5:String;
            var _local_6:*;
            if ((grpsamsg.informations is GameRolePlayMerchantInformations))
            {
                this.removeElementHandler(grpsamsg.informations.contextualId);
            }
            else
            {
                _local_2 = (grpsamsg.informations as GameRolePlayCharacterInformations);
                if (_local_2 == null)
                {
                    return;
                };
                _local_3 = _local_2.contextualId;
                _local_4 = this.getEntity(_local_3);
                _local_5 = "";
                for each (_local_6 in _local_2.humanoidInfo.options)
                {
                    if ((_local_6 is HumanOptionAlliance))
                    {
                        _local_5 = (("[" + _local_6.allianceInformations.allianceTag) + "]");
                    };
                };
                if (_local_4)
                {
                    if (_local_5 != _local_4.allianceName)
                    {
                        this.removeElementHandler(_local_3);
                        _local_4 = null;
                    }
                    else
                    {
                        _local_4.visible = false;
                        (DofusEntities.getEntity(_local_3) as AnimatedCharacter).addEventListener(TiphonEvent.RENDER_SUCCEED, this.onAnimationEnd);
                    };
                };
                if (!(_local_4))
                {
                    this.addEntity(_local_3, _local_2.name, _local_5);
                };
            };
        }

        private function removeElementHandler(entityId:int):void
        {
            var nameIndex:int;
            var mvtIndex:int;
            var entity:DisplayedEntity = this.getEntity(entityId);
            if (entity != null)
            {
                nameIndex = this._playersNames.indexOf(entity);
                if (nameIndex != -1)
                {
                    mvtIndex = this._movableEntities.indexOf(nameIndex);
                    if (mvtIndex != -1)
                    {
                        this._movableEntities.splice(mvtIndex, 1);
                    };
                    this._playersNames.splice(nameIndex, 1);
                    if (this._labelContainer.contains(entity.text))
                    {
                        this._labelContainer.removeChild(entity.text);
                    };
                    entity.text.removeEventListener(MouseEvent.CLICK, this.onTooltipClicked);
                    entity.clear();
                    entity = null;
                };
            };
        }

        private function mouseOverHandler(identityId:int):void
        {
            var identity:DisplayedEntity = this.getEntity(identityId);
            if (identity != null)
            {
                identity.visible = false;
            };
        }

        private function mouseOutHandler(identityId:int):void
        {
            var identity:DisplayedEntity = this.getEntity(identityId);
            if (identity != null)
            {
                identity.visible = true;
            };
        }

        private function onAnimationEnd(pEvt:TiphonEvent):void
        {
            var _local_3:DisplayedEntity;
            var e:AnimatedCharacter = (pEvt.currentTarget as AnimatedCharacter);
            if (e.hasEventListener(TiphonEvent.ANIMATION_END))
            {
                e.removeEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
            };
            if (e.hasEventListener(TiphonEvent.RENDER_SUCCEED))
            {
                e.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onAnimationEnd);
            };
            if (StealthBones.getStealthBonesById((pEvt.currentTarget as TiphonSprite).look.getBone()))
            {
                this.removeElementHandler(e.id);
            }
            else
            {
                _local_3 = this.getEntity(e.id);
                _local_3.visible = true;
                _local_3.target = this.getBounds(e.id);
                this.updateDisplayedEntityPosition(_local_3);
            };
        }

        private function updateEntities():void
        {
            var entityId:int;
            var entityInfo:GameRolePlayCharacterInformations;
            var allianceTag:String;
            var option:*;
            if (this._roleplayEntitiesFrame == null)
            {
                this._roleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
            };
            var ids:Array = this._roleplayEntitiesFrame.playersId;
            for each (entityId in ids)
            {
                entityInfo = (this._roleplayEntitiesFrame.getEntityInfos(entityId) as GameRolePlayCharacterInformations);
                if (entityInfo != null)
                {
                    allianceTag = "";
                    for each (option in entityInfo.humanoidInfo.options)
                    {
                        if ((option is HumanOptionAlliance))
                        {
                            allianceTag = (("[" + option.allianceInformations.allianceTag) + "]");
                        };
                    };
                    this.addEntity(entityId, entityInfo.name, allianceTag);
                }
                else
                {
                    _log.warn((("Entity info for " + entityId) + " not found"));
                };
            };
        }

        private function removeAllTooltips():void
        {
            var de:DisplayedEntity;
            var i:int;
            var ac:AnimatedCharacter;
            while (this._playersNames.length)
            {
                de = this._playersNames.pop();
                if (de != null)
                {
                    if (this._labelContainer.contains(de.text))
                    {
                        this._labelContainer.removeChild(de.text);
                    };
                    ac = (DofusEntities.getEntity(de.entityId) as AnimatedCharacter);
                    if (ac)
                    {
                        ac.removeEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail);
                        ac.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess);
                    };
                    de.clear();
                    de = null;
                };
            };
        }

        private function getEntity(id:int):DisplayedEntity
        {
            var i:int;
            var len:int = this._playersNames.length;
            i = 0;
            while (i < len)
            {
                if (this._playersNames[i].entityId == id)
                {
                    return (this._playersNames[i]);
                };
                i++;
            };
            _log.warn((("DisplayedEntity " + id) + " not found"));
            return (null);
        }

        private function getEntityFromLabel(lbl:Label):DisplayedEntity
        {
            var i:int;
            var len:int = this._playersNames.length;
            i = 0;
            while (i < len)
            {
                if (this._playersNames[i].text == lbl)
                {
                    return (this._playersNames[i]);
                };
                i++;
            };
            _log.warn("DisplayedEntity not found");
            return (null);
        }

        private function updateDisplayedEntityPosition(de:DisplayedEntity):void
        {
            if (de == null)
            {
                return;
            };
            if ((((((de.target == null)) || ((de.target.width == 0)))) || ((de.target.height == 0))))
            {
                this._waitList.push(de.entityId);
                if (!(EnterFrameDispatcher.hasEventListener(this.waitForEntity)))
                {
                    EnterFrameDispatcher.addEventListener(this.waitForEntity, "wait for entity", 5);
                };
            }
            else
            {
                de.text.x = (de.target.x + (((de.target.width > de.text.textWidth)) ? ((de.target.width - de.text.textWidth) / 2) : (((de.text.textWidth - de.target.width) / 2) * -1)));
                de.text.y = (de.target.y - 30);
                if (de.text.y < 0)
                {
                    de.text.y = 2;
                };
            };
        }

        private function addEntity(entityId:int, pName:String, aTag:String=""):void
        {
            var lbl:Label;
            var ts:TiphonSprite;
            var de:DisplayedEntity;
            var e:IEntity;
            var _local_8:int;
            if (this.getEntity(entityId) == null)
            {
                lbl = new Label();
                lbl.css = new Uri((XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css"));
                if (aTag != "")
                {
                    lbl.text = ((pName + " ") + aTag);
                }
                else
                {
                    lbl.text = pName;
                };
                lbl.mouseEnabled = true;
                lbl.bgColor = XmlConfig.getInstance().getEntry("colors.tooltip.bg");
                lbl.bgAlpha = XmlConfig.getInstance().getEntry("colors.tooltip.bg.alpha");
                lbl.width = (lbl.textWidth + 7);
                lbl.height = (lbl.height + 4);
                lbl.buttonMode = true;
                lbl.addEventListener(MouseEvent.CLICK, this.onTooltipClicked);
                if (entityId == PlayedCharacterApi.id())
                {
                    lbl.colorText = XmlConfig.getInstance().getEntry("colors.tooltip.text.red");
                };
                ts = (DofusEntities.getEntity(entityId) as TiphonSprite);
                if (ts == null)
                {
                    de = new DisplayedEntity(entityId, lbl);
                }
                else
                {
                    de = new DisplayedEntity(entityId, lbl, this.getBounds(entityId), aTag);
                    if (StealthBones.getStealthBonesById(ts.look.getBone()))
                    {
                        return;
                    };
                    this._labelContainer.addChild(lbl);
                };
                this.updateDisplayedEntityPosition(de);
                this._playersNames.push(de);
                e = DofusEntities.getEntity(entityId);
                if ((e is IMovable))
                {
                    if (IMovable(e).isMoving)
                    {
                        this._movableEntities.push(this._playersNames.indexOf(de));
                    }
                    else
                    {
                        _local_8 = this._movableEntities.indexOf(this._playersNames.indexOf(de));
                        if (_local_8 != -1)
                        {
                            this._movableEntities.splice(_local_8, 1);
                        };
                    };
                };
            };
        }

        public function updateAllTooltips():void
        {
            var ent:DisplayedEntity;
            for each (ent in this._playersNames)
            {
                ent.target = this.getBounds(ent.entityId);
                this.updateDisplayedEntityPosition(ent);
            };
        }

        private function updateAllTooltipsAfterRender():void
        {
            var ent:DisplayedEntity;
            var ac:AnimatedCharacter;
            for each (ent in this._playersNames)
            {
                ac = (DofusEntities.getEntity(ent.entityId) as AnimatedCharacter);
                ac.addEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail, false, 0, true);
                ac.addEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess, false, 0, true);
            };
        }

        private function onUpdateEntitySuccess(pEvt:TiphonEvent):void
        {
            pEvt.sprite.removeEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail);
            pEvt.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess);
            var ent:DisplayedEntity = this.getEntity(pEvt.target.id);
            ent.target = this.getBounds(ent.entityId);
            this.updateDisplayedEntityPosition(ent);
        }

        private function onUpdateEntityFail(pEvt:TiphonEvent):void
        {
            pEvt.sprite.removeEventListener(TiphonEvent.RENDER_FAILED, this.onUpdateEntityFail);
            pEvt.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onUpdateEntitySuccess);
        }

        private function onTooltipClicked(pEvt:MouseEvent):void
        {
            var entity:DisplayedEntity;
            var entityInfo:GameContextActorInformations;
            if (!(PlayedCharacterManager.getInstance().isFighting))
            {
                entity = this.getEntityFromLabel((pEvt.currentTarget as Label));
                entityInfo = this._roleplayEntitiesFrame.getEntityInfos(entity.entityId);
                if (entityInfo)
                {
                    RoleplayManager.getInstance().displayCharacterContextualMenu(entityInfo);
                };
            };
        }

        private function updateTextsPosition(pEvt:Event):void
        {
            var i:int;
            var len:int;
            var de:DisplayedEntity;
            var entityId:int;
            if (!(this.removeListener()))
            {
                len = this._movableEntities.length;
                i = 0;
                while (i < len)
                {
                    if ((((((i >= this._movableEntities.length)) || ((this._movableEntities[i] >= this._playersNames.length)))) || ((this._playersNames[this._movableEntities[i]] == null))))
                    {
                    }
                    else
                    {
                        entityId = this._playersNames[this._movableEntities[i]].entityId;
                        de = this.getEntity(entityId);
                        if (de)
                        {
                            de.target = this.getBounds(entityId);
                            this.updateDisplayedEntityPosition(de);
                        };
                    };
                    i = (i + 1);
                };
            };
        }

        private function addListener():Boolean
        {
            if ((((this._movableEntities.length > 0)) && (!(EnterFrameDispatcher.hasEventListener(this.updateTextsPosition)))))
            {
                EnterFrameDispatcher.addEventListener(this.updateTextsPosition, "Infos Entities", 25);
                return (true);
            };
            return (false);
        }

        private function removeListener():Boolean
        {
            if ((((this._movableEntities.length <= 0)) && (EnterFrameDispatcher.hasEventListener(this.updateTextsPosition))))
            {
                EnterFrameDispatcher.removeEventListener(this.updateTextsPosition);
                return (true);
            };
            return (false);
        }

        private function waitForEntity(pEvt:Event):void
        {
            var entityId:uint;
            var entity:DisplayedEntity;
            var ts:TiphonSprite;
            var t:DisplayObject;
            for each (entityId in this._waitList)
            {
                entity = this.getEntity(entityId);
                if (((!((entity == null))) && (!((DofusEntities.getEntity(entityId) == null)))))
                {
                    ts = (DofusEntities.getEntity(entityId) as TiphonSprite);
                    t = ts.getSlot("Tete");
                    entity.target = this.getBounds(entityId);
                    if (((((ts) && (!((entity.target.width == 0))))) && (!((entity.target.height == 0)))))
                    {
                        this._waitList.splice(this._waitList.indexOf(entityId), 1);
                        if (StealthBones.getStealthBonesById(ts.look.getBone()))
                        {
                            return;
                        };
                        if (!(this._labelContainer.contains(entity.text)))
                        {
                            this._labelContainer.addChild(entity.text);
                        };
                        this.updateDisplayedEntityPosition(entity);
                    };
                };
            };
            if (this._waitList.length <= 0)
            {
                EnterFrameDispatcher.removeEventListener(this.waitForEntity);
            };
        }

        private function getBounds(entityId:int):IRectangle
        {
            var targetBounds:IRectangle;
            var r1:Rectangle;
            var r2:Rectangle2;
            var foot:DisplayObject;
            var rider:TiphonSprite;
            var ts:TiphonSprite = (DofusEntities.getEntity(entityId) as TiphonSprite);
            if (ts == null)
            {
                return (null);
            };
            var head:DisplayObject = ts.getSlot("Tete");
            if (head)
            {
                r1 = head.getBounds(StageShareManager.stage);
                r2 = new Rectangle2(r1.x, r1.y, r1.width, r1.height);
                targetBounds = r2;
                if (targetBounds.y <= targetBounds.height)
                {
                    foot = ts.getSlot("Pied");
                    if (!(foot))
                    {
                        rider = (ts.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite);
                        if (rider)
                        {
                            foot = rider.getSlot("Pied");
                        };
                    };
                    if (foot)
                    {
                        r1 = foot.getBounds(StageShareManager.stage);
                        r2 = new Rectangle2(r1.x, ((r1.y + targetBounds.height) + 30), r1.width, r1.height);
                        targetBounds = r2;
                    };
                };
            };
            if (!(targetBounds))
            {
                targetBounds = (ts as IDisplayable).absoluteBounds;
                if (targetBounds.y <= targetBounds.height)
                {
                    targetBounds.y = (targetBounds.y + (targetBounds.height + 30));
                };
            };
            return (targetBounds);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.frames

import com.ankamagames.berilia.components.Label;
import com.ankamagames.jerakine.interfaces.IRectangle;

class DisplayedEntity 
{

    public var entityId:int;
    public var text:Label;
    public var target:IRectangle;
    public var allianceName:String;

    public function DisplayedEntity(pId:int=0, pText:Label=null, pTarget:IRectangle=null, pAllianceName:String=""):void
    {
        this.entityId = pId;
        this.text = pText;
        this.target = pTarget;
        this.allianceName = pAllianceName;
    }

    public function clear():void
    {
        this.text.remove();
        this.text = null;
        this.target = null;
    }

    public function set visible(val:Boolean):void
    {
        this.text.visible = val;
    }


}

