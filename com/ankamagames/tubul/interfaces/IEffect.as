package com.ankamagames.tubul.interfaces
{
    public interface IEffect 
    {

        function get name():String;
        function process(_arg_1:Number):Number;
        function duplicate():IEffect;

    }
}//package com.ankamagames.tubul.interfaces

