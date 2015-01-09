package com.ankamagames.jerakine.entities.behaviours
{
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.jerakine.interfaces.IRectangle;

    public interface IDisplayBehavior 
    {

        function getAbsoluteBounds(_arg_1:IDisplayable):IRectangle;
        function display(_arg_1:IDisplayable, _arg_2:uint=0):void;
        function remove(_arg_1:IDisplayable):void;

    }
}//package com.ankamagames.jerakine.entities.behaviours

