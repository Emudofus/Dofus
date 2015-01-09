package com.ankamagames.atouin.utils
{
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.atouin.types.DataMapContainer;

    public interface IZoneRenderer 
    {

        function render(_arg_1:Vector.<uint>, _arg_2:Color, _arg_3:DataMapContainer, _arg_4:Boolean=false, _arg_5:Boolean=false):void;
        function remove(_arg_1:Vector.<uint>, _arg_2:DataMapContainer):void;

    }
}//package com.ankamagames.atouin.utils

