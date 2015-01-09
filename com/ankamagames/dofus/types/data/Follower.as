package com.ankamagames.dofus.types.data
{
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;

    public class Follower 
    {

        public static const TYPE_NETWORK:uint = 0;
        public static const TYPE_PET:uint = 1;
        public static const TYPE_MONSTER:uint = 2;

        public var entity:IMovable;
        public var type:uint;

        public function Follower(entity:IMovable, type:uint)
        {
            this.entity = entity;
            this.type = type;
            if (type != TYPE_MONSTER)
            {
                (entity as AnimatedCharacter).allowMovementThrough = true;
            };
        }

    }
}//package com.ankamagames.dofus.types.data

