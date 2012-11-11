package com.ankamagames.atouin.types
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;

    public class TweenEntityData extends Object
    {
        public var path:MovementPath;
        public var entity:IEntity;
        public var animation:String;
        public var linearVelocity:Number;
        public var hDiagVelocity:Number;
        public var vDiagVelocity:Number;
        public var barycentre:Number = 0;
        public var currentCell:MapPoint;
        public var nextCell:MapPoint;
        public var wasOrdered:Boolean;
        public var start:uint;
        public var velocity:Number;
        public var orientation:uint;
        public var currentCellSprite:Sprite;
        public var nextCellSprite:Sprite;
        public var callback:Function;

        public function TweenEntityData()
        {
            return;
        }// end function

        public function clear() : void
        {
            this.currentCellSprite = null;
            this.nextCellSprite = null;
            return;
        }// end function

    }
}
