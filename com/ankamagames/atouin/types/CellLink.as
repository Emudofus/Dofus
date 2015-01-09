package com.ankamagames.atouin.types
{
    import flash.display.Shape;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.managers.EntitiesDisplayManager;
    import com.ankamagames.jerakine.interfaces.IRectangle;

    public class CellLink extends Shape implements IDisplayable 
    {

        private var _displayBehaviors:IDisplayBehavior;
        private var _displayed:Boolean;
        public var strata:uint;
        public var orderedCheckpoints:Vector.<MapPoint>;


        public function display(strata:uint=0):void
        {
            if (((this.orderedCheckpoints) && (this.orderedCheckpoints.length)))
            {
                EntitiesDisplayManager.getInstance().displayEntity(this, this.orderedCheckpoints[0], strata);
                this._displayed = true;
            };
        }

        public function remove():void
        {
            this.orderedCheckpoints = null;
            this._displayed = false;
            EntitiesDisplayManager.getInstance().removeEntity(this);
        }

        public function get displayBehaviors():IDisplayBehavior
        {
            return (this._displayBehaviors);
        }

        public function set displayBehaviors(value:IDisplayBehavior):void
        {
            this._displayBehaviors = value;
        }

        public function get displayed():Boolean
        {
            return (this._displayed);
        }

        public function get absoluteBounds():IRectangle
        {
            return (this._displayBehaviors.getAbsoluteBounds(this));
        }


    }
}//package com.ankamagames.atouin.types

