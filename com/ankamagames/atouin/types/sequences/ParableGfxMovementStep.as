package com.ankamagames.atouin.types.sequences
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.geom.Point;
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import flash.display.DisplayObject;
   import gs.TweenMax;
   import gs.easing.Linear;
   import gs.events.TweenEvent;
   
   public class ParableGfxMovementStep extends AbstractSequencable
   {
      
      public function ParableGfxMovementStep(gfxEntity:IMovable, targetPoint:MapPoint, speed:uint, curvePrc:Number=0.5, yOffset:int=0, waitEnd:Boolean=true, yOffsetOnHit:int=0) {
         super();
         this._gfxEntity = gfxEntity;
         this._targetPoint = targetPoint;
         this._curvePrc = curvePrc;
         this._waitEnd = waitEnd;
         this._speed = speed;
         this._yOffset = yOffset;
         this._yOffsetOnHit = yOffsetOnHit;
      }
      
      private var _gfxEntity:IMovable;
      
      private var _targetPoint:MapPoint;
      
      private var _curvePrc:Number;
      
      private var _yOffset:int;
      
      private var _yOffsetOnHit:int;
      
      private var _waitEnd:Boolean;
      
      private var _speed:uint;
      
      override public function start() : void {
         var distance:* = NaN;
         if(this._targetPoint.equals(this._gfxEntity.position))
         {
            this.onTweenEnd(null);
            return;
         }
         var start:Point = new Point(CellUtil.getPixelXFromMapPoint((this._gfxEntity as IEntity).position),CellUtil.getPixelYFromMapPoint((this._gfxEntity as IEntity).position) + this._yOffset);
         var end:Point = new Point(CellUtil.getPixelXFromMapPoint(this._targetPoint),CellUtil.getPixelYFromMapPoint(this._targetPoint) + (!(this._yOffsetOnHit == 0)?this._yOffsetOnHit:this._yOffset));
         distance = Point.distance(start,end);
         var curvePoint:Point = Point.interpolate(start,end,0.5);
         curvePoint.y = curvePoint.y - distance * this._curvePrc;
         DisplayObject(this._gfxEntity).y = DisplayObject(this._gfxEntity).y + this._yOffset;
         var tweener:TweenMax = new TweenMax(this._gfxEntity,distance / 100 * this._speed / 1000,
            {
               "x":end.x,
               "y":end.y,
               "orientToBezier":true,
               "bezier":[
                  {
                     "x":curvePoint.x,
                     "y":curvePoint.y
                  }],
               "scaleX":1,
               "scaleY":1,
               "rotation":15,
               "alpha":1,
               "ease":Linear.easeNone,
               "renderOnStart":true
            });
         tweener.addEventListener(TweenEvent.COMPLETE,this.onTweenEnd);
         if(!this._waitEnd)
         {
            executeCallbacks();
         }
      }
      
      private function onTweenEnd(e:TweenEvent) : void {
         if(this._waitEnd)
         {
            executeCallbacks();
         }
      }
   }
}
