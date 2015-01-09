package com.ankamagames.dofus.types.entities
{
    import flash.display.Sprite;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import flash.geom.ColorTransform;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.types.Uri;
    import flash.events.Event;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.jerakine.types.Swl;
    import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;

    public class ExplosionEntity extends Sprite implements IEntity 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExplosionEntity));
        public static const TYPE_CLASSIC:uint = 0;
        public static const TYPE_TWIRL:uint = 1;
        public static const TYPE_MIX:uint = 2;
        private static var MAX_PARTICLES:uint;
        private static var CURRENT_PARTICLES:uint;
        private static var _running:Boolean;
        private static var _particules:Dictionary = new Dictionary();

        private var _renderer:DisplayObjectRenderer;
        private var _fxLoader:IResourceLoader;
        private var _startColors:Array;
        private var _explode:Boolean;
        private var _particleCount:uint;
        private var _fxClass:Array;
        private var _transformColor:Array;
        private var _type:uint;

        public function ExplosionEntity(fxUri:Uri, startColors:Array, particleCount:uint=40, explode:Boolean=false, type:uint=2)
        {
            var c:uint;
            var t:ColorTransform;
            this._renderer = new DisplayObjectRenderer();
            super();
            if (!(fxUri))
            {
                return;
            };
            if (((startColors) && (startColors.length)))
            {
                this._transformColor = [];
                for each (c in startColors)
                {
                    t = new ColorTransform();
                    t.color = c;
                    this._transformColor.push(t);
                };
            };
            this._type = type;
            this._explode = explode;
            this._particleCount = particleCount;
            if (!(OptionManager.getOptionManager("atouin").allowParticlesFx))
            {
                MAX_PARTICLES = 0;
            }
            else
            {
                if (OptionManager.getOptionManager("dofus").dofusQuality >= 2)
                {
                    MAX_PARTICLES = 800;
                }
                else
                {
                    MAX_PARTICLES = 400;
                };
            };
            this._fxLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._fxLoader.addEventListener(ResourceLoadedEvent.LOADED, this.onResourceReady);
            this._fxLoader.load(fxUri);
        }

        private static function onFrame(e:Event):void
        {
            var p:IParticule;
            for each (p in _particules)
            {
                p.update();
            };
        }


        public function get id():int
        {
            return (0);
        }

        public function set id(nValue:int):void
        {
        }

        public function get position():MapPoint
        {
            return (null);
        }

        public function set position(oValue:MapPoint):void
        {
        }

        private function init(fxClass:Array):void
        {
            this._fxClass = fxClass;
            addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
        }

        private function createParticle(container:DisplayObjectContainer, count:uint, transformColor:Array, type:uint, subExplosionRatio:Number, fxClass:Array, deathCallback:Function, xStart:Number=0, yStart:Number=0):void
        {
            var p:DisplayObject;
            var pType:uint;
            var colorIndex:uint;
            var i:uint;
            while (i < count)
            {
                if (CURRENT_PARTICLES < MAX_PARTICLES)
                {
                    p = (new (fxClass[Math.floor((fxClass.length * Math.random()))])() as DisplayObject);
                    p.x = xStart;
                    p.y = yStart;
                    pType = type;
                    if (type == TYPE_MIX)
                    {
                        pType = (((Math.random() > 0.5)) ? TYPE_TWIRL : TYPE_CLASSIC);
                    };
                    if (transformColor)
                    {
                        if (type == TYPE_MIX)
                        {
                            if (pType == TYPE_CLASSIC)
                            {
                                colorIndex = Math.floor(((this._transformColor.length / 2) * Math.random()));
                            }
                            else
                            {
                                colorIndex = Math.floor(((this._transformColor.length / 2) + ((this._transformColor.length / 2) * Math.random())));
                            };
                        }
                        else
                        {
                            colorIndex = Math.floor((this._transformColor.length * Math.random()));
                        };
                        p.transform.colorTransform = this._transformColor[colorIndex];
                    };
                    container.addChild(p);
                    _particules[p] = new TwirlParticle(p, 100, (Math.random() < subExplosionRatio), deathCallback, ((-(container.parent.y) + (20 * Math.random())) - 10), (((pType == TYPE_TWIRL)) ? 10 : 0));
                    CURRENT_PARTICLES++;
                };
                i++;
            };
        }

        private function onResourceReady(e:ResourceLoadedEvent):void
        {
            var def:Array = Swl(e.resource).getDefinitions();
            var classes:Array = [];
            var i:uint;
            while (i < def.length)
            {
                classes.push(Swl(e.resource).getDefinition(def[i]));
                i++;
            };
            this.init(classes);
        }

        private function onParticuleDeath(particule:IParticule, mustExplose:Boolean):void
        {
            if (particule.sprite.parent)
            {
                particule.sprite.parent.removeChild(particule.sprite);
            };
            delete _particules[particule.sprite];
            CURRENT_PARTICLES--;
            if (mustExplose)
            {
                this.createParticle(this, (this._particleCount / 2), this._transformColor, this._type, 0, this._fxClass, this.onParticuleDeath, particule.sprite.x, particule.sprite.y);
            };
        }

        private function onAdded(e:Event):void
        {
            rotation = parent.parent.parent.rotation;
            this.createParticle(this, this._particleCount, this._transformColor, this._type, ((this._explode) ? 0.2 : 0), this._fxClass, this.onParticuleDeath);
            removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            if (!(_running))
            {
                _running = true;
                EnterFrameDispatcher.addEventListener(onFrame, "feeArtifice", 25);
            };
        }


    }
}//package com.ankamagames.dofus.types.entities

