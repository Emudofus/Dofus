package com.ankamagames.tiphon.types
{
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;

    public interface ISubEntityHandler 
    {

        function onSubEntityAdded(_arg_1:TiphonSprite, _arg_2:TiphonEntityLook, _arg_3:uint, _arg_4:uint):Boolean;

    }
}//package com.ankamagames.tiphon.types

