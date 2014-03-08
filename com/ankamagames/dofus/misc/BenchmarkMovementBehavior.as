package com.ankamagames.dofus.misc
{
   import com.ankamagames.atouin.entities.behaviours.movements.AnimatedMovementBehavior;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class BenchmarkMovementBehavior extends AnimatedMovementBehavior
   {
      
      public function BenchmarkMovementBehavior() {
         super();
         if(_self)
         {
            throw new SingletonError("Warning : RunningMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
         }
         else
         {
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BenchmarkMovementBehavior));
      
      private static var _self:BenchmarkMovementBehavior;
      
      private static const RUN_LINEAR_VELOCITY:Number = 1 / 170;
      
      private static const RUN_HORIZONTAL_DIAGONAL_VELOCITY:Number = 1 / 255;
      
      private static const RUN_VERTICAL_DIAGONAL_VELOCITY:Number = 1 / 212.5;
      
      private static const RUN_ANIMATION:String = AnimationEnum.ANIM_COURSE;
      
      public static function getInstance() : BenchmarkMovementBehavior {
         if(!_self)
         {
            _self = new BenchmarkMovementBehavior();
         }
         return _self;
      }
      
      public static function getRandomCell() : MapPoint {
         var _loc1_:uint = 40;
         var _loc2_:MapPoint = MapPoint.fromCellId(Math.floor(Math.random() * AtouinConstants.MAP_CELLS_COUNT));
         while(!MapPoint.isInMap(_loc2_.x,_loc2_.y) && (--_loc1_))
         {
            _loc2_ = MapPoint.fromCellId(Math.floor(Math.random() * AtouinConstants.MAP_CELLS_COUNT));
         }
         return _loc2_;
      }
      
      public static function getRandomPath(param1:IMovable) : MovementPath {
         var _loc6_:* = 0;
         var _loc2_:MovementPath = new MovementPath();
         _loc2_.start = param1.position;
         var _loc3_:Array = new Array();
         var _loc4_:* = -1;
         while(_loc4_ < 2)
         {
            _loc6_ = -1;
            while(_loc6_ < 2)
            {
               if((MapPoint.isInMap(_loc2_.start.x + _loc4_,_loc2_.start.y + _loc6_)) && (!(_loc4_ == 0) || !(_loc6_ == 0)) && (DataMapProvider.getInstance().pointMov(_loc2_.start.x + _loc4_,_loc2_.start.y + _loc6_)))
               {
                  _loc3_.push(MapPoint.fromCoords(_loc2_.start.x + _loc4_,_loc2_.start.y + _loc6_));
               }
               _loc6_++;
            }
            _loc4_++;
         }
         _loc2_.end = _loc3_[Math.floor(Math.random() * _loc3_.length)];
         var _loc5_:PathElement = new PathElement();
         _loc5_.step = _loc2_.start;
         _loc5_.orientation = _loc2_.start.orientationTo(_loc2_.end);
         _loc2_.addPoint(_loc5_);
         return _loc2_;
      }
      
      override protected function getLinearVelocity() : Number {
         return RUN_LINEAR_VELOCITY;
      }
      
      override protected function getHorizontalDiagonalVelocity() : Number {
         return RUN_HORIZONTAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getVerticalDiagonalVelocity() : Number {
         return RUN_VERTICAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getAnimation() : String {
         return RUN_ANIMATION;
      }
      
      override protected function stopMovement(param1:IMovable) : void {
         super.stopMovement(param1);
         var _loc2_:MovementPath = getRandomPath(param1);
         if(_loc2_.path.length > 0)
         {
            param1.move(_loc2_);
         }
         else
         {
            stop(param1,true);
            AnimatedCharacter(param1).remove();
         }
      }
   }
}
