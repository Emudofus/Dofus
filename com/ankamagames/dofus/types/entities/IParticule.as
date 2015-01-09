package com.ankamagames.dofus.types.entities
{
    import flash.display.DisplayObject;

    public interface IParticule 
    {

        function update():void;
        function get sprite():DisplayObject;
        function get life():uint;
        function get subExplosion():Boolean;
        function set subExplosion(_arg_1:Boolean):void;

    }
}//package com.ankamagames.dofus.types.entities

