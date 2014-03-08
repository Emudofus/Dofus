package com.ankamagames.dofus.types.entities
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.events.Event;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.types.Uri;
   import flash.geom.ColorTransform;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class ExplosionEntity extends Sprite implements IEntity
   {
      
      public function ExplosionEntity(param1:Uri, param2:Array, param3:uint=40, param4:Boolean=false, param5:uint=2) {
         var _loc6_:uint = 0;
         var _loc7_:ColorTransform = null;
         this._renderer = new DisplayObjectRenderer();
         super();
         if(!param1)
         {
            return;
         }
         if((param2) && (param2.length))
         {
            this._transformColor = [];
            for each (_loc6_ in param2)
            {
               _loc7_ = new ColorTransform();
               _loc7_.color = _loc6_;
               this._transformColor.push(_loc7_);
            }
         }
         this._type = param5;
         this._explode = param4;
         this._particleCount = param3;
         if(!OptionManager.getOptionManager("atouin").allowParticlesFx)
         {
            MAX_PARTICLES = 0;
         }
         else
         {
            if(OptionManager.getOptionManager("dofus").dofusQuality >= 2)
            {
               MAX_PARTICLES = 800;
            }
            else
            {
               MAX_PARTICLES = 400;
            }
         }
         this._fxLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         this._fxLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onResourceReady);
         this._fxLoader.load(param1);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExplosionEntity));
      
      public static const TYPE_CLASSIC:uint = 0;
      
      public static const TYPE_TWIRL:uint = 1;
      
      public static const TYPE_MIX:uint = 2;
      
      private static var MAX_PARTICLES:uint;
      
      private static var CURRENT_PARTICLES:uint;
      
      private static var _running:Boolean;
      
      private static var _particules:Dictionary = new Dictionary();
      
      private static function onFrame(param1:Event) : void {
         var _loc2_:IParticule = null;
         for each (_loc2_ in _particules)
         {
            _loc2_.update();
         }
      }
      
      private var _renderer:DisplayObjectRenderer;
      
      private var _fxLoader:IResourceLoader;
      
      private var _startColors:Array;
      
      private var _explode:Boolean;
      
      private var _particleCount:uint;
      
      private var _fxClass:Array;
      
      private var _transformColor:Array;
      
      private var _type:uint;
      
      public function get id() : int {
         return 0;
      }
      
      public function set id(param1:int) : void {
      }
      
      public function get position() : MapPoint {
         return null;
      }
      
      public function set position(param1:MapPoint) : void {
      }
      
      private function init(param1:Array) : void {
         this._fxClass = param1;
         addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
      }
      
      private function createParticle(param1:DisplayObjectContainer, param2:uint, param3:Array, param4:uint, param5:Number, param6:Array, param7:Function, param8:Number=0, param9:Number=0) : void {
         var _loc11_:DisplayObject = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         while(_loc10_ < param2)
         {
            if(CURRENT_PARTICLES < MAX_PARTICLES)
            {
               _loc11_ = new param6[Math.floor(param6.length * Math.random())]() as DisplayObject;
               _loc11_.x = param8;
               _loc11_.y = param9;
               _loc12_ = param4;
               if(param4 == TYPE_MIX)
               {
                  _loc12_ = Math.random() > 0.5?TYPE_TWIRL:TYPE_CLASSIC;
               }
               if(param3)
               {
                  if(param4 == TYPE_MIX)
                  {
                     if(_loc12_ == TYPE_CLASSIC)
                     {
                        _loc13_ = Math.floor(this._transformColor.length / 2 * Math.random());
                     }
                     else
                     {
                        _loc13_ = Math.floor(this._transformColor.length / 2 + this._transformColor.length / 2 * Math.random());
                     }
                  }
                  else
                  {
                     _loc13_ = Math.floor(this._transformColor.length * Math.random());
                  }
                  _loc11_.transform.colorTransform = this._transformColor[_loc13_];
               }
               param1.addChild(_loc11_);
               _particules[_loc11_] = new TwirlParticle(_loc11_,100,Math.random() < param5,param7,-param1.parent.y + 20 * Math.random() - 10,_loc12_ == TYPE_TWIRL?10:0);
               CURRENT_PARTICLES++;
            }
            _loc10_++;
         }
      }
      
      private function onResourceReady(param1:ResourceLoadedEvent) : void {
         var _loc2_:Array = Swl(param1.resource).getDefinitions();
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_.push(Swl(param1.resource).getDefinition(_loc2_[_loc4_]));
            _loc4_++;
         }
         this.init(_loc3_);
      }
      
      private function onParticuleDeath(param1:IParticule, param2:Boolean) : void {
         if(param1.sprite.parent)
         {
            param1.sprite.parent.removeChild(param1.sprite);
         }
         delete _particules[[param1.sprite]];
         CURRENT_PARTICLES--;
         if(param2)
         {
            this.createParticle(this,this._particleCount / 2,this._transformColor,this._type,0,this._fxClass,this.onParticuleDeath,param1.sprite.x,param1.sprite.y);
         }
      }
      
      private function onAdded(param1:Event) : void {
         rotation = parent.parent.parent.rotation;
         this.createParticle(this,this._particleCount,this._transformColor,this._type,this._explode?0.2:0,this._fxClass,this.onParticuleDeath);
         removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         if(!_running)
         {
            _running = true;
            EnterFrameDispatcher.addEventListener(onFrame,"feeArtifice",25);
         }
      }
   }
}
