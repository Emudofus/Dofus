package com.ankamagames.jerakine.entities.interfaces
{
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.interfaces.*;

    public interface IDisplayable
    {

        public function IDisplayable();

        function get displayBehaviors() : IDisplayBehavior;

        function set displayBehaviors(param1:IDisplayBehavior) : void;

        function get displayed() : Boolean;

        function get absoluteBounds() : IRectangle;

        function display(param1:uint = 0) : void;

        function remove() : void;

    }
}
