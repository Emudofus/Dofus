package com.ankamagames.tiphon.types
{
    import com.ankamagames.tiphon.display.*;

    public interface ISubEntityBehavior
    {

        public function ISubEntityBehavior();

        function updateFromParentEntity(param1:TiphonSprite, param2:BehaviorData) : void;

        function remove() : void;

    }
}
