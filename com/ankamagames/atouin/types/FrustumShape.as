package com.ankamagames.atouin.types
{
    import flash.display.Sprite;

    public class FrustumShape extends Sprite 
    {

        private var _direction:uint;

        public function FrustumShape(direction:uint)
        {
            this._direction = direction;
        }

        public function get direction():uint
        {
            return (this._direction);
        }


    }
}//package com.ankamagames.atouin.types

