package com.ankamagames.dofus.misc.utils.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.console.moduleLUA.ConsoleLUA;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
    import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
    import com.ankamagames.dofus.network.messages.game.chat.ChatServerMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameMapChangeOrientationMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.GameRolePlayShowActorMessage;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUsedMessage;
    import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseEndedMessage;
    import com.ankamagames.dofus.network.messages.game.chat.smiley.ChatSmileyMessage;
    import com.ankamagames.atouin.messages.CellOverMessage;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayInteractivesFrame;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.console.moduleLUA.LuaMoveEnum;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.datacenter.jobs.Skill;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.jerakine.types.enums.Priority;

    public class LuaScriptRecorderFrame implements Frame 
    {

        private static var resourceID:int = 0;

        private var _luaScript:String = "";
        private var _playerId:int;
        private var _playerX:int;
        private var _playerY:int;
        private var _paused:Boolean;
        private var _running:Boolean = false;
        private var _autoTimer:Boolean;
        private var _moveType:int = 0;
        private var _mainSeqStartTime:int;
        private var _waitStartTime:int;
        private var _charMoveStartTime:int;
        private var _waitModTime:int = 0;
        private var _elementID:uint;
        private var _currentCell:MapPoint;
        private var _currentCameraZoom:int;


        private function addScriptLine(line:String, overrideRunningStatus:Boolean=false):void
        {
            var time:int;
            if (((((!(this._paused)) && (this._running))) || (overrideRunningStatus)))
            {
                if (this._luaScript != "")
                {
                    this._luaScript = (this._luaScript + "\n");
                };
                if (this._autoTimer)
                {
                    if (!(this._waitStartTime))
                    {
                        this._waitStartTime = this._mainSeqStartTime;
                    };
                    time = getTimer();
                    if (this._charMoveStartTime)
                    {
                        line = ((("seq.add(player.wait(" + String((this._charMoveStartTime - this._waitStartTime))) + "))\n") + line);
                    }
                    else
                    {
                        line = ((("seq.add(player.wait(" + String((time - this._waitStartTime))) + "))\n") + line);
                    };
                    this._charMoveStartTime = 0;
                    this._waitModTime = 0;
                    this._waitStartTime = getTimer();
                };
                this._luaScript = (this._luaScript + line);
                ConsoleLUA.getInstance().printLine(line);
            };
        }

        public function pushed():Boolean
        {
            InteractiveCellManager.getInstance().cellOverEnabled = true;
            this._currentCameraZoom = 1;
            return (true);
        }

        public function pulled():Boolean
        {
            InteractiveCellManager.getInstance().cellOverEnabled = false;
            this.stop();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var cmd:String;
            var param:String;
            var _local_5:GameMapMovementMessage;
            var _local_6:EntityMovementCompleteMessage;
            var _local_7:ChatServerMessage;
            var _local_8:GameMapChangeOrientationMessage;
            var _local_9:EmotePlayMessage;
            var _local_10:GameRolePlayShowActorMessage;
            var _local_11:TiphonEntityLook;
            var _local_12:InteractiveUsedMessage;
            var _local_13:InteractiveUseEndedMessage;
            var _local_14:ChatSmileyMessage;
            var _local_15:CellOverMessage;
            var time:int;
            var waitValRes:int;
            var waitValPlayer:int;
            var autoTimerVal:Boolean;
            var rif:RoleplayInteractivesFrame;
            var user:IEntity;
            var useAnimation:String;
            var worldPos:MapPoint;
            var useDirection:uint;
            var useQuote:Boolean;
            switch (true)
            {
                case (msg is GameMapMovementMessage):
                    _local_5 = (msg as GameMapMovementMessage);
                    if (_local_5.actorId == this._playerId)
                    {
                        this._charMoveStartTime = getTimer();
                    };
                    return (false);
                case (msg is EntityMovementCompleteMessage):
                    _local_6 = (msg as EntityMovementCompleteMessage);
                    if (_local_6.entity.id == this._playerId)
                    {
                        switch (this._moveType)
                        {
                            case LuaMoveEnum.MOVE_DEFAULT:
                                cmd = "move";
                                break;
                            case LuaMoveEnum.MOVE_WALK:
                                cmd = "walk";
                                break;
                            case LuaMoveEnum.MOVE_RUN:
                                cmd = "run";
                                break;
                            case LuaMoveEnum.MOVE_TELEPORT:
                                cmd = "teleport";
                                break;
                            case LuaMoveEnum.MOVE_SLIDE:
                                cmd = "slide";
                                break;
                        };
                        param = ((_local_6.entity.position.x + ", ") + _local_6.entity.position.y);
                        this._playerX = _local_6.entity.position.x;
                        this._playerY = _local_6.entity.position.y;
                    }
                    else
                    {
                        return (false);
                    };
                    break;
                case (msg is ChatServerMessage):
                    _local_7 = (msg as ChatServerMessage);
                    if (_local_7.senderId == this._playerId)
                    {
                        useQuote = true;
                        if (_local_7.content.substr(0, 6).toLowerCase() == "/think")
                        {
                            cmd = "think";
                            param = _local_7.content.substr(7);
                        }
                        else
                        {
                            cmd = "speak";
                            param = _local_7.content;
                        };
                    }
                    else
                    {
                        return (false);
                    };
                    break;
                case (msg is GameMapChangeOrientationMessage):
                    _local_8 = (msg as GameMapChangeOrientationMessage);
                    if (_local_8.orientation.id == this._playerId)
                    {
                        cmd = "setDirection";
                        param = _local_8.orientation.direction.toString();
                    }
                    else
                    {
                        return (false);
                    };
                    break;
                case (msg is EmotePlayMessage):
                    _local_9 = (msg as EmotePlayMessage);
                    if (_local_9.actorId == this._playerId)
                    {
                        cmd = "playEmote";
                        param = _local_9.emoteId.toString();
                    }
                    else
                    {
                        return (false);
                    };
                    break;
                case (msg is GameRolePlayShowActorMessage):
                    _local_10 = (msg as GameRolePlayShowActorMessage);
                    _local_11 = EntityLookAdapter.fromNetwork(_local_10.informations.look);
                    if ((((_local_10.informations.contextualId == this._playerId)) && (!(((_local_11 as EntityLook) == PlayedCharacterManager.getInstance().realEntityLook)))))
                    {
                        useQuote = true;
                        cmd = "look";
                        param = _local_11.toString();
                    }
                    else
                    {
                        return (false);
                    };
                    break;
                case (msg is InteractiveUsedMessage):
                    _local_12 = (msg as InteractiveUsedMessage);
                    if (_local_12.entityId == this._playerId)
                    {
                        if (!(this._waitStartTime))
                        {
                            this._waitStartTime = this._mainSeqStartTime;
                        };
                        time = getTimer();
                        waitValRes = (time - this._mainSeqStartTime);
                        waitValPlayer = (time - this._waitStartTime);
                        autoTimerVal = this._autoTimer;
                        this._autoTimer = false;
                        rif = (Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame);
                        user = DofusEntities.getEntity(_local_12.entityId);
                        useAnimation = Skill.getSkillById(_local_12.skillId).useAnimation;
                        worldPos = Atouin.getInstance().getIdentifiedElementPosition(_local_12.elemId);
                        useDirection = rif.getUseDirection((user as TiphonSprite), useAnimation, worldPos);
                        this.createLine("player", "wait", waitValPlayer.toString(), false);
                        this.createLine("player", "setDirection", useDirection.toString(), useQuote);
                        this.createLine("player", "setAnimation", (('"' + useAnimation) + '", 5'), false);
                        this.addScriptLine((((("local harvestedRes" + resourceID) + " = EntityApi.getWorldEntity(") + _local_12.elemId) + ")"));
                        this.addScriptLine((("local seqRes" + resourceID) + " = SeqApi.create()"));
                        this.addScriptLine((((((("seqRes" + resourceID) + ".add(harvestedRes") + resourceID) + ".wait(") + waitValRes.toString()) + "))"));
                        this.addScriptLine((((("seqRes" + resourceID) + ".add(harvestedRes") + resourceID) + '.setAnimation("AnimState2", 5, "AnimState2_to_AnimState1"))'));
                        this.addScriptLine((((("seqRes" + resourceID) + ".add(harvestedRes") + resourceID) + ".wait(500))"));
                        this.addScriptLine((((("seqRes" + resourceID) + ".add(harvestedRes") + resourceID) + '.setAnimation("AnimState1", -1, "none"))'));
                        this._waitStartTime = getTimer();
                        resourceID++;
                        this._elementID = _local_12.elemId;
                        this._autoTimer = autoTimerVal;
                    };
                    return (false);
                case (msg is InteractiveUseEndedMessage):
                    _local_13 = (msg as InteractiveUseEndedMessage);
                    if (this._elementID == _local_13.elemId)
                    {
                        this._waitStartTime = getTimer();
                        this._elementID = 0;
                    };
                    return (false);
                case (msg is ChatSmileyMessage):
                    _local_14 = (msg as ChatSmileyMessage);
                    if (_local_14.entityId == this._playerId)
                    {
                        cmd = "playSmiley";
                        param = _local_14.smileyId.toString();
                    }
                    else
                    {
                        return (false);
                    };
                    break;
                case (msg is CellOverMessage):
                    _local_15 = (msg as CellOverMessage);
                    this._currentCell = _local_15.cell;
                    return (false);
                case (msg is MouseWheelMessage):
                default:
                    return (false);
            };
            this.createLine("player", cmd, param, useQuote);
            return (false);
        }

        public function cameraZoom(value:Number, centerOnCharacter:Boolean=false):void
        {
            var param:String;
            var sysApi:SystemApi = new SystemApi();
            if ((((value <= 0)) || ((value > AtouinConstants.MAX_ZOOM))))
            {
                return;
            };
            if (this._currentCameraZoom != value)
            {
                this.addScriptLine((("seq.add(CameraApi.setZoom(" + value) + "))"));
            };
            this._currentCameraZoom = value;
            if (this._currentCameraZoom == 1)
            {
                this.addScriptLine("seq.add(CameraApi.zoom(0))");
                return;
            };
            if (centerOnCharacter)
            {
                param = "player";
            }
            else
            {
                param = ((this._currentCell.x.toString() + ", ") + this._currentCell.y.toString());
            };
            this.addScriptLine((("seq.add(CameraApi.zoom(" + param) + "))"));
        }

        public function createLine(entity:String, cmd:String, param:String, useQuote:Boolean):void
        {
            if (useQuote)
            {
                this.addScriptLine((((((("seq.add(" + entity) + ".") + cmd) + '("') + param) + '"))'));
            }
            else
            {
                this.addScriptLine((((((("seq.add(" + entity) + ".") + cmd) + "(") + param) + "))"));
            };
        }

        public function stop():void
        {
            this._autoTimer = false;
            this._running = false;
            this.addSeqStart();
        }

        public function addSeqStart():void
        {
            var autoTimerVal:Boolean = this._autoTimer;
            this._autoTimer = false;
            this.addScriptLine("seq.start()", true);
            var i:int;
            while (i < resourceID)
            {
                this.addScriptLine((("seqRes" + i) + ".start()"), true);
                i++;
            };
            this._autoTimer = autoTimerVal;
        }

        public function start(autoTimer:Boolean):void
        {
            this._luaScript = "";
            this._running = true;
            this._paused = false;
            this._moveType = LuaMoveEnum.MOVE_DEFAULT;
            this._playerId = PlayedCharacterManager.getInstance().id;
            var entity:IEntity = EntitiesManager.getInstance().getEntity(this._playerId);
            this._playerX = entity.position.x;
            this._playerY = entity.position.y;
            this.addScriptLine("local player = EntityApi.getPlayer()");
            this.addScriptLine("local seq = SeqApi.create()");
            this.createLine("player", "teleport", ((this._playerX.toString() + ", ") + this._playerY.toString()), false);
            this._autoTimer = autoTimer;
            this._mainSeqStartTime = getTimer();
            this._waitStartTime = 0;
            this._charMoveStartTime = 0;
            resourceID = 0;
        }

        public function set pause(paused:Boolean):void
        {
            this._paused = paused;
            if (this._paused == false)
            {
                this._waitStartTime = getTimer();
            };
        }

        public function wait(time:Number):void
        {
            this.createLine("player", "wait", time.toString(), false);
        }

        public function autoFollowCam(enabled:Boolean):void
        {
            if (enabled)
            {
                this.addScriptLine("seq.add(CameraApi.follow(player))");
            }
            else
            {
                this.addScriptLine("seq.add(CameraApi.stop())");
            };
        }

        public function get running():Boolean
        {
            return (this._running);
        }

        public function set moveType(moveType:int):void
        {
            this._moveType = moveType;
        }

        public function get luaScript():String
        {
            return (this._luaScript);
        }

        public function get priority():int
        {
            return (Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM);
        }

        public function set luaScript(value:String):void
        {
            this._luaScript = value;
        }


    }
}//package com.ankamagames.dofus.misc.utils.frames

