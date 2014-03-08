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
      
      public function initActorOrientation(param1:int=0, param2:uint=1) : ActorOrientation {
         this.id = param1;
         this.direction = param2;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
         this.direction = 1;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ActorOrientation(param1);
      }
      
      public function serializeAs_ActorOrientation(param1:IDataOutput) : void {
         param1.writeInt(this.id);
         param1.writeByte(this.direction);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ActorOrientation(param1);
      }
      
      public function deserializeAs_ActorOrientation(param1:IDataInput) : void {
         this.id = param1.readInt();
         this.direction = param1.readByte();
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
