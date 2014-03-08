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
      
      public static function setSubEntityDefaultBehavior(category:uint, behavior:ISubEntityBehavior) : void {
         _subEntitiesBehaviors[category] = behavior;
      }
      
      public static function setAnimationModifier(boneId:uint, am:IAnimationModifier) : void {
         _animationModifier[boneId] = am;
      }
      
      public static function setSkinModifier(boneId:uint, sm:ISkinModifier) : void {
         _skinModifier[boneId] = sm;
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
      
      public function set look(rawLook:*) : void {
         var look:TiphonEntityLook = null;
         var entity:TiphonSprite = null;
         if(lookAdaptater != null)
         {
            look = lookAdaptater(rawLook);
         }
         else
         {
            if(rawLook is TiphonEntityLook)
            {
               look = rawLook as TiphonEntityLook;
            }
            else
            {
               throw new ArgumentError();
            }
         }
         if(this._entity)
         {
            this._entity.visible = !(look == null);
         }
         if(this.withoutMount)
         {
            look = TiphonUtility.getLookWithoutMount(look);
         }
         if(look != null)
         {
            if(this.clearSubEntities)
            {
               look.resetSubEntities();
            }
            else
            {
               if(this.clearAuras)
               {
                  look.removeSubEntity(6);
               }
            }
         }
         if((look) && (this._lookUpdate))
         {
            if(look.toString() == this._lookUpdate.toString())
            {
               return;
            }
         }
         this._lookUpdate = look?look.clone():look;
         if(this._useCache)
         {
            entity = this._cache[look.toString()];
            if(entity)
            {
               if(this._entity)
               {
                  this.destroyOldEntity(this._entity);
               }
               addChild(entity);
               this._entity = entity;
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
      
      public function set direction(n:uint) : void {
         this._direction = n;
         if((!this._listenForUpdate) && (this._entity is TiphonSprite))
         {
            TiphonSprite(this._entity).setDirection(n);
         }
      }
      
      public function set animation(anim:String) : void {
         this._animation = anim;
         if(this._entity is TiphonSprite)
         {
            TiphonSprite(this._entity).setAnimation(anim);
         }
      }
      
      public function set gotoAndStop(value:int) : void {
         if(this._entity)
         {
            if(value == -1)
            {
               this._entity.stopAnimationAtEnd();
            }
            else
            {
               this._entity.stopAnimation(value);
            }
         }
         else
         {
            this._gotoAndStop = value;
         }
      }
      
      public function set staticDisplay(b:Boolean) : void {
         this._staticDisplay = b;
      }
      
      public function get staticDisplay() : Boolean {
         return this._staticDisplay;
      }
      
      override public function set scale(n:Number) : void {
         this._scale = n;
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
      
      public function set view(value:String) : void {
         this._view = value;
         if(this._entity is TiphonSprite)
         {
            this._entity.setView(value);
         }
      }
      
      override public function set handCursor(value:Boolean) : void {
         super.handCursor = value;
         if(value)
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
      
      public function set useCache(value:Boolean) : void {
         this._useCache = value;
         if(!this._cache)
         {
            this._cache = new Object();
         }
      }
      
      override public function get cacheAsBitmap() : Boolean {
         return super.cacheAsBitmap;
      }
      
      override public function set cacheAsBitmap(value:Boolean) : void {
         _log.fatal("Attention : Il ne faut surtout pas utiliser la propriété cacheAsBitmap sur les EntityDisplayer. TiphonSprite le gère déjà.");
      }
      
      public function update() : void {
         this.needUpdate();
      }
      
      public function updateMask() : void {
         if((this._scale > 1) || (!(this.yOffset == 0)))
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
            if((this._mask) && (this._mask.parent) && (this._mask.parent == this))
            {
               removeChild(this._mask);
            }
            TiphonSprite(this._entity).mask = null;
            this._mask = null;
         }
      }
      
      public function updateScaleAndOffsets() : void {
         var entRatio:* = NaN;
         var b:Rectangle = null;
         var dis:DisplayInfoSprite = null;
         var r:* = NaN;
         var m:* = NaN;
         this._entity.x = 0;
         this._entity.y = 0;
         if(this._view != null)
         {
            dis = TiphonSprite(this._entity).getDisplayInfoSprite(this._view);
            if(dis != null)
            {
               TiphonSprite(this._entity).look.setScales(1,1);
               TiphonSprite(this._entity).setView(this._view);
               entRatio = this._entity.width / this._entity.height;
               if(this._entity.width > this._entity.height)
               {
                  this._entity.height = width / entRatio * this._scale;
                  this._entity.width = width * this._scale;
               }
               else
               {
                  this._entity.width = height * entRatio * this._scale;
                  this._entity.height = height * this._scale;
               }
               b = TiphonSprite(this._entity).getBounds(this);
               this._entity.x = (width - this._entity.width) / 2 - b.left + this.xOffset;
               this._entity.y = (height - this._entity.height) / 2 - b.top + this.yOffset;
               r = dis.width / dis.height;
               m = width / height < dis.width / dis.height?width / dis.getRect(this).width:height / dis.getRect(this).height;
               this._entity.height = this._entity.height * m;
               this._entity.width = this._entity.width * m;
               this._entity.x = this._entity.x - dis.getRect(this).x;
               this._entity.y = this._entity.y - dis.getRect(this).y;
            }
         }
         else
         {
            entRatio = this._entity.width / this._entity.height;
            if(this._entity.width > this._entity.height)
            {
               this._entity.height = width / entRatio * this._scale;
               this._entity.width = width * this._scale;
            }
            else
            {
               this._entity.width = height * entRatio * this._scale;
               this._entity.height = height * this._scale;
            }
            b = TiphonSprite(this._entity).getBounds(this);
            this._entity.x = (width - this._entity.width) / 2 - b.left + this.xOffset;
            this._entity.y = (height - this._entity.height) / 2 - b.top + this.yOffset;
         }
      }
      
      public function setAnimationAndDirection(anim:String, dir:uint) : void {
         var seq:SerialSequencer = null;
         if(!this._fromCache)
         {
            this._animation = anim;
            this._direction = dir;
            if(this._entity is TiphonSprite)
            {
               seq = new SerialSequencer();
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
                     seq.addStep(new SetDirectionStep(TiphonSprite(this._entity),this._direction));
                     seq.addStep(new PlayAnimationStep(TiphonSprite(this._entity),this._animation,false));
                     seq.addStep(new SetAnimationStep(TiphonSprite(this._entity),"AnimStatique"));
                     seq.start();
                  }
               }
            }
         }
      }
      
      public function equipCharacter(list:Array, numDelete:int=0) : void {
         var base:Array = null;
         var tel:TiphonEntityLook = null;
         var bones:Array = null;
         var k:* = 0;
         if(this._entity is TiphonSprite)
         {
            base = TiphonSprite(this._entity).look.toString().split("|");
            if(list.length)
            {
               list.unshift(base[1].split(","));
               base[1] = list.join(",");
            }
            else
            {
               if(numDelete < base[1].length)
               {
                  bones = base[1].split(",");
                  k = 0;
                  while(k < numDelete)
                  {
                     bones.pop();
                     k++;
                  }
                  base[1] = bones.join(",");
               }
            }
            tel = TiphonEntityLook.fromString(base.join("|"));
            this._entity.look.updateFrom(tel);
         }
         else
         {
            if((!this._entity) && (list.length))
            {
               this._waitingForEquipement = list;
            }
         }
      }
      
      public function getSlotPosition(name:String) : Point {
         var s:Object = null;
         var p:Point = null;
         var point:Point = null;
         if((this._entity) && (this._entity is TiphonSprite))
         {
            s = TiphonSprite(this._entity).getSlot(name);
            if(s)
            {
               p = s.localToGlobal(new Point(s.x,s.y));
               point = this.globalToLocal(p);
               return point;
            }
            _log.error("Null entity, cannot get slot position.");
            return null;
         }
         _log.error("Null entity, cannot get slot position.");
         return null;
      }
      
      public function getSlotBounds(pSlotName:String) : Rectangle {
         var bounds:Rectangle = null;
         var slot:DisplayObject = null;
         var localPos:Point = null;
         if(this._entity)
         {
            slot = this._entity.getSlot(pSlotName);
            if(slot)
            {
               localPos = this.getSlotPosition(pSlotName);
               bounds = new Rectangle(localPos.x,localPos.y,slot.width,slot.height);
            }
         }
         return bounds;
      }
      
      public function getEntityBounds() : Rectangle {
         return this._entity?this._entity.getBounds(this):null;
      }
      
      override public function remove() : void {
         var behavior:ISubEntityBehavior = null;
         var ts:TiphonSprite = null;
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
            for each (ts in this._cache)
            {
               ts.destroy();
            }
            this._cache = null;
         }
         this._lookUpdate = null;
         EnterFrameDispatcher.removeEventListener(this.onFade);
         removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         for each (behavior in _subEntitiesBehaviors)
         {
            if(behavior)
            {
               behavior.remove();
            }
         }
         super.remove();
      }
      
      public function setColor(index:uint, color:uint) : void {
         if((TiphonSprite(this._entity)) && (TiphonSprite(this._entity).look))
         {
            TiphonSprite(this._entity).look.setColor(index,color);
         }
      }
      
      public function resetColor(index:uint) : void {
         if((TiphonSprite(this._entity)) && (TiphonSprite(this._entity).look))
         {
            TiphonSprite(this._entity).look.resetColor(index);
         }
      }
      
      private function onCharacterReady(e:Event) : void {
         var cat:* = undefined;
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
         for (cat in _subEntitiesBehaviors)
         {
            if(_subEntitiesBehaviors[cat])
            {
               (this._entity as TiphonSprite).setSubEntityBehaviour(cat,_subEntitiesBehaviors[cat]);
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
         if((!this._entity.height) || (!this.autoSize))
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
      
      private function destroyOldEntity(entity:TiphonSprite) : void {
         if(entity.parent)
         {
            removeChild(entity);
         }
         if(!this._useCache)
         {
            entity.destroy();
         }
      }
      
      private function needUpdate(e:Event=null) : void {
         var cat:* = undefined;
         var key:String = null;
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
            key = this._entity.look.toString();
            this._cache[key] = this._entity;
         }
         this._originalScaleX = (this._entity as TiphonSprite).look.getScaleX();
         this._originalScaleY = (this._entity as TiphonSprite).look.getScaleY();
         for (cat in _subEntitiesBehaviors)
         {
            if(_subEntitiesBehaviors[cat])
            {
               (this._entity as TiphonSprite).setSubEntityBehaviour(cat,_subEntitiesBehaviors[cat]);
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
      
      private function onFade(e:Event) : void {
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
      
      private function mouseOver(e:MouseEvent) : void {
         this._entity.transform.colorTransform = new ColorTransform(1.3,1.3,1.3,1);
      }
      
      private function mouseOut(e:MouseEvent) : void {
         this._entity.transform.colorTransform = new ColorTransform(1,1,1,1);
      }
   }
}
