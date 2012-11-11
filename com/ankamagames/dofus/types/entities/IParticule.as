package com.ankamagames.dofus.types.entities
{
    import flash.display.*;

    public interface IParticule
    {

        public function IParticule();

        function update() : void;

        function get sprite() : DisplayObject;

        function get life() : uint;

        function get subExplosion() : Boolean;

        function set subExplosion(param1:Boolean) : void;

    }
}
