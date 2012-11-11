package com.ankamagames.tubul.interfaces
{

    public interface IEffect
    {

        public function IEffect();

        function get name() : String;

        function process(param1:Number) : Number;

        function duplicate() : IEffect;

    }
}
