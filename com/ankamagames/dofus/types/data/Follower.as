package com.ankamagames.dofus.types.data
{
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   
   public class Follower extends Object
   {
      
      public function Follower(param1:IMovable, param2:uint)
      {
         super();
         this.entity = param1;
         this.type = param2;
         if(param2 != TYPE_MONSTER)
         {
            (param1 as AnimatedCharacter).allowMovementThrough = true;
         }
      }
      
      public static const TYPE_NETWORK:uint = 0;
      
      public static const TYPE_PET:uint = 1;
      
      public static const TYPE_MONSTER:uint = 2;
      
      public var entity:IMovable;
      
      public var type:uint;
   }
}
