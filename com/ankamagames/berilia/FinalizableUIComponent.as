package com.ankamagames.berilia
{
    public interface FinalizableUIComponent extends UIComponent 
    {

        function get finalized():Boolean;
        function set finalized(_arg_1:Boolean):void;
        function finalize():void;

    }
}//package com.ankamagames.berilia

