package com.ankamagames.tiphon.types
{
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;

    public interface IAnimationModifier 
    {

        function get priority():int;
        function getModifiedAnimation(_arg_1:String, _arg_2:TiphonEntityLook):String;

    }
}//package com.ankamagames.tiphon.types

