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

      public function move(entity:IMovable, path:MovementPath, callback:Function=null) : void {
         var tweenData:TweenEntityData = new TweenEntityData();
         tweenData.path=path;
         tweenData.entity=entity;
         if(this.getAnimation())
         {
            tweenData.animation=this.getAnimation();
         }
         tweenData.linearVelocity=this.getLinearVelocity();
         tweenData.hDiagVelocity=this.getHorizontalDiagonalVelocity();
         tweenData.vDiagVelocity=this.getVerticalDiagonalVelocity();
         tweenData.callback=callback;
         this.initMovement(entity,tweenData);
         Atouin.getInstance().handler.process(new EntityMovementStartMessage(entity));
      }

      public function synchroniseSubEntitiesPosition(entityRef:IMovable, subEntityContainer:DisplayObject=null) : void {
         var ts:TiphonSprite = null;
         var carriedEntity:IMovable = null;
         var subEntities:Array = null;
         var subEntity:* = undefined;
         var mount:TiphonSprite = null;
         var subSubEntities:Array = null;
         var subSubEntity:* = undefined;
         if(entityRef is TiphonSprite)
         {
            ts=entityRef as TiphonSprite;
            if((subEntityContainer)&&(subEntityContainer is TiphonSprite))
            {
               ts=TiphonSprite(subEntityContainer);
            }
            if(ts.carriedEntity)
            {
               carriedEntity=ts.carriedEntity as IMovable;
            }
            else
            {
               mount=ts.getSubEntitySlot(2,0) as TiphonSprite;
               if((mount)&&(mount.carriedEntity))
               {
                  carriedEntity=mount.carriedEntity as IMovable;
               }
            }
            if(carriedEntity)
            {
               carriedEntity.position.x=entityRef.position.x;
               carriedEntity.position.y=entityRef.position.y;
               carriedEntity.position.cellId=entityRef.position.cellId;
            }
            subEntities=ts.getSubEntitiesList();
            for each (subEntity in subEntities)
            {
               if(subEntity is IMovable)
               {
                  if((subEntity.position)&&(entityRef.position))
                  {
                     subEntity.position.x=entityRef.position.x;
                     subEntity.position.y=entityRef.position.y;
                  }
                  if((subEntity.movementBehavior)&&(!(subEntity==entityRef)))
                  {
                     subEntity.movementBehavior.synchroniseSubEntitiesPosition(subEntity);
                  }
               }
               else
               {
                  if(subEntity is TiphonSprite)
                  {
                     subSubEntities=TiphonSprite(subEntity).getSubEntitiesList();
                     for each (subSubEntity in subSubEntities)
                     {
                        if((subSubEntity is IMovable)&&(subSubEntity.movementBehavior)&&(!(subSubEntity==entityRef)))
                        {
                           IMovable(subSubEntity).movementBehavior.synchroniseSubEntitiesPosition(entityRef,subEntity);
                        }
                     }
                  }
               }
            }
         }
      }

      public function jump(entity:IMovable, newPosition:MapPoint) : void {
         this.processJump(entity,newPosition);
      }

      public function stop(entity:IMovable, forceStop:Boolean=false) : void {
         if(forceStop)
         {
            IAnimated(entity).setAnimation("AnimStatique");
            _aEntitiesMoving[entity.id]=null;
            delete _aEntitiesMoving[[entity.id]];
         }
         else
         {
            _stoppingEntity[entity]=true;
         }
      }

      public function isMoving(entity:IMovable) : Boolean {
         return !(_aEntitiesMoving[entity.id]==null);
      }

      public function getNextCell(entity:IMovable) : MapPoint {
         return _aEntitiesMoving[entity.id]!=null?TweenEntityData(_aEntitiesMoving[entity.id]).nextCell:null;
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

      protected function initMovement(oMobile:IMovable, tweenData:TweenEntityData, wasLinked:Boolean=false) : void {
         var firstPe:PathElement = null;
         if(_aEntitiesMoving[oMobile.id]!=null)
         {
            _log.warn("Moving an already moving entity. Replacing the previous move.");
            _movingCount--;
         }
         _aEntitiesMoving[oMobile.id]=tweenData;
         _movingCount++;
         if(!wasLinked)
         {
            firstPe=tweenData.path.path.shift();
            if(firstPe)
            {
               tweenData.orientation=firstPe.orientation;
            }
            if((this.mustChangeOrientation())&&(firstPe))
            {
               IAnimated(oMobile).setAnimationAndDirection(tweenData.animation,firstPe.orientation);
            }
            else
            {
               IAnimated(oMobile).setAnimation(tweenData.animation);
            }
         }
         this.goNextCell(oMobile);
         this.checkIfEnterFrameNeeded();
      }

      protected function goNextCell(entity:IMovable) : void {
         var pe:PathElement = null;
         var tweenData:TweenEntityData = _aEntitiesMoving[entity.id];
         tweenData.currentCell=entity.position;
         if(_stoppingEntity[entity])
         {
            this.stopMovement(entity);
            Atouin.getInstance().handler.process(new EntityMovementStoppedMessage(entity));
            delete _stoppingEntity[[entity]];
            return;
         }
         if(tweenData.path.path.length>0)
         {
            pe=tweenData.path.path.shift() as PathElement;
            if(this.mustChangeOrientation())
            {
               IAnimated(entity).setAnimationAndDirection(tweenData.animation,tweenData.orientation);
            }
            else
            {
               IAnimated(entity).setAnimation(tweenData.animation);
            }
            tweenData.velocity=this.getVelocity(tweenData,tweenData.orientation);
            tweenData.nextCell=pe.step;
            tweenData.orientation=pe.orientation;
            tweenData.start=getTimer();
         }
         else
         {
            if(!tweenData.currentCell.equals(tweenData.path.end))
            {
               tweenData.velocity=this.getVelocity(tweenData,IAnimated(entity).getDirection());
               if(this.mustChangeOrientation())
               {
                  IAnimated(entity).setDirection(tweenData.orientation);
               }
               tweenData.nextCell=tweenData.path.end;
               tweenData.start=getTimer();
            }
            else
            {
               this.stopMovement(entity);
               Atouin.getInstance().handler.process(new EntityMovementCompleteMessage(entity));
            }
         }
         tweenData.barycentre=0;
      }

      protected function stopMovement(entity:IMovable) : void {
         IAnimated(entity).setAnimation("AnimStatique");
         var callback:Function = (_aEntitiesMoving[entity.id] as TweenEntityData).callback;
         delete _aEntitiesMoving[[entity.id]];
         _movingCount--;
         this.checkIfEnterFrameNeeded();
         if(callback!=null)
         {
            callback();
         }
      }

      private function getVelocity(ted:TweenEntityData, orientation:uint) : Number {
         if(orientation%2==0)
         {
            if(orientation%4==0)
            {
               return ted.hDiagVelocity;
            }
            return ted.vDiagVelocity;
         }
         return ted.linearVelocity;
      }

      protected function processMovement(tweenData:TweenEntityData, currentTime:uint) : void {
         var listener:ISoundPositionListener = null;
         var newPoint:Point = null;
         tweenData.barycentre=tweenData.velocity*(currentTime-tweenData.start);
         if(tweenData.barycentre>1)
         {
            tweenData.barycentre=1;
         }
         if(!tweenData.currentCellSprite)
         {
            tweenData.currentCellSprite=_cellsManager.getCell(tweenData.currentCell.cellId);
            tweenData.nextCellSprite=_cellsManager.getCell(tweenData.nextCell.cellId);
         }
         var displayObject:DisplayObject = DisplayObject(tweenData.entity);
         displayObject.x=(1-tweenData.barycentre)*tweenData.currentCellSprite.x+tweenData.barycentre*tweenData.nextCellSprite.x+tweenData.currentCellSprite.width/2;
         displayObject.y=(1-tweenData.barycentre)*tweenData.currentCellSprite.y+tweenData.barycentre*tweenData.nextCellSprite.y+tweenData.currentCellSprite.height/2;
         for each (listener in Atouin.getInstance().movementListeners)
         {
            newPoint=new Point(displayObject.x,displayObject.y);
            listener.setSoundSourcePosition(tweenData.entity.id,newPoint);
         }
         if((!tweenData.wasOrdered)&&(tweenData.barycentre<0.5))
         {
            EntitiesDisplayManager.getInstance().orderEntity(displayObject,tweenData.nextCellSprite);
         }
         if(tweenData.barycentre>=1)
         {
            tweenData.clear();
            IEntity(tweenData.entity).position=tweenData.nextCell;
            this.synchroniseSubEntitiesPosition(IMovable(tweenData.entity));
            this.goNextCell(IMovable(tweenData.entity));
         }
      }

      protected function processJump(entity:IMovable, newPosition:MapPoint) : void {
         var newCellSprite:Sprite = InteractiveCellManager.getInstance().getCell(newPosition.cellId);
         var displayObject:DisplayObject = entity as DisplayObject;
         displayObject.x=newCellSprite.x+newCellSprite.width/2;
         displayObject.y=newCellSprite.y+newCellSprite.height/2;
         if(displayObject.stage!=null)
         {
            EntitiesDisplayManager.getInstance().orderEntity(displayObject,newCellSprite);
         }
         entity.position=newPosition;
         this.synchroniseSubEntitiesPosition(entity);
      }

      private function onEnterFrame(e:Event) : void {
         var tweenData:TweenEntityData = null;
         var currentTime:uint = getTimer();
         for each (tweenData in _aEntitiesMoving)
         {
            this.processMovement(tweenData,currentTime);
         }
      }

      protected function checkIfEnterFrameNeeded() : void {
         if((_movingCount==0)&&(_enterFrameRegistered))
         {
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            _enterFrameRegistered=false;
         }
         else
         {
            if((_movingCount<0)&&(!_enterFrameRegistered))
            {
               EnterFrameDispatcher.addEventListener(this.onEnterFrame,"AnimatedMovementBehaviour",50);
               _enterFrameRegistered=true;
            }
         }
      }
   }

}