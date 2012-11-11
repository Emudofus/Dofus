package com.ankamagames.dofus.types.entities
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.entities.behaviours.display.*;
    import com.ankamagames.atouin.entities.behaviours.movements.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.dofus.datacenter.sounds.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.pathfinding.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.engine.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class AnimatedCharacter extends TiphonSprite implements IEntity, IMovable, IDisplayable, IAnimated, IInteractive, IRectangle, IObstacle, ITransparency, ICustomUnicNameGetter
    {
        private var _id:int;
        private var _position:MapPoint;
        private var _displayed:Boolean;
        private var _followers:Vector.<IMovable>;
        private var _followed:AnimatedCharacter;
        private var _transparencyAllowed:Boolean = true;
        private var _name:String;
        private var _canSeeThrough:Boolean = false;
        protected var _movementBehavior:IMovementBehavior;
        protected var _displayBehavior:IDisplayBehavior;
        private var _bmpAlpha:Bitmap;
        public var slideOnNextMove:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimatedCharacter));
        private static const LUMINOSITY_FACTOR:Number = 1.2;
        private static const LUMINOSITY_TRANSFORM:ColorTransform = new ColorTransform(LUMINOSITY_FACTOR, LUMINOSITY_FACTOR, LUMINOSITY_FACTOR);
        private static const NORMAL_TRANSFORM:ColorTransform = new ColorTransform();
        private static const TRANSPARENCY_TRANSFORM:ColorTransform = new ColorTransform(1, 1, 1, AtouinConstants.OVERLAY_MODE_ALPHA);

        public function AnimatedCharacter(param1:int, param2:TiphonEntityLook, param3:AnimatedCharacter = null)
        {
            super(param2);
            this._name = "entity::" + param1;
            this._displayBehavior = AtouinDisplayBehavior.getInstance();
            this._movementBehavior = WalkingMovementBehavior.getInstance();
            addEventListener(TiphonEvent.RENDER_SUCCEED, this.onFirstRender);
            addEventListener(TiphonEvent.RENDER_FAILED, this.onFirstError);
            setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE, DirectionsEnum.DOWN_RIGHT);
            this.id = param1;
            name = "AnimatedCharacter" + param1;
            this._followers = new Vector.<IMovable>;
            this._followed = param3;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function set id(param1:int) : void
        {
            this._id = param1;
            return;
        }// end function

        public function get customUnicName() : String
        {
            return this._name;
        }// end function

        public function get position() : MapPoint
        {
            return this._position;
        }// end function

        public function set position(param1:MapPoint) : void
        {
            this._position = param1;
            return;
        }// end function

        public function get movementBehavior() : IMovementBehavior
        {
            return this._movementBehavior;
        }// end function

        public function set movementBehavior(param1:IMovementBehavior) : void
        {
            this._movementBehavior = param1;
            return;
        }// end function

        public function get followed() : AnimatedCharacter
        {
            return this._followed;
        }// end function

        public function get displayBehaviors() : IDisplayBehavior
        {
            return this._displayBehavior;
        }// end function

        public function set displayBehaviors(param1:IDisplayBehavior) : void
        {
            this._displayBehavior = param1;
            return;
        }// end function

        public function get displayed() : Boolean
        {
            return this._displayed;
        }// end function

        public function get handler() : MessageHandler
        {
            return Kernel.getWorker();
        }// end function

        public function get enabledInteractions() : uint
        {
            return InteractionsEnum.CLICK | InteractionsEnum.OUT | InteractionsEnum.OVER;
        }// end function

        public function get isMoving() : Boolean
        {
            return this._movementBehavior.isMoving(this);
        }// end function

        public function get absoluteBounds() : IRectangle
        {
            return this._displayBehavior.getAbsoluteBounds(this);
        }// end function

        override public function get useHandCursor() : Boolean
        {
            return true;
        }// end function

        public function getIsTransparencyAllowed() : Boolean
        {
            return this._transparencyAllowed;
        }// end function

        public function set transparencyAllowed(param1:Boolean) : void
        {
            this._transparencyAllowed = param1;
            return;
        }// end function

        private function onFirstError(event:TiphonEvent) : void
        {
            removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onFirstRender);
            removeEventListener(TiphonEvent.RENDER_FAILED, this.onFirstError);
            var _loc_2:* = getAvaibleDirection(AnimationEnum.ANIM_STATIQUE);
            var _loc_3:* = DirectionsEnum.DOWN_RIGHT;
            while (_loc_3 < DirectionsEnum.DOWN_RIGHT + 7)
            {
                
                if (_loc_2[_loc_3 % 8])
                {
                    setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE, _loc_3 % 8);
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function onFirstRender(event:TiphonEvent) : void
        {
            removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onFirstRender);
            removeEventListener(TiphonEvent.RENDER_FAILED, this.onFirstError);
            return;
        }// end function

        public function canSeeThrough() : Boolean
        {
            return this._canSeeThrough;
        }// end function

        public function setCanSeeThrough(param1:Boolean) : void
        {
            this._canSeeThrough = param1;
            return;
        }// end function

        public function move(param1:MovementPath, param2:Function = null) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = false;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = false;
            if (!param1.start.equals(this.position))
            {
                _log.warn("Unsynchronized position for entity " + this.id + ", jumping from " + this.position + " to " + param1.start + ".");
                this.jump(param1.start);
            }
            var _loc_3:* = param1.path.length + 1;
            this._movementBehavior = null;
            if (this.slideOnNextMove)
            {
                this._movementBehavior = SlideMovementBehavior.getInstance();
                this.slideOnNextMove = false;
            }
            else
            {
                if (Kernel.getWorker().contains(RoleplayEntitiesFrame))
                {
                    _loc_7 = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(this.id);
                    if (_loc_7 is GameRolePlayHumanoidInformations)
                    {
                        if ((_loc_7 as GameRolePlayHumanoidInformations).humanoidInfo.restrictions.forceSlowWalk)
                        {
                            this._movementBehavior = FantomMovementBehavior.getInstance();
                        }
                        if ((_loc_7 as GameRolePlayHumanoidInformations).humanoidInfo.restrictions.cantRun)
                        {
                            this._movementBehavior = WalkingMovementBehavior.getInstance();
                        }
                    }
                    else if (_loc_7 is GameRolePlayGroupMonsterInformations)
                    {
                        this._movementBehavior = WalkingMovementBehavior.getInstance();
                    }
                }
                if (!this._movementBehavior)
                {
                    if (_loc_3 > 3)
                    {
                        _loc_8 = false;
                        if (Kernel.getWorker().contains(RoleplayEntitiesFrame))
                        {
                            _loc_8 = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).isCreatureMode;
                        }
                        if (!_loc_8 && this.isMounted())
                        {
                            this._movementBehavior = MountedMovementBehavior.getInstance();
                        }
                        else
                        {
                            this._movementBehavior = RunningMovementBehavior.getInstance();
                        }
                    }
                    else if (_loc_3 > 0)
                    {
                        this._movementBehavior = WalkingMovementBehavior.getInstance();
                    }
                    else
                    {
                        return;
                    }
                }
            }
            var _loc_4:* = this.getDirection();
            var _loc_5:* = DataMapProvider.getInstance();
            if (this._followers.length > 0)
            {
                _loc_9 = new Array();
                _loc_10 = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
                if (_loc_10 != null)
                {
                    _loc_11 = _loc_10.entitiesFrame.interactiveElements;
                    for each (_loc_12 in _loc_11)
                    {
                        
                        _loc_13 = Atouin.getInstance().getIdentifiedElementPosition(_loc_12.elementId).cellId;
                        _loc_9.push(_loc_13);
                    }
                }
            }
            for each (_loc_6 in this._followers)
            {
                
                _loc_14 = null;
                _loc_15 = 0;
                do
                {
                    
                    _loc_14 = param1.end.getNearestFreeCellInDirection(_loc_4, _loc_5, false, false, _loc_9);
                    _loc_4++;
                    _loc_4 = _loc_4 % 8;
                }while (!_loc_14 && ++_loc_15 < 8)
                if (_loc_14)
                {
                    _loc_16 = [];
                    if (_loc_6 is TiphonSprite)
                    {
                        _loc_16 = TiphonSprite(_loc_6).getAvaibleDirection();
                    }
                    _loc_17 = 0;
                    for each (_loc_18 in _loc_16)
                    {
                        
                        if (_loc_18)
                        {
                            _loc_17 = _loc_17 + 1;
                        }
                    }
                    if (_loc_16[1] && !_loc_16[3])
                    {
                        _loc_17 = _loc_17 + 1;
                    }
                    if (!_loc_16[1] && _loc_16[3])
                    {
                        _loc_17 = _loc_17 + 1;
                    }
                    if (_loc_16[7] && !_loc_16[5])
                    {
                        _loc_17 = _loc_17 + 1;
                    }
                    if (!_loc_16[7] && _loc_16[5])
                    {
                        _loc_17 = _loc_17 + 1;
                    }
                    if (!_loc_16[0] && _loc_16[4])
                    {
                        _loc_17 = _loc_17 + 1;
                    }
                    if (_loc_16[0] && !_loc_16[4])
                    {
                        _loc_17 = _loc_17 + 1;
                    }
                    Pathfinding.findPath(_loc_5, _loc_6.position, _loc_14, _loc_17 >= 8, true, this.processMove, new Array(_loc_6, _loc_14));
                    continue;
                }
                _log.warn("Unable to get a proper destination for the follower.");
            }
            this._movementBehavior.move(this, param1, param2);
            return;
        }// end function

        private function processMove(param1:MovementPath, param2:Array) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = param2[0];
            if (param1 && param1.path.length > 0)
            {
                _loc_3.movementBehavior = this._movementBehavior;
                _loc_3.move(param1);
            }
            else
            {
                _loc_4 = param2[1];
                _log.warn("There was no path from " + _loc_3.position + " to " + _loc_4 + " for a follower. Jumping !");
                _loc_3.jump(_loc_4);
            }
            return;
        }// end function

        public function jump(param1:MapPoint) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._movementBehavior.jump(this, param1);
            for each (_loc_2 in this._followers)
            {
                
                _loc_3 = DataMapProvider.getInstance();
                _loc_4 = this.position.getNearestFreeCell(_loc_3, false);
                if (!_loc_4)
                {
                    _loc_4 = this.position.getNearestFreeCell(_loc_3, true);
                    if (!_loc_4)
                    {
                        return;
                    }
                }
                _loc_2.jump(_loc_4);
            }
            return;
        }// end function

        public function stop(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            this._movementBehavior.stop(this, param1);
            for each (_loc_2 in this._followers)
            {
                
                _loc_2.stop(param1);
            }
            return;
        }// end function

        public function display(param1:uint = 10) : void
        {
            this._displayBehavior.display(this, param1);
            this._displayed = true;
            return;
        }// end function

        public function remove() : void
        {
            this.removeAllFollowers();
            this._displayed = false;
            this._movementBehavior.stop(this, true);
            this._displayBehavior.remove(this);
            return;
        }// end function

        override public function destroy() : void
        {
            this._followed = null;
            this.remove();
            super.destroy();
            return;
        }// end function

        public function getRootEntity() : AnimatedCharacter
        {
            if (this._followed)
            {
                return this._followed.getRootEntity();
            }
            return this;
        }// end function

        public function removeAllFollowers() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = this._followers.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._followers[_loc_2];
                _loc_4 = _loc_3 as IDisplayable;
                if (_loc_4)
                {
                    _loc_4.remove();
                }
                _loc_5 = _loc_3 as TiphonSprite;
                if (_loc_5)
                {
                    _loc_5.destroy();
                }
                _loc_2++;
            }
            this._followers = new Vector.<IMovable>;
            return;
        }// end function

        public function addFollower(param1:IMovable, param2:Boolean = false) : void
        {
            var _loc_5:* = null;
            this._followers.push(param1);
            var _loc_3:* = DataMapProvider.getInstance();
            var _loc_4:* = this.position.getNearestFreeCell(_loc_3, false);
            if (!this.position.getNearestFreeCell(_loc_3, false))
            {
                _loc_4 = this.position.getNearestFreeCell(_loc_3, true);
                if (!_loc_4)
                {
                    return;
                }
            }
            if (param1.position == null)
            {
                param1.position = _loc_4;
            }
            if (param1 is IDisplayable)
            {
                _loc_5 = param1 as IDisplayable;
                if (this._displayed && !_loc_5.displayed)
                {
                    _loc_5.display();
                }
                else if (!this._displayed && _loc_5.displayed)
                {
                    _loc_5.remove();
                }
            }
            if (_loc_4.equals(param1.position))
            {
                return;
            }
            if (param2)
            {
                param1.jump(_loc_4);
            }
            else
            {
                param1.move(Pathfinding.findPath(_loc_3, param1.position, _loc_4, false, false));
            }
            return;
        }// end function

        public function isMounted() : Boolean
        {
            var _loc_1:* = this.look.getSubEntities(true);
            if (!_loc_1)
            {
                return false;
            }
            var _loc_2:* = _loc_1[SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER];
            if (!_loc_2 || _loc_2.length == 0)
            {
                return false;
            }
            return true;
        }// end function

        public function highLightCharacterAndFollower(param1:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = this.getRootEntity();
            var _loc_3:* = _loc_2._followers.length;
            var _loc_4:* = -1;
            while (++_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2._followers[_loc_4] as AnimatedCharacter;
                if (_loc_5)
                {
                    _loc_5.highLight(param1);
                }
            }
            this.highLight(param1);
            return;
        }// end function

        public function highLight(param1:Boolean) : void
        {
            if (param1)
            {
                transform.colorTransform = LUMINOSITY_TRANSFORM;
            }
            else if (Atouin.getInstance().options.transparentOverlayMode)
            {
                transform.colorTransform = TRANSPARENCY_TRANSFORM;
            }
            else
            {
                transform.colorTransform = NORMAL_TRANSFORM;
            }
            return;
        }// end function

        public function showBitmapAlpha(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._bmpAlpha == null)
            {
                _loc_2 = new BitmapData(width, height, true, 16711680);
                _loc_2.draw(this.bitmapData);
                this._bmpAlpha = new Bitmap(_loc_2);
                this._bmpAlpha.alpha = param1;
                _loc_3 = InteractiveCellManager.getInstance().getCell(this.position.cellId);
                this._bmpAlpha.x = _loc_3.x + _loc_3.width / 2 - this.width / 2;
                this._bmpAlpha.y = _loc_3.y + _loc_3.height - this.height;
                this.parent.addChild(this._bmpAlpha);
                visible = false;
            }
            return;
        }// end function

        public function hideBitmapAlpha() : void
        {
            visible = true;
            if (this._bmpAlpha != null && StageShareManager.stage.contains(this._bmpAlpha))
            {
                this.parent.removeChild(this._bmpAlpha);
                this._bmpAlpha = null;
            }
            return;
        }// end function

        override protected function onAdded(event:Event) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            super.onAdded(event);
            var _loc_2:* = event.target as TiphonAnimation;
            var _loc_3:* = SoundBones.getSoundBonesById(look.getBone());
            if (_loc_3)
            {
                _loc_4 = getQualifiedClassName(_loc_2);
                _loc_5 = _loc_3.getSoundAnimations(_loc_4);
                _loc_2.spriteHandler.tiphonEventManager.removeEvents(TiphonEventsManager.BALISE_SOUND, _loc_4);
                for each (_loc_6 in _loc_5)
                {
                    
                    _loc_7 = TiphonEventsManager.BALISE_DATASOUND + TiphonEventsManager.BALISE_PARAM_BEGIN + (_loc_6.label != null && _loc_6.label != "null" ? (_loc_6.label) : ("")) + TiphonEventsManager.BALISE_PARAM_END;
                    _loc_2.spriteHandler.tiphonEventManager.addEvent(_loc_7, _loc_6.startFrame, _loc_4);
                }
            }
            return;
        }// end function

    }
}
