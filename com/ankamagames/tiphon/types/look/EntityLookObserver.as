package com.ankamagames.tiphon.types.look
{
    public interface EntityLookObserver 
    {

        function boneChanged(_arg_1:TiphonEntityLook):void;
        function skinsChanged(_arg_1:TiphonEntityLook):void;
        function colorsChanged(_arg_1:TiphonEntityLook):void;
        function scalesChanged(_arg_1:TiphonEntityLook):void;
        function subEntitiesChanged(_arg_1:TiphonEntityLook):void;

    }
}//package com.ankamagames.tiphon.types.look

