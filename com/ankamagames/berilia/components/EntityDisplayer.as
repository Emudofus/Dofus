package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.sequence.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class EntityDisplayer extends GraphicContainer implements UIComponent, IRectangle
    {
        private var _entity:TiphonSprite;
        private var _oldEntity:TiphonSprite;
        private var _direction:uint = 1;
        private var _animation:String = "AnimStatique";
        private var _view:String;
        private var _scale:Number = 1;
        private var _mask:Shape;
        private var _mask2:Shape;
        private var _lookUpdate:TiphonEntityLook;
        private var _listenForUpdate:Boolean = false;
        private var _waitingForEquipement:Array;
        private var _skipResize:Boolean = false;
        private var _staticDisplay:Boolean = false;
        private var _useCache:Boolean = false;
        private var _fromCache:Boolean = false;
        private var _cache:Object;
        private var _gotoAndStop:int = 0;
        private var _originalScaleX:Number;
        private var _originalScaleY:Number;
        public var yOffset:uint = 0;
        public var xOffset:uint = 0;
        public var autoSize:Boolean = true;
        public var useFade:Boolean = true;
        public var clearSubEntities:Boolean = true;
        public var clearAuras:Boolean = true;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        public static var animationModifier:IAnimationModifier;
        public static var lookAdaptater:Function;
        private static const _subEntitiesBehaviors:Dictionary = new Dictionary();

        public function EntityDisplayer()
        {
            this._waitingForEquipement = new Array();
            mouseChildren = false;
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function set look(param1) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (lookAdaptater != null)
            {
                _loc_2 = lookAdaptater(param1);
            }
            else if (param1 is TiphonEntityLook)
            {
                _loc_2 = param1 as TiphonEntityLook;
            }
            else
            {
                throw new ArgumentError();
            }
            if (this._entity)
            {
                this._entity.visible = _loc_2 != null;
            }
            if (_loc_2 != null)
            {
                if (this.clearSubEntities)
                {
                    _loc_2.resetSubEntities();
                }
                else if (this.clearAuras)
                {
                    _loc_2.removeSubEntity(6);
                }
            }
            if (_loc_2 && this._lookUpdate)
            {
                if (_loc_2.toString() == this._lookUpdate.toString())
                {
                    return;
                }
            }
            this._lookUpdate = _loc_2 ? (_loc_2.clone()) : (_loc_2);
            if (this._useCache)
            {
                _loc_3 = this._cache[_loc_2.toString()];
                if (_loc_3)
                {
                    if (this._entity)
                    {
                        this.destroyOldEntity(this._entity);
                    }
                    addChild(_loc_3);
                    this._entity = _loc_3;
                    this._fromCache = true;
                    return;
                }
            }
            this._fromCache = false;
            this._listenForUpdate = true;
            EnterFrameDispatcher.addEventListener(this.needUpdate, "EntityDisplayerUpdater");
            return;
        }// end function

        public function get look() : TiphonEntityLook
        {
            return this._entity ? (this._entity.look) : (this._lookUpdate);
        }// end function

        public function set direction(param1:uint) : void
        {
            this._direction = param1;
            if (!this._listenForUpdate && this._entity is TiphonSprite)
            {
                TiphonSprite(this._entity).setDirection(param1);
            }
            return;
        }// end function

        public function set animation(param1:String) : void
        {
            this._animation = param1;
            if (this._entity is TiphonSprite)
            {
                TiphonSprite(this._entity).setAnimation(param1);
            }
            return;
        }// end function

        public function set gotoAndStop(param1:int) : void
        {
            if (this._entity)
            {
                if (param1 == -1)
                {
                    this._entity.stopAnimationAtEnd();
                }
                else
                {
                    this._entity.stopAnimation(param1);
                }
            }
            else
            {
                this._gotoAndStop = param1;
            }
            return;
        }// end function

        public function set staticDisplay(param1:Boolean) : void
        {
            this._staticDisplay = param1;
            return;
        }// end function

        public function get staticDisplay() : Boolean
        {
            return this._staticDisplay;
        }// end function

        override public function set scale(param1:Number) : void
        {
            this._scale = param1;
            return;
        }// end function

        override public function get scale() : Number
        {
            return this._scale;
        }// end function

        public function get direction() : uint
        {
            return this._direction;
        }// end function

        public function get animation() : String
        {
            return this._animation;
        }// end function

        public function set view(param1:String) : void
        {
            this._view = param1;
            if (this._entity is TiphonSprite)
            {
                this._entity.setView(param1);
            }
            return;
        }// end function

        override public function set HandCursor(param1:Boolean) : void
        {
            super.HandCursor = param1;
            if (param1)
            {
                addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
                addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            }
            else
            {
                removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
                removeEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            }
            return;
        }// end function

        public function get useCache() : Boolean
        {
            return this._useCache;
        }// end function

        public function set useCache(param1:Boolean) : void
        {
            this._useCache = param1;
            if (!this._cache)
            {
                this._cache = new Object();
            }
            return;
        }// end function

        override public function get cacheAsBitmap() : Boolean
        {
            return super.cacheAsBitmap;
        }// end function

        override public function set cacheAsBitmap(param1:Boolean) : void
        {
            _log.fatal("Attention : Il ne faut surtout pas utiliser la propriété cacheAsBitmap sur les EntityDisplayer. TiphonSprite le gère déjà.");
            return;
        }// end function

        public function setAnimationAndDirection(param1:String, param2:uint) : void
        {
            var _loc_3:* = null;
            if (!this._fromCache)
            {
                this._animation = param1;
                this._direction = param2;
                if (this._entity is TiphonSprite)
                {
                    _loc_3 = new SerialSequencer();
                    if (this._animation == "AnimStatique")
                    {
                        TiphonSprite(this._entity).setAnimationAndDirection("AnimStatique", this._direction);
                    }
                    else if (this._animation == "AnimArtwork")
                    {
                        TiphonSprite(this._entity).setAnimationAndDirection("AnimArtwork", this._direction);
                    }
                    else
                    {
                        _loc_3.addStep(new SetDirectionStep(TiphonSprite(this._entity), this._direction));
                        _loc_3.addStep(new PlayAnimationStep(TiphonSprite(this._entity), this._animation, false));
                        _loc_3.addStep(new SetAnimationStep(TiphonSprite(this._entity), "AnimStatique"));
                        _loc_3.start();
                    }
                }
            }
            return;
        }// end function

        public function equipCharacter(param1:Array, param2:int = 0) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (this._entity is TiphonSprite)
            {
                _loc_3 = TiphonSprite(this._entity).look.toString().split("|");
                if (param1.length)
                {
                    param1.unshift(_loc_3[1].split(","));
                    _loc_3[1] = param1.join(",");
                }
                else if (param2 < _loc_3[1].length)
                {
                    _loc_5 = _loc_3[1].split(",");
                    _loc_6 = 0;
                    while (_loc_6 < param2)
                    {
                        
                        _loc_5.pop();
                        _loc_6++;
                    }
                    _loc_3[1] = _loc_5.join(",");
                }
                _loc_4 = TiphonEntityLook.fromString(_loc_3.join("|"));
                this._entity.look.updateFrom(_loc_4);
            }
            else if (!this._entity && param1.length)
            {
                this._waitingForEquipement = param1;
            }
            return;
        }// end function

        public function getSlotPosition(param1:String) : Point
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._entity && this._entity is TiphonSprite)
            {
                _loc_2 = TiphonSprite(this._entity).getSlot(param1);
                if (_loc_2)
                {
                    _loc_3 = _loc_2.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    _loc_4 = this.globalToLocal(_loc_3);
                    return _loc_4;
                }
                _log.error("Null entity, cannot get slot position.");
                return null;
            }
            else
            {
                _log.error("Null entity, cannot get slot position.");
                return null;
            }
        }// end function

        override public function remove() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._entity)
            {
                (this._entity as EventDispatcher).removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onCharacterReady);
                this._entity.destroy();
                this._entity = null;
            }
            if (this._oldEntity)
            {
                (this._oldEntity as EventDispatcher).removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onCharacterReady);
                this._oldEntity.destroy();
                this._oldEntity = null;
            }
            if (this._cache)
            {
                for each (_loc_2 in this._cache)
                {
                    
                    _loc_2.destroy();
                }
                this._cache = null;
            }
            this._lookUpdate = null;
            EnterFrameDispatcher.removeEventListener(this.onFade);
            removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            removeEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            for each (_loc_1 in _subEntitiesBehaviors)
            {
                
                if (_loc_1)
                {
                    _loc_1.remove();
                }
            }
            super.remove();
            return;
        }// end function

        public function setColor(param1:uint, param2:uint) : void
        {
            if (TiphonSprite(this._entity) && TiphonSprite(this._entity).look)
            {
                TiphonSprite(this._entity).look.setColor(param1, param2);
            }
            return;
        }// end function

        public function resetColor(param1:uint) : void
        {
            if (TiphonSprite(this._entity) && TiphonSprite(this._entity).look)
            {
                TiphonSprite(this._entity).look.resetColor(param1);
            }
            return;
        }// end function

        private function onCharacterReady(event:Event) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            if (this._gotoAndStop)
            {
                if (this._gotoAndStop == -1)
                {
                    this._entity.stopAnimationAtEnd();
                }
                else
                {
                    this._entity.stopAnimation(this._gotoAndStop);
                }
                this._gotoAndStop = 0;
            }
            if (this._staticDisplay)
            {
                if (this._skipResize)
                {
                    return;
                }
                this._skipResize = true;
            }
            this._entity.x = 0;
            this._entity.y = 0;
            if (EntityDisplayer.animationModifier != null)
            {
                (this._entity as TiphonSprite).addAnimationModifier(EntityDisplayer.animationModifier);
            }
            for (_loc_2 in _subEntitiesBehaviors)
            {
                
                if (_subEntitiesBehaviors[_loc_2])
                {
                    (this._entity as TiphonSprite).setSubEntityBehaviour(_loc_2, _subEntitiesBehaviors[_loc_2]);
                }
            }
            this._entity.visible = true;
            if (this._scale > 1 || this.yOffset != 0)
            {
                if (this._mask)
                {
                    this._mask.graphics.clear();
                }
                else
                {
                    this._mask = new Shape();
                }
                this._mask.graphics.beginFill(0);
                this._mask.graphics.drawRect(0, 0, width, height);
                addChild(this._mask);
                TiphonSprite(this._entity).mask = this._mask;
                if (this._oldEntity)
                {
                    if (this._mask2)
                    {
                        this._mask2.graphics.clear();
                    }
                    else
                    {
                        this._mask2 = new Shape();
                    }
                    this._mask2.graphics.beginFill(0);
                    this._mask2.graphics.drawRect(0, 0, width, height);
                    addChild(this._mask2);
                    TiphonSprite(this._oldEntity).mask = this._mask2;
                }
            }
            else
            {
                TiphonSprite(this._entity).mask = null;
                if (this._mask)
                {
                    removeChild(this._mask);
                }
                this._mask = null;
            }
            if (this._oldEntity)
            {
                if (this.useFade)
                {
                    this._oldEntity.alpha = 1;
                    this._entity.alpha = 0;
                    EnterFrameDispatcher.addEventListener(this.onFade, "entityDisplayerFade");
                }
                else
                {
                    this.destroyOldEntity(this._oldEntity);
                    this._oldEntity = null;
                }
            }
            if (!this._entity.height || !this.autoSize)
            {
                Berilia.getInstance().handler.process(new EntityReadyMessage(InteractiveObject(this)));
                return;
            }
            if (this._view != null)
            {
                _loc_5 = TiphonSprite(this._entity).getDisplayInfoSprite(this._view);
                if (_loc_5 != null)
                {
                    TiphonSprite(this._entity).look.setScales(1, 1);
                    TiphonSprite(this._entity).setView(this._view);
                    _loc_3 = this._entity.width / this._entity.height;
                    if (this._entity.width > this._entity.height)
                    {
                        this._entity.height = width / _loc_3 * this._scale;
                        this._entity.width = width * this._scale;
                    }
                    else
                    {
                        this._entity.width = height * _loc_3 * this._scale;
                        this._entity.height = height * this._scale;
                    }
                    _loc_4 = TiphonSprite(this._entity).getBounds(this);
                    this._entity.x = (width - this._entity.width) / 2 - _loc_4.left + this.xOffset;
                    this._entity.y = (height - this._entity.height) / 2 - _loc_4.top + this.yOffset;
                    _loc_6 = _loc_5.width / _loc_5.height;
                    _loc_7 = width / height < _loc_5.width / _loc_5.height ? (width / _loc_5.getRect(this).width) : (height / _loc_5.getRect(this).height);
                    this._entity.height = this._entity.height * _loc_7;
                    this._entity.width = this._entity.width * _loc_7;
                    this._entity.x = this._entity.x - _loc_5.getRect(this).x;
                    this._entity.y = this._entity.y - _loc_5.getRect(this).y;
                }
            }
            else
            {
                _loc_3 = this._entity.width / this._entity.height;
                if (this._entity.width > this._entity.height)
                {
                    this._entity.height = width / _loc_3 * this._scale;
                    this._entity.width = width * this._scale;
                }
                else
                {
                    this._entity.width = height * _loc_3 * this._scale;
                    this._entity.height = height * this._scale;
                }
                _loc_4 = TiphonSprite(this._entity).getBounds(this);
                this._entity.x = (width - this._entity.width) / 2 - _loc_4.left + this.xOffset;
                this._entity.y = (height - this._entity.height) / 2 - _loc_4.top + this.yOffset;
            }
            this._entity.visible = true;
            Berilia.getInstance().handler.process(new EntityReadyMessage(InteractiveObject(this)));
            return;
        }// end function

        private function destroyOldEntity(param1:TiphonSprite) : void
        {
            if (param1.parent)
            {
                removeChild(param1);
            }
            if (!this._useCache)
            {
                param1.destroy();
            }
            return;
        }// end function

        private function needUpdate(event:Event) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            EnterFrameDispatcher.removeEventListener(this.needUpdate);
            this._listenForUpdate = false;
            if (this._oldEntity)
            {
                this.destroyOldEntity(this._oldEntity);
                this._oldEntity = null;
            }
            if (!this._lookUpdate)
            {
                if (this._entity)
                {
                    this.destroyOldEntity(this._entity);
                    this._entity = null;
                }
                return;
            }
            this._oldEntity = this._entity;
            this._entity = new TiphonSprite(SecureCenter.unsecure(this._lookUpdate.clone()));
            this._entity.visible = false;
            if (this._useCache)
            {
                _loc_3 = this._entity.look.toString();
                this._cache[_loc_3] = this._entity;
            }
            this._originalScaleX = (this._entity as TiphonSprite).look.getScaleX();
            this._originalScaleY = (this._entity as TiphonSprite).look.getScaleY();
            if (EntityDisplayer.animationModifier != null)
            {
                (this._entity as TiphonSprite).addAnimationModifier(EntityDisplayer.animationModifier);
            }
            for (_loc_2 in _subEntitiesBehaviors)
            {
                
                if (_subEntitiesBehaviors[_loc_2])
                {
                    (this._entity as TiphonSprite).setSubEntityBehaviour(_loc_2, _subEntitiesBehaviors[_loc_2]);
                }
            }
            (this._entity as EventDispatcher).addEventListener(TiphonEvent.RENDER_SUCCEED, this.onCharacterReady);
            addChild(this._entity);
            this.setAnimationAndDirection(this._animation, this._direction);
            if (this._waitingForEquipement.length)
            {
                this.equipCharacter(this._waitingForEquipement, 0);
            }
            return;
        }// end function

        private function onFade(event:Event) : void
        {
            if (this._entity)
            {
                this._entity.alpha = this._entity.alpha + (1 - this._entity.alpha) / 3;
                this._oldEntity.alpha = this._oldEntity.alpha + -this._oldEntity.alpha / 3;
                if (this._oldEntity.alpha < 0.05)
                {
                    this._entity.alpha = 1;
                    this.destroyOldEntity(this._oldEntity);
                    this._oldEntity = null;
                    EnterFrameDispatcher.removeEventListener(this.onFade);
                }
            }
            else
            {
                EnterFrameDispatcher.removeEventListener(this.onFade);
                _log.error("entity est null");
            }
            return;
        }// end function

        private function mouseOver(event:MouseEvent) : void
        {
            this._entity.transform.colorTransform = new ColorTransform(1.3, 1.3, 1.3, 1);
            return;
        }// end function

        private function mouseOut(event:MouseEvent) : void
        {
            this._entity.transform.colorTransform = new ColorTransform(1, 1, 1, 1);
            return;
        }// end function

        public static function setSubEntityDefaultBehavior(param1:uint, param2:ISubEntityBehavior) : void
        {
            _subEntitiesBehaviors[param1] = param2;
            return;
        }// end function

    }
}
