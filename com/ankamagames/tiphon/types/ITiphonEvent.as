package com.ankamagames.tiphon.types
{

    public interface ITiphonEvent
    {

        public function ITiphonEvent();

        function get label() : String;

        function get sprite();

        function get params() : String;

        function get animationName() : String;

    }
}
