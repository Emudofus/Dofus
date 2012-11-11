package com.ankamagames.tiphon.display
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.*;
    import com.ankamagames.tiphon.engine.*;
    import com.ankamagames.tiphon.error.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class TiphonSprite extends Sprite implements IAnimated, IAnimationSpriteHandler, IDestroyable, EntityLookObserver
    {
        protected var _useCacheIfPossible:Boolean = false;
        private var _init:Boolean = false;
        public var _currentAnimation:String;
        private var _lastAnimation:String;
        private var _targetAnimation:String;
        private var _currentDirection:int;
        private var _animMovieClip:TiphonAnimation;
        private var _customColoredParts:Array;
        private var _displayInfoParts:Dictionary;
        private var _customView:String;
        private var _aTransformColors:Array;
        private var _skin:Skin;
        private var _aSubEntities:Array;
        private var _subEntitiesList:Array;
        private var _look:TiphonEntityLook;
        private var _lookCode:String;
        private var _rasterize:Boolean = false;
        private var _parentSprite:TiphonSprite;
        private var _rendered:Boolean = false;
        private var _libReady:Boolean = false;
        private var _subEntityBehaviors:Array;
        private var _backgroundTemp:Array;
        private var _subEntitiesTemp:Vector.<SubEntityTempInfo>;
        private var _lastClassName:String;
        private var _alternativeSkinIndex:int = -1;
        private var _recursiveAlternativeSkinIndex:Boolean = false;
        private var _background:Array;
        private var _deactivatedSubEntityCategory:Array;
        private var _waitingEventInitList:Vector.<Event>;
        private var _backgroundOnly:Boolean = false;
        private var _tiphonEventManager:TiphonEventsManager;
        private var _animationModifier:Array;
        private var _savedMouseEnabled:Boolean = true;
        public var destroyed:Boolean = false;
        public var overrideNextAnimation:Boolean = false;
        public var disableMouseEventWhenAnimated:Boolean = false;
        private var _lastRenderRequest:uint;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        public static var MEMORY_LOG2:Dictionary = new Dictionary(true);
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonSprite));
        private static var _cache:Dictionary = new Dictionary();

        public function TiphonSprite(param1:TiphonEntityLook)
        {
            var _loc_2:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            this._backgroundTemp = new Array();
            this._deactivatedSubEntityCategory = new Array();
            this._waitingEventInitList = new Vector.<Event>;
            this._animationModifier = [];
            this._lastRenderRequest = getTimer();
            FpsManager.getInstance().watchObject(this, true);
            this._libReady = false;
            this._background = new Array();
            this.initializeLibrary(param1.getBone());
            this._subEntityBehaviors = new Array();
            this._currentAnimation = null;
            this._currentDirection = -1;
            this._customColoredParts = new Array();
            this._displayInfoParts = new Dictionary();
            this._aTransformColors = new Array();
            this._aSubEntities = new Array();
            this._subEntitiesList = new Array();
            this._subEntitiesTemp = new Vector.<SubEntityTempInfo>;
            this._look = param1;
            this._lookCode = this._look.toString();
            this._skin = new Skin();
            this._skin.addEventListener(Event.COMPLETE, this.checkRessourceState);
            var _loc_3:* = this._look.getSkins(true);
            if (_loc_3)
            {
                _loc_2 = _loc_3.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_2)
                {
                    
                    _loc_7 = _loc_3[_loc_6];
                    _loc_7 = this._skin.add(_loc_7, this._alternativeSkinIndex);
                    _loc_6++;
                }
            }
            var _loc_4:* = this._look.getSubEntities(true);
            for (_loc_5 in _loc_4)
            {
                
                _loc_8 = int(_loc_5);
                _loc_2 = _loc_4[_loc_8].length;
                _loc_9 = 0;
                while (_loc_9 < _loc_2)
                {
                    
                    _loc_10 = new TiphonSprite(this._look.getSubEntity(_loc_8, _loc_9));
                    _loc_10.addEventListener(TiphonEvent.RENDER_SUCCEED, this.onSubEntityRendered, false, 0, true);
                    this.addSubEntity(_loc_10, _loc_8, _loc_9);
                    _loc_9 = _loc_9 + 1;
                }
            }
            this._look.addObserver(this);
            this.mouseChildren = false;
            this._tiphonEventManager = new TiphonEventsManager(this);
            this._init = true;
            if (this._waitingEventInitList.length)
            {
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, this.dispatchWaitingEvents);
            }
            return;
        }// end function

        public function get tiphonEventManager() : TiphonEventsManager
        {
            if (this._tiphonEventManager == null)
            {
                throw new TiphonError("_tiphonEventManager is null, can\'t access so");
            }
            return this._tiphonEventManager;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            return;
        }// end function

        override public function set alpha(param1:Number) : void
        {
            super.alpha = param1;
            return;
        }// end function

        override public function set mouseEnabled(param1:Boolean) : void
        {
            this._savedMouseEnabled = param1;
            super.mouseEnabled = param1;
            return;
        }// end function

        override public function get mouseEnabled() : Boolean
        {
            return this._savedMouseEnabled;
        }// end function

        public function get bitmapData() : BitmapData
        {
            var _loc_1:* = getBounds(this);
            if (_loc_1.height * _loc_1.width == 0)
            {
                return null;
            }
            var _loc_2:* = new BitmapData(_loc_1.right - _loc_1.left, _loc_1.bottom - _loc_1.top, true, 22015);
            var _loc_3:* = new Matrix();
            _loc_3.translate(-_loc_1.left, -_loc_1.top);
            _loc_2.draw(this, _loc_3);
            return _loc_2;
        }// end function

        public function get look() : TiphonEntityLook
        {
            return this._look;
        }// end function

        public function get rasterize() : Boolean
        {
            return this._rasterize;
        }// end function

        public function set rasterize(param1:Boolean) : void
        {
            this._rasterize = param1;
            return;
        }// end function

        public function get rawAnimation() : TiphonAnimation
        {
            return this._animMovieClip;
        }// end function

        public function get libraryIsAvaible() : Boolean
        {
            return this._libReady;
        }// end function

        public function get skinIsAvailable() : Boolean
        {
            return this._skin.complete;
        }// end function

        public function get parentSprite() : TiphonSprite
        {
            return this._parentSprite;
        }// end function

        public function get rootEntity() : TiphonSprite
        {
            var _loc_1:* = this;
            while (_loc_1._parentSprite)
            {
                
                _loc_1 = _loc_1._parentSprite;
            }
            return _loc_1;
        }// end function

        public function get maxFrame() : uint
        {
            if (this._animMovieClip)
            {
                return this._animMovieClip.totalFrames;
            }
            return 0;
        }// end function

        public function get animationModifiers() : Array
        {
            return this._animationModifier;
        }// end function

        public function get animationList() : Array
        {
            if (BoneIndexManager.getInstance().hasCustomBone(this._look.getBone()))
            {
                return BoneIndexManager.getInstance().getAllCustomAnimations(this._look.getBone());
            }
            return Tiphon.skullLibrary.getResourceById(this._look.getBone()).getDefinitions();
        }// end function

        public function stopAnimation(param1:int = 0) : void
        {
            if (this._animMovieClip)
            {
                if (param1)
                {
                    this._animMovieClip.gotoAndStop(param1);
                }
                else
                {
                    this._animMovieClip.stop();
                }
                FpsControler.uncontrolFps(this._animMovieClip);
            }
            return;
        }// end function

        public function stopAnimationAtLastFrame() : void
        {
            if (this._animMovieClip)
            {
                this.stopAnimationAtEnd();
                this.restartAnimation();
            }
            else
            {
                addEventListener(TiphonEvent.RENDER_SUCCEED, this.onLoadComplete);
            }
            return;
        }// end function

        private function onLoadComplete(event:TiphonEvent) : void
        {
            removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onLoadComplete);
            this.stopAnimation(this.maxFrame);
            return;
        }// end function

        public function restartAnimation(param1:int = -1) : void
        {
            var _loc_2:* = Tiphon.skullLibrary.getResourceById(this._look.getBone(), this._currentAnimation);
            if (this._animMovieClip && _loc_2)
            {
                if (param1 != -1)
                {
                    this._animMovieClip.gotoAndStop(param1);
                }
                FpsControler.controlFps(this._animMovieClip, _loc_2.frameRate);
            }
            return;
        }// end function

        public function stopAnimationAtEnd() : void
        {
            var _loc_1:* = null;
            if (this._animMovieClip)
            {
                this._animMovieClip.gotoAndStop(this._animMovieClip.totalFrames);
                if (this._animMovieClip.numChildren)
                {
                    _loc_1 = this._animMovieClip.getChildAt(0) as MovieClip;
                    if (_loc_1)
                    {
                        _loc_1.gotoAndStop(_loc_1.totalFrames);
                    }
                }
                FpsControler.uncontrolFps(this._animMovieClip);
                this._animMovieClip.cacheAsBitmap = true;
            }
            return;
        }// end function

        public function setDirection(param1:uint) : void
        {
            if (this._currentAnimation)
            {
                this.setAnimationAndDirection(this._currentAnimation, param1);
            }
            else
            {
                this._currentDirection = param1;
            }
            return;
        }// end function

        public function getDirection() : uint
        {
            return this._currentDirection > 0 ? (this._currentDirection) : (0);
        }// end function

        public function setAnimation(param1:String) : void
        {
            this.setAnimationAndDirection(param1, this._currentDirection);
            return;
        }// end function

        public function getAnimation() : String
        {
            return this._currentAnimation;
        }// end function

        public function addAnimationModifier(param1:IAnimationModifier, param2:Boolean = true) : void
        {
            if (!param2 || this._animationModifier.indexOf(param1) == -1)
            {
                this._animationModifier.push(param1);
            }
            this._animationModifier.sortOn("priority");
            return;
        }// end function

        public function removeAnimationModifier(param1:IAnimationModifier) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._animationModifier)
            {
                
                if (param1 != _loc_3)
                {
                    _loc_2.push(_loc_3);
                }
            }
            this._animationModifier = _loc_2;
            return;
        }// end function

        public function removeAnimationModifierByClass(param1:Class) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._animationModifier)
            {
                
                if (!(_loc_3 is param1))
                {
                    _loc_2.push(_loc_3);
                }
            }
            this._animationModifier = _loc_2;
            return;
        }// end function

        public function setAnimationAndDirection(param1:String, param2:uint) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (this.destroyed)
            {
                return;
            }
            FpsManager.getInstance().startTracking("animation", 40277);
            if (!param1)
            {
                param1 = this._currentAnimation;
            }
            if (this is IEntity)
            {
                if ((this._currentAnimation == "AnimMarche" || this._currentAnimation == "AnimCourse") && param1 == "AnimStatique")
                {
                    for each (_loc_5 in TiphonEventsManager.listeners)
                    {
                        
                        _loc_5.listener.removeEntitySound(this as IEntity);
                    }
                }
            }
            var _loc_3:* = new BehaviorData(param1, param2, this);
            for (_loc_4 in this._aSubEntities)
            {
                
                _loc_6 = this._aSubEntities[_loc_4];
                if (!_loc_6)
                {
                    continue;
                }
                for each (_loc_7 in _loc_6)
                {
                    
                    if (_loc_7 is TiphonSprite)
                    {
                        if (this._subEntityBehaviors[_loc_4])
                        {
                            (this._subEntityBehaviors[_loc_4] as ISubEntityBehavior).updateFromParentEntity(TiphonSprite(_loc_7), _loc_3);
                            continue;
                        }
                        this.updateFromParentEntity(TiphonSprite(_loc_7), _loc_3);
                    }
                }
            }
            if (this._animationModifier)
            {
                for each (_loc_8 in this._animationModifier)
                {
                    
                    _loc_3.animation = _loc_8.getModifiedAnimation(_loc_3.animation, this.look);
                }
            }
            if (!this.overrideNextAnimation && _loc_3.animation == this._currentAnimation && param2 == this._currentDirection)
            {
                if (this._animMovieClip && this._animMovieClip.totalFrames > 1)
                {
                    this.restartAnimation();
                }
                if (this._subEntitiesList.length)
                {
                    this.dispatchEvent(new TiphonEvent(TiphonEvent.RENDER_FATHER_SUCCEED, this));
                }
                this.dispatchEvent(new TiphonEvent(TiphonEvent.RENDER_SUCCEED, this));
                return;
            }
            this.overrideNextAnimation = false;
            this._lastAnimation = this._currentAnimation;
            this._currentDirection = param2;
            if (BoneIndexManager.getInstance().hasTransition(this._look.getBone(), this._lastAnimation, _loc_3.animation, this._currentDirection))
            {
                _loc_9 = BoneIndexManager.getInstance().getTransition(this._look.getBone(), this._lastAnimation, _loc_3.animation, this._currentDirection);
                this._currentAnimation = _loc_9;
                this._targetAnimation = _loc_3.animation;
            }
            else
            {
                this._currentAnimation = _loc_3.animation;
            }
            if (BoneIndexManager.getInstance().hasCustomBone(this._look.getBone()))
            {
                this.initializeLibrary(this._look.getBone(), BoneIndexManager.getInstance().getBoneFile(this._look.getBone(), this._currentAnimation));
            }
            this._rendered = false;
            this.finalize();
            FpsManager.getInstance().stopTracking("animation");
            return;
        }// end function

        public function setView(param1:String) : void
        {
            this._customView = param1;
            var _loc_2:* = this.getDisplayInfoSprite(param1);
            if (_loc_2)
            {
                if (this.mask != null)
                {
                    this.mask.parent.removeChild(this.mask);
                }
                addChild(_loc_2);
                this.mask = _loc_2;
            }
            return;
        }// end function

        public function setSubEntityBehaviour(param1:int, param2:ISubEntityBehavior) : void
        {
            this._subEntityBehaviors[param1] = param2;
            return;
        }// end function

        public function updateFromParentEntity(param1:TiphonSprite, param2:BehaviorData) : void
        {
            if (!param1)
            {
                return;
            }
            var _loc_3:* = false;
            var _loc_4:* = param1.getAvaibleDirection(param2.animation);
            var _loc_5:* = 0;
            while (_loc_5 < 8)
            {
                
                _loc_3 = _loc_4[_loc_5] || _loc_3;
                _loc_5++;
            }
            if (_loc_3 || !this._libReady)
            {
                param1.setAnimationAndDirection(param2.animation, param2.direction);
            }
            return;
        }// end function

        public function destroy() : void
        {
            var i:int;
            var num:int;
            var subEntity:TiphonSprite;
            try
            {
                if (!this.destroyed)
                {
                    if (parent)
                    {
                        parent.removeChild(this);
                    }
                    this.destroyed = true;
                    this._parentSprite = null;
                    if (this._look)
                    {
                        this._look.removeObserver(this);
                    }
                    this.clearAnimation();
                    if (this._tiphonEventManager)
                    {
                        this._tiphonEventManager.destroy();
                        this._tiphonEventManager = null;
                    }
                    if (this._subEntitiesList)
                    {
                        i;
                        num = this._subEntitiesList.length;
                        do
                        {
                            
                            subEntity = this._subEntitiesList[i] as TiphonSprite;
                            if (subEntity)
                            {
                                this.removeSubEntity(subEntity);
                                subEntity.destroy();
                            }
                            i = (i + 1);
                        }while ((i + 1) < num)
                    }
                    if (this._subEntitiesTemp)
                    {
                        i;
                        num = this._subEntitiesTemp.length;
                        do
                        {
                            
                            subEntity = this._subEntitiesList[i].entity as TiphonSprite;
                            if (subEntity)
                            {
                                subEntity.destroy();
                            }
                            i = (i + 1);
                        }while ((i + 1) < num)
                        this._subEntitiesTemp = null;
                    }
                    if (this._skin)
                    {
                        this._skin.reset();
                        this._skin.removeEventListener(Event.COMPLETE, this.checkRessourceState);
                        this._skin = null;
                    }
                    this._subEntitiesList = null;
                    this._aSubEntities = null;
                    this._subEntityBehaviors = null;
                    this._customColoredParts = null;
                    this._displayInfoParts = null;
                    this._aTransformColors = null;
                    this._backgroundTemp = null;
                    this._subEntitiesTemp = null;
                    this._background = null;
                    this._animationModifier = null;
                }
            }
            catch (e:Error)
            {
                _log.fatal("TiphonSprite impossible à détruire !");
            }
            return;
        }// end function

        public function getAvaibleDirection(param1:String = null, param2:Boolean = false) : Array
        {
            var _loc_3:* = Tiphon.skullLibrary.getResourceById(this._look.getBone());
            var _loc_4:* = new Array();
            if (!_loc_3)
            {
                return [];
            }
            var _loc_5:* = 0;
            while (_loc_5 < 8)
            {
                
                _loc_4[_loc_5] = _loc_3.getDefinitions().indexOf((param1 ? (param1) : (this._currentAnimation)) + "_" + _loc_5) != -1;
                if (param2 && !_loc_4[_loc_5])
                {
                    _loc_4[_loc_5] = _loc_3.getDefinitions().indexOf((param1 ? (param1) : (this._currentAnimation)) + "_" + TiphonUtility.getFlipDirection(_loc_5)) != -1;
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_4;
        }// end function

        public function hasAnimation(param1:String, param2:int = -1) : Boolean
        {
            if (param2 != -1)
            {
                return Tiphon.skullLibrary.hasAnim(this._look.getBone(), param1, param2) || Tiphon.skullLibrary.hasAnim(this._look.getBone(), param1, TiphonUtility.getFlipDirection(param2));
            }
            var _loc_3:* = 0;
            while (_loc_3 < 8)
            {
                
                Tiphon.skullLibrary.hasAnim(this._look.getBone(), (param1 ? (param1) : (this._currentAnimation)) + "_" + _loc_3);
                if (param2)
                {
                    return true;
                }
                _loc_3 = _loc_3 + 1;
            }
            return false;
        }// end function

        public function getSlot(param1:String = "") : DisplayObject
        {
            var _loc_2:* = 0;
            if (numChildren && this._animMovieClip)
            {
                _loc_2 = 0;
                while (_loc_2 < this._animMovieClip.numChildren)
                {
                    
                    if (getQualifiedClassName(this._animMovieClip.getChildAt(_loc_2)).indexOf(param1) == 0)
                    {
                        return this._animMovieClip.getChildAt(_loc_2);
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            return null;
        }// end function

        public function getColorTransform(param1:uint) : ColorTransform
        {
            var _loc_3:* = null;
            if (this._aTransformColors[param1])
            {
                return this._aTransformColors[param1];
            }
            var _loc_2:* = this._look.getColor(param1);
            if (!_loc_2.isDefault)
            {
                _loc_3 = new ColorTransform();
                _loc_3.color = _loc_2.color;
                this._aTransformColors[param1] = _loc_3;
                return _loc_3;
            }
            return null;
        }// end function

        public function getSkinSprite(param1:EquipmentSprite) : Sprite
        {
            var _loc_2:* = getQualifiedClassName(param1);
            return this._skin.getPart(_loc_2);
        }// end function

        public function addSubEntity(param1:DisplayObject, param2:uint, param3:uint) : void
        {
            param1.x = 0;
            param1.y = 0;
            var _loc_4:* = param1 as TiphonSprite;
            if (param1 as TiphonSprite)
            {
                _loc_4._parentSprite = this;
                _loc_4.overrideNextAnimation = true;
                _loc_4.setDirection(this._currentDirection);
            }
            if (this._rendered)
            {
                if (!this._aSubEntities[param2])
                {
                    this._aSubEntities[param2] = new Array();
                }
                this._aSubEntities[param2][param3] = param1;
                this.dispatchEvent(new TiphonEvent(TiphonEvent.SUB_ENTITY_ADDED, this));
                this._subEntitiesList.push(param1);
                _log.debug("Add subentity " + param1.name + " to " + name + " (cat: " + param2 + ")");
                if (this._recursiveAlternativeSkinIndex && _loc_4)
                {
                    _loc_4.setAlternativeSkinIndex(this._alternativeSkinIndex);
                }
                this.finalize();
            }
            else
            {
                this._subEntitiesTemp.push(new SubEntityTempInfo(param1, param2, param3));
            }
            return;
        }// end function

        public function removeSubEntity(param1:DisplayObject) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_6:* = null;
            if (this.destroyed)
            {
                return;
            }
            for (_loc_3 in this._aSubEntities)
            {
                
                for (_loc_6 in this._aSubEntities[_loc_3])
                {
                    
                    if (param1 === this._aSubEntities[_loc_3][_loc_6])
                    {
                        if (this._subEntityBehaviors[_loc_3] is ISubEntityBehavior)
                        {
                            ISubEntityBehavior(this._subEntityBehaviors[_loc_3]).remove();
                        }
                        delete this._subEntityBehaviors[_loc_3];
                        delete this._aSubEntities[_loc_3][_loc_6];
                        _loc_2 = true;
                        break;
                    }
                }
                if (_loc_2)
                {
                    break;
                }
            }
            _loc_4 = this._subEntitiesList.indexOf(param1);
            if (_loc_4 != -1)
            {
                this._subEntitiesList.splice(_loc_4, 1);
            }
            var _loc_5:* = param1 as TiphonSprite;
            if (param1 as TiphonSprite)
            {
                _loc_5._parentSprite = null;
                _loc_5.overrideNextAnimation = true;
            }
            return;
        }// end function

        public function getSubEntitySlot(param1:uint, param2:uint) : DisplayObjectContainer
        {
            if (this.destroyed)
            {
                return null;
            }
            if (this._aSubEntities[param1] && this._aSubEntities[param1][param2])
            {
                if (this._aSubEntities[param1][param2] is TiphonSprite)
                {
                    (this._aSubEntities[param1][param2] as TiphonSprite)._parentSprite = this;
                }
            }
            else
            {
                return null;
            }
            return this._aSubEntities[param1][param2];
        }// end function

        public function getSubEntitiesList() : Array
        {
            return this._subEntitiesList;
        }// end function

        public function getTmpSubEntitiesNb() : uint
        {
            return this._subEntitiesTemp.length;
        }// end function

        public function registerColoredSprite(param1:ColoredSprite, param2:uint) : void
        {
            if (!this._customColoredParts[param2])
            {
                this._customColoredParts[param2] = new Array();
            }
            this._customColoredParts[param2].push(param1);
            return;
        }// end function

        public function registerInfoSprite(param1:DisplayInfoSprite, param2:String) : void
        {
            this._displayInfoParts[param2] = param1;
            if (param2 == this._customView)
            {
                this.setView(param2);
            }
            return;
        }// end function

        public function getDisplayInfoSprite(param1:String) : DisplayInfoSprite
        {
            return this._displayInfoParts[param1];
        }// end function

        public function addBackground(param1:String, param2:DisplayObject, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            if (!this._background[param1])
            {
                this._background[param1] = param2;
                if (this._rendered)
                {
                    if (param1 == "teamCircle")
                    {
                    }
                    if (param3)
                    {
                        _loc_4 = this.getRect(this);
                        param2.y = _loc_4.y - 10;
                    }
                    addChildAt(param2, 0);
                    this.updateScale();
                }
                else
                {
                    if (param1 == "teamCircle")
                    {
                    }
                    this._backgroundTemp.push(param2, param3);
                }
            }
            return;
        }// end function

        public function removeBackground(param1:String) : void
        {
            if (this._rendered && this._background[param1])
            {
                removeChild(this._background[param1]);
            }
            this._background[param1] = null;
            return;
        }// end function

        public function showOnlyBackground(param1:Boolean) : void
        {
            this._backgroundOnly = param1;
            if (param1 && this._animMovieClip && contains(this._animMovieClip))
            {
                removeChild(this._animMovieClip);
            }
            else if (!param1 && this._animMovieClip)
            {
                addChild(this._animMovieClip);
            }
            return;
        }// end function

        public function isShowingOnlyBackground() : Boolean
        {
            return this._backgroundOnly;
        }// end function

        public function setAlternativeSkinIndex(param1:int = -1, param2:Boolean = false) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this._recursiveAlternativeSkinIndex = param2;
            if (this._recursiveAlternativeSkinIndex)
            {
                _loc_3 = -1;
                _loc_4 = this._subEntitiesList.length;
                while (++_loc_3 < _loc_4)
                {
                    
                    _loc_5 = this._subEntitiesList[_loc_3] as TiphonSprite;
                    if (_loc_5)
                    {
                        _loc_5.setAlternativeSkinIndex(param1);
                    }
                }
            }
            if (param1 != this._alternativeSkinIndex)
            {
                this._alternativeSkinIndex = param1;
                this.resetSkins();
            }
            return;
        }// end function

        public function getAlternativeSkinIndex() : int
        {
            return this._alternativeSkinIndex;
        }// end function

        public function getGlobalScale() : Number
        {
            var _loc_1:* = 1;
            var _loc_2:* = this.parentSprite;
            while (_loc_2)
            {
                
                _loc_1 = _loc_1 * (_loc_2._animMovieClip ? (_loc_2._animMovieClip.scaleX) : (1));
                _loc_2 = _loc_2.parentSprite;
            }
            return _loc_1;
        }// end function

        private function initializeLibrary(param1:uint, param2:Uri = null) : void
        {
            if (!param2)
            {
                if (BoneIndexManager.getInstance().hasCustomBone(param1))
                {
                    return;
                }
                param2 = new Uri(TiphonConstants.SWF_SKULL_PATH + param1 + ".swl");
            }
            Tiphon.skullLibrary.addResource(param1, param2);
            Tiphon.skullLibrary.askResource(param1, this._currentAnimation, new Callback(this.onSkullLibraryReady), new Callback(this.onSkullLibraryError));
            return;
        }// end function

        private function applyColor(param1:uint) : void
        {
            var _loc_2:* = null;
            if (this._customColoredParts[param1])
            {
                for each (_loc_2 in this._customColoredParts[param1])
                {
                    
                    _loc_2.colorize(this.getColorTransform(param1));
                }
            }
            return;
        }// end function

        private function resetSkins() : void
        {
            var _loc_1:* = 0;
            this._skin.validate = false;
            this._skin.reset();
            for each (_loc_1 in this._look.getSkins(true))
            {
                
                _loc_1 = this._skin.add(_loc_1, this._alternativeSkinIndex);
            }
            this._skin.validate = true;
            return;
        }// end function

        private function resetSubEntities() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            while (this._subEntitiesList.length)
            {
                
                _loc_3 = this._subEntitiesList.shift() as TiphonSprite;
                if (_loc_3)
                {
                    _loc_3.destroy();
                }
            }
            this._aSubEntities = [];
            var _loc_1:* = this._look.getSubEntities(true);
            for (_loc_2 in _loc_1)
            {
                
                if (this._deactivatedSubEntityCategory.indexOf(_loc_2) != -1)
                {
                    continue;
                }
                for (_loc_4 in _loc_1[_loc_2])
                {
                    
                    _loc_5 = _loc_1[_loc_2][_loc_4];
                    _loc_6 = new TiphonSprite(_loc_5);
                    _loc_6.setAnimationAndDirection("AnimStatique", this._currentDirection);
                    this.addSubEntity(_loc_6, parseInt(_loc_2), parseInt(_loc_4));
                }
            }
            return;
        }// end function

        private function finalize() : void
        {
            if (this.destroyed)
            {
                return;
            }
            Tiphon.skullLibrary.askResource(this._look.getBone(), this._currentAnimation, new Callback(this.checkRessourceState), new Callback(this.onRenderFail));
            return;
        }// end function

        private function checkRessourceState(event:Event = null) : void
        {
            if (this.destroyed)
            {
                return;
            }
            if ((this._skin.complete || this._lastRenderRequest > 60) && Tiphon.skullLibrary.isLoaded(this._look.getBone(), this._currentAnimation) && this._currentAnimation != null && this._currentDirection >= 0)
            {
                this.render();
            }
            this._lastRenderRequest = getTimer();
            return;
        }// end function

        private function render() : void
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            if (this.destroyed)
            {
                return;
            }
            FpsManager.getInstance().startTracking("animation", 40277);
            var _loc_1:* = null;
            var _loc_2:* = Tiphon.skullLibrary.getResourceById(this._look.getBone(), this._currentAnimation);
            var _loc_3:* = this._currentDirection;
            if (this.parentSprite)
            {
                if (this.getGlobalScale() < 0)
                {
                    _loc_3 = TiphonUtility.getFlipDirection(_loc_3);
                }
            }
            var _loc_4:* = false;
            var _loc_5:* = this._currentAnimation + "_" + _loc_3;
            if (_loc_2.hasDefinition(_loc_5))
            {
                _loc_1 = _loc_2.getDefinition(_loc_5) as Class;
            }
            else
            {
                _loc_5 = this._currentAnimation + "_" + TiphonUtility.getFlipDirection(_loc_3);
                if (_loc_2.hasDefinition(_loc_5))
                {
                    _loc_1 = _loc_2.getDefinition(_loc_5) as Class;
                    _loc_4 = true;
                }
            }
            if (_loc_1 == null)
            {
                _loc_12 = "Class [" + this._currentAnimation + "_" + _loc_3 + "] or [" + this._currentAnimation + "_" + TiphonUtility.getFlipDirection(_loc_3) + "] cannot be found in library " + this._look.getBone();
                _log.error(_loc_12);
                _loc_13 = SubstituteAnimationManager.getDefaultAnimation(this._currentAnimation);
                if (_loc_13 && this._currentAnimation != _loc_13)
                {
                    _log.error("On ne trouve cette animation, on va jouer l\'animation " + _loc_13 + "_" + this._currentDirection + " à la place.");
                    this.setAnimationAndDirection(_loc_13, this._currentDirection);
                }
                else
                {
                    this.onRenderFail();
                }
                return;
            }
            var _loc_6:* = -1;
            if (this._currentAnimation == this._lastClassName && this._animMovieClip)
            {
                _loc_6 = this._animMovieClip.currentFrame;
            }
            this._lastClassName = this._currentAnimation;
            this.clearAnimation();
            for each (_loc_7 in this._background)
            {
                
                if (_loc_7)
                {
                    addChild(_loc_7);
                }
            }
            this._customColoredParts = new Array();
            this._displayInfoParts = new Dictionary();
            ScriptedAnimation.currentSpriteHandler = this;
            _loc_8 = this._look.getBone();
            if (this._useCacheIfPossible && TiphonCacheManager.hasCache(_loc_8, this._currentAnimation))
            {
                this._animMovieClip = TiphonCacheManager.getScriptedAnimation(_loc_8, this._currentAnimation, this._currentDirection);
            }
            else
            {
                this._animMovieClip = new _loc_1 as ScriptedAnimation;
            }
            ScriptedAnimation.currentSpriteHandler = null;
            MEMORY_LOG2[this._animMovieClip] = 1;
            if (!this._animMovieClip)
            {
                _log.error("Class [" + this._currentAnimation + "_" + _loc_3 + "] is not a ScriptedAnimation");
                return;
            }
            this._animMovieClip.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            if (_loc_4 && this._animMovieClip.scaleX > 0)
            {
                this._animMovieClip.scaleX = this._animMovieClip.scaleX * -1;
            }
            else if (!_loc_4 && this._animMovieClip.scaleX < 0)
            {
                this._animMovieClip.scaleX = this._animMovieClip.scaleX * -1;
            }
            var _loc_9:* = MovieClipUtils.isSingleFrame(this._animMovieClip);
            this._animMovieClip.cacheAsBitmap = _loc_9;
            if (this.disableMouseEventWhenAnimated)
            {
                super.mouseEnabled = _loc_9 && this.mouseEnabled;
            }
            if (!this._backgroundOnly)
            {
                this.addChild(this._animMovieClip);
            }
            if (_loc_9 || !this._rasterize && !Tiphon.getInstance().isRasterizeAnimation(this._currentAnimation))
            {
                if ((this._currentAnimation.indexOf("AnimStatique") != -1 || this._currentAnimation.indexOf("AnimState") != -1) && this._currentAnimation.indexOf("_to_") == -1 && !_loc_9)
                {
                    _log.error("/!\\ ATTENTION, l\'animation [" + this._currentAnimation + "_" + _loc_3 + "] sur le squelette [" + this._look.getBone() + "] contient un clip qui contient plusieurs frames. C\'est mal.");
                }
                if (!_loc_9)
                {
                    FpsControler.controlFps(this._animMovieClip, _loc_2.frameRate);
                }
                this._animMovieClip.addEventListener(AnimationEvent.EVENT, this.animEventHandler);
                this._animMovieClip.addEventListener(AnimationEvent.ANIM, this.animSwitchHandler);
            }
            else
            {
                this._animMovieClip.visible = false;
                _loc_14 = new RasterizedSyncAnimation(this._animMovieClip, this._lookCode);
                FpsControler.controlFps(_loc_14, _loc_2.frameRate);
                _loc_14.addEventListener(AnimationEvent.EVENT, this.animEventHandler);
                _loc_14.addEventListener(AnimationEvent.ANIM, this.animSwitchHandler);
                if (!this._backgroundOnly)
                {
                    this.addChild(_loc_14);
                }
                this._animMovieClip = _loc_14;
            }
            if (!_loc_9 && _loc_6 != -1)
            {
                this._animMovieClip.gotoAndStop(_loc_6);
                if (this._animMovieClip is ScriptedAnimation)
                {
                    (this._animMovieClip as ScriptedAnimation).playEventAtFrame(_loc_6);
                }
            }
            this._rendered = true;
            if (this._subEntitiesList.length)
            {
                this.dispatchEvent(new TiphonEvent(TiphonEvent.RENDER_FATHER_SUCCEED, this));
            }
            var _loc_10:* = this._backgroundTemp.length;
            var _loc_11:* = 0;
            while (_loc_11 < _loc_10)
            {
                
                _loc_15 = this._backgroundTemp.shift();
                if (this._backgroundTemp.shift())
                {
                    _loc_16 = this.getRect(this);
                    _loc_15.y = _loc_16.y - 10;
                }
                addChildAt(_loc_15, 0);
                _loc_11 = _loc_11 + 2;
            }
            FpsManager.getInstance().stopTracking("animation");
            if (this._subEntitiesTemp)
            {
                while (this._subEntitiesTemp.length)
                {
                    
                    _loc_17 = this._subEntitiesTemp.shift();
                    _loc_18 = _loc_17.entity as TiphonSprite;
                    if (_loc_18 && !_loc_18._currentAnimation)
                    {
                        _loc_18._currentAnimation = this._currentAnimation;
                    }
                    this.addSubEntity(_loc_17.entity, _loc_17.category, _loc_17.slot);
                }
            }
            this.checkRenderState();
            return;
        }// end function

        public function forceRender() : void
        {
            var _loc_1:* = this._currentDirection;
            if (this.parentSprite && this.getGlobalScale() < 0)
            {
                _loc_1 = TiphonUtility.getFlipDirection(_loc_1);
            }
            var _loc_2:* = this._currentAnimation + "_" + _loc_1;
            var _loc_3:* = Tiphon.skullLibrary.getResourceById(this._look.getBone(), this._currentAnimation, true);
            if (_loc_3 == null)
            {
                Tiphon.skullLibrary.addEventListener(SwlEvent.SWL_LOADED, this.checkRessourceState);
            }
            else
            {
                this.checkRessourceState();
            }
            return;
        }// end function

        protected function clearAnimation() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this._animMovieClip)
            {
                this._animMovieClip.removeEventListener(AnimationEvent.EVENT, this.animEventHandler);
                this._animMovieClip.removeEventListener(AnimationEvent.ANIM, this.animSwitchHandler);
                this._animMovieClip.removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
                FpsControler.uncontrolFps(this._animMovieClip);
                if (this._animMovieClip.parent)
                {
                    removeChild(this._animMovieClip);
                }
                if (this._useCacheIfPossible && (this._animMovieClip as MovieClip).inCache)
                {
                    TiphonCacheManager.pushScriptedAnimation(this._animMovieClip as ScriptedAnimation);
                }
                else
                {
                    TiphonFpsManager.addOldScriptedAnimation(this._animMovieClip as ScriptedAnimation, true);
                }
                (this._animMovieClip as MovieClip).destroy();
                _loc_1 = this._animMovieClip.numChildren;
                _loc_2 = -1;
                while (++_loc_2 < _loc_1)
                {
                    
                    this._animMovieClip.removeChildAt(0);
                }
                this._animMovieClip = null;
            }
            while (numChildren)
            {
                
                this.removeChildAt(0);
            }
            return;
        }// end function

        private function animEventHandler(event:AnimationEvent) : void
        {
            this.dispatchEvent(new TiphonEvent(event.id, this));
            this.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_EVENT, this));
            return;
        }// end function

        private function animSwitchHandler(event:AnimationEvent) : void
        {
            this.setAnimation(event.id);
            return;
        }// end function

        override public function dispatchEvent(event:Event) : Boolean
        {
            var _loc_2:* = null;
            if (event.type == TiphonEvent.ANIMATION_END && this._targetAnimation)
            {
                _loc_2 = this._targetAnimation;
                this._targetAnimation = null;
                this.setAnimation(_loc_2);
                return false;
            }
            return super.dispatchEvent(event);
        }// end function

        private function checkRenderState() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._subEntitiesList)
            {
                
                if (_loc_1 is TiphonSprite && !TiphonSprite(_loc_1)._rendered)
                {
                    return;
                }
            }
            if (!this._skin.complete)
            {
                return;
            }
            this.dispatchEvent(new TiphonEvent(TiphonEvent.RENDER_SUCCEED, this));
            return;
        }// end function

        private function updateScale() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!this._animMovieClip)
            {
                return;
            }
            var _loc_1:* = this._animMovieClip.scaleX >= 0 ? (1) : (-1);
            var _loc_2:* = this._animMovieClip.scaleY >= 0 ? (1) : (-1);
            var _loc_3:* = this;
            while (_loc_3.parent)
            {
                
                _loc_1 = _loc_1 * (_loc_3.parent.scaleX >= 0 ? (1) : (-1));
                _loc_2 = _loc_2 * (_loc_3.parent.scaleY >= 0 ? (1) : (-1));
                if (_loc_3.parent is TiphonSprite && _loc_4 == null)
                {
                    _loc_4 = _loc_3.parent;
                }
                _loc_3 = _loc_3.parent;
            }
            if (_loc_4 is TiphonSprite && (TiphonSprite(_loc_4).look.getScaleX() != 1 || TiphonSprite(_loc_4).look.getScaleY() != 1))
            {
                _loc_6 = _loc_4 as TiphonSprite;
                this._animMovieClip.scaleX = this.look.getScaleX() / _loc_6.look.getScaleX() * (this._animMovieClip.scaleX < 0 ? (-1) : (1));
                this._animMovieClip.scaleY = this.look.getScaleY() / _loc_6.look.getScaleY();
            }
            else
            {
                this._animMovieClip.scaleX = this.look.getScaleX() * (this._animMovieClip.scaleX < 0 ? (-1) : (1));
                this._animMovieClip.scaleY = this.look.getScaleY();
            }
            for each (_loc_5 in this._background)
            {
                
                if (!_loc_5)
                {
                    continue;
                }
                if (_loc_4 is TiphonSprite)
                {
                    _loc_5.scaleX = 1 / _loc_6.look.getScaleX() * _loc_1;
                    _loc_5.scaleY = 1 / _loc_6.look.getScaleY() * _loc_2;
                    continue;
                }
                var _loc_9:* = 1;
                _loc_5.scaleY = 1;
                _loc_5.scaleX = _loc_9;
            }
            return;
        }// end function

        private function dispatchWaitingEvents(event:Event) : void
        {
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, this.dispatchWaitingEvents);
            while (this._waitingEventInitList.length)
            {
                
                this.dispatchEvent(this._waitingEventInitList.shift());
            }
            return;
        }// end function

        public function onAnimationEvent(param1:String, param2:String = "") : void
        {
            if (param1 == TiphonEvent.PLAYER_STOP)
            {
                this.stopAnimation();
            }
            var _loc_3:* = new TiphonEvent(param1, this, param2);
            var _loc_4:* = new TiphonEvent(TiphonEvent.ANIMATION_EVENT, this);
            if (this._init)
            {
                this.dispatchEvent(_loc_3);
                this.dispatchEvent(_loc_4);
            }
            else
            {
                this._waitingEventInitList.push(_loc_3, _loc_4);
            }
            if (param1 != TiphonEvent.PLAYER_STOP && this.parentSprite)
            {
                this.parentSprite.onAnimationEvent(param1);
            }
            return;
        }// end function

        private function onRenderFail() : void
        {
            var _loc_1:* = new TiphonEvent(TiphonEvent.RENDER_FAILED, this);
            if (this._init)
            {
                this.dispatchEvent(_loc_1);
            }
            else
            {
                this._waitingEventInitList.push(_loc_1);
            }
            TiphonDebugManager.displayDofusScriptError("Rendu impossible : " + this._currentAnimation + ", " + this._currentDirection, this);
            return;
        }// end function

        private function onSubEntityRendered(event:Event) : void
        {
            this.checkRenderState();
            return;
        }// end function

        private function onSkullLibraryReady() : void
        {
            this._libReady = true;
            var _loc_1:* = new TiphonEvent(TiphonEvent.SPRITE_INIT, this);
            if (this._init)
            {
                this.dispatchEvent(_loc_1);
            }
            else
            {
                this._waitingEventInitList.push(_loc_1);
            }
            return;
        }// end function

        private function onSkullLibraryError() : void
        {
            var _loc_1:* = new TiphonEvent(TiphonEvent.SPRITE_INIT_FAILED, this);
            if (this._init)
            {
                this.dispatchEvent(_loc_1);
            }
            else
            {
                this._waitingEventInitList.push(_loc_1);
            }
            TiphonDebugManager.displayDofusScriptError("Initialisation impossible : " + this._currentAnimation + ", " + this._currentDirection, this);
            return;
        }// end function

        protected function onAdded(event:Event) : void
        {
            this.updateScale();
            return;
        }// end function

        public function boneChanged(param1:TiphonEntityLook) : void
        {
            this._look = param1;
            this._lookCode = this._look.toString();
            this._tiphonEventManager = new TiphonEventsManager(this);
            this._rendered = false;
            this.initializeLibrary(param1.getBone(), BoneIndexManager.getInstance().getBoneFile(this._look.getBone(), this._currentAnimation));
            return;
        }// end function

        public function skinsChanged(param1:TiphonEntityLook) : void
        {
            this._look = param1;
            this._lookCode = this._look.toString();
            this._rendered = false;
            this.resetSkins();
            this.finalize();
            return;
        }// end function

        public function colorsChanged(param1:TiphonEntityLook) : void
        {
            var _loc_2:* = null;
            this._look = param1;
            this._lookCode = this._look.toString();
            this._aTransformColors = new Array();
            if (this._rasterize)
            {
                this.finalize();
            }
            else
            {
                for (_loc_2 in this._customColoredParts)
                {
                    
                    this.applyColor(uint(_loc_2));
                }
            }
            return;
        }// end function

        public function scalesChanged(param1:TiphonEntityLook) : void
        {
            this._look = param1;
            this._lookCode = this._look.toString();
            if (this._rasterize)
            {
                this.finalize();
            }
            else if (this._animMovieClip != null)
            {
                this.updateScale();
            }
            return;
        }// end function

        public function subEntitiesChanged(param1:TiphonEntityLook) : void
        {
            this._look = param1;
            this._lookCode = this._look.toString();
            this.resetSubEntities();
            this.finalize();
            return;
        }// end function

        public function enableSubCategory(param1:int, param2:Boolean = true) : void
        {
            if (param2)
            {
                this._deactivatedSubEntityCategory.splice(this._deactivatedSubEntityCategory.indexOf(param1.toString()), 1);
            }
            else if (this._deactivatedSubEntityCategory.indexOf(param1.toString()) == -1)
            {
                this._deactivatedSubEntityCategory.push(param1.toString());
            }
            return;
        }// end function

        override public function toString() : String
        {
            return "[TiphonSprite] " + this._look.toString();
        }// end function

    }
}
