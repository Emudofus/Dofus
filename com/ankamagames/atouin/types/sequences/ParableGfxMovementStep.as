package com.ankamagames.atouin.types.sequences
{
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;
    import flash.geom.*;
    import gs.*;
    import gs.easing.*;
    import gs.events.*;

    public class ParableGfxMovementStep extends AbstractSequencable
    {
        private var _gfxEntity:IMovable;
        private var _targetPoint:MapPoint;
        private var _curvePrc:Number;
        private var _yOffset:int;
        private var _yOffsetOnHit:int;
        private var _waitEnd:Boolean;
        private var _speed:uint;

        public function ParableGfxMovementStep(param1:IMovable, param2:MapPoint, param3:uint, param4:Number = 0.5, param5:int = 0, param6:Boolean = true, param7:int = 0)
        {
            this._gfxEntity = param1;
            this._targetPoint = param2;
            this._curvePrc = param4;
            this._waitEnd = param6;
            this._speed = param3;
            this._yOffset = param5;
            this._yOffsetOnHit = param7;
            return;
        }// end function

        override public function start() : void
        {
            var _loc_3:* = NaN;
            if (this._targetPoint.equals(this._gfxEntity.position))
            {
                this.onTweenEnd(null);
                return;
            }
            var _loc_1:* = new Point(CellUtil.getPixelXFromMapPoint((this._gfxEntity as IEntity).position), CellUtil.getPixelYFromMapPoint((this._gfxEntity as IEntity).position) + this._yOffset);
            var _loc_2:* = new Point(CellUtil.getPixelXFromMapPoint(this._targetPoint), CellUtil.getPixelYFromMapPoint(this._targetPoint) + (this._yOffsetOnHit != 0 ? (this._yOffsetOnHit) : (this._yOffset)));
            _loc_3 = Point.distance(_loc_1, _loc_2);
            var _loc_4:* = Point.interpolate(_loc_1, _loc_2, 0.5);
            Point.interpolate(_loc_1, _loc_2, 0.5).y = Point.interpolate(_loc_1, _loc_2, 0.5).y - _loc_3 * this._curvePrc;
            DisplayObject(this._gfxEntity).y = DisplayObject(this._gfxEntity).y + this._yOffset;
            var _loc_5:* = new TweenMax(this._gfxEntity, _loc_3 / 100 * this._speed / 1000, {x:_loc_2.x, y:_loc_2.y, orientToBezier:true, bezier:[{x:_loc_4.x, y:_loc_4.y}], scaleX:1, scaleY:1, rotation:15, alpha:1, ease:Linear.easeNone, renderOnStart:true});
            new TweenMax(this._gfxEntity, _loc_3 / 100 * this._speed / 1000, {x:_loc_2.x, y:_loc_2.y, orientToBezier:true, bezier:[{x:_loc_4.x, y:_loc_4.y}], scaleX:1, scaleY:1, rotation:15, alpha:1, ease:Linear.easeNone, renderOnStart:true}).addEventListener(TweenEvent.COMPLETE, this.onTweenEnd);
            if (!this._waitEnd)
            {
                executeCallbacks();
            }
            return;
        }// end function

        private function onTweenEnd(event:TweenEvent) : void
        {
            if (this._waitEnd)
            {
                executeCallbacks();
            }
            return;
        }// end function

    }
}
