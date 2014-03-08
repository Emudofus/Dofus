package com.ankamagames.atouin.entities.behaviours.movements
{
   import flash.geom.Point;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.atouin.types.TweenEntityData;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import flash.display.Sprite;
   import flash.display.DisplayObject;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class ParableMovementBehavior extends AnimatedMovementBehavior
   {
      
      public function ParableMovementBehavior() {
         super();
         if(_self)
         {
            throw new SingletonError("Warning : ParableMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
         }
         else
         {
            return;
         }
      }
      
      private static const LINEAR_VELOCITY:Number = 1 / 400;
      
      private static const HORIZONTAL_DIAGONAL_VELOCITY:Number = 1 / 500;
      
      private static const VERTICAL_DIAGONAL_VELOCITY:Number = 1 / 450;
      
      private static const ANIMATION:String = "FX";
      
      private static var _curvePoint:Point;
      
      private static var _velocity:Number;
      
      private static var _angle:Number;
      
      private static var _self:ParableMovementBehavior;
      
      public static function getInstance() : ParableMovementBehavior {
         if(!_self)
         {
            _self = new ParableMovementBehavior();
         }
         return _self;
      }
      
      override protected function getLinearVelocity() : Number {
         return LINEAR_VELOCITY;
      }
      
      override protected function getHorizontalDiagonalVelocity() : Number {
         return HORIZONTAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getVerticalDiagonalVelocity() : Number {
         return VERTICAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getAnimation() : String {
         return ANIMATION;
      }
      
      override public function move(param1:IMovable, param2:MovementPath, param3:Function=null) : void {
         var _loc4_:TweenEntityData = new TweenEntityData();
         _loc4_.path = param2;
         _loc4_.entity = param1;
         var _loc5_:Sprite = InteractiveCellManager.getInstance().getCell(_loc4_.path.start.cellId);
         var _loc6_:Sprite = InteractiveCellManager.getInstance().getCell(_loc4_.path.end.cellId);
         var _loc7_:Point = new Point(_loc5_.x,_loc5_.y);
         var _loc8_:Point = new Point(_loc6_.x,_loc6_.y);
         var _loc9_:Number = Point.distance(_loc7_,_loc8_);
         _curvePoint = Point.interpolate(_loc7_,_loc8_,0.5);
         _curvePoint.y = _curvePoint.y - _loc9_ / 2;
         _velocity = 1 / (500 + param2.start.distanceTo(param2.end) * 50);
         _angle = this.checkAngle(_loc7_,_loc8_);
         var _loc10_:* = DisplayObject(_loc4_.entity);
         _loc10_.rotation = _loc10_.rotation - (_angle + (90 - _angle) / 2);
         initMovement(param1,_loc4_);
      }
      
      override protected function processMovement(param1:TweenEntityData, param2:uint) : void {
         var _loc8_:* = NaN;
         param1.barycentre = _velocity * (param2 - param1.start);
         if(param1.barycentre > 1)
         {
            param1.barycentre = 1;
         }
         var _loc3_:DisplayObject = DisplayObject(param1.entity);
         var _loc4_:Sprite = InteractiveCellManager.getInstance().getCell(param1.currentCell.cellId);
         var _loc5_:Sprite = InteractiveCellManager.getInstance().getCell(param1.nextCell.cellId);
         _loc3_.x = (1 - param1.barycentre) * (1 - param1.barycentre) * _loc4_.x + 2 * (1 - param1.barycentre) * param1.barycentre * _curvePoint.x + param1.barycentre * param1.barycentre * _loc5_.x;
         _loc3_.y = (1 - param1.barycentre) * (1 - param1.barycentre) * _loc4_.y + 2 * (1 - param1.barycentre) * param1.barycentre * _curvePoint.y + param1.barycentre * param1.barycentre * _loc5_.y;
         var _loc6_:Number = -(_angle + (90 - _angle) / 2);
         var _loc7_:Number = 2.5 * (90 + _loc6_) * param1.barycentre;
         _loc3_.rotation = _loc6_ + _loc7_;
         if(_loc5_.y > _loc4_.y)
         {
            _loc8_ = 2 * (90 + _loc6_) * (1 - param1.barycentre);
            _loc3_.rotation = -_loc6_ - _loc8_;
         }
         _loc3_.scaleX = 1 - param1.barycentre * (90 - Math.abs(90 - _angle)) / 90;
         if(!param1.wasOrdered && param1.barycentre > 0.5)
         {
            EntitiesDisplayManager.getInstance().orderEntity(_loc3_,_loc5_);
         }
         if(param1.barycentre >= 1)
         {
            IEntity(param1.entity).position = param1.nextCell;
            goNextCell(IMovable(param1.entity));
            EntitiesManager.getInstance().removeEntity(IEntity(param1.entity).id);
         }
      }
      
      private function checkAngle(param1:Point, param2:Point) : Number {
         var _loc3_:Number = Point.distance(param1,new Point(param2.x,param1.y));
         var _loc4_:Number = Point.distance(param1,param2);
         var _loc5_:Number = Math.acos(_loc3_ / _loc4_) * 180 / Math.PI;
         if(param1.x > param2.x)
         {
            _loc5_ = 180 - _loc5_;
         }
         return _loc5_;
      }
   }
}
