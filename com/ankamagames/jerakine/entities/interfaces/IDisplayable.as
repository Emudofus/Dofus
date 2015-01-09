package com.ankamagames.jerakine.entities.interfaces
{
    import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
    import com.ankamagames.jerakine.interfaces.IRectangle;

    public interface IDisplayable 
    {

        function get displayBehaviors():IDisplayBehavior;
        function set displayBehaviors(_arg_1:IDisplayBehavior):void;
        function get displayed():Boolean;
        function get absoluteBounds():IRectangle;
        function display(_arg_1:uint=0):void;
        function remove():void;

    }
}//package com.ankamagames.jerakine.entities.interfaces

