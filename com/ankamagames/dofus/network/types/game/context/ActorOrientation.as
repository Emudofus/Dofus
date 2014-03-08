package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ActorOrientation extends Object implements INetworkType
   {
      
      public function ActorOrientation() {
         super();
      }
      
      public static const protocolId:uint = 353;
      
      public var id:int = 0;
      
      public var direction:uint = 1;
      
      public function getTypeId() : uint {
         return 353;
      }
      
      public function initActorOrientation(id:int=0, direction:uint=1) : ActorOrientation {
         this.id = id;
         this.direction = direction;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
         this.direction = 1;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ActorOrientation(output);
      }
      
      public function serializeAs_ActorOrientation(output:IDataOutput) : void {
         output.writeInt(this.id);
         output.writeByte(this.direction);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ActorOrientation(input);
      }
      
      public function deserializeAs_ActorOrientation(input:IDataInput) : void {
         this.id = input.readInt();
         this.direction = input.readByte();
         if(this.direction < 0)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element of ActorOrientation.direction.");
         }
         else
         {
            return;
         }
      }
   }
}
