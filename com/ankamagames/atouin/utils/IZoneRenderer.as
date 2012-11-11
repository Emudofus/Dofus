package com.ankamagames.atouin.utils
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.jerakine.types.*;

    public interface IZoneRenderer
    {

        public function IZoneRenderer();

        function render(param1:Vector.<uint>, param2:Color, param3:DataMapContainer, param4:Boolean = false) : void;

        function remove(param1:Vector.<uint>, param2:DataMapContainer) : void;

    }
}
