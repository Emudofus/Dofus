package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.atouin.entities.behaviours.display.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;
    import flash.utils.*;

    public class RoleplayObjectEntity extends Sprite implements IInteractive, IDisplayable
    {
        private var _id:int;
        private var _position:MapPoint;
        private var _displayed:Boolean;
        protected var _displayBehavior:IDisplayBehavior;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayObjectEntity));

        public function RoleplayObjectEntity(param1:int, param2:MapPoint)
        {
            this._displayBehavior = AtouinDisplayBehavior.getInstance();
            this.id = EntitiesManager.getInstance().getFreeEntityId();
            this.position = param2;
            mouseChildren = false;
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

        public function get displayed() : Boolean
        {
            return this._displayed;
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

        public function get absoluteBounds() : IRectangle
        {
            return this._displayBehavior.getAbsoluteBounds(this);
        }// end function

        public function get handler() : MessageHandler
        {
            return Kernel.getWorker();
        }// end function

        override public function get useHandCursor() : Boolean
        {
            return true;
        }// end function

        public function get enabledInteractions() : uint
        {
            return InteractionsEnum.CLICK | InteractionsEnum.OUT | InteractionsEnum.OVER;
        }// end function

        public function display(param1:uint = 10) : void
        {
            this._displayBehavior.display(this, param1);
            this._displayed = true;
            return;
        }// end function

        public function remove() : void
        {
            this._displayed = false;
            this._displayBehavior.remove(this);
            return;
        }// end function

    }
}
