package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.atouin.entities.behaviours.display.*;
    import com.ankamagames.atouin.entities.behaviours.movements.*;
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.events.*;
    import flash.utils.*;

    public class Projectile extends TiphonSprite implements IDisplayable, IMovable, IEntity
    {
        private var _id:int;
        private var _position:MapPoint;
        private var _displayed:Boolean;
        private var _displayBehavior:IDisplayBehavior;
        private var _movementBehavior:IMovementBehavior;
        public var startPlayingOnlyWhenDisplayed:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Projectile));

        public function Projectile(param1:int, param2:TiphonEntityLook, param3:Boolean = false, param4:Boolean = true)
        {
            super(param2);
            this.startPlayingOnlyWhenDisplayed = param4;
            this.id = param1;
            if (!param3)
            {
                this.init();
            }
            mouseChildren = false;
            mouseEnabled = false;
            return;
        }// end function

        public function get displayBehaviors() : IDisplayBehavior
        {
            return this._displayBehavior;
        }// end function

        public function set displayBehaviors(param1:IDisplayBehavior) : void
        {
            this._displayBehavior = param1;
            return;
        }// end function

        public function get movementBehavior() : IMovementBehavior
        {
            return this._movementBehavior;
        }// end function

        public function set movementBehavior(param1:IMovementBehavior) : void
        {
            this._movementBehavior = param1;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function set id(param1:int) : void
        {
            this._id = param1;
            return;
        }// end function

        public function get position() : MapPoint
        {
            return this._position;
        }// end function

        public function set position(param1:MapPoint) : void
        {
            this._position = param1;
            return;
        }// end function

        public function get isMoving() : Boolean
        {
            return this._movementBehavior.isMoving(this);
        }// end function

        public function get absoluteBounds() : IRectangle
        {
            return this._displayBehavior.getAbsoluteBounds(this);
        }// end function

        public function get displayed() : Boolean
        {
            return this._displayed;
        }// end function

        public function init(param1:int = -1) : void
        {
            this._displayBehavior = AtouinDisplayBehavior.getInstance();
            this._movementBehavior = ParableMovementBehavior.getInstance();
            setDirection(param1 == -1 ? (DirectionsEnum.RIGHT) : (param1));
            if (!this.startPlayingOnlyWhenDisplayed || parent)
            {
                this.setAnim();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, this.onProjectileAdded);
            }
            return;
        }// end function

        public function display(param1:uint = 0) : void
        {
            this._displayBehavior.display(this, param1);
            this._displayed = true;
            return;
        }// end function

        public function remove() : void
        {
            this._displayed = false;
            this._displayBehavior.remove(this);
            clearAnimation();
            return;
        }// end function

        override public function destroy() : void
        {
            this.remove();
            super.destroy();
            return;
        }// end function

        public function move(param1:MovementPath, param2:Function = null) : void
        {
            this._movementBehavior.move(this, param1, param2);
            return;
        }// end function

        public function jump(param1:MapPoint) : void
        {
            this._movementBehavior.jump(this, param1);
            return;
        }// end function

        public function stop(param1:Boolean = false) : void
        {
            this._movementBehavior.stop(this);
            return;
        }// end function

        private function setAnim() : void
        {
            setAnimation("FX");
            return;
        }// end function

        private function onProjectileAdded(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onProjectileAdded);
            this.setAnim();
            return;
        }// end function

    }
}
