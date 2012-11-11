package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.tiphon.types.look.*;

    public class Glyph extends Projectile
    {
        public var glyphType:uint;

        public function Glyph(param1:int, param2:TiphonEntityLook, param3:Boolean = false, param4:Boolean = true, param5:uint = 0)
        {
            super(param1, param2, param3, param4);
            this.glyphType = param5;
            return;
        }// end function

    }
}
