package com.ankamagames.tiphon.types
{
    import com.ankamagames.tiphon.display.TiphonSprite;

    public interface ISubEntityBehavior 
    {

        function updateFromParentEntity(_arg_1:TiphonSprite, _arg_2:BehaviorData):void;
        function remove():void;

    }
}//package com.ankamagames.tiphon.types

