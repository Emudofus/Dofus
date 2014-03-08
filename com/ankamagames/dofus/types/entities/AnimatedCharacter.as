package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.interfaces.IObstacle;
   import com.ankamagames.jerakine.interfaces.ITransparency;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.ColorTransform;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import flash.display.Bitmap;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.types.enums.InteractionsEnum;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.atouin.entities.behaviours.movements.SlideMovementBehavior;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.atouin.entities.behaviours.movements.WalkingMovementBehavior;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.atouin.entities.behaviours.movements.MountedMovementBehavior;
   import com.ankamagames.atouin.entities.behaviours.movements.RunningMovementBehavior;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.pathfinding.Pathfinding;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import com.ankamagames.dofus.datacenter.sounds.SoundAnimation;
   import com.ankamagames.tiphon.display.TiphonAnimation;
   import com.ankamagames.dofus.datacenter.sounds.SoundBones;
   import com.ankamagames.tiphon.engine.TiphonEventsManager;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.atouin.entities.behaviours.display.AtouinDisplayBehavior;
   
   public class AnimatedCharacter extends TiphonSprite implements IEntity, IMovable, IDisplayable, IAnimated, IInteractive, IRectangle, IObstacle, ITransparency, ICustomUnicNameGetter
   {
      
      public function AnimatedCharacter(param1:int, param2:TiphonEntityLook, param3:AnimatedCharacter=null) {
         super(param2);
         this._name = "entity::" + param1;
         this._displayBehavior = AtouinDisplayBehavior.getInstance();
         this._movementBehavior = WalkingMovementBehavior.getInstance();
         addEventListener(TiphonEvent.RENDER_SUCCEED,this.onFirstRender);
         addEventListener(TiphonEvent.RENDER_FAILED,this.onFirstError);
         setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE,DirectionsEnum.DOWN_RIGHT);
         this.id = param1;
         name = "AnimatedCharacter" + param1;
         this._followers = new Vector.<IMovable>();
         this._followed = param3;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimatedCharacter));
      
      private static const LUMINOSITY_FACTOR:Number = 1.2;
      
      private static const LUMINOSITY_TRANSFORM:ColorTransform = new ColorTransform(LUMINOSITY_FACTOR,LUMINOSITY_FACTOR,LUMINOSITY_FACTOR);
      
      private static const NORMAL_TRANSFORM:ColorTransform = new ColorTransform();
      
      private static const TRANSPARENCY_TRANSFORM:ColorTransform = new ColorTransform(1,1,1,AtouinConstants.OVERLAY_MODE_ALPHA);
      
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
      
      private var _auraEntity:TiphonSprite;
      
      private var _visibleAura:Boolean = true;
      
      public var speedAdjust:Number = 0.0;
      
      public function get id() : int {
         return this._id;
      }
      
      public function set id(param1:int) : void {
         this._id = param1;
      }
      
      public function get customUnicName() : String {
         return this._name;
      }
      
      public function get position() : MapPoint {
         return this._position;
      }
      
      public function set position(param1:MapPoint) : void {
         this._position = param1;
      }
      
      public function get movementBehavior() : IMovementBehavior {
         return this._movementBehavior;
      }
      
      public function set movementBehavior(param1:IMovementBehavior) : void {
         this._movementBehavior = param1;
      }
      
      public function get followed() : AnimatedCharacter {
         return this._followed;
      }
      
      public function get displayBehaviors() : IDisplayBehavior {
         return this._displayBehavior;
      }
      
      public function set displayBehaviors(param1:IDisplayBehavior) : void {
         this._displayBehavior = param1;
      }
      
      public function get displayed() : Boolean {
         return this._displayed;
      }
      
      public function get handler() : MessageHandler {
         return Kernel.getWorker();
      }
      
      public function get enabledInteractions() : uint {
         return InteractionsEnum.CLICK | InteractionsEnum.OUT | InteractionsEnum.OVER;
      }
      
      public function get isMoving() : Boolean {
         return this._movementBehavior.isMoving(this);
      }
      
      public function get absoluteBounds() : IRectangle {
         return this._displayBehavior.getAbsoluteBounds(this);
      }
      
      override public function get useHandCursor() : Boolean {
         return true;
      }
      
      public function get visibleAura() : Boolean {
         return this._visibleAura;
      }
      
      public function set visibleAura(param1:Boolean) : void {
         var _loc2_:String = null;
         if(this._visibleAura == param1)
         {
            return;
         }
         this._visibleAura = param1;
         if(param1)
         {
            _loc2_ = getAnimation();
            if((this._auraEntity) && (_loc2_) && !(_loc2_.indexOf("AnimStatique") == -1))
            {
               this.addSubEntity(this._auraEntity,SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND,0);
               this._auraEntity.restartAnimation(0);
               this._auraEntity = null;
            }
         }
         else
         {
            this._auraEntity = getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND,0) as TiphonSprite;
            if(this._auraEntity)
            {
               removeSubEntity(this._auraEntity);
               super.finalize();
            }
         }
      }
      
      public function get hasAura() : Boolean {
         if(!(this._auraEntity == null) || !(getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND,0) == null))
         {
            return true;
         }
         return false;
      }
      
      public function getIsTransparencyAllowed() : Boolean {
         return this._transparencyAllowed;
      }
      
      public function set transparencyAllowed(param1:Boolean) : void {
         this._transparencyAllowed = param1;
      }
      
      public var slideOnNextMove:Boolean;
      
      private function onFirstError(param1:TiphonEvent) : void {
         removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onFirstRender);
         removeEventListener(TiphonEvent.RENDER_FAILED,this.onFirstError);
         var _loc2_:Array = getAvaibleDirection(AnimationEnum.ANIM_STATIQUE);
         var _loc3_:uint = DirectionsEnum.DOWN_RIGHT;
         while(_loc3_ < DirectionsEnum.DOWN_RIGHT + 7)
         {
            if(_loc2_[_loc3_ % 8])
            {
               setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE,_loc3_ % 8);
            }
            _loc3_++;
         }
      }
      
      private function onFirstRender(param1:TiphonEvent) : void {
         removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onFirstRender);
         removeEventListener(TiphonEvent.RENDER_FAILED,this.onFirstError);
      }
      
      public function canSeeThrough() : Boolean {
         return this._canSeeThrough;
      }
      
      public function setCanSeeThrough(param1:Boolean) : void {
         this._canSeeThrough = param1;
      }
      
      public function move(param1:MovementPath, param2:Function=null) : void {
         var _loc6_:IMovable = null;
         var _loc7_:GameContextActorInformations = null;
         var _loc8_:* = false;
         var _loc9_:Array = null;
         var _loc10_:RoleplayContextFrame = null;
         var _loc11_:Vector.<InteractiveElement> = null;
         var _loc12_:InteractiveElement = null;
         var _loc13_:* = 0;
         var _loc14_:MapPoint = null;
         var _loc15_:uint = 0;
         var _loc16_:Array = null;
         var _loc17_:uint = 0;
         var _loc18_:* = false;
         if(!param1.start.equals(this.position))
         {
            _log.warn("Unsynchronized position for entity " + this.id + ", jumping from " + this.position + " to " + param1.start + ".");
            this.jump(param1.start);
         }
         var _loc3_:uint = param1.path.length + 1;
         this._movementBehavior = null;
         if(this.slideOnNextMove)
         {
            this._movementBehavior = SlideMovementBehavior.getInstance();
            this.slideOnNextMove = false;
         }
         else
         {
            if(Kernel.getWorker().contains(RoleplayEntitiesFrame))
            {
               _loc7_ = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(this.id);
               if(_loc7_ is GameRolePlayHumanoidInformations)
               {
                  if((_loc7_ as GameRolePlayHumanoidInformations).humanoidInfo.restrictions.cantRun)
                  {
                     this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                  }
               }
               else
               {
                  if(_loc7_ is GameRolePlayGroupMonsterInformations)
                  {
                     this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                  }
               }
            }
            if(!this._movementBehavior)
            {
               if(_loc3_ > 3)
               {
                  _loc8_ = false;
                  if(Kernel.getWorker().contains(RoleplayEntitiesFrame))
                  {
                     _loc8_ = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).isCreatureMode;
                  }
                  if(!_loc8_ && (this.isMounted()))
                  {
                     this._movementBehavior = MountedMovementBehavior.getInstance();
                  }
                  else
                  {
                     this._movementBehavior = RunningMovementBehavior.getInstance(this.speedAdjust);
                  }
               }
               else
               {
                  if(_loc3_ > 0)
                  {
                     this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                  }
                  else
                  {
                     return;
                  }
               }
            }
         }
         var _loc4_:int = this.getDirection();
         var _loc5_:IDataMapProvider = DataMapProvider.getInstance();
         if(this._followers.length > 0)
         {
            _loc9_ = new Array();
            _loc10_ = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
            if(_loc10_ != null)
            {
               _loc11_ = _loc10_.entitiesFrame.interactiveElements;
               for each (_loc12_ in _loc11_)
               {
                  _loc13_ = Atouin.getInstance().getIdentifiedElementPosition(_loc12_.elementId).cellId;
                  _loc9_.push(_loc13_);
               }
            }
         }
         for each (_loc6_ in this._followers)
         {
            _loc14_ = null;
            _loc15_ = 0;
            do
            {
                  _loc14_ = param1.end.getNearestFreeCellInDirection(_loc4_,_loc5_,false,false,_loc9_);
                  _loc4_++;
                  _loc4_ = _loc4_ % 8;
               }while(!_loc14_ && ++_loc15_ < 8);
               
               if(_loc14_)
               {
                  _loc16_ = [];
                  if(_loc6_ is TiphonSprite)
                  {
                     _loc16_ = TiphonSprite(_loc6_).getAvaibleDirection();
                  }
                  _loc17_ = 0;
                  for each (_loc18_ in _loc16_)
                  {
                     if(_loc18_)
                     {
                        _loc17_++;
                     }
                  }
                  if((_loc16_[1]) && !_loc16_[3])
                  {
                     _loc17_++;
                  }
                  if(!_loc16_[1] && (_loc16_[3]))
                  {
                     _loc17_++;
                  }
                  if((_loc16_[7]) && !_loc16_[5])
                  {
                     _loc17_++;
                  }
                  if(!_loc16_[7] && (_loc16_[5]))
                  {
                     _loc17_++;
                  }
                  if(!_loc16_[0] && (_loc16_[4]))
                  {
                     _loc17_++;
                  }
                  if((_loc16_[0]) && !_loc16_[4])
                  {
                     _loc17_++;
                  }
                  Pathfinding.findPath(_loc5_,_loc6_.position,_loc14_,!(_loc17_ < 8),true,this.processMove,new Array(_loc6_,_loc14_));
               }
               else
               {
                  _log.warn("Unable to get a proper destination for the follower.");
               }
            }
            this._movementBehavior.move(this,param1,param2);
         }
         
         private function processMove(param1:MovementPath, param2:Array) : void {
            var _loc4_:MapPoint = null;
            var _loc3_:IMovable = param2[0];
            if((param1) && param1.path.length > 0)
            {
               _loc3_.movementBehavior = this._movementBehavior;
               _loc3_.move(param1);
            }
            else
            {
               _loc4_ = param2[1];
               _log.warn("There was no path from " + _loc3_.position + " to " + _loc4_ + " for a follower. Jumping !");
               _loc3_.jump(_loc4_);
            }
         }
         
         public function jump(param1:MapPoint) : void {
            var _loc2_:IMovable = null;
            var _loc3_:IDataMapProvider = null;
            var _loc4_:MapPoint = null;
            this._movementBehavior.jump(this,param1);
            for each (_loc2_ in this._followers)
            {
               _loc3_ = DataMapProvider.getInstance();
               _loc4_ = this.position.getNearestFreeCell(_loc3_,false);
               if(!_loc4_)
               {
                  _loc4_ = this.position.getNearestFreeCell(_loc3_,true);
                  if(!_loc4_)
                  {
                     return;
                  }
               }
               _loc2_.jump(_loc4_);
            }
         }
         
         public function stop(param1:Boolean=false) : void {
            var _loc2_:IMovable = null;
            this._movementBehavior.stop(this,param1);
            for each (_loc2_ in this._followers)
            {
               _loc2_.stop(param1);
            }
         }
         
         public function display(param1:uint=10) : void {
            this._displayBehavior.display(this,param1);
            this._displayed = true;
         }
         
         public function remove() : void {
            var _loc1_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if((_loc1_) && (_loc1_.justSwitchingCreaturesFightMode))
            {
               this.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_DESTROY,this));
            }
            this.removeAllFollowers();
            this._displayed = false;
            this._movementBehavior.stop(this,true);
            this._displayBehavior.remove(this);
         }
         
         override public function destroy() : void {
            this._followed = null;
            this.remove();
            super.destroy();
         }
         
         public function getRootEntity() : AnimatedCharacter {
            if(this._followed)
            {
               return this._followed.getRootEntity();
            }
            return this;
         }
         
         public function removeAllFollowers() : void {
            var _loc3_:IMovable = null;
            var _loc4_:IDisplayable = null;
            var _loc5_:TiphonSprite = null;
            var _loc1_:int = this._followers.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this._followers[_loc2_];
               _loc4_ = _loc3_ as IDisplayable;
               if(_loc4_)
               {
                  _loc4_.remove();
               }
               _loc5_ = _loc3_ as TiphonSprite;
               if(_loc5_)
               {
                  _loc5_.destroy();
               }
               _loc2_++;
            }
            this._followers = new Vector.<IMovable>();
         }
         
         public function addFollower(param1:IMovable, param2:Boolean=false) : void {
            var _loc5_:IDisplayable = null;
            this._followers.push(param1);
            var _loc3_:IDataMapProvider = DataMapProvider.getInstance();
            var _loc4_:MapPoint = this.position.getNearestFreeCell(_loc3_,false);
            if(!_loc4_)
            {
               _loc4_ = this.position.getNearestFreeCell(_loc3_,true);
               if(!_loc4_)
               {
                  return;
               }
            }
            if(param1.position == null)
            {
               param1.position = _loc4_;
            }
            if(param1 is IDisplayable)
            {
               _loc5_ = param1 as IDisplayable;
               if((this._displayed) && !_loc5_.displayed)
               {
                  _loc5_.display();
               }
               else
               {
                  if(!this._displayed && (_loc5_.displayed))
                  {
                     _loc5_.remove();
                  }
               }
            }
            if(_loc4_.equals(param1.position))
            {
               return;
            }
            if(param2)
            {
               param1.jump(_loc4_);
            }
            else
            {
               param1.move(Pathfinding.findPath(_loc3_,param1.position,_loc4_,false,false));
            }
         }
         
         public function followersEqual(param1:Vector.<EntityLook>) : Boolean {
            var _loc2_:* = 0;
            if(!param1)
            {
               return false;
            }
            var _loc3_:int = param1.length;
            var _loc4_:* = 0;
            if(this._followers.length != _loc3_)
            {
               return false;
            }
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if((this._followers[_loc2_] as AnimatedCharacter).look.equals(EntityLookAdapter.fromNetwork(param1[_loc2_])))
               {
                  _loc4_++;
               }
               _loc2_++;
            }
            if(_loc4_ != _loc3_)
            {
               return false;
            }
            return true;
         }
         
         public function isMounted() : Boolean {
            var _loc1_:Array = this.look.getSubEntities(true);
            if(!_loc1_)
            {
               return false;
            }
            var _loc2_:Array = _loc1_[SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER];
            if(!_loc2_ || _loc2_.length == 0)
            {
               return false;
            }
            return true;
         }
         
         public function highLightCharacterAndFollower(param1:Boolean) : void {
            var _loc5_:AnimatedCharacter = null;
            var _loc2_:AnimatedCharacter = this.getRootEntity();
            var _loc3_:int = _loc2_._followers.length;
            var _loc4_:* = -1;
            while(++_loc4_ < _loc3_)
            {
               _loc5_ = _loc2_._followers[_loc4_] as AnimatedCharacter;
               if(_loc5_)
               {
                  _loc5_.highLight(param1);
               }
            }
            this.highLight(param1);
         }
         
         public function highLight(param1:Boolean) : void {
            if(param1)
            {
               transform.colorTransform = LUMINOSITY_TRANSFORM;
            }
            else
            {
               if(Atouin.getInstance().options.transparentOverlayMode)
               {
                  transform.colorTransform = TRANSPARENCY_TRANSFORM;
               }
               else
               {
                  transform.colorTransform = NORMAL_TRANSFORM;
               }
            }
         }
         
         public function showBitmapAlpha(param1:Number) : void {
            var _loc2_:BitmapData = null;
            var _loc3_:Sprite = null;
            if(this._bmpAlpha == null)
            {
               _loc2_ = new BitmapData(width,height,true,16711680);
               _loc2_.draw(this.bitmapData);
               this._bmpAlpha = new Bitmap(_loc2_);
               this._bmpAlpha.alpha = param1;
               _loc3_ = InteractiveCellManager.getInstance().getCell(this.position.cellId);
               this._bmpAlpha.x = _loc3_.x + _loc3_.width / 2 - this.width / 2;
               this._bmpAlpha.y = _loc3_.y + _loc3_.height - this.height;
               this.parent.addChild(this._bmpAlpha);
               visible = false;
            }
         }
         
         public function hideBitmapAlpha() : void {
            visible = true;
            if(!(this._bmpAlpha == null) && (StageShareManager.stage.contains(this._bmpAlpha)))
            {
               this.parent.removeChild(this._bmpAlpha);
               this._bmpAlpha = null;
            }
         }
         
         override public function addSubEntity(param1:DisplayObject, param2:uint, param3:uint) : void {
            if(param2 == SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND && param3 == 0 && !this._visibleAura)
            {
               this._auraEntity = param1 as TiphonSprite;
               return;
            }
            super.addSubEntity(param1,param2,param3);
         }
         
         override protected function onAdded(param1:Event) : void {
            var _loc4_:String = null;
            var _loc5_:Vector.<SoundAnimation> = null;
            var _loc6_:SoundAnimation = null;
            var _loc7_:String = null;
            super.onAdded(param1);
            var _loc2_:TiphonAnimation = param1.target as TiphonAnimation;
            var _loc3_:SoundBones = SoundBones.getSoundBonesById(look.getBone());
            if(_loc3_)
            {
               _loc4_ = getQualifiedClassName(_loc2_);
               _loc5_ = _loc3_.getSoundAnimations(_loc4_);
               _loc2_.spriteHandler.tiphonEventManager.removeEvents(TiphonEventsManager.BALISE_SOUND,_loc4_);
               for each (_loc6_ in _loc5_)
               {
                  _loc7_ = TiphonEventsManager.BALISE_DATASOUND + TiphonEventsManager.BALISE_PARAM_BEGIN + (!(_loc6_.label == null) && !(_loc6_.label == "null")?_loc6_.label:"") + TiphonEventsManager.BALISE_PARAM_END;
                  _loc2_.spriteHandler.tiphonEventManager.addEvent(_loc7_,_loc6_.startFrame,_loc4_);
               }
            }
         }
      }
   }
