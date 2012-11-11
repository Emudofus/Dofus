package com.ankamagames.tiphon.types.cache
{
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.types.look.*;

    public class SpriteCacheInfo extends Object
    {
        public var sprite:TiphonSprite;
        public var look:TiphonEntityLook;

        public function SpriteCacheInfo(param1:TiphonSprite, param2:TiphonEntityLook)
        {
            this.sprite = param1;
            this.look = param2;
            return;
        }// end function

    }
}
