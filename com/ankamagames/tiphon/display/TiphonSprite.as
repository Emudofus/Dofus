package com.ankamagames.tiphon.display
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.tiphon.types.IAnimationSpriteHandler;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.tiphon.types.look.EntityLookObserver;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.Point;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.types.Skin;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.tiphon.types.SubEntityTempInfo;
   import flash.events.Event;
   import com.ankamagames.tiphon.engine.TiphonEventsManager;
   import com.ankamagames.tiphon.types.ISkinModifier;
   import com.ankamagames.tiphon.error.TiphonError;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.geom.Matrix;
   import com.ankamagames.tiphon.engine.BoneIndexManager;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.display.MovieClip;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.EventListener;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.tiphon.types.BehaviorData;
   import com.ankamagames.tiphon.types.ISubEntityBehavior;
   import com.ankamagames.tiphon.types.DisplayInfoSprite;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import flash.geom.ColorTransform;
   import com.ankamagames.jerakine.types.DefaultableColor;
   import com.ankamagames.tiphon.types.EquipmentSprite;
   import com.ankamagames.tiphon.types.TransformData;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.tiphon.types.ColoredSprite;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.jerakine.types.Callback;
   import flash.utils.getTimer;
   import com.ankamagames.tiphon.engine.SubstituteAnimationManager;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   import com.ankamagames.tiphon.engine.TiphonCacheManager;
   import com.ankamagames.jerakine.utils.display.MovieClipUtils;
   import com.ankamagames.tiphon.events.AnimationEvent;
   import com.ankamagames.tiphon.events.SwlEvent;
   import com.ankamagames.tiphon.engine.TiphonFpsManager;
   import flash.utils.setTimeout;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.tiphon.engine.TiphonDebugManager;
   import com.ankamagames.tiphon.types.CarriedSprite;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   
   public class TiphonSprite extends Sprite implements IAnimated, IAnimationSpriteHandler, IDestroyable, EntityLookObserver
   {
      
      public function TiphonSprite(look:TiphonEntityLook) {
         var num:* = 0;
         var cat:String = null;
         var i:* = 0;
         var skin:uint = 0;
         var category:* = 0;
         var subIndex:uint = 0;
         var subEntity:TiphonSprite = null;
         this._backgroundTemp = new Array();
         this._deactivatedSubEntityCategory = new Array();
         this._waitingEventInitList = new Vector.<Event>();
         this._animationModifier = [];
         this.useProgressiveLoading = AirScanner.isStreamingVersion();
         this._lastRenderRequest = getTimer();
         super();
         FpsManager.getInstance().watchObject(this,true);
         this._libReady = false;
         this._background = new Array();
         this.initializeLibrary(look.getBone());
         this._subEntityBehaviors = new Array();
         this._currentAnimation = null;
         this._currentDirection = -1;
         this._customColoredParts = new Array();
         this._displayInfoParts = new Dictionary();
         this._aTransformColors = new Array();
         this._aSubEntities = new Array();
         this._subEntitiesList = new Array();
         this._subEntitiesTemp = new Vector.<SubEntityTempInfo>();
         this._look = look;
         this._lookCode = this._look.toString();
         this._skin = new Skin();
         this._skin.addEventListener(Event.COMPLETE,this.checkRessourceState);
         var skinList:Vector.<uint> = this._look.getSkins(true);
         if(skinList)
         {
            num = skinList.length;
            i = 0;
            while(i < num)
            {
               skin = skinList[i];
               skin = this._skin.add(skin,this._alternativeSkinIndex);
               i++;
            }
         }
         var subEntitiesLook:Array = this._look.getSubEntities(true);
         for (cat in subEntitiesLook)
         {
            category = int(cat);
            num = subEntitiesLook[category].length;
            subIndex = 0;
            while(subIndex < num)
            {
               subEntity = new TiphonSprite(this._look.getSubEntity(category,subIndex));
               subEntity.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onSubEntityRendered,false,0,true);
               this.addSubEntity(subEntity,category,subIndex);
               subIndex++;
            }
         }
         this._look.addObserver(this);
         this.mouseChildren = false;
         this._tiphonEventManager = new TiphonEventsManager(this);
         this._init = true;
         if(this._waitingEventInitList.length)
         {
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.dispatchWaitingEvents);
         }
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public static var MEMORY_LOG2:Dictionary = new Dictionary(true);
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonSprite));
      
      private static var _cache:Dictionary = new Dictionary();
      
      private static var _point:Point = new Point(0,0);
      
      protected var _useCacheIfPossible:Boolean = false;
      
      private var _init:Boolean = false;
      
      private var _currentAnimation:String;
      
      private var _rawAnimation:String;
      
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
      
      private var _skinModifier:ISkinModifier;
      
      private var _savedMouseEnabled:Boolean = true;
      
      private var _carriedEntity:TiphonSprite;
      
      private var _isCarrying:Boolean;
      
      private var _changeDispatched:Boolean;
      
      public var destroyed:Boolean = false;
      
      public var overrideNextAnimation:Boolean = false;
      
      public var disableMouseEventWhenAnimated:Boolean = false;
      
      public var useProgressiveLoading:Boolean;
      
      public var allowMovementThrough:Boolean = false;
      
      public function get tiphonEventManager() : TiphonEventsManager {
         if(this._tiphonEventManager == null)
         {
            throw new TiphonError("_tiphonEventManager is null, can\'t access so");
         }
         else
         {
            return this._tiphonEventManager;
         }
      }
      
      override public function set visible(v:Boolean) : void {
         super.visible = v;
      }
      
      override public function set alpha(a:Number) : void {
         super.alpha = a;
      }
      
      override public function set mouseEnabled(enabled:Boolean) : void {
         this._savedMouseEnabled = enabled;
         super.mouseEnabled = enabled;
      }
      
      override public function get mouseEnabled() : Boolean {
         return this._savedMouseEnabled;
      }
      
      public function get carriedEntity() : TiphonSprite {
         return this._carriedEntity;
      }
      
      public function set carriedEntity(pTs:TiphonSprite) : void {
         this._carriedEntity = pTs;
      }
      
      public function set isCarrying(pIsCarrying:Boolean) : void {
         this._isCarrying = pIsCarrying;
      }
      
      public function get bitmapData() : BitmapData {
         var bounds:Rectangle = getBounds(this);
         if(bounds.height * bounds.width == 0)
         {
            return null;
         }
         var bitmapdata:BitmapData = new BitmapData(bounds.right - bounds.left,bounds.bottom - bounds.top,true,22015);
         var m:Matrix = new Matrix();
         m.translate(-bounds.left,-bounds.top);
         bitmapdata.draw(this,m);
         return bitmapdata;
      }
      
      public function get look() : TiphonEntityLook {
         return this._look;
      }
      
      public function get rasterize() : Boolean {
         return this._rasterize;
      }
      
      public function set rasterize(b:Boolean) : void {
         this._rasterize = b;
      }
      
      public function get rawAnimation() : TiphonAnimation {
         return this._animMovieClip;
      }
      
      public function get libraryIsAvaible() : Boolean {
         return this._libReady;
      }
      
      public function get skinIsAvailable() : Boolean {
         return this._skin.complete;
      }
      
      public function get parentSprite() : TiphonSprite {
         return this._parentSprite;
      }
      
      public function get rootEntity() : TiphonSprite {
         var currentSprite:TiphonSprite = this;
         while(currentSprite._parentSprite)
         {
            currentSprite = currentSprite._parentSprite;
         }
         return currentSprite;
      }
      
      public function get maxFrame() : uint {
         if(this._animMovieClip)
         {
            return this._animMovieClip.totalFrames;
         }
         return 0;
      }
      
      public function get animationModifiers() : Array {
         return this._animationModifier;
      }
      
      public function get animationList() : Array {
         if(BoneIndexManager.getInstance().hasCustomBone(this._look.getBone()))
         {
            return BoneIndexManager.getInstance().getAllCustomAnimations(this._look.getBone());
         }
         var resource:Swl = Tiphon.skullLibrary.getResourceById(this._look.getBone());
         return resource?resource.getDefinitions():null;
      }
      
      public function set skinModifier(sm:ISkinModifier) : void {
         this._skinModifier = sm;
      }
      
      public function get skinModifier() : ISkinModifier {
         return this._skinModifier;
      }
      
      public function get rendered() : Boolean {
         return this._rendered;
      }
      
      public function isPlayingAnimation() : Boolean {
         var playing:* = false;
         if(this._animMovieClip)
         {
            playing = !(this._animMovieClip.currentFrame == this._animMovieClip.totalFrames);
         }
         return playing;
      }
      
      public function stopAnimation(frame:int=0) : void {
         if(this._animMovieClip)
         {
            if(frame)
            {
               this._animMovieClip.gotoAndStop(frame);
            }
            else
            {
               this._animMovieClip.stop();
            }
            FpsControler.uncontrolFps(this._animMovieClip);
         }
      }
      
      public function stopAnimationAtLastFrame() : void {
         if((this._animMovieClip) && (this._rendered) && (this._lastAnimation == this._currentAnimation))
         {
            this.stopAnimationAtEnd();
            this.restartAnimation();
         }
         else
         {
            addEventListener(TiphonEvent.RENDER_SUCCEED,this.onLoadComplete);
         }
      }
      
      protected function onLoadComplete(pEvt:TiphonEvent) : void {
         removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onLoadComplete);
         var customStaticAnim:String = this._currentAnimation.indexOf("_Statique_") == -1?this._currentAnimation.replace("_","_Statique_"):null;
         var rider:TiphonSprite = this.getSubEntitySlot(2,0) as TiphonSprite;
         if(this._currentAnimation != "AnimStatique")
         {
            if((customStaticAnim) && (this.hasAnimation(customStaticAnim,this._currentDirection)) || (rider) && (rider.hasAnimation(customStaticAnim,rider.getDirection())))
            {
               this.setAnimation(customStaticAnim);
            }
            else
            {
               this.stopAnimation(this.maxFrame);
            }
         }
         this.visible = true;
         if(this.parentSprite)
         {
            this.parentSprite.visible = true;
         }
      }
      
      public function restartAnimation(frame:int=-1) : void {
         var lib:Swl = Tiphon.skullLibrary.getResourceById(this._look.getBone(),this._currentAnimation);
         if((this._animMovieClip) && (lib))
         {
            if(frame != -1)
            {
               this._animMovieClip.gotoAndStop(frame);
            }
            FpsControler.controlFps(this._animMovieClip,lib.frameRate);
         }
      }
      
      public function stopAnimationAtEnd() : void {
         var child:MovieClip = null;
         if(this._animMovieClip)
         {
            this._animMovieClip.gotoAndStop(this._animMovieClip.totalFrames);
            if(this._animMovieClip.numChildren)
            {
               child = this._animMovieClip.getChildAt(0) as MovieClip;
               if(child)
               {
                  child.gotoAndStop(child.totalFrames);
               }
            }
            FpsControler.uncontrolFps(this._animMovieClip);
            this._animMovieClip.cacheAsBitmap = true;
         }
      }
      
      public function setDirection(newDirection:uint) : void {
         if(this._currentAnimation)
         {
            this.setAnimationAndDirection(this._currentAnimation,newDirection);
         }
         else
         {
            this._currentDirection = newDirection;
         }
      }
      
      public function getDirection() : uint {
         return this._currentDirection > 0?this._currentDirection:0;
      }
      
      public function setAnimation(newAnimation:String) : void {
         this.setAnimationAndDirection(newAnimation,this._currentDirection);
      }
      
      public function getAnimation() : String {
         return this._currentAnimation;
      }
      
      public function addAnimationModifier(modifier:IAnimationModifier, noDuplicate:Boolean=true) : void {
         if((!noDuplicate) || (this._animationModifier.indexOf(modifier) == -1))
         {
            this._animationModifier.push(modifier);
         }
         this._animationModifier.sortOn("priority");
      }
      
      public function removeAnimationModifier(modifier:IAnimationModifier) : void {
         var currentModifier:IAnimationModifier = null;
         var tmp:Array = [];
         for each (currentModifier in this._animationModifier)
         {
            if(modifier != currentModifier)
            {
               tmp.push(currentModifier);
            }
         }
         this._animationModifier = tmp;
      }
      
      public function removeAnimationModifierByClass(modifier:Class) : void {
         var currentModifier:IAnimationModifier = null;
         var tmp:Array = [];
         for each (currentModifier in this._animationModifier)
         {
            if(!(currentModifier is modifier))
            {
               tmp.push(currentModifier);
            }
         }
         this._animationModifier = tmp;
      }
      
      public function setAnimationAndDirection(animation:String, direction:uint, pDisableAnimModifier:Boolean=false) : void {
         var catId:String = null;
         var eListener:EventListener = null;
         var cat:Array = null;
         var subEntity:DisplayObject = null;
         var modifier:IAnimationModifier = null;
         var te:TiphonEvent = null;
         var transitionalAnim:String = null;
         var boneFileUri:Uri = null;
         if(this.destroyed)
         {
            return;
         }
         FpsManager.getInstance().startTracking("animation",40277);
         this._rawAnimation = animation;
         if(!animation)
         {
            animation = this._currentAnimation;
         }
         if(this is IEntity)
         {
            if(((this._currentAnimation == "AnimMarche") || (this._currentAnimation == "AnimCourse")) && (animation == "AnimStatique"))
            {
               for each (eListener in TiphonEventsManager.listeners)
               {
                  eListener.listener.removeEntitySound(this as IEntity);
               }
            }
         }
         var behaviorData:BehaviorData = new BehaviorData(animation,direction,this);
         for (catId in this._aSubEntities)
         {
            cat = this._aSubEntities[catId];
            if(cat)
            {
               for each (subEntity in cat)
               {
                  if(subEntity is TiphonSprite)
                  {
                     if(this._subEntityBehaviors[catId])
                     {
                        (this._subEntityBehaviors[catId] as ISubEntityBehavior).updateFromParentEntity(TiphonSprite(subEntity),behaviorData);
                     }
                     else
                     {
                        this.updateFromParentEntity(TiphonSprite(subEntity),behaviorData);
                     }
                  }
               }
            }
         }
         if(this._animationModifier)
         {
            for each (modifier in this._animationModifier)
            {
               behaviorData.animation = modifier.getModifiedAnimation(behaviorData.animation,this.look);
            }
         }
         if(pDisableAnimModifier)
         {
            this._currentAnimation = animation;
            this.overrideNextAnimation = true;
         }
         if((!this.overrideNextAnimation) && (behaviorData.animation == this._currentAnimation) && (direction == this._currentDirection) && (this._rendered))
         {
            if((this._animMovieClip) && (this._animMovieClip.totalFrames > 1))
            {
               this.restartAnimation();
            }
            this._changeDispatched = true;
            if(this._subEntitiesList.length)
            {
               this.dispatchEvent(new TiphonEvent(TiphonEvent.RENDER_FATHER_SUCCEED,this));
            }
            te = new TiphonEvent(TiphonEvent.RENDER_SUCCEED,this);
            te.animationName = this._currentAnimation + "_" + this._currentDirection;
            this.dispatchEvent(te);
            return;
         }
         this.overrideNextAnimation = false;
         this._changeDispatched = false;
         this._lastAnimation = this._currentAnimation;
         this._currentDirection = direction;
         if(!pDisableAnimModifier)
         {
            if(BoneIndexManager.getInstance().hasTransition(this._look.getBone(),this._lastAnimation,behaviorData.animation,this._currentDirection))
            {
               transitionalAnim = BoneIndexManager.getInstance().getTransition(this._look.getBone(),this._lastAnimation,behaviorData.animation,this._currentDirection);
               this._currentAnimation = transitionalAnim;
               this._targetAnimation = behaviorData.animation;
            }
            else
            {
               this._currentAnimation = behaviorData.animation;
            }
         }
         if(BoneIndexManager.getInstance().hasCustomBone(this._look.getBone()))
         {
            boneFileUri = BoneIndexManager.getInstance().getBoneFile(this._look.getBone(),this._currentAnimation);
            if((!(boneFileUri.fileName == this._look.getBone() + ".swl")) || (BoneIndexManager.getInstance().hasAnim(this._look.getBone(),this._currentAnimation,this._currentDirection)))
            {
               this.initializeLibrary(this._look.getBone(),boneFileUri);
            }
            else
            {
               this._currentAnimation = "AnimStatique";
            }
         }
         this._rendered = false;
         this.finalize();
         FpsManager.getInstance().stopTracking("animation");
      }
      
      public function setView(view:String) : void {
         this._customView = view;
         var infoSprite:DisplayInfoSprite = this.getDisplayInfoSprite(view);
         if(infoSprite)
         {
            if((!(this.mask == null)) && (this.mask.parent))
            {
               this.mask.parent.removeChild(this.mask);
            }
            addChild(infoSprite);
            this.mask = infoSprite;
         }
      }
      
      public function getSubEntityBehavior(pCategory:int) : ISubEntityBehavior {
         return this._subEntityBehaviors[pCategory];
      }
      
      public function setSubEntityBehaviour(category:int, behaviour:ISubEntityBehavior) : void {
         this._subEntityBehaviors[category] = behaviour;
      }
      
      public function updateFromParentEntity(subEntity:TiphonSprite, parentData:BehaviorData) : void {
         if(!subEntity)
         {
            return;
         }
         var animExist:Boolean = false;
         var ad:Array = subEntity.getAvaibleDirection(parentData.animation);
         var i:int = 0;
         while(i < 8)
         {
            animExist = (ad[i]) || (animExist);
            i++;
         }
         if((animExist) || (!this._libReady))
         {
            subEntity.setAnimationAndDirection(parentData.animation,parentData.direction);
         }
      }
      
      public function destroy() : void {
         var i:int = 0;
         var num:int = 0;
         var subEntity:TiphonSprite = null;
         var isCarriedEntity:Boolean = false;
         try
         {
            if(!this.destroyed)
            {
               if(parent)
               {
                  parent.removeChild(this);
               }
               this.destroyed = true;
               this._parentSprite = null;
               if(this._look)
               {
                  this._look.removeObserver(this);
               }
               this.clearAnimation();
               if(this._tiphonEventManager)
               {
                  this._tiphonEventManager.destroy();
                  this._tiphonEventManager = null;
               }
               if(this._subEntitiesList)
               {
                  i = -1;
                  num = this._subEntitiesList.length;
                  while(++i < num)
                  {
                     subEntity = this._subEntitiesList[i] as TiphonSprite;
                     if(subEntity)
                     {
                        isCarriedEntity = (this._aSubEntities["3"]) && (subEntity == this._aSubEntities["3"]["0"]);
                        this.removeSubEntity(subEntity);
                        if(!isCarriedEntity)
                        {
                           subEntity.destroy();
                        }
                     }
                  }
               }
               if(this._subEntitiesTemp)
               {
                  i = -1;
                  num = this._subEntitiesTemp.length;
                  while(++i < num)
                  {
                     subEntity = this._subEntitiesList[i].entity as TiphonSprite;
                     if(subEntity)
                     {
                        subEntity.destroy();
                     }
                  }
                  this._subEntitiesTemp = null;
               }
               if(this._skin)
               {
                  this._skin.reset();
                  this._skin.removeEventListener(Event.COMPLETE,this.checkRessourceState);
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
         catch(e:Error)
         {
            _log.fatal("TiphonSprite impossible à détruire !");
         }
      }
      
      public function getAvaibleDirection(anim:String=null, flipped:Boolean=false) : Array {
         var lib:Swl = Tiphon.skullLibrary.getResourceById(this._look.getBone());
         var res:Array = new Array();
         if(!lib)
         {
            return [];
         }
         var i:uint = 0;
         while(i < 8)
         {
            res[i] = !(lib.getDefinitions().indexOf((anim?anim:this._currentAnimation) + "_" + i) == -1);
            if((flipped) && (!res[i]))
            {
               res[i] = !(lib.getDefinitions().indexOf((anim?anim:this._currentAnimation) + "_" + TiphonUtility.getFlipDirection(i)) == -1);
            }
            i++;
         }
         return res;
      }
      
      public function hasAnimation(anim:String, direction:int=-1) : Boolean {
         var i:* = 0;
         var result:Boolean = false;
         var bone:uint = this._look.getBone();
         if(direction != -1)
         {
            result = (Tiphon.skullLibrary.hasAnim(bone,anim,direction)) || (Tiphon.skullLibrary.hasAnim(bone,anim,TiphonUtility.getFlipDirection(direction)));
         }
         else
         {
            i = 0;
            while(i < 8)
            {
               Tiphon.skullLibrary.hasAnim(bone,(anim?anim:this._currentAnimation) + "_" + i);
               if(direction)
               {
                  result = true;
               }
               i++;
            }
         }
         if((!result) && (this._look.getSubEntity(2,0)))
         {
            bone = this._look.getSubEntity(2,0).getBone();
            if(direction != -1)
            {
               result = (Tiphon.skullLibrary.hasAnim(bone,anim,direction)) || (Tiphon.skullLibrary.hasAnim(bone,anim,TiphonUtility.getFlipDirection(direction)));
            }
            else
            {
               i = 0;
               while(i < 8)
               {
                  Tiphon.skullLibrary.hasAnim(bone,(anim?anim:this._currentAnimation) + "_" + i);
                  if(direction)
                  {
                     result = true;
                  }
                  i++;
               }
            }
         }
         return result;
      }
      
      public function getSlot(name:String="") : DisplayObject {
         var i:uint = 0;
         if((numChildren) && (this._animMovieClip))
         {
            i = 0;
            while(i < this._animMovieClip.numChildren)
            {
               if(getQualifiedClassName(this._animMovieClip.getChildAt(i)).indexOf(name) == 0)
               {
                  return this._animMovieClip.getChildAt(i);
               }
               i++;
            }
         }
         return null;
      }
      
      public function getColorTransform(index:uint) : ColorTransform {
         var ct:ColorTransform = null;
         if(this._aTransformColors[index])
         {
            return this._aTransformColors[index];
         }
         var c:DefaultableColor = this._look.getColor(index);
         if(!c.isDefault)
         {
            ct = new ColorTransform();
            ct.color = c.color;
            this._aTransformColors[index] = ct;
            return ct;
         }
         return null;
      }
      
      public function getSkinSprite(sprite:EquipmentSprite) : Sprite {
         if(!this._skin)
         {
            return null;
         }
         var className:String = getQualifiedClassName(sprite);
         if(this._skinModifier != null)
         {
            className = this._skinModifier.getModifiedSkin(this._skin,className,this._look);
         }
         return this._skin.getPart(className);
      }
      
      public function getPartTransformData(part:String) : TransformData {
         return this._skin?this._skin.getTransformData(part):null;
      }
      
      public function addSubEntity(entity:DisplayObject, category:uint, slot:uint) : void {
         var tiphonEntity:TiphonSprite = null;
         if((category == 3) && (slot == 0))
         {
            this._carriedEntity = entity as TiphonSprite;
         }
         if(this._rendered)
         {
            entity.x = 0;
            entity.y = 0;
            tiphonEntity = entity as TiphonSprite;
            if(tiphonEntity)
            {
               tiphonEntity._parentSprite = this;
               tiphonEntity.overrideNextAnimation = true;
               tiphonEntity.setDirection(this._currentDirection);
            }
            if(!this._aSubEntities[category])
            {
               this._aSubEntities[category] = new Array();
            }
            this._aSubEntities[category][slot] = entity;
            this.dispatchEvent(new TiphonEvent(TiphonEvent.SUB_ENTITY_ADDED,this));
            this._subEntitiesList.push(entity);
            _log.info("Add subentity " + entity.name + " to " + name + " (cat: " + category + ")");
            if((this._recursiveAlternativeSkinIndex) && (tiphonEntity))
            {
               tiphonEntity.setAlternativeSkinIndex(this._alternativeSkinIndex);
            }
            this.finalize();
         }
         else
         {
            this._subEntitiesTemp.push(new SubEntityTempInfo(entity,category,slot));
         }
      }
      
      public function removeSubEntity(entity:DisplayObject) : void {
         var found:* = false;
         var i:String = null;
         var index:* = 0;
         var j:String = null;
         if(entity == this._carriedEntity)
         {
            this._carriedEntity = null;
            this._isCarrying = false;
         }
         if(this.destroyed)
         {
            return;
         }
         for (i in this._aSubEntities)
         {
            for (j in this._aSubEntities[i])
            {
               if(entity === this._aSubEntities[i][j])
               {
                  if(this._subEntityBehaviors[i] is ISubEntityBehavior)
                  {
                     ISubEntityBehavior(this._subEntityBehaviors[i]).remove();
                  }
                  delete this._subEntityBehaviors[[i]];
                  delete this._aSubEntities[i][[j]];
                  found = true;
                  break;
               }
            }
            if(found)
            {
               break;
            }
         }
         index = this._subEntitiesList.indexOf(entity);
         if(index != -1)
         {
            this._subEntitiesList.splice(index,1);
         }
         var tiphonSprite:TiphonSprite = entity as TiphonSprite;
         if(tiphonSprite)
         {
            tiphonSprite._parentSprite = null;
            tiphonSprite.overrideNextAnimation = true;
         }
      }
      
      public function getSubEntitySlot(category:uint, slot:uint) : DisplayObjectContainer {
         if(this.destroyed)
         {
            return null;
         }
         if((this._aSubEntities[category]) && (this._aSubEntities[category][slot]))
         {
            if(this._aSubEntities[category][slot] is TiphonSprite)
            {
               (this._aSubEntities[category][slot] as TiphonSprite)._parentSprite = this;
            }
            return this._aSubEntities[category][slot];
         }
         return null;
      }
      
      public function getSubEntitiesList() : Array {
         return this._subEntitiesList;
      }
      
      public function getTmpSubEntitiesNb() : uint {
         return this._subEntitiesTemp.length;
      }
      
      public function registerColoredSprite(sprite:ColoredSprite, nColorIndex:uint) : void {
         if(!this._customColoredParts[nColorIndex])
         {
            this._customColoredParts[nColorIndex] = new Dictionary(true);
         }
         this._customColoredParts[nColorIndex][sprite] = 1;
      }
      
      public function registerInfoSprite(sprite:DisplayInfoSprite, nViewIndex:String) : void {
         this._displayInfoParts[nViewIndex] = sprite;
         if(nViewIndex == this._customView)
         {
            this.setView(nViewIndex);
         }
      }
      
      public function getDisplayInfoSprite(nViewIndex:String) : DisplayInfoSprite {
         return this._displayInfoParts[nViewIndex];
      }
      
      public function addBackground(name:String, sprite:DisplayObject, posAuto:Boolean=false) : void {
         var pos:Rectangle = null;
         if(!this._background[name])
         {
            this._background[name] = sprite;
            if(this._rendered)
            {
               if(name == "teamCircle")
               {
               }
               if(posAuto)
               {
                  pos = this.getRect(this);
                  sprite.y = pos.y - 10;
               }
               addChildAt(sprite,0);
               this.updateScale();
            }
            else
            {
               if(name == "teamCircle")
               {
               }
               this._backgroundTemp.push(sprite,posAuto);
            }
         }
      }
      
      public function removeBackground(name:String) : void {
         if((this._rendered) && (this._background[name]))
         {
            removeChild(this._background[name]);
         }
         this._background[name] = null;
      }
      
      public function showOnlyBackground(pOnlyBackground:Boolean) : void {
         this._backgroundOnly = pOnlyBackground;
         if((pOnlyBackground) && (this._animMovieClip) && (contains(this._animMovieClip)))
         {
            removeChild(this._animMovieClip);
         }
         else
         {
            if((!pOnlyBackground) && (this._animMovieClip))
            {
               addChild(this._animMovieClip);
            }
         }
      }
      
      public function isShowingOnlyBackground() : Boolean {
         return this._backgroundOnly;
      }
      
      public function setAlternativeSkinIndex(index:int=-1, recursiveAlternativeSkinIndex:Boolean=false) : void {
         var i:* = 0;
         var num:* = 0;
         var entity:TiphonSprite = null;
         this._recursiveAlternativeSkinIndex = recursiveAlternativeSkinIndex;
         if(this._recursiveAlternativeSkinIndex)
         {
            i = -1;
            num = this._subEntitiesList.length;
            while(++i < num)
            {
               entity = this._subEntitiesList[i] as TiphonSprite;
               if(entity)
               {
                  entity.setAlternativeSkinIndex(index);
               }
            }
         }
         if(index != this._alternativeSkinIndex)
         {
            this._alternativeSkinIndex = index;
            this.resetSkins();
         }
      }
      
      public function getAlternativeSkinIndex() : int {
         return this._alternativeSkinIndex;
      }
      
      public function getGlobalScale() : Number {
         var globalScale:Number = 1;
         var currentParentSprite:TiphonSprite = this.parentSprite;
         while(currentParentSprite)
         {
            globalScale = globalScale * (currentParentSprite._animMovieClip?currentParentSprite._animMovieClip.scaleX:1);
            currentParentSprite = currentParentSprite.parentSprite;
         }
         return globalScale;
      }
      
      public function reprocessSkin() : void {
         if(this._skin)
         {
            this._skin.reprocess();
         }
      }
      
      private function initializeLibrary(gfxId:uint, file:Uri=null) : void {
         if(!file)
         {
            if(BoneIndexManager.getInstance().hasCustomBone(gfxId))
            {
               return;
            }
            file = new Uri(TiphonConstants.SWF_SKULL_PATH + gfxId + ".swl");
         }
         this._libReady = false;
         Tiphon.skullLibrary.addResource(gfxId,file);
         Tiphon.skullLibrary.askResource(gfxId,this._currentAnimation,new Callback(this.onSkullLibraryReady,gfxId),new Callback(this.onSkullLibraryError));
      }
      
      private function applyColor(index:uint) : void {
         var cs:* = undefined;
         if(this._customColoredParts[index])
         {
            for (cs in this._customColoredParts[index])
            {
               cs.colorize(this.getColorTransform(index));
            }
         }
      }
      
      private function resetSkins() : void {
         var skin:uint = 0;
         this._skin.validate = false;
         this._skin.reset();
         for each (skin in this._look.getSkins(true))
         {
            skin = this._skin.add(skin,this._alternativeSkinIndex);
         }
         this._skin.validate = true;
      }
      
      private function resetSubEntities() : void {
         var mountCarriedEntity:TiphonSprite = null;
         var subEntitiesCategory:String = null;
         var entity:TiphonSprite = null;
         var subEntityIndex:String = null;
         var subEntityLook:TiphonEntityLook = null;
         var subEntity:TiphonSprite = null;
         while(this._subEntitiesList.length)
         {
            entity = this._subEntitiesList.shift() as TiphonSprite;
            if((entity) && (!((this._carriedEntity) && (entity == this._carriedEntity))))
            {
               if((this._aSubEntities["2"]) && (this._aSubEntities["2"]["0"]) && (entity == this._aSubEntities["2"]["0"]))
               {
                  if((!(this._deactivatedSubEntityCategory.indexOf("2") == -1)) && (entity.carriedEntity))
                  {
                     this._carriedEntity = entity.carriedEntity;
                  }
                  else
                  {
                     mountCarriedEntity = entity.getSubEntitySlot(3,0) as TiphonSprite;
                  }
               }
               entity.destroy();
            }
         }
         this._aSubEntities = [];
         var subEntities:Array = this._look.getSubEntities(true);
         for (subEntitiesCategory in subEntities)
         {
            if(this._deactivatedSubEntityCategory.indexOf(subEntitiesCategory) == -1)
            {
               if((subEntitiesCategory == "2") && (this._carriedEntity))
               {
                  mountCarriedEntity = this._carriedEntity;
                  this.removeSubEntity(this._carriedEntity);
               }
               for (subEntityIndex in subEntities[subEntitiesCategory])
               {
                  subEntityLook = subEntities[subEntitiesCategory][subEntityIndex];
                  subEntity = new TiphonSprite(subEntityLook);
                  subEntity.setAnimationAndDirection("AnimStatique",this._currentDirection);
                  if(!subEntity.rendered)
                  {
                     subEntity.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onSubEntityRendered,false,0,true);
                  }
                  this.addSubEntity(subEntity,parseInt(subEntitiesCategory),parseInt(subEntityIndex));
                  if((parseInt(subEntitiesCategory) == 2) && (parseInt(subEntityIndex) == 0) && (mountCarriedEntity))
                  {
                     subEntity.isCarrying = true;
                     subEntity.addSubEntity(mountCarriedEntity,3,0);
                  }
               }
            }
         }
         if(this._carriedEntity)
         {
            if(!this._aSubEntities["3"])
            {
               this._aSubEntities["3"] = new Array();
            }
            this._aSubEntities["3"]["0"] = this._carriedEntity;
            this._subEntitiesList.push(entity);
         }
      }
      
      protected function finalize() : void {
         if(this.destroyed)
         {
            return;
         }
         Tiphon.skullLibrary.askResource(this._look.getBone(),this._currentAnimation,new Callback(this.checkRessourceState),new Callback(this.onRenderFail));
      }
      
      private var _lastRenderRequest:uint;
      
      private function checkRessourceState(e:Event=null) : void {
         if(this.destroyed)
         {
            return;
         }
         if(((this._skin.complete) || (this.useProgressiveLoading) && (this._lastRenderRequest > 60)) && (Tiphon.skullLibrary.isLoaded(this._look.getBone(),this._currentAnimation)) && (!(this._currentAnimation == null)) && (this._currentDirection >= 0))
         {
            this.render();
         }
         this._lastRenderRequest = getTimer();
      }
      
      private function render() : void {
         var bgElement:DisplayObject = null;
         var currentBone:* = 0;
         var log:String = null;
         var defaultAnimation:String = null;
         var defaultOrientation:uint = 0;
         var carrying:* = 0;
         var dirs:Array = null;
         var dir:* = undefined;
         var rasterizedSyncAnimation:RasterizedSyncAnimation = null;
         var sprite:Sprite = null;
         var pos:Rectangle = null;
         var subEntityInfo:SubEntityTempInfo = null;
         var tiphonSprite:TiphonSprite = null;
         if(this.destroyed)
         {
            return;
         }
         FpsManager.getInstance().startTracking("animation",40277);
         var animClass:Class = null;
         var lib:Swl = Tiphon.skullLibrary.getResourceById(this._look.getBone(),this._currentAnimation);
         var finalDirection:int = this._currentDirection;
         if(this.parentSprite)
         {
            if(this.getGlobalScale() < 0)
            {
               finalDirection = TiphonUtility.getFlipDirection(finalDirection);
            }
         }
         var fliped:Boolean = false;
         var className:String = this._currentAnimation + "_" + finalDirection;
         if(lib.hasDefinition(className))
         {
            animClass = lib.getDefinition(className) as Class;
         }
         else
         {
            className = this._currentAnimation + "_" + TiphonUtility.getFlipDirection(finalDirection);
            if(lib.hasDefinition(className))
            {
               animClass = lib.getDefinition(className) as Class;
               fliped = true;
            }
         }
         if(animClass == null)
         {
            log = "Class [" + this._currentAnimation + "_" + finalDirection + "] or [" + this._currentAnimation + "_" + TiphonUtility.getFlipDirection(finalDirection) + "] cannot be found in library " + this._look.getBone();
            _log.error(log);
            defaultAnimation = SubstituteAnimationManager.getDefaultAnimation(this._currentAnimation);
            defaultOrientation = this._currentDirection;
            if(defaultAnimation)
            {
               dirs = this.getAvaibleDirection(defaultAnimation,true);
               for (dir in dirs)
               {
                  if(dirs[dir])
                  {
                     defaultOrientation = int(dir);
                     break;
                  }
               }
            }
            carrying = this._currentAnimation.indexOf("Carrying");
            if((!defaultAnimation) && (!(carrying == -1)))
            {
               defaultAnimation = this._currentAnimation.substring(0,carrying);
            }
            if((defaultAnimation) && (!(this._currentAnimation == defaultAnimation)))
            {
               _log.error("On ne trouve cette animation, on va jouer l\'animation " + defaultAnimation + "_" + this._currentDirection + " à la place.");
               this.setAnimationAndDirection(defaultAnimation,this._currentDirection,true);
            }
            else
            {
               if((defaultAnimation) && (this._currentAnimation == defaultAnimation) && (!(this._currentDirection == defaultOrientation)))
               {
                  _log.error("On ne trouve pas cette animation dans cette direction, on va jouer l\'animation " + defaultAnimation + "_" + defaultOrientation + " à la place.");
                  this.setAnimationAndDirection(defaultAnimation,defaultOrientation,true);
               }
               else
               {
                  this.onRenderFail();
               }
            }
            return;
         }
         if((this._lastAnimation == "AnimPickup") && (this._currentAnimation == "AnimStatiqueCarrying"))
         {
            this._isCarrying = true;
         }
         var gotoFrame:int = -1;
         if((this._currentAnimation == this._lastClassName) && (this._animMovieClip))
         {
            gotoFrame = this._animMovieClip.currentFrame;
         }
         this._lastClassName = this._currentAnimation;
         this.clearAnimation();
         for each (bgElement in this._background)
         {
            if(bgElement)
            {
               addChild(bgElement);
            }
         }
         this._customColoredParts = new Array();
         this._displayInfoParts = new Dictionary();
         ScriptedAnimation.currentSpriteHandler = this;
         currentBone = this._look.getBone();
         if((this._useCacheIfPossible) && (TiphonCacheManager.hasCache(currentBone,this._currentAnimation)))
         {
            this._animMovieClip = TiphonCacheManager.getScriptedAnimation(currentBone,this._currentAnimation,this._currentDirection);
         }
         else
         {
            this._animMovieClip = new animClass() as ScriptedAnimation;
         }
         ScriptedAnimation.currentSpriteHandler = null;
         MEMORY_LOG2[this._animMovieClip] = 1;
         if(!this._animMovieClip)
         {
            _log.error("Class [" + this._currentAnimation + "_" + finalDirection + "] is not a ScriptedAnimation");
            return;
         }
         this._animMovieClip.addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         if((fliped) && (this._animMovieClip.scaleX > 0))
         {
            this._animMovieClip.scaleX = this._animMovieClip.scaleX * -1;
         }
         else
         {
            if((!fliped) && (this._animMovieClip.scaleX < 0))
            {
               this._animMovieClip.scaleX = this._animMovieClip.scaleX * -1;
            }
         }
         var isSingleFrame:Boolean = MovieClipUtils.isSingleFrame(this._animMovieClip);
         this._animMovieClip.cacheAsBitmap = isSingleFrame;
         if(this.disableMouseEventWhenAnimated)
         {
            super.mouseEnabled = (isSingleFrame) && (this.mouseEnabled);
         }
         if(!this._backgroundOnly)
         {
            this.addChild(this._animMovieClip);
         }
         if((isSingleFrame) || (!this._rasterize) && (!Tiphon.getInstance().isRasterizeAnimation(this._currentAnimation)))
         {
            if(((!(this._currentAnimation.indexOf("AnimStatique") == -1)) || (!(this._currentAnimation.indexOf("AnimState") == -1))) && (this._currentAnimation.indexOf("_to_") == -1) && (!isSingleFrame))
            {
               _log.error("/!\\ ATTENTION, l\'animation [" + this._currentAnimation + "_" + finalDirection + "] sur le squelette [" + this._look.getBone() + "] contient un clip qui contient plusieurs frames. C\'est mal.");
            }
            if(!isSingleFrame)
            {
               FpsControler.controlFps(this._animMovieClip,lib.frameRate);
            }
            this._animMovieClip.addEventListener(AnimationEvent.EVENT,this.animEventHandler);
            this._animMovieClip.addEventListener(AnimationEvent.ANIM,this.animSwitchHandler);
         }
         else
         {
            this._animMovieClip.visible = false;
            rasterizedSyncAnimation = new RasterizedSyncAnimation(this._animMovieClip,this._lookCode);
            FpsControler.controlFps(rasterizedSyncAnimation,lib.frameRate);
            rasterizedSyncAnimation.addEventListener(AnimationEvent.EVENT,this.animEventHandler);
            rasterizedSyncAnimation.addEventListener(AnimationEvent.ANIM,this.animSwitchHandler);
            if(!this._backgroundOnly)
            {
               this.addChild(rasterizedSyncAnimation);
            }
            this._animMovieClip = rasterizedSyncAnimation;
         }
         if((!isSingleFrame) && (!(gotoFrame == -1)))
         {
            this._animMovieClip.gotoAndStop(gotoFrame);
            if(this._animMovieClip is ScriptedAnimation)
            {
               (this._animMovieClip as ScriptedAnimation).playEventAtFrame(gotoFrame);
            }
         }
         this._rendered = true;
         if(this._subEntitiesList.length)
         {
            this.dispatchEvent(new TiphonEvent(TiphonEvent.RENDER_FATHER_SUCCEED,this));
         }
         var nbb:int = this._backgroundTemp.length;
         var m:int = 0;
         while(m < nbb)
         {
            sprite = this._backgroundTemp.shift();
            if(this._backgroundTemp.shift())
            {
               pos = this.getRect(this);
               sprite.y = pos.y - 10;
            }
            addChildAt(sprite,0);
            m = m + 2;
         }
         FpsManager.getInstance().stopTracking("animation");
         if(this._subEntitiesTemp)
         {
            while(this._subEntitiesTemp.length)
            {
               subEntityInfo = this._subEntitiesTemp.shift();
               tiphonSprite = subEntityInfo.entity as TiphonSprite;
               if((tiphonSprite) && (!tiphonSprite._currentAnimation))
               {
                  tiphonSprite._currentAnimation = this._currentAnimation;
               }
               this.addSubEntity(subEntityInfo.entity,subEntityInfo.category,subEntityInfo.slot);
            }
         }
         this.checkRenderState();
      }
      
      public function forceRender() : void {
         var finalDirection:int = this._currentDirection;
         if((this.parentSprite) && (this.getGlobalScale() < 0))
         {
            finalDirection = TiphonUtility.getFlipDirection(finalDirection);
         }
         var className:String = this._currentAnimation + "_" + finalDirection;
         var lib:Swl = Tiphon.skullLibrary.getResourceById(this._look.getBone(),this._currentAnimation,true);
         if(lib == null)
         {
            Tiphon.skullLibrary.addEventListener(SwlEvent.SWL_LOADED,this.checkRessourceState);
         }
         else
         {
            this.checkRessourceState();
         }
      }
      
      protected function clearAnimation() : void {
         var num:* = 0;
         var i:* = 0;
         if(this._animMovieClip)
         {
            this._animMovieClip.removeEventListener(AnimationEvent.EVENT,this.animEventHandler);
            this._animMovieClip.removeEventListener(AnimationEvent.ANIM,this.animSwitchHandler);
            this._animMovieClip.removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
            FpsControler.uncontrolFps(this._animMovieClip);
            if(this._animMovieClip.parent)
            {
               removeChild(this._animMovieClip);
            }
            if((this._useCacheIfPossible) && ((this._animMovieClip as MovieClip).inCache))
            {
               TiphonCacheManager.pushScriptedAnimation(this._animMovieClip as ScriptedAnimation);
            }
            else
            {
               TiphonFpsManager.addOldScriptedAnimation(this._animMovieClip as ScriptedAnimation,true);
            }
            (this._animMovieClip as MovieClip).destroy();
            num = this._animMovieClip.numChildren;
            i = -1;
            while(++i < num)
            {
               this._animMovieClip.removeChildAt(0);
            }
            this._animMovieClip = null;
         }
         while(numChildren)
         {
            this.removeChildAt(0);
         }
      }
      
      private function animEventHandler(event:AnimationEvent) : void {
         this.dispatchEvent(new TiphonEvent(event.id,this));
         this.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_EVENT,this));
      }
      
      private function animSwitchHandler(event:AnimationEvent) : void {
         this.setAnimation(event.id);
      }
      
      override public function dispatchEvent(event:Event) : Boolean {
         var anim:String = null;
         if((event.type == TiphonEvent.ANIMATION_END) && (this._targetAnimation))
         {
            anim = this._targetAnimation;
            this._targetAnimation = null;
            this.setAnimation(anim);
            return false;
         }
         return super.dispatchEvent(event);
      }
      
      private function checkRenderState() : void {
         var subEntity:DisplayObject = null;
         for each (subEntity in this._subEntitiesList)
         {
            if((subEntity is TiphonSprite) && (!TiphonSprite(subEntity)._rendered))
            {
               return;
            }
         }
         if((!this._skin) || (!this._skin.complete))
         {
            return;
         }
         var te:TiphonEvent = new TiphonEvent(TiphonEvent.RENDER_SUCCEED,this);
         te.animationName = this._currentAnimation + "_" + this._currentDirection;
         if(!this._changeDispatched)
         {
            this._changeDispatched = true;
            setTimeout(this.dispatchEvent,1,te);
         }
      }
      
      private function updateScale() : void {
         var p:DisplayObject = null;
         var bg:DisplayObject = null;
         var parentSprite:TiphonSprite = null;
         var p2:TiphonSprite = null;
         if(!this._animMovieClip)
         {
            return;
         }
         var valueX:int = this._animMovieClip.scaleX >= 0?1:-1;
         var valueY:int = this._animMovieClip.scaleY >= 0?1:-1;
         var ent:DisplayObject = this;
         while(ent.parent)
         {
            valueX = valueX * (ent.parent.scaleX >= 0?1:-1);
            valueY = valueY * (ent.parent.scaleY >= 0?1:-1);
            if((ent.parent is TiphonSprite) && (p == null))
            {
               p = ent.parent;
            }
            ent = ent.parent;
         }
         if((p is TiphonSprite) && ((!(TiphonSprite(p).look.getScaleX() == 1)) || (!(TiphonSprite(p).look.getScaleY() == 1))))
         {
            parentSprite = p as TiphonSprite;
            this._animMovieClip.scaleX = this.look.getScaleX() / parentSprite.look.getScaleX() * (this._animMovieClip.scaleX < 0?-1:1);
            this._animMovieClip.scaleY = this.look.getScaleY() / parentSprite.look.getScaleY();
         }
         else
         {
            this._animMovieClip.scaleX = this.look.getScaleX() * (this._animMovieClip.scaleX < 0?-1:1);
            this._animMovieClip.scaleY = this.look.getScaleY();
         }
         for each (bg in this._background)
         {
            if(bg)
            {
               if(p is TiphonSprite)
               {
                  p2 = p as TiphonSprite;
                  bg.scaleX = 1 / p2.look.getScaleX() * valueX;
                  bg.scaleY = 1 / p2.look.getScaleY() * valueY;
               }
               else
               {
                  bg.scaleX = bg.scaleY = 1;
               }
            }
         }
      }
      
      private function dispatchWaitingEvents(e:Event) : void {
         StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,this.dispatchWaitingEvents);
         while(this._waitingEventInitList.length)
         {
            this.dispatchEvent(this._waitingEventInitList.shift());
         }
      }
      
      public function onAnimationEvent(eventName:String, params:String="") : void {
         if(eventName == TiphonEvent.PLAYER_STOP)
         {
            this.stopAnimation();
         }
         var event:TiphonEvent = new TiphonEvent(eventName,this,params);
         var animEvent:TiphonEvent = new TiphonEvent(TiphonEvent.ANIMATION_EVENT,this);
         if(this._init)
         {
            this.dispatchEvent(event);
            this.dispatchEvent(animEvent);
         }
         else
         {
            this._waitingEventInitList.push(event,animEvent);
         }
         if((!(eventName == TiphonEvent.PLAYER_STOP)) && (this.parentSprite))
         {
            this.parentSprite.onAnimationEvent(eventName);
         }
      }
      
      private function onRenderFail() : void {
         var event:TiphonEvent = new TiphonEvent(TiphonEvent.RENDER_FAILED,this);
         if(this._init)
         {
            this.dispatchEvent(event);
         }
         else
         {
            this._waitingEventInitList.push(event);
         }
         TiphonDebugManager.displayDofusScriptError("Rendu impossible : " + this._currentAnimation + ", " + this._currentDirection,this);
      }
      
      private function onSubEntityRendered(e:Event) : void {
         e.currentTarget.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onSubEntityRendered);
         this.checkRenderState();
      }
      
      private function onSkullLibraryReady(pBoneId:uint) : void {
         this._libReady = true;
         var event:TiphonEvent = new TiphonEvent(TiphonEvent.SPRITE_INIT,this,pBoneId);
         if(this._init)
         {
            this.dispatchEvent(event);
         }
         else
         {
            this._waitingEventInitList.push(event);
         }
      }
      
      private function onSkullLibraryError() : void {
         var event:TiphonEvent = new TiphonEvent(TiphonEvent.SPRITE_INIT_FAILED,this);
         if(this._init)
         {
            this.dispatchEvent(event);
         }
         else
         {
            this._waitingEventInitList.push(event);
         }
         TiphonDebugManager.displayDofusScriptError("Initialisation impossible : " + this._currentAnimation + ", " + this._currentDirection,this);
      }
      
      protected function onAdded(e:Event) : void {
         var carriedSprite:CarriedSprite = null;
         var child:DisplayObject = null;
         var splitedName:Array = null;
         this.updateScale();
         var nc:int = this._animMovieClip.numChildren;
         var i:int = 0;
         while(i < nc)
         {
            child = this._animMovieClip.getChildAt(i);
            if(child is CarriedSprite)
            {
               splitedName = getQualifiedClassName(child).split("_");
               if((splitedName[1] == "3") && (splitedName[2] == "0"))
               {
                  carriedSprite = this._animMovieClip.getChildAt(i) as CarriedSprite;
               }
            }
            i++;
         }
         if((this._isCarrying) && (this._carriedEntity))
         {
            if(carriedSprite)
            {
               this._carriedEntity.y = this._carriedEntity.x = 0;
               this._carriedEntity.setDirection(this._currentDirection);
               carriedSprite.addChild(this._carriedEntity);
            }
            else
            {
               if((this._animMovieClip.width > 0) && (this._animMovieClip.height > 0))
               {
                  if(this._carriedEntity.parent == this._animMovieClip)
                  {
                     this._animMovieClip.removeChild(this._carriedEntity);
                  }
                  this._carriedEntity.y = -(this._animMovieClip.localToGlobal(_point).y - this._animMovieClip.getBounds(StageShareManager.stage).y);
                  this._animMovieClip.addChild(this._carriedEntity);
               }
            }
         }
         this.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_ADDED,this));
      }
      
      public function boneChanged(look:TiphonEntityLook) : void {
         this._look = look;
         this._lookCode = this._look.toString();
         this._tiphonEventManager = new TiphonEventsManager(this);
         this._rendered = false;
         var boneFileUri:Uri = BoneIndexManager.getInstance().getBoneFile(this._look.getBone(),this._currentAnimation);
         if(BoneIndexManager.getInstance().hasCustomBone(this._look.getBone()))
         {
            if((!(boneFileUri.fileName == this._look.getBone() + ".swl")) || (BoneIndexManager.getInstance().hasAnim(this._look.getBone(),this._currentAnimation,this._currentDirection)))
            {
               this.initializeLibrary(look.getBone(),boneFileUri);
               this.setAnimation(this._rawAnimation);
            }
            else
            {
               this.setAnimationAndDirection("AnimStatique",this._currentDirection,true);
            }
         }
         else
         {
            this.initializeLibrary(look.getBone(),boneFileUri);
            this.setAnimation(this._rawAnimation);
         }
      }
      
      public function skinsChanged(look:TiphonEntityLook) : void {
         this._look = look;
         this._lookCode = this._look.toString();
         this._rendered = false;
         this.resetSkins();
         this.finalize();
      }
      
      public function colorsChanged(look:TiphonEntityLook) : void {
         var colorIndex:String = null;
         this._look = look;
         this._lookCode = this._look.toString();
         this._aTransformColors = new Array();
         if(this._rasterize)
         {
            this.finalize();
         }
         else
         {
            for (colorIndex in this._customColoredParts)
            {
               this.applyColor(uint(colorIndex));
            }
         }
      }
      
      public function scalesChanged(look:TiphonEntityLook) : void {
         this._look = look;
         this._lookCode = this._look.toString();
         if(this._rasterize)
         {
            this.finalize();
         }
         else
         {
            if(this._animMovieClip != null)
            {
               this.updateScale();
            }
         }
      }
      
      public function subEntitiesChanged(look:TiphonEntityLook) : void {
         this._look = look;
         this._lookCode = this._look.toString();
         this.resetSubEntities();
         this.finalize();
      }
      
      public function enableSubCategory(catId:int, isEnabled:Boolean=true) : void {
         if(isEnabled)
         {
            this._deactivatedSubEntityCategory.splice(this._deactivatedSubEntityCategory.indexOf(catId.toString()),1);
         }
         else
         {
            if(this._deactivatedSubEntityCategory.indexOf(catId.toString()) == -1)
            {
               this._deactivatedSubEntityCategory.push(catId.toString());
            }
         }
      }
      
      override public function toString() : String {
         return "[TiphonSprite] " + this._look.toString();
      }
   }
}
