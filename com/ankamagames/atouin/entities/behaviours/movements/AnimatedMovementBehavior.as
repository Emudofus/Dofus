package com.ankamagames.atouin.entities.behaviours.movements
{
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.atouin.types.TweenEntityData;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.messages.EntityMovementStartMessage;
   import flash.display.DisplayObject;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.atouin.utils.errors.AtouinError;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
   import flash.utils.getTimer;
   import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
   import com.ankamagames.jerakine.interfaces.ISoundPositionListener;
   import flash.geom.Point;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import flash.display.Sprite;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   
   public class AnimatedMovementBehavior extends Object implements IMovementBehavior
   {
      
      public function AnimatedMovementBehavior() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimatedMovementBehavior));
      
      protected static var _movingCount:uint;
      
      protected static var _aEntitiesMoving:Array = new Array();
      
      private static var _stoppingEntity:Dictionary = new Dictionary(true);
      
      private static var _enterFrameRegistered:Boolean;
      
      private static var _cellsManager:InteractiveCellManager = InteractiveCellManager.getInstance();
      
      protected static const _cache:Dictionary = new Dictionary();
      
      protected static function getFromCache(param1:Number, param2:Class) : AnimatedMovementBehavior {
         var _loc3_:* = undefined;
         var _loc4_:AnimatedMovementBehavior = null;
         if(!_cache[param2])
         {
            _cache[param2] = new Dictionary(true);
         }
         for (_loc3_ in _cache[param2])
         {
            if(AnimatedMovementBehavior(_loc3_).speedAdjust == param1)
            {
               return _loc3_;
            }
         }
         _loc4_ = new param2() as AnimatedMovementBehavior;
         _loc4_.speedAdjust = param1;
         _cache[param2][_loc4_] = true;
         return _loc4_;
      }
      
      public var speedAdjust:Number = 0.0;
      
      public function move(param1:IMovable, param2:MovementPath, param3:Function=null) : void {
         var _loc4_:TweenEntityData = new TweenEntityData();
         _loc4_.path = param2;
         _loc4_.entity = param1;
         if(this.getAnimation())
         {
            _loc4_.animation = this.getAnimation();
         }
         _loc4_.linearVelocity = this.getLinearVelocity() * (this.speedAdjust / 10 + 1);
         _loc4_.hDiagVelocity = this.getHorizontalDiagonalVelocity() * (this.speedAdjust / 10 + 1);
         _loc4_.vDiagVelocity = this.getVerticalDiagonalVelocity() * (this.speedAdjust / 10 + 1);
         _loc4_.callback = param3;
         this.initMovement(param1,_loc4_);
         Atouin.getInstance().handler.process(new EntityMovementStartMessage(param1));
      }
      
      public function synchroniseSubEntitiesPosition(param1:IMovable, param2:DisplayObject=null) : void {
         var _loc3_:TiphonSprite = null;
         var _loc4_:IMovable = null;
         var _loc5_:Array = null;
         var _loc6_:* = undefined;
         var _loc7_:TiphonSprite = null;
         var _loc8_:Array = null;
         var _loc9_:* = undefined;
         if(param1 is TiphonSprite)
         {
            _loc3_ = param1 as TiphonSprite;
            if((param2) && param2 is TiphonSprite)
            {
               _loc3_ = TiphonSprite(param2);
            }
            if(_loc3_.carriedEntity)
            {
               _loc4_ = _loc3_.carriedEntity as IMovable;
            }
            else
            {
               _loc7_ = _loc3_.getSubEntitySlot(2,0) as TiphonSprite;
               if((_loc7_) && (_loc7_.carriedEntity))
               {
                  _loc4_ = _loc7_.carriedEntity as IMovable;
               }
            }
            while(_loc4_)
            {
               if((_loc4_.position) && (param1.position))
               {
                  _loc4_.position.x = param1.position.x;
                  _loc4_.position.y = param1.position.y;
                  _loc4_.position.cellId = param1.position.cellId;
               }
               _loc4_ = (_loc4_ as TiphonSprite).carriedEntity as IMovable;
            }
            _loc5_ = _loc3_.getSubEntitiesList();
            for each (_loc6_ in _loc5_)
            {
               if(_loc6_ is IMovable)
               {
                  if((_loc6_.position) && (param1.position))
                  {
                     _loc6_.position.x = param1.position.x;
                     _loc6_.position.y = param1.position.y;
                  }
                  if((_loc6_.movementBehavior) && !(_loc6_ == param1))
                  {
                     _loc6_.movementBehavior.synchroniseSubEntitiesPosition(_loc6_);
                  }
               }
               else
               {
                  if(_loc6_ is TiphonSprite)
                  {
                     _loc8_ = TiphonSprite(_loc6_).getSubEntitiesList();
                     for each (_loc9_ in _loc8_)
                     {
                        if((_loc9_ is IMovable) && (_loc9_.movementBehavior) && !(_loc9_ == param1))
                        {
                           IMovable(_loc9_).movementBehavior.synchroniseSubEntitiesPosition(param1,_loc6_);
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function jump(param1:IMovable, param2:MapPoint) : void {
         this.processJump(param1,param2);
      }
      
      public function stop(param1:IMovable, param2:Boolean=false) : void {
         var _loc3_:Array = null;
         if(param2)
         {
            _loc3_ = (param1 as TiphonSprite).animationList;
            if((_loc3_) && !(_loc3_.indexOf("AnimStatique") == -1))
            {
               IAnimated(param1).setAnimation("AnimStatique");
            }
            _aEntitiesMoving[param1.id] = null;
            delete _aEntitiesMoving[[param1.id]];
         }
         else
         {
            _stoppingEntity[param1] = true;
         }
      }
      
      public function isMoving(param1:IMovable) : Boolean {
         return !(_aEntitiesMoving[param1.id] == null);
      }
      
      public function getNextCell(param1:IMovable) : MapPoint {
         return _aEntitiesMoving[param1.id] != null?TweenEntityData(_aEntitiesMoving[param1.id]).nextCell:null;
      }
      
      protected function getLinearVelocity() : Number {
         throw new AtouinError("Abstract function call.");
      }
      
      protected function getHorizontalDiagonalVelocity() : Number {
         throw new AtouinError("Abstract function call.");
      }
      
      protected function getVerticalDiagonalVelocity() : Number {
         throw new AtouinError("Abstract function call.");
      }
      
      protected function getAnimation() : String {
         throw new AtouinError("Abstract function call.");
      }
      
      protected function mustChangeOrientation() : Boolean {
         return true;
      }
      
      protected function initMovement(param1:IMovable, param2:TweenEntityData, param3:Boolean=false) : void {
         var _loc4_:PathElement = null;
         if(_aEntitiesMoving[param1.id] != null)
         {
            _log.warn("Moving an already moving entity. Replacing the previous move.");
            _movingCount--;
         }
         _aEntitiesMoving[param1.id] = param2;
         _movingCount++;
         if(!param3)
         {
            _loc4_ = param2.path.path.shift();
            if(_loc4_)
            {
               param2.orientation = _loc4_.orientation;
            }
            if((this.mustChangeOrientation()) && (_loc4_))
            {
               IAnimated(param1).setAnimationAndDirection(param2.animation,_loc4_.orientation);
            }
            else
            {
               IAnimated(param1).setAnimation(param2.animation);
            }
         }
         this.goNextCell(param1);
         this.checkIfEnterFrameNeeded();
      }
      
      protected function goNextCell(param1:IMovable) : void {
         var _loc3_:PathElement = null;
         var _loc2_:TweenEntityData = _aEntitiesMoving[param1.id];
         _loc2_.currentCell = param1.position;
         if(_stoppingEntity[param1])
         {
            this.stopMovement(param1);
            Atouin.getInstance().handler.process(new EntityMovementStoppedMessage(param1));
            delete _stoppingEntity[[param1]];
            return;
         }
         if(_loc2_.path.path.length > 0)
         {
            _loc3_ = _loc2_.path.path.shift() as PathElement;
            if(this.mustChangeOrientation())
            {
               IAnimated(param1).setAnimationAndDirection(_loc2_.animation,_loc2_.orientation);
            }
            else
            {
               IAnimated(param1).setAnimation(_loc2_.animation);
            }
            _loc2_.velocity = this.getVelocity(_loc2_,_loc2_.orientation);
            _loc2_.nextCell = _loc3_.step;
            _loc2_.orientation = _loc3_.orientation;
            _loc2_.start = getTimer();
         }
         else
         {
            if(!_loc2_.currentCell.equals(_loc2_.path.end))
            {
               _loc2_.velocity = this.getVelocity(_loc2_,IAnimated(param1).getDirection());
               if(this.mustChangeOrientation())
               {
                  IAnimated(param1).setDirection(_loc2_.orientation);
               }
               _loc2_.nextCell = _loc2_.path.end;
               _loc2_.start = getTimer();
            }
            else
            {
               this.stopMovement(param1);
               Atouin.getInstance().handler.process(new EntityMovementCompleteMessage(param1));
            }
         }
         _loc2_.barycentre = 0;
      }
      
      protected function stopMovement(param1:IMovable) : void {
         IAnimated(param1).setAnimation("AnimStatique");
         var _loc2_:Function = (_aEntitiesMoving[param1.id] as TweenEntityData).callback;
         delete _aEntitiesMoving[[param1.id]];
         _movingCount--;
         this.checkIfEnterFrameNeeded();
         if(_loc2_ != null)
         {
            _loc2_();
         }
      }
      
      private function getVelocity(param1:TweenEntityData, param2:uint) : Number {
         if(param2 % 2 == 0)
         {
            if(param2 % 4 == 0)
            {
               return param1.hDiagVelocity;
            }
            return param1.vDiagVelocity;
         }
         return param1.linearVelocity;
      }
      
      protected function processMovement(param1:TweenEntityData, param2:uint) : void {
         var _loc4_:ISoundPositionListener = null;
         var _loc5_:Point = null;
         param1.barycentre = param1.velocity * (param2 - param1.start);
         if(param1.barycentre > 1)
         {
            param1.barycentre = 1;
         }
         if(!param1.currentCellSprite)
         {
            param1.currentCellSprite = _cellsManager.getCell(param1.currentCell.cellId);
            param1.nextCellSprite = _cellsManager.getCell(param1.nextCell.cellId);
         }
         var _loc3_:DisplayObject = DisplayObject(param1.entity);
         _loc3_.x = (1 - param1.barycentre) * param1.currentCellSprite.x + param1.barycentre * param1.nextCellSprite.x + param1.currentCellSprite.width / 2;
         _loc3_.y = (1 - param1.barycentre) * param1.currentCellSprite.y + param1.barycentre * param1.nextCellSprite.y + param1.currentCellSprite.height / 2;
         for each (_loc4_ in Atouin.getInstance().movementListeners)
         {
            _loc5_ = new Point(_loc3_.x,_loc3_.y);
            _loc4_.setSoundSourcePosition(param1.entity.id,_loc5_);
         }
         if(!param1.wasOrdered && param1.barycentre > 0.5)
         {
            EntitiesDisplayManager.getInstance().orderEntity(_loc3_,param1.nextCellSprite);
         }
         if(param1.barycentre >= 1)
         {
            param1.clear();
            IEntity(param1.entity).position = param1.nextCell;
            this.synchroniseSubEntitiesPosition(IMovable(param1.entity));
            this.goNextCell(IMovable(param1.entity));
         }
      }
      
      protected function processJump(param1:IMovable, param2:MapPoint) : void {
         var _loc3_:Sprite = InteractiveCellManager.getInstance().getCell(param2.cellId);
         var _loc4_:DisplayObject = param1 as DisplayObject;
         _loc4_.x = _loc3_.x + _loc3_.width / 2;
         _loc4_.y = _loc3_.y + _loc3_.height / 2;
         if(_loc4_.stage != null)
         {
            EntitiesDisplayManager.getInstance().orderEntity(_loc4_,_loc3_);
         }
         param1.position = param2;
         this.synchroniseSubEntitiesPosition(param1);
      }
      
      private function onEnterFrame(param1:Event) : void {
         var _loc3_:TweenEntityData = null;
         var _loc2_:uint = getTimer();
         for each (_loc3_ in _aEntitiesMoving)
         {
            this.processMovement(_loc3_,_loc2_);
         }
      }
      
      protected function checkIfEnterFrameNeeded() : void {
         if(_movingCount == 0 && (_enterFrameRegistered))
         {
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            _enterFrameRegistered = false;
         }
         else
         {
            if(_movingCount > 0 && !_enterFrameRegistered)
            {
               EnterFrameDispatcher.addEventListener(this.onEnterFrame,"AnimatedMovementBehaviour",50);
               _enterFrameRegistered = true;
            }
         }
      }
   }
}
