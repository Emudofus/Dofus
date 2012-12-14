package com.ankamagames.tiphon.types
{
    import com.ankamagames.tiphon.types.look.*;

    public interface ISkinModifier
    {

        public function ISkinModifier();

        function getModifiedSkin(param1:Skin, param2:String, param3:TiphonEntityLook) : String;

    }
}
