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
   import com.ankamagames.dofus.types.data.Follower;
   import com.ankamagames.jerakine.types.positions.MovementPath;
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
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.jerakine.types.positions.PathElement;
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
      
      public function AnimatedCharacter(param1:int, param2:TiphonEntityLook, param3:AnimatedCharacter = null)
      {
         this.id = param1;
         name = "AnimatedCharacter" + param1;
         this._followers = new Vector.<Follower>();
         this._followersMovPath = new Vector.<MovementPath>();
         this._followed = param3;
         super(param2);
         this._name = "entity::" + param1;
         this._displayBehavior = AtouinDisplayBehavior.getInstance();
         this._movementBehavior = WalkingMovementBehavior.getInstance();
         addEventListener(TiphonEvent.RENDER_SUCCEED,this.onFirstRender);
         addEventListener(TiphonEvent.RENDER_FAILED,this.onFirstError);
         setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE,DirectionsEnum.DOWN_RIGHT);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimatedCharacter));
      
      private static const LUMINOSITY_FACTOR:Number = 1.2;
      
      private static const LUMINOSITY_TRANSFORM:ColorTransform = new ColorTransform(LUMINOSITY_FACTOR,LUMINOSITY_FACTOR,LUMINOSITY_FACTOR);
      
      private static const NORMAL_TRANSFORM:ColorTransform = new ColorTransform();
      
      private static const TRANSPARENCY_TRANSFORM:ColorTransform = new ColorTransform(1,1,1,AtouinConstants.OVERLAY_MODE_ALPHA);
      
      private var _id:int;
      
      private var _position:MapPoint;
      
      private var _displayed:Boolean;
      
      private var _followers:Vector.<Follower>;
      
      private var _followed:AnimatedCharacter;
      
      private var _followersMovPath:Vector.<MovementPath>;
      
      private var _transparencyAllowed:Boolean = true;
      
      private var _name:String;
      
      private var _canSeeThrough:Boolean = false;
      
      protected var _movementBehavior:IMovementBehavior;
      
      protected var _displayBehavior:IDisplayBehavior;
      
      private var _bmpAlpha:Bitmap;
      
      private var _auraEntity:TiphonSprite;
      
      private var _visibleAura:Boolean = true;
      
      public var speedAdjust:Number = 0.0;
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get customUnicName() : String
      {
         return this._name;
      }
      
      public function get position() : MapPoint
      {
         return this._position;
      }
      
      public function set position(param1:MapPoint) : void
      {
         var _loc3_:Follower = null;
         var _loc2_:MapPoint = this._position;
         this._position = param1;
         if(!_loc2_)
         {
            for each(_loc3_ in this._followers)
            {
               if(!_loc3_.entity.position)
               {
                  this.addFollower(_loc3_,true);
               }
            }
         }
      }
      
      public function get movementBehavior() : IMovementBehavior
      {
         return this._movementBehavior;
      }
      
      public function set movementBehavior(param1:IMovementBehavior) : void
      {
         this._movementBehavior = param1;
      }
      
      public function get followed() : AnimatedCharacter
      {
         return this._followed;
      }
      
      public function get displayBehaviors() : IDisplayBehavior
      {
         return this._displayBehavior;
      }
      
      public function set displayBehaviors(param1:IDisplayBehavior) : void
      {
         this._displayBehavior = param1;
      }
      
      public function get displayed() : Boolean
      {
         return this._displayed;
      }
      
      public function get handler() : MessageHandler
      {
         return Kernel.getWorker();
      }
      
      public function get enabledInteractions() : uint
      {
         return InteractionsEnum.CLICK | InteractionsEnum.OUT | InteractionsEnum.OVER;
      }
      
      public function get isMoving() : Boolean
      {
         return this._movementBehavior.isMoving(this);
      }
      
      public function get absoluteBounds() : IRectangle
      {
         return this._displayBehavior.getAbsoluteBounds(this);
      }
      
      override public function get useHandCursor() : Boolean
      {
         return true;
      }
      
      public function get visibleAura() : Boolean
      {
         return this._visibleAura;
      }
      
      public function set visibleAura(param1:Boolean) : void
      {
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
      
      public function get hasAura() : Boolean
      {
         if(!(this._auraEntity == null) || !(getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND,0) == null))
         {
            return true;
         }
         return false;
      }
      
      public function getIsTransparencyAllowed() : Boolean
      {
         return this._transparencyAllowed;
      }
      
      public function set transparencyAllowed(param1:Boolean) : void
      {
         this._transparencyAllowed = param1;
      }
      
      public function get followers() : Vector.<Follower>
      {
         return this._followers;
      }
      
      public var slideOnNextMove:Boolean;
      
      private function onFirstError(param1:TiphonEvent) : void
      {
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
      
      private function onFirstRender(param1:TiphonEvent) : void
      {
         removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onFirstRender);
         removeEventListener(TiphonEvent.RENDER_FAILED,this.onFirstError);
      }
      
      public function canSeeThrough() : Boolean
      {
         return this._canSeeThrough;
      }
      
      public function setCanSeeThrough(param1:Boolean) : void
      {
         this._canSeeThrough = param1;
      }
      
      public function canWalkThrough() : Boolean
      {
         return this._canSeeThrough;
      }
      
      public function canWalkTo() : Boolean
      {
         return this._canSeeThrough;
      }
      
      public function move(param1:MovementPath, param2:Function = null, param3:IMovementBehavior = null) : void
      {
         var _loc7_:Follower = null;
         var _loc8_:GameContextActorInformations = null;
         var _loc9_:* = false;
         var _loc10_:Array = null;
         var _loc11_:RoleplayContextFrame = null;
         var _loc12_:Vector.<InteractiveElement> = null;
         var _loc13_:InteractiveElement = null;
         var _loc14_:MapPoint = null;
         var _loc15_:* = 0;
         var _loc16_:uint = 0;
         var _loc17_:MapPoint = null;
         var _loc18_:MapPoint = null;
         var _loc19_:uint = 0;
         var _loc20_:MovementPath = null;
         var _loc21_:Array = null;
         var _loc22_:MovementPath = null;
         var _loc23_:uint = 0;
         var _loc24_:MovementPath = null;
         var _loc25_:PathElement = null;
         var _loc26_:PathElement = null;
         if(!param1.start.equals(this.position))
         {
            _log.warn("Unsynchronized position for entity " + this.id + ", jumping from " + this.position + " to " + param1.start + ".");
            this.jump(param1.start);
         }
         var _loc4_:uint = param1.path.length + 1;
         this._movementBehavior = param3;
         if(!this._movementBehavior)
         {
            if(Kernel.getWorker().contains(RoleplayEntitiesFrame))
            {
               _loc8_ = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(this.id);
               if(_loc8_ is GameRolePlayHumanoidInformations)
               {
                  if((_loc8_ as GameRolePlayHumanoidInformations).humanoidInfo.restrictions.cantRun)
                  {
                     this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                  }
               }
               else if(_loc8_ is GameRolePlayGroupMonsterInformations)
               {
                  this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
               }
               
            }
            if(!this._movementBehavior)
            {
               if(_loc4_ > 3)
               {
                  _loc9_ = false;
                  if(Kernel.getWorker().contains(RoleplayEntitiesFrame))
                  {
                     _loc9_ = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).isCreatureMode;
                  }
                  if(!_loc9_ && (this.isMounted()))
                  {
                     this._movementBehavior = MountedMovementBehavior.getInstance();
                  }
                  else
                  {
                     this._movementBehavior = RunningMovementBehavior.getInstance(this.speedAdjust);
                  }
               }
               else if(_loc4_ > 0)
               {
                  this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
               }
               else
               {
                  return;
               }
               
            }
         }
         var _loc5_:uint = param1.end.advancedOrientationTo(this.position);
         var _loc6_:IDataMapProvider = DataMapProvider.getInstance();
         if(this._followers.length > 0)
         {
            _loc10_ = new Array();
            _loc11_ = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
            if(_loc11_ != null)
            {
               _loc12_ = _loc11_.entitiesFrame.interactiveElements;
               for each(_loc13_ in _loc12_)
               {
                  if(_loc13_)
                  {
                     _loc14_ = Atouin.getInstance().getIdentifiedElementPosition(_loc13_.elementId);
                     if(_loc14_)
                     {
                        _loc15_ = _loc14_.cellId;
                        _loc10_.push(_loc15_);
                     }
                  }
               }
            }
         }
         this._followersMovPath = new Vector.<MovementPath>();
         for each(_loc7_ in this._followers)
         {
            _loc16_ = this.getFollowerAvailiableDirectionNumber(_loc7_);
            _loc17_ = param1.end;
            _loc10_.push(_loc17_.cellId);
            if(!(_loc7_.type == Follower.TYPE_MONSTER) && !_loc16_ < 8 && !(this._followers.indexOf(_loc7_) == 0) && this._followersMovPath.length > 0)
            {
               _loc17_ = this._followersMovPath[this._followersMovPath.length - 1].end;
            }
            _loc5_ = _loc17_.advancedOrientationTo(this.position);
            _loc18_ = null;
            _loc19_ = 0;
            do
            {
               _loc18_ = _loc17_.getNearestFreeCellInDirection(_loc5_,_loc6_,false,false,true,_loc10_);
               _loc5_++;
               _loc5_ = _loc5_ % 8;
            }
            while(!_loc18_ && ++_loc19_ < 8);
            
            if(_loc18_)
            {
               if(!(_loc16_ < 8) && !(_loc7_.type == Follower.TYPE_MONSTER))
               {
                  _loc22_ = new MovementPath();
                  if(this._followers.indexOf(_loc7_) == 0 || this._followersMovPath.length <= 0)
                  {
                     _loc20_ = param1;
                     _loc21_ = _loc20_.path.concat();
                     _loc22_.end = _loc18_;
                     if(_loc21_.length > 0)
                     {
                        _loc21_ = _loc21_.concat(Pathfinding.findPath(_loc6_,_loc21_[_loc21_.length - 1].step,_loc18_).path);
                     }
                     else
                     {
                        _loc21_ = _loc21_.concat(Pathfinding.findPath(_loc6_,param1.start,_loc18_).path);
                     }
                  }
                  else
                  {
                     _loc20_ = this._followersMovPath[this._followersMovPath.length - 1];
                     _loc21_ = _loc20_.path.concat();
                     if(_loc20_.length > 0)
                     {
                        _loc22_.end = _loc20_.getPointAtIndex(_loc20_.length - 1).step;
                     }
                     else
                     {
                        _loc22_.end = _loc20_.start;
                     }
                  }
                  if(_loc10_.indexOf(_loc22_.end) != -1)
                  {
                     _loc22_.end = _loc22_.end.getNearestFreeCellInDirection(_loc5_,_loc6_,false,false,true,_loc10_);
                  }
                  _loc10_.push(_loc22_.end.cellId);
                  _loc22_.start = _loc7_.entity.position;
                  if(_loc21_.length > 0)
                  {
                     _loc22_.addPoint(new PathElement(_loc7_.entity.position,_loc7_.entity.position.orientationTo(_loc21_[0].step)));
                  }
                  else
                  {
                     _loc22_.addPoint(new PathElement(_loc7_.entity.position,_loc7_.entity.position.orientationTo(param1.start)));
                  }
                  _loc23_ = 0;
                  while(_loc23_ < _loc21_.length - 1)
                  {
                     _loc25_ = new PathElement();
                     _loc25_.step.x = _loc21_[_loc23_].step.x;
                     _loc25_.step.y = _loc21_[_loc23_].step.y;
                     _loc25_.orientation = _loc21_[_loc23_].step.orientationTo(_loc21_[_loc23_ + 1].step);
                     _loc22_.addPoint(_loc25_);
                     _loc23_++;
                  }
                  _loc24_ = new MovementPath();
                  _loc24_.path = _loc22_.path.concat();
                  _loc24_.end = _loc22_.end;
                  _loc24_.start = _loc22_.start;
                  this._followersMovPath.push(_loc24_);
                  if(this._followers.indexOf(_loc7_) == 0)
                  {
                     _loc26_ = _loc22_.getPointAtIndex(_loc22_.length - 1);
                     _loc26_.orientation = _loc22_.getPointAtIndex(_loc22_.length - 1).step.orientationTo(_loc18_);
                  }
                  this.processMove(_loc22_,new Array(_loc7_.entity,_loc18_));
               }
               else
               {
                  _loc10_.push(_loc18_.cellId);
                  Pathfinding.findPath(_loc6_,_loc7_.entity.position,_loc18_,!(_loc16_ < 8),true,this.processMove,new Array(_loc7_.entity,_loc18_));
               }
            }
            else
            {
               _log.warn("Unable to get a proper destination for the follower.");
            }
         }
         this._movementBehavior.move(this,param1,param2);
      }
      
      private function processMove(param1:MovementPath, param2:Array) : void
      {
         var _loc4_:MapPoint = null;
         var _loc3_:IMovable = param2[0];
         if((param1) && param1.path.length > 0)
         {
            _loc3_.movementBehavior = this._movementBehavior;
            _loc3_.move(param1,null,this._movementBehavior);
         }
         else
         {
            _loc4_ = param2[1];
            _log.warn("There was no path from " + _loc3_.position + " to " + _loc4_ + " for a follower. Jumping !");
            _loc3_.jump(_loc4_);
         }
      }
      
      public function jump(param1:MapPoint) : void
      {
         var _loc2_:Follower = null;
         var _loc3_:IDataMapProvider = null;
         var _loc4_:MapPoint = null;
         this._movementBehavior.jump(this,param1);
         for each(_loc2_ in this._followers)
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
            _loc2_.entity.jump(_loc4_);
         }
      }
      
      public function stop(param1:Boolean = false) : void
      {
         var _loc2_:Follower = null;
         this._movementBehavior.stop(this,param1);
         for each(_loc2_ in this._followers)
         {
            _loc2_.entity.stop(param1);
         }
      }
      
      public function display(param1:uint = 10) : void
      {
         var _loc2_:Follower = null;
         this._displayBehavior.display(this,param1);
         this._displayed = true;
         for each(_loc2_ in this._followers)
         {
            if(_loc2_.entity is IDisplayable && !IDisplayable(_loc2_.entity).displayed)
            {
               IDisplayable(_loc2_.entity).display();
            }
         }
      }
      
      public function remove() : void
      {
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
      
      override public function destroy() : void
      {
         this._followed = null;
         this.remove();
         super.destroy();
      }
      
      public function getRootEntity() : AnimatedCharacter
      {
         if(this._followed)
         {
            return this._followed.getRootEntity();
         }
         return this;
      }
      
      public function removeAllFollowers() : void
      {
         var _loc3_:Follower = null;
         var _loc4_:IDisplayable = null;
         var _loc5_:TiphonSprite = null;
         var _loc1_:int = this._followers.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._followers[_loc2_];
            _loc4_ = _loc3_.entity as IDisplayable;
            if(_loc4_)
            {
               _loc4_.remove();
            }
            _loc5_ = _loc3_.entity as TiphonSprite;
            if(_loc5_)
            {
               _loc5_.destroy();
            }
            _loc2_++;
         }
         this._followers = new Vector.<Follower>();
      }
      
      public function removeFollower(param1:Follower) : void
      {
         var _loc4_:Follower = null;
         var _loc5_:IDisplayable = null;
         var _loc6_:TiphonSprite = null;
         var _loc2_:int = this._followers.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._followers[_loc3_];
            if(param1 == _loc4_)
            {
               _loc5_ = _loc4_.entity as IDisplayable;
               if(_loc5_)
               {
                  _loc5_.remove();
               }
               _loc6_ = _loc4_.entity as TiphonSprite;
               if(_loc6_)
               {
                  _loc6_.destroy();
               }
               this._followers.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function addFollower(param1:Follower, param2:Boolean = false) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:Follower = null;
         var _loc8_:uint = 0;
         var _loc9_:IDisplayable = null;
         var _loc3_:* = false;
         for each(_loc5_ in this._followers)
         {
            if(_loc5_.entity.id == param1.entity.id)
            {
               _loc3_ = true;
               break;
            }
         }
         if(!_loc3_)
         {
            if(param1.type == Follower.TYPE_PET)
            {
               this._followers.unshift(param1);
            }
            else
            {
               _loc8_ = this.getFollowerAvailiableDirectionNumber(param1);
               if(_loc8_ < 8 || param1.type == Follower.TYPE_MONSTER)
               {
                  this._followers.push(param1);
               }
               else
               {
                  if(this._followers.length == 0 || !(this._followers[0].type == Follower.TYPE_PET))
                  {
                     _loc4_ = 0;
                  }
                  this._followers.splice(_loc4_,0,param1);
               }
            }
         }
         if(!this.position)
         {
            return;
         }
         var _loc6_:IDataMapProvider = DataMapProvider.getInstance();
         var _loc7_:MapPoint = this.position.getNearestFreeCell(_loc6_,false);
         if(!_loc7_)
         {
            _loc7_ = this.position.getNearestFreeCell(_loc6_,true);
            if(!_loc7_)
            {
               return;
            }
         }
         if(param1.entity.position == null)
         {
            param1.entity.position = _loc7_;
         }
         if(param1.entity is IDisplayable)
         {
            _loc9_ = param1.entity as IDisplayable;
            if((this._displayed) && !_loc9_.displayed)
            {
               _loc9_.display();
            }
            else if(!this._displayed && (_loc9_.displayed))
            {
               _loc9_.remove();
            }
            
         }
         if(_loc7_.equals(param1.entity.position))
         {
            return;
         }
         if(param2)
         {
            param1.entity.jump(_loc7_);
         }
         else
         {
            param1.entity.move(Pathfinding.findPath(_loc6_,param1.entity.position,_loc7_,false,false));
         }
      }
      
      private function getFollowerAvailiableDirectionNumber(param1:Follower) : uint
      {
         var _loc4_:* = false;
         var _loc2_:Array = [];
         if(param1.entity is TiphonSprite)
         {
            _loc2_ = TiphonSprite(param1.entity).getAvaibleDirection();
         }
         var _loc3_:uint = 0;
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_)
            {
               _loc3_++;
            }
         }
         if((_loc2_[1]) && !_loc2_[3])
         {
            _loc3_++;
         }
         if(!_loc2_[1] && (_loc2_[3]))
         {
            _loc3_++;
         }
         if((_loc2_[7]) && !_loc2_[5])
         {
            _loc3_++;
         }
         if(!_loc2_[7] && (_loc2_[5]))
         {
            _loc3_++;
         }
         if(!_loc2_[0] && (_loc2_[4]))
         {
            _loc3_++;
         }
         if((_loc2_[0]) && !_loc2_[4])
         {
            _loc3_++;
         }
         return _loc3_;
      }
      
      public function followersEqual(param1:Vector.<EntityLook>) : Boolean
      {
         var _loc2_:* = 0;
         var _loc5_:Follower = null;
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
         for each(_loc5_ in this._followers)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if((_loc5_.entity as AnimatedCharacter).look.equals(EntityLookAdapter.fromNetwork(param1[_loc2_])))
               {
                  _loc4_++;
                  break;
               }
               _loc2_++;
            }
         }
         if(_loc4_ != _loc3_)
         {
            return false;
         }
         return true;
      }
      
      public function isMounted() : Boolean
      {
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
      
      public function highLightCharacterAndFollower(param1:Boolean) : void
      {
         var _loc5_:AnimatedCharacter = null;
         var _loc2_:AnimatedCharacter = this.getRootEntity();
         var _loc3_:int = _loc2_._followers.length;
         var _loc4_:* = -1;
         while(++_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_._followers[_loc4_].entity as AnimatedCharacter;
            if(_loc5_)
            {
               _loc5_.highLight(param1);
            }
         }
         this.highLight(param1);
      }
      
      public function highLight(param1:Boolean) : void
      {
         if(param1)
         {
            transform.colorTransform = LUMINOSITY_TRANSFORM;
         }
         else if(Atouin.getInstance().options.transparentOverlayMode)
         {
            transform.colorTransform = TRANSPARENCY_TRANSFORM;
         }
         else
         {
            transform.colorTransform = NORMAL_TRANSFORM;
         }
         
      }
      
      public function showBitmapAlpha(param1:Number) : void
      {
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
      
      public function hideBitmapAlpha() : void
      {
         visible = true;
         if(!(this._bmpAlpha == null) && (StageShareManager.stage.contains(this._bmpAlpha)))
         {
            this.parent.removeChild(this._bmpAlpha);
            this._bmpAlpha = null;
         }
      }
      
      override public function addSubEntity(param1:DisplayObject, param2:uint, param3:uint) : void
      {
         if(param2 == SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND && param3 == 0 && !this._visibleAura)
         {
            this._auraEntity = param1 as TiphonSprite;
            return;
         }
         super.addSubEntity(param1,param2,param3);
      }
      
      override protected function onAdded(param1:Event) : void
      {
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
            for each(_loc6_ in _loc5_)
            {
               _loc7_ = TiphonEventsManager.BALISE_DATASOUND + TiphonEventsManager.BALISE_PARAM_BEGIN + (!(_loc6_.label == null) && !(_loc6_.label == "null")?_loc6_.label:"") + TiphonEventsManager.BALISE_PARAM_END;
               _loc2_.spriteHandler.tiphonEventManager.addEvent(_loc7_,_loc6_.startFrame,_loc4_);
            }
         }
      }
   }
}
