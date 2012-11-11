package com.ankamagames.tiphon.types
{
    import com.ankamagames.tiphon.types.look.*;

    public interface IAnimationModifier
    {

        public function IAnimationModifier();

        function get priority() : int;

        function getModifiedAnimation(param1:String, param2:TiphonEntityLook) : String;

    }
}
