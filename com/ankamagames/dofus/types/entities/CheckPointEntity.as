package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;

    public class CheckPointEntity extends Sprite implements IEntity, IDisplayable
    {
        private var _id:int;
        private var _position:MapPoint;
        private var _displayed:Boolean;
        private var _displayedObject:Sprite;

        public function CheckPointEntity(param1:Sprite = null, param2:MapPoint = null)
        {
            this._position = param2;
            if (param1 != null)
            {
                this._displayedObject = param1;
                addChild(this._displayedObject);
            }
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

        public function get displayBehaviors() : IDisplayBehavior
        {
            return null;
        }// end function

        public function set displayBehaviors(param1:IDisplayBehavior) : void
        {
            return;
        }// end function

        public function get absoluteBounds() : IRectangle
        {
            return null;
        }// end function

        public function get displayed() : Boolean
        {
            return this._displayed;
        }// end function

        public function display(param1:uint = 0) : void
        {
            this._displayed = true;
            return;
        }// end function

        public function remove() : void
        {
            if (this._displayedObject != null)
            {
                removeChild(this._displayedObject);
                this._displayedObject = null;
            }
            this._displayed = false;
            return;
        }// end function

    }
}
