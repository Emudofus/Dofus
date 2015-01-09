package com.ankamagames.jerakine.interfaces
{
    import com.ankamagames.jerakine.entities.interfaces.IEntity;

    public interface IFLAEventHandler 
    {

        function handleFLAEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Object=null):void;
        function removeEntitySound(_arg_1:IEntity):void;

    }
}//package com.ankamagames.jerakine.interfaces

