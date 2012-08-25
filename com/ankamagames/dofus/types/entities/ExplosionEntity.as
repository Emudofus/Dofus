package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.flintparticles.twoD.renderers.*;

    public class ExplosionEntity extends Sprite implements IEntity
    {
        private var _renderer:DisplayObjectRenderer;
        private var _fxLoader:IResourceLoader;
        private var _startColors:Array;
        private var _explode:Boolean;
        private var _particleCount:uint;
        private var _fxClass:Array;
        private var _transformColor:Array;
        private var _type:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ExplosionEntity));
        public static const TYPE_CLASSIC:uint = 0;
        public static const TYPE_TWIRL:uint = 1;
        public static const TYPE_MIX:uint = 2;
        private static var MAX_PARTICLES:uint;
        private static var CURRENT_PARTICLES:uint;
        private static var _running:Boolean;
        private static var _particules:Dictionary = new Dictionary();

        public function ExplosionEntity(param1:Uri, param2:Array, param3:uint = 40, param4:Boolean = false, param5:uint = 2)
        {
            var _loc_6:uint = 0;
            var _loc_7:ColorTransform = null;
            this._renderer = new DisplayObjectRenderer();
            if (!param1)
            {
                return;
            }
            if (param2 && param2.length)
            {
                this._transformColor = [];
                for each (_loc_6 in param2)
                {
                    
                    _loc_7 = new ColorTransform();
                    _loc_7.color = _loc_6;
                    this._transformColor.push(_loc_7);
                }
            }
            this._type = param5;
            this._explode = param4;
            this._particleCount = param3;
            if (!OptionManager.getOptionManager("atouin").allowParticlesFx)
            {
                MAX_PARTICLES = 0;
            }
            else if (OptionManager.getOptionManager("dofus").dofusQuality >= 2)
            {
                MAX_PARTICLES = 800;
            }
            else
            {
                MAX_PARTICLES = 400;
            }
            this._fxLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._fxLoader.addEventListener(ResourceLoadedEvent.LOADED, this.onResourceReady);
            this._fxLoader.load(param1);
            return;
        }// end function

        public function get id() : int
        {
            return 0;
        }// end function

        public function set id(param1:int) : void
        {
            return;
        }// end function

        public function get position() : MapPoint
        {
            return null;
        }// end function

        public function set position(param1:MapPoint) : void
        {
            return;
        }// end function

        private function init(param1:Array) : void
        {
            this._fxClass = param1;
            addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            return;
        }// end function

        private function createParticle(param1:DisplayObjectContainer, param2:uint, param3:Array, param4:uint, param5:Number, param6:Array, param7:Function, param8:Number = 0, param9:Number = 0) : void
        {
            var _loc_11:DisplayObject = null;
            var _loc_12:uint = 0;
            var _loc_13:uint = 0;
            var _loc_10:uint = 0;
            while (_loc_10 < param2)
            {
                
                if (CURRENT_PARTICLES < MAX_PARTICLES)
                {
                    _loc_11 = new param6[Math.floor(param6.length * Math.random())] as DisplayObject;
                    _loc_11.x = param8;
                    _loc_11.y = param9;
                    _loc_12 = param4;
                    if (param4 == TYPE_MIX)
                    {
                        _loc_12 = Math.random() > 0.5 ? (TYPE_TWIRL) : (TYPE_CLASSIC);
                    }
                    if (param3)
                    {
                        if (param4 == TYPE_MIX)
                        {
                            if (_loc_12 == TYPE_CLASSIC)
                            {
                                _loc_13 = Math.floor(this._transformColor.length / 2 * Math.random());
                            }
                            else
                            {
                                _loc_13 = Math.floor(this._transformColor.length / 2 + this._transformColor.length / 2 * Math.random());
                            }
                        }
                        else
                        {
                            _loc_13 = Math.floor(this._transformColor.length * Math.random());
                        }
                        _loc_11.transform.colorTransform = this._transformColor[_loc_13];
                    }
                    param1.addChild(_loc_11);
                    _particules[_loc_11] = new TwirlParticle(_loc_11, 100, Math.random() < param5, param7, -param1.parent.y + 20 * Math.random() - 10, _loc_12 == TYPE_TWIRL ? (10) : (0));
                    var _loc_15:* = CURRENT_PARTICLES + 1;
                    CURRENT_PARTICLES = _loc_15;
                }
                _loc_10 = _loc_10 + 1;
            }
            return;
        }// end function

        private function onResourceReady(event:ResourceLoadedEvent) : void
        {
            var _loc_2:* = Swl(event.resource).getDefinitions();
            var _loc_3:Array = [];
            var _loc_4:uint = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_3.push(Swl(event.resource).getDefinition(_loc_2[_loc_4]));
                _loc_4 = _loc_4 + 1;
            }
            this.init(_loc_3);
            return;
        }// end function

        private function onParticuleDeath(param1:IParticule, param2:Boolean) : void
        {
            if (param1.sprite.parent)
            {
                param1.sprite.parent.removeChild(param1.sprite);
            }
            delete _particules[param1.sprite];
            var _loc_4:* = CURRENT_PARTICLES - 1;
            CURRENT_PARTICLES = _loc_4;
            if (param2)
            {
                this.createParticle(this, this._particleCount / 2, this._transformColor, this._type, 0, this._fxClass, this.onParticuleDeath, param1.sprite.x, param1.sprite.y);
            }
            return;
        }// end function

        private function onAdded(event:Event) : void
        {
            rotation = parent.parent.parent.rotation;
            this.createParticle(this, this._particleCount, this._transformColor, this._type, this._explode ? (0.2) : (0), this._fxClass, this.onParticuleDeath);
            removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            if (!_running)
            {
                _running = true;
                EnterFrameDispatcher.addEventListener(onFrame, "feeArtifice", 25);
            }
            return;
        }// end function

        private static function onFrame(event:Event) : void
        {
            var _loc_2:IParticule = null;
            for each (_loc_2 in _particules)
            {
                
                _loc_2.update();
            }
            return;
        }// end function

    }
}
