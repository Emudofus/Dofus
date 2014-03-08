package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import flash.utils.Dictionary;
   import com.ankamagames.tiphon.types.ISubEntityBehavior;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.ISkinModifier;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.Shape;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import com.ankamagames.tiphon.types.DisplayInfoSprite;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetAnimationStep;
   import flash.geom.Point;
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.events.Event;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.messages.EntityReadyMessage;
   import flash.display.InteractiveObject;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.geom.ColorTransform;
   
   public class EntityDisplayer extends GraphicContainer implements UIComponent, IRectangle
   {
      
      public function EntityDisplayer() {
         this._waitingForEquipement = new Array();
         super();
         mouseChildren = false;
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public static var lookAdaptater:Function;
      
      private static const _subEntitiesBehaviors:Dictionary = new Dictionary();
      
      private static const _animationModifier:Dictionary = new Dictionary();
      
      private static const _skinModifier:Dictionary = new Dictionary();
      
      public static function setSubEntityDefaultBehavior(param1:uint, param2:ISubEntityBehavior) : void {
         _subEntitiesBehaviors[param1] = param2;
      }
      
      public static function setAnimationModifier(param1:uint, param2:IAnimationModifier) : void {
         _animationModifier[param1] = param2;
      }
      
      public static function setSkinModifier(param1:uint, param2:ISkinModifier) : void {
         _skinModifier[param1] = param2;
      }
      
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
      
      public var yOffset:int = 0;
      
      public var xOffset:int = 0;
      
      public var autoSize:Boolean = true;
      
      public var useFade:Boolean = true;
      
      public var clearSubEntities:Boolean = true;
      
      public var clearAuras:Boolean = true;
      
      public var withoutMount:Boolean = false;
      
      public function set look(param1:*) : void {
         var _loc2_:TiphonEntityLook = null;
         var _loc3_:TiphonSprite = null;
         if(lookAdaptater != null)
         {
            _loc2_ = lookAdaptater(param1);
         }
         else
         {
            if(param1 is TiphonEntityLook)
            {
               _loc2_ = param1 as TiphonEntityLook;
            }
            else
            {
               throw new ArgumentError();
            }
         }
         if(this._entity)
         {
            this._entity.visible = !(_loc2_ == null);
         }
         if(this.withoutMount)
         {
            _loc2_ = TiphonUtility.getLookWithoutMount(_loc2_);
         }
         if(_loc2_ != null)
         {
            if(this.clearSubEntities)
            {
               _loc2_.resetSubEntities();
            }
            else
            {
               if(this.clearAuras)
               {
                  _loc2_.removeSubEntity(6);
               }
            }
         }
         if((_loc2_) && (this._lookUpdate))
         {
            if(_loc2_.toString() == this._lookUpdate.toString())
            {
               return;
            }
         }
         this._lookUpdate = _loc2_?_loc2_.clone():_loc2_;
         if(this._useCache)
         {
            _loc3_ = this._cache[_loc2_.toString()];
            if(_loc3_)
            {
               if(this._entity)
               {
                  this.destroyOldEntity(this._entity);
               }
               addChild(_loc3_);
               this._entity = _loc3_;
               this._fromCache = true;
               return;
            }
         }
         this._fromCache = false;
         this._listenForUpdate = true;
         EnterFrameDispatcher.addEventListener(this.needUpdate,"EntityDisplayerUpdater");
      }
      
      public function get look() : TiphonEntityLook {
         return this._entity?this._entity.look:this._lookUpdate;
      }
      
      public function set direction(param1:uint) : void {
         this._direction = param1;
         if(!this._listenForUpdate && this._entity is TiphonSprite)
         {
            TiphonSprite(this._entity).setDirection(param1);
         }
      }
      
      public function set animation(param1:String) : void {
         this._animation = param1;
         if(this._entity is TiphonSprite)
         {
            TiphonSprite(this._entity).setAnimation(param1);
         }
      }
      
      public function set gotoAndStop(param1:int) : void {
         if(this._entity)
         {
            if(param1 == -1)
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
      }
      
      public function set staticDisplay(param1:Boolean) : void {
         this._staticDisplay = param1;
      }
      
      public function get staticDisplay() : Boolean {
         return this._staticDisplay;
      }
      
      override public function set scale(param1:Number) : void {
         this._scale = param1;
      }
      
      override public function get scale() : Number {
         return this._scale;
      }
      
      public function get direction() : uint {
         return this._direction;
      }
      
      public function get animation() : String {
         return this._animation;
      }
      
      public function set view(param1:String) : void {
         this._view = param1;
         if(this._entity is TiphonSprite)
         {
            this._entity.setView(param1);
         }
      }
      
      override public function set handCursor(param1:Boolean) : void {
         super.handCursor = param1;
         if(param1)
         {
            addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
            addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         }
         else
         {
            removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
            removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         }
      }
      
      public function get useCache() : Boolean {
         return this._useCache;
      }
      
      public function set useCache(param1:Boolean) : void {
         this._useCache = param1;
         if(!this._cache)
         {
            this._cache = new Object();
         }
      }
      
      override public function get cacheAsBitmap() : Boolean {
         return super.cacheAsBitmap;
      }
      
      override public function set cacheAsBitmap(param1:Boolean) : void {
         _log.fatal("Attention : Il ne faut surtout pas utiliser la propriété cacheAsBitmap sur les EntityDisplayer. TiphonSprite le gère déjà.");
      }
      
      public function update() : void {
         this.needUpdate();
      }
      
      public function updateMask() : void {
         if(this._scale > 1 || !(this.yOffset == 0))
         {
            if(this._mask)
            {
               this._mask.graphics.clear();
            }
            else
            {
               this._mask = new Shape();
            }
            this._mask.graphics.beginFill(0);
            this._mask.graphics.drawRect(0,0,width,height);
            addChild(this._mask);
            TiphonSprite(this._entity).mask = this._mask;
            if(this._oldEntity)
            {
               if(this._mask2)
               {
                  this._mask2.graphics.clear();
               }
               else
               {
                  this._mask2 = new Shape();
               }
               this._mask2.graphics.beginFill(0);
               this._mask2.graphics.drawRect(0,0,width,height);
               addChild(this._mask2);
               TiphonSprite(this._oldEntity).mask = this._mask2;
            }
         }
         else
         {
            if((this._mask) && (this._mask.parent) && this._mask.parent == this)
            {
               removeChild(this._mask);
            }
            TiphonSprite(this._entity).mask = null;
            this._mask = null;
         }
      }
      
      public function updateScaleAndOffsets() : void {
         var _loc1_:* = NaN;
         var _loc2_:Rectangle = null;
         var _loc3_:DisplayInfoSprite = null;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         this._entity.x = 0;
         this._entity.y = 0;
         if(this._view != null)
         {
            _loc3_ = TiphonSprite(this._entity).getDisplayInfoSprite(this._view);
            if(_loc3_ != null)
            {
               TiphonSprite(this._entity).look.setScales(1,1);
               TiphonSprite(this._entity).setView(this._view);
               _loc1_ = this._entity.width / this._entity.height;
               if(this._entity.width > this._entity.height)
               {
                  this._entity.height = width / _loc1_ * this._scale;
                  this._entity.width = width * this._scale;
               }
               else
               {
                  this._entity.width = height * _loc1_ * this._scale;
                  this._entity.height = height * this._scale;
               }
               _loc2_ = TiphonSprite(this._entity).getBounds(this);
               this._entity.x = (width - this._entity.width) / 2 - _loc2_.left + this.xOffset;
               this._entity.y = (height - this._entity.height) / 2 - _loc2_.top + this.yOffset;
               _loc4_ = _loc3_.width / _loc3_.height;
               _loc5_ = width / height < _loc3_.width / _loc3_.height?width / _loc3_.getRect(this).width:height / _loc3_.getRect(this).height;
               this._entity.height = this._entity.height * _loc5_;
               this._entity.width = this._entity.width * _loc5_;
               this._entity.x = this._entity.x - _loc3_.getRect(this).x;
               this._entity.y = this._entity.y - _loc3_.getRect(this).y;
            }
         }
         else
         {
            _loc1_ = this._entity.width / this._entity.height;
            if(this._entity.width > this._entity.height)
            {
               this._entity.height = width / _loc1_ * this._scale;
               this._entity.width = width * this._scale;
            }
            else
            {
               this._entity.width = height * _loc1_ * this._scale;
               this._entity.height = height * this._scale;
            }
            _loc2_ = TiphonSprite(this._entity).getBounds(this);
            this._entity.x = (width - this._entity.width) / 2 - _loc2_.left + this.xOffset;
            this._entity.y = (height - this._entity.height) / 2 - _loc2_.top + this.yOffset;
         }
      }
      
      public function setAnimationAndDirection(param1:String, param2:uint) : void {
         var _loc3_:SerialSequencer = null;
         if(!this._fromCache)
         {
            this._animation = param1;
            this._direction = param2;
            if(this._entity is TiphonSprite)
            {
               _loc3_ = new SerialSequencer();
               if(this._animation == "AnimStatique")
               {
                  TiphonSprite(this._entity).setAnimationAndDirection("AnimStatique",this._direction);
               }
               else
               {
                  if(this._animation == "AnimArtwork")
                  {
                     TiphonSprite(this._entity).setAnimationAndDirection("AnimArtwork",this._direction);
                  }
                  else
                  {
                     _loc3_.addStep(new SetDirectionStep(TiphonSprite(this._entity),this._direction));
                     _loc3_.addStep(new PlayAnimationStep(TiphonSprite(this._entity),this._animation,false));
                     _loc3_.addStep(new SetAnimationStep(TiphonSprite(this._entity),"AnimStatique"));
                     _loc3_.start();
                  }
               }
            }
         }
      }
      
      public function equipCharacter(param1:Array, param2:int=0) : void {
         var _loc3_:Array = null;
         var _loc4_:TiphonEntityLook = null;
         var _loc5_:Array = null;
         var _loc6_:* = 0;
         if(this._entity is TiphonSprite)
         {
            _loc3_ = TiphonSprite(this._entity).look.toString().split("|");
            if(param1.length)
            {
               param1.unshift(_loc3_[1].split(","));
               _loc3_[1] = param1.join(",");
            }
            else
            {
               if(param2 < _loc3_[1].length)
               {
                  _loc5_ = _loc3_[1].split(",");
                  _loc6_ = 0;
                  while(_loc6_ < param2)
                  {
                     _loc5_.pop();
                     _loc6_++;
                  }
                  _loc3_[1] = _loc5_.join(",");
               }
            }
            _loc4_ = TiphonEntityLook.fromString(_loc3_.join("|"));
            this._entity.look.updateFrom(_loc4_);
         }
         else
         {
            if(!this._entity && (param1.length))
            {
               this._waitingForEquipement = param1;
            }
         }
      }
      
      public function getSlotPosition(param1:String) : Point {
         var _loc2_:Object = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         if((this._entity) && this._entity is TiphonSprite)
         {
            _loc2_ = TiphonSprite(this._entity).getSlot(param1);
            if(_loc2_)
            {
               _loc3_ = _loc2_.localToGlobal(new Point(_loc2_.x,_loc2_.y));
               _loc4_ = this.globalToLocal(_loc3_);
               return _loc4_;
            }
            _log.error("Null entity, cannot get slot position.");
            return null;
         }
         _log.error("Null entity, cannot get slot position.");
         return null;
      }
      
      public function getSlotBounds(param1:String) : Rectangle {
         var _loc2_:Rectangle = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:Point = null;
         if(this._entity)
         {
            _loc3_ = this._entity.getSlot(param1);
            if(_loc3_)
            {
               _loc4_ = this.getSlotPosition(param1);
               _loc2_ = new Rectangle(_loc4_.x,_loc4_.y,_loc3_.width,_loc3_.height);
            }
         }
         return _loc2_;
      }
      
      public function getEntityBounds() : Rectangle {
         return this._entity?this._entity.getBounds(this):null;
      }
      
      override public function remove() : void {
         var _loc1_:ISubEntityBehavior = null;
         var _loc2_:TiphonSprite = null;
         if(this._entity)
         {
            (this._entity as EventDispatcher).removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onCharacterReady);
            this._entity.destroy();
            this._entity = null;
         }
         if(this._oldEntity)
         {
            (this._oldEntity as EventDispatcher).removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onCharacterReady);
            this._oldEntity.destroy();
            this._oldEntity = null;
         }
         if(this._cache)
         {
            for each (_loc2_ in this._cache)
            {
               _loc2_.destroy();
            }
            this._cache = null;
         }
         this._lookUpdate = null;
         EnterFrameDispatcher.removeEventListener(this.onFade);
         removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         for each (_loc1_ in _subEntitiesBehaviors)
         {
            if(_loc1_)
            {
               _loc1_.remove();
            }
         }
         super.remove();
      }
      
      public function setColor(param1:uint, param2:uint) : void {
         if((TiphonSprite(this._entity)) && (TiphonSprite(this._entity).look))
         {
            TiphonSprite(this._entity).look.setColor(param1,param2);
         }
      }
      
      public function resetColor(param1:uint) : void {
         if((TiphonSprite(this._entity)) && (TiphonSprite(this._entity).look))
         {
            TiphonSprite(this._entity).look.resetColor(param1);
         }
      }
      
      private function onCharacterReady(param1:Event) : void {
         var _loc2_:* = undefined;
         (this._entity as EventDispatcher).removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onCharacterReady);
         if(this._entity.rawAnimation)
         {
            this._entity.rawAnimation.gotoAndPlay(0);
         }
         if(this._gotoAndStop)
         {
            if(this._gotoAndStop == -1)
            {
               this._entity.stopAnimationAtEnd();
            }
            else
            {
               this._entity.stopAnimation(this._gotoAndStop);
            }
            this._gotoAndStop = 0;
         }
         if(this._staticDisplay)
         {
            if(this._skipResize)
            {
               return;
            }
            this._skipResize = true;
         }
         if(_animationModifier[this._entity.look.getBone()])
         {
            this._entity.addAnimationModifier(_animationModifier[this._entity.look.getBone()]);
         }
         if(_skinModifier[this._entity.look.getBone()])
         {
            this._entity.skinModifier = _skinModifier[this._entity.look.getBone()];
         }
         for (_loc2_ in _subEntitiesBehaviors)
         {
            if(_subEntitiesBehaviors[_loc2_])
            {
               (this._entity as TiphonSprite).setSubEntityBehaviour(_loc2_,_subEntitiesBehaviors[_loc2_]);
            }
         }
         this._entity.visible = true;
         this.updateMask();
         if(this._oldEntity)
         {
            if(this.useFade)
            {
               this._oldEntity.alpha = 1;
               this._entity.alpha = 0;
               EnterFrameDispatcher.addEventListener(this.onFade,"entityDisplayerFade");
            }
            else
            {
               this.destroyOldEntity(this._oldEntity);
               this._oldEntity = null;
            }
         }
         if(!this._entity.height || !this.autoSize)
         {
            Berilia.getInstance().handler.process(new EntityReadyMessage(InteractiveObject(this)));
            return;
         }
         this.updateScaleAndOffsets();
         this._entity.visible = true;
         if(Berilia.getInstance().handler)
         {
            Berilia.getInstance().handler.process(new EntityReadyMessage(InteractiveObject(this)));
         }
      }
      
      private function destroyOldEntity(param1:TiphonSprite) : void {
         if(param1.parent)
         {
            removeChild(param1);
         }
         if(!this._useCache)
         {
            param1.destroy();
         }
      }
      
      private function needUpdate(param1:Event=null) : void {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         EnterFrameDispatcher.removeEventListener(this.needUpdate);
         this._listenForUpdate = false;
         if(this._oldEntity)
         {
            this.destroyOldEntity(this._oldEntity);
            this._oldEntity = null;
         }
         if(!this._lookUpdate)
         {
            if(this._entity)
            {
               this.destroyOldEntity(this._entity);
               this._entity = null;
            }
            return;
         }
         this._oldEntity = this._entity;
         this._entity = new TiphonSprite(SecureCenter.unsecure(this._lookUpdate.clone()));
         this._entity.visible = false;
         if(_animationModifier[this._entity.look.getBone()])
         {
            this._entity.addAnimationModifier(_animationModifier[this._entity.look.getBone()]);
         }
         if(_skinModifier[this._entity.look.getBone()])
         {
            this._entity.skinModifier = _skinModifier[this._entity.look.getBone()];
         }
         if(this._useCache)
         {
            _loc3_ = this._entity.look.toString();
            this._cache[_loc3_] = this._entity;
         }
         this._originalScaleX = (this._entity as TiphonSprite).look.getScaleX();
         this._originalScaleY = (this._entity as TiphonSprite).look.getScaleY();
         for (_loc2_ in _subEntitiesBehaviors)
         {
            if(_subEntitiesBehaviors[_loc2_])
            {
               (this._entity as TiphonSprite).setSubEntityBehaviour(_loc2_,_subEntitiesBehaviors[_loc2_]);
            }
         }
         (this._entity as EventDispatcher).addEventListener(TiphonEvent.RENDER_SUCCEED,this.onCharacterReady);
         addChild(this._entity);
         this.setAnimationAndDirection(this._animation,this._direction);
         if(this._waitingForEquipement.length)
         {
            this.equipCharacter(this._waitingForEquipement,0);
         }
      }
      
      private function onFade(param1:Event) : void {
         if(this._entity)
         {
            this._entity.alpha = this._entity.alpha + (1 - this._entity.alpha) / 3;
            this._oldEntity.alpha = this._oldEntity.alpha + (0 - this._oldEntity.alpha) / 3;
            if(this._oldEntity.alpha < 0.05)
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
      }
      
      private function mouseOver(param1:MouseEvent) : void {
         this._entity.transform.colorTransform = new ColorTransform(1.3,1.3,1.3,1);
      }
      
      private function mouseOut(param1:MouseEvent) : void {
         this._entity.transform.colorTransform = new ColorTransform(1,1,1,1);
      }
   }
}
